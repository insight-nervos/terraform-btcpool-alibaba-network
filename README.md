# terraform-btcpool-alibaba-network

[![open-issues](https://img.shields.io/github/issues-raw/insight-nervos/terraform-btcpool-alibaba-network?style=for-the-badge)](https://github.com/insight-nervos/terraform-btcpool-alibaba-network/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-nervos/terraform-btcpool-alibaba-network?style=for-the-badge)](https://github.com/insight-nervos/terraform-btcpool-alibaba-network/pulls)

## Features

This module sets up a network on Alibaba cloud for running a btcpool mining pool. Meant to be used with the associated [automated node deployment](https://github.com/insight-nervos/terraform-btcpool-alibaba-node). 

## Terraform Versions

For Terraform v0.12.0+

## Usage

```hcl
module "this" {
  source = "github.com/insight-nervos/terraform-btcpool-alibaba-network"
}
```
## Examples

- [defaults](https://github.com/insight-nervos/terraform-btcpool-alibaba-network/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| alicloud | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| all\_enabled | Bool to enable all the security groups | `bool` | `false` | no |
| azs | List of availability zones | `list(string)` | `[]` | no |
| bastion\_enabled | Boolean to enable a bastion host.  All ssh traffic restricted to bastion | `bool` | `false` | no |
| bastion\_sg\_name | Name for the bastion security group | `string` | `"bastion-sg"` | no |
| cidr | The cidr range for network | `string` | `"10.0.0.0/16"` | no |
| corporate\_ip | The corporate IP you want to restrict ssh traffic to | `string` | `""` | no |
| create\_private\_subnets | Bool to enable creation of private subnets | `bool` | `false` | no |
| create\_public\_subnets | Bool to enable creation of public subnets | `bool` | `true` | no |
| node\_sg\_name | Name for the node security group | `string` | `"node-sg"` | no |
| num\_azs | The number of AZs to deploy into | `number` | `0` | no |
| public\_ports | List of publicly open ports | `list(number)` | <pre>[<br>  1800,<br>  8114,<br>  8115,<br>  9021,<br>  9090,<br>  3000<br>]</pre> | no |
| vpc\_name | The name of the VPC | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_security\_group\_id | #### SGs #### |
| node\_security\_group\_id | n/a |
| private\_vswitch\_ids | n/a |
| public\_vswitch\_ids | n/a |
| vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [Richard Mah](https://github.com/shinyfoil)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.