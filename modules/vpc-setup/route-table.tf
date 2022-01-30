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