<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_ipv4_cidr_block_association.sec_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_subnet_tags"></a> [additional\_subnet\_tags](#input\_additional\_subnet\_tags) | Additional tags for subnets | `map(string)` | `{}` | no |
| <a name="input_additional_vpc_tags"></a> [additional\_vpc\_tags](#input\_additional\_vpc\_tags) | Additional tags to vpc | `map(string)` | `{}` | no |
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | The boolean indicates whether the VPC flow logs should be enabled | `bool` | `true` | no |
| <a name="input_external_nat_elasip_ids"></a> [external\_nat\_eip\_ids](#input\_external\_nat\_eip\_ids) | EIPs to associate with nats. | `list(string)` | `[]` | no |
| <a name="input_flow_logs_format"></a> [flow\_logs\_format](#input\_flow\_logs\_format) | (Optional) The fields to include in the flow log record, in the order in which they should appear. | `string` | `"${version} ${account-id} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status} ${tcp-flags} ${pkt-srcaddr} ${pkt-dstaddr} ${flow-direction} ${traffic-path}"` | no |
| <a name="input_flow_logs_group_name"></a> [flow\_logs\_group\_name](#input\_flow\_logs\_group\_name) | (Optional) CloudWatch log group name for the flow logs | `string` | `""` | no |
| <a name="input_flow_logs_retention_in_days"></a> [flow\_logs\_retention\_in\_days](#input\_flow\_logs\_retention\_in\_days) | (Optional) Specifies the number of days you want to retain log events in the log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number` | `365` | no |
| <a name="input_flow_logs_role_arn"></a> [flow\_logs\_role\_arn](#input\_flow\_logs\_role\_arn) | (Optional) The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group. This must be set if `enable_flow_logs` is true. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of VPC | `string` | n/a | yes |
| <a name="input_private_cidr_blocks"></a> [private\_cidr\_blocks](#input\_private\_cidr\_blocks) | A list of CIDR blocks for the private ELB subnets. The number of blocks must be greater than or equal the number of valid zones | `list(string)` | n/a | yes |
| <a name="input_public_cidr_blocks"></a> [public\_cidr\_blocks](#input\_public\_cidr\_blocks) | A list of CIDR blocks for the public ELB subnets. The number of blocks must be greater than or equal the number of valid zones | `list(string)` | n/a | yes |
| <a name="input_secondary_ipv4_cidrs"></a> [secondary\_ipv4\_cidrs](#input\_secondary\_ipv4\_cidrs) | A list of secondary CIDR blocks to associate with vpc. | `list(string)` | `[]` | no |
| <a name="input_valid_zones"></a> [valid\_zones](#input\_valid\_zones) | A list of valid availability zones for the subnets | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for VPC network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway"></a> [nat\_gateway](#output\_nat\_gateway) | Nat gateway ids |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | A list of private route table ids. |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | Private subnet ids |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | A list of public route table ids. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Public subnet ids |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | Default Sg |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Vpc |
<!-- END_TF_DOCS -->