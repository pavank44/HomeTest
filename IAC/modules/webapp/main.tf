provider "aws" {
  region     = "ca-central-1"
  access_key = "AKIA5HEO4U2TC7R6SHJQ"
  secret_key = "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"

}

module "alb-vpc" {
  source              = "../vpc"
  name                = "alb-vpc"
  vpc_cidr_block      = "10.0.0.0/16"
  valid_zones         = ["ca-central-1a", "ca-central-1d"]
  public_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
  additional_vpc_tags = { Description = "This VPC is used for ALB" }
}

module "alb-webapp" {
  source                            = "../alb"
  vpc_id                            = module.alb-vpc.vpc_id
  security_group_ids                = [module.alb-vpc.vpc_default_security_group_id]
  subnet_ids                        = module.alb-vpc.public_subnet_ids
  internal                          = false
  http_enabled                      = true
  http_redirect                     = true
  cross_zone_load_balancing_enabled = false
  http2_enabled                     = false
  idle_timeout                      = 60
  ip_address_type                   = "ipv4"
  deletion_protection_enabled       = false
  health_check_path                 = "/"
  health_check_timeout              = 8
  health_check_healthy_threshold    = 2
  health_check_unhealthy_threshold  = 2
  health_check_interval             = 10
  health_check_matcher              = "200-399"
  target_group_port                 = 8080
  target_group_target_type          = "ip"
  target_group_name                 = "webapp"
}