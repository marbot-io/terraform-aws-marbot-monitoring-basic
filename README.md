# AWS basics monitoring

Connects you to all relevant sources of errors and warnings published by AWS services.

## Usage

1. Create a new directory
2. Within the new directory, create a file `main.tf` with the following content:
```
provider "aws" {}

module "basic" {
  source           = "git::https://github.com/marbot-io/terraform-aws-marbot-monitoring-basic"

  endpoint_id      = "" # to get this value: select a Slack channel where marbot belongs to and send a message like this: "@marbot show me my endpoint id"
  budget_threshold = 10 # in USD (optional)
}
```
3. Run the following commands:
```
terraform init
terraform apply
```
