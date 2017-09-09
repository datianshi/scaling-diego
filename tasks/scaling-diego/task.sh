#!/bin/bash
set -eu

cf_resources=$(
  jq -n \
    --argjson diego_cell_instances $DIEGO_CELL_INSTANCES \
    '
    {
      "diego_cell": { "instances": $diego_cell_instances }
    }
    '
)

echo $cf_resources

om-linux \
  --target https://$OPSMAN_DOMAIN_OR_IP_ADDRESS \
  --username $OPSMAN_USERNAME \
  --password $OPSMAN_PASSWORD \
  --skip-ssl-validation \
  configure-product \
  --product-name cf \
  --product-resources "$cf_resources"
