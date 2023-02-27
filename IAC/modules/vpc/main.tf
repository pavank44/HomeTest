locals {
  nat_elasip_ids   = length(var.external_nat_elasip_ids) > 0 ? var.external_nat_elasip_ids : aws_eip.nat[*].id
  nats_count = min(length(var.public_cidr_blocks), length(var.valid_zones))
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.additional_vpc_tags,
    {
      Name = var.name
    }
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "sec_cidrs" {
  count = length(var.secondary_ipv4_cidrs)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.secondary_ipv4_cidrs[count.index]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.name
  }
}

resource "aws_eip" "nat" {
  count = length(var.external_nat_elasip_ids) == 0 ? local.nats_count : 0

  vpc = true

  tags = {
    Name    = "${var.name}-${var.valid_zones[count.index]}"
    Network = "NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  count = local.nats_count

  allocation_id = local.nat_elasip_ids[count.index]
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags = {
    Name = "${var.name}-${element(var.valid_zones, count.index)}"
  }

  depends_on = [aws_subnet.public]
}

resource "aws_subnet" "private" {
  count = length(var.private_cidr_blocks)

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.valid_zones, count.index)
  cidr_block              = var.private_cidr_blocks[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.additional_subnet_tags,
    {
      Name       = "private-${element(var.valid_zones, count.index)}-${var.name}"
      SubnetType = "Private"
    }
  )
}

resource "aws_route_table" "private" {
  count = length(var.private_cidr_blocks)

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private-${element(var.valid_zones, count.index)}-${var.name}"
    Type = "private"
    vpc  = var.name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_cidr_blocks)

  availability_zone       = element(var.valid_zones, count.index)
  cidr_block              = var.public_cidr_blocks[count.index]
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id

  tags = merge(
    var.additional_subnet_tags,
    {
      Name       = "public-${element(var.valid_zones, count.index)}-${var.name}"
      SubnetType = "Public"
    }
  )
}

resource "aws_route_table" "public" {
  count = length(var.public_cidr_blocks)

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-${element(var.valid_zones, count.index)}-${var.name}"
    Type = "public"
    vpc  = var.name
  }
}

resource "aws_route" "public" {
  count = length(var.public_cidr_blocks)

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_cidr_blocks)

  route_table_id = aws_route_table.public[count.index].id
  subnet_id      = aws_subnet.public[count.index].id
}


resource "aws_route" "private" {
  count = length(var.private_cidr_blocks)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat[*].id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_cidr_blocks)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}