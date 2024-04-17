locals {
  prefix = "BTF-${var.cid}-${var.env}-${var.rgc}"
}

resource "aws_vpc" "vpc" {
  cidr_block    = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name        = "${local.prefix}-VPC-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "VPC"
    Created_on  = timestamp()
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = var.public_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.public_availability_zone[count.index]
  tags = {
    Name        = "${local.prefix}-PUB-SUB-0${count.index + 1}"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Created_on  = timestamp()
    Managed_by  = var.managed_by
    Resource    = "PUB-SUB"
    Created_on  = timestamp()
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.prefix}-IGW-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "IGW"
    Created_on  = timestamp()
  }
}
#----------------------------------------------------
resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.prefix}-PUB-ROU-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "PUB-ROU"
    Created_on  = timestamp()
  }
}
resource "aws_route_table_association" "pub_subnet_asso" {
  count = 3
  route_table_id = aws_route_table.pub_route_table.id
  subnet_id = aws_subnet.public_subnet[count.index].id
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.pub_route_table.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}
#----------------------------------------------------
resource "aws_subnet" "nat_private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.nat_private_subnet_cidr)
  cidr_block              = var.nat_private_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.nat_private_subnet_availability_zone[count.index]
  tags = {
    Name        = "${local.prefix}-PVT-NAT-SUB-0${count.index + 1}"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Created_on  = timestamp()
    Managed_by  = var.managed_by
    Resource    = "PVT-NAT-SUB"
    Created_on  = timestamp()
  }
}

resource "aws_eip" "eip" {
  vpc   = true
  tags = {
    Name        = "${local.prefix}-EIP-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "EIP"
    Created_on  = timestamp()
  }
}
###############################
## nat gateway configuration ##
###############################
resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.eip.id
  tags = {
    Name        = "${local.prefix}-NAT-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "NAT"
    Created_on  = timestamp()
  }
}

resource "aws_route_table" "nat_pvt_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.prefix}-PVR-NAT-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "PVR-NAT"
    Created_on  = timestamp()
  }
}
resource "aws_route_table_association" "nat_pvt_subnet_asso" {
  count = 3
  route_table_id = aws_route_table.nat_pvt_route_table.id
  subnet_id = aws_subnet.nat_private_subnet[count.index].id
}

resource "aws_route" "nat_pvt_route" {
  route_table_id = aws_route_table.nat_pvt_route_table.id
  nat_gateway_id = aws_nat_gateway.ngw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnet_cidr)
  cidr_block              = var.private_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.private_subnet_availability_zone[count.index]
  tags = {
    Name        = "${local.prefix}-PVT-SUB-0${count.index + 1}"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Created_on  = timestamp()
    Managed_by  = var.managed_by
    Resource    = "PVT-SUB"
    Created_on  = timestamp()
  }
}

resource "aws_route_table" "pvt_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.prefix}-PVT-ROU-01"
    Region      = var.region
    Region_code = var.rgc
    Env         = var.env
    Managed_by  = var.managed_by
    Resource    = "PVT-ROU"
    Created_on  = timestamp()
  }
}
resource "aws_route_table_association" "pvt_subnet_asso" {
  count = 3
  route_table_id = aws_route_table.pvt_route_table.id
  subnet_id = aws_subnet.private_subnet[count.index].id
}






