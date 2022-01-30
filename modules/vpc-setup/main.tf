/*
resource "aws_vpc" "t-vpc" {

   cidr_block = var.CIDR
   tags = {
       Name = "${var.vpc_name}-vpc"
   }
}

resource "aws_internet_gateway" "internet-gatway" {

  depends_on = [ aws_vpc.t-vpc ]

    vpc_id = aws_vpc.t-vpc.id
    tags = {
           Name = "${var.vpc_name}-ig"
    }
}

resource "aws_subnet" "public_subnets" {

   depends_on = [ aws_vpc.t-vpc,aws_internet_gateway.internet-gatway ]

   count = length(var.public_subnets)
   vpc_id = aws_vpc.t-vpc.id
   map_public_ip_on_launch = true
   availability_zone = element(var.az-zons,count.index)
   cidr_block = element(var.public_subnets,count.index)
   tags = {
     Name = "${var.vpc_name}-public_subnet-${count.index+1}"
   }
}

resource "aws_route_table" "t-route" {

    depends_on = [ aws_vpc.t-vpc,aws_internet_gateway.internet-gatway ]

     vpc_id = aws_vpc.t-vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.internet-gatway.id
    } 

    tags = {
      Name = "Route Table for ${var.vpc_name}-Internet-gateway"
    }
}

resource "aws_route_table_association" "t-associate" {

        depends_on = [ aws_subnet.public_subnets,aws_route_table.t-route]

        count = length(var.public_subnets)
        subnet_id      = element(aws_subnet.public_subnets.*.id,count.index)
        route_table_id = aws_route_table.t-route.id

}

resource "aws_subnet" "private_subnets" {

   count = length(var.private_subnets)
   vpc_id = aws_vpc.t-vpc.id
   availability_zone = element(var.az-zons,count.index)
   cidr_block = element(var.private_subnets,count.index)
   tags = {
     Name = "${var.vpc_name}-private_subnet-${count.index+1}"
   }

}

resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.t-associate
  ]
  vpc = true
  tags = {
    Name = "${var.vpc_name}-EIP"
  }
}

resource "aws_nat_gateway" "NAT_GATEWAY" {
  subnet_id     = aws_subnet.public_subnets[0].id
  allocation_id = aws_eip.Nat-Gateway-EIP.id

  tags = {
    Name = "${var.vpc_name}-NAT-Gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [ aws_vpc.t-vpc,aws_subnet.private_subnets]
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.t-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for ${var.vpc_name}-NAT Gateway"
  }

}
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  count = length(var.private_subnets)
#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = element(aws_subnet.private_subnets.*.id,count.index)

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}


*/
