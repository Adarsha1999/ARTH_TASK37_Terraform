resource "aws_internet_gateway" "internet-gatway" {

  depends_on = [ aws_vpc.t-vpc ]

    vpc_id = aws_vpc.t-vpc.id
    tags = {
           Name = "${var.vpc_name}-ig"
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

