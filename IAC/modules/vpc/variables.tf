variable "vpc_cidr_block" {
  description = "CIDR block for VPC network"
  type        = string
}

variable "name" {
  description = "Name of VPC"
  type        = string
}

variable "valid_zones" {
  description = "A list of valid availability zones for the subnets"
  type        = list(string)
}

variable "private_cidr_blocks" {
  description = "A list of CIDR blocks for the private ELB subnets. The number of blocks must be greater than or equal the number of valid zones"
  type        = list(string)
}

variable "public_cidr_blocks" {
  description = "A list of CIDR blocks for the public ELB subnets. The number of blocks must be greater than or equal the number of valid zones"
  type        = list(string)
}

variable "secondary_ipv4_cidrs" {
  description = "A list of secondary CIDR blocks to associate with vpc."
  type        = list(string)
  default     = []
}

variable "external_nat_elasip_ids" {
  description = "EIPs to associate with nats."
  type        = list(string)
  default     = []
}

variable "additional_vpc_tags" {
  description = "Additional tags to vpc"
  type        = map(string)
  default     = {}
}

variable "additional_subnet_tags" {
  description = "Additional tags for subnets"
  type        = map(string)
  default     = {}
}

variable "enable_flow_logs" {
  description = "The boolean indicates whether the VPC flow logs should be enabled"
  type        = bool
  default     = true
}

variable "flow_logs_role_arn" {
  description = "(Optional) The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group. This must be set if `enable_flow_logs` is true."
  type        = string
  default     = ""
}

variable "flow_logs_group_name" {
  description = "(Optional) CloudWatch log group name for the flow logs"
  type        = string
  default     = ""
}

variable "flow_logs_format" {
  description = "(Optional) The fields to include in the flow log record, in the order in which they should appear."
  type        = string
  default     = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${tcp-flags} $${pkt-srcaddr} $${pkt-dstaddr} $${flow-direction} $${traffic-path}"
}

variable "flow_logs_retention_in_days" {
  description = "(Optional) Specifies the number of days you want to retain log events in the log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = 365 # Prod PCI requirement
}