
# 1. Create vpc
resource "aws_vpc" "vpc"{
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = merge(
      var.common_tags,
    {
      Name = "vpc_icap"
    },
  )
}

# 02. Create Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    {
      Name = "internet_gateway_icap"
    },
  )
  depends_on = [aws_vpc.vpc]
}

# 03. Create Subnet public
resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnets_public_cidr
  availability_zone = var.vpc_azs[0]
  map_public_ip_on_launch = "true"
  tags = merge(
    var.common_tags,
    {
      Name = "subnet_public_icap"
    },
  )
  depends_on = [aws_vpc.vpc]
}

# 06. Associate public Route Table with public Subnet
resource "aws_route_table_association" "rta_public_icap" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_vpc.vpc.default_route_table_id
  depends_on = [aws_vpc.vpc,aws_internet_gateway.internet_gateway, aws_subnet.subnet_public]
}
