resource "aws_subnet" "public_subnets" {

   depends_on = [ aws_vpc.t-vpc,aws_internet_gateway.internet-gatway ]

   count = length(var.public_subnets)
   vpc_id = aws_vpc.t-vpc.id
   map_public_ip_on_launch = true
   availability_zone = element(var.az-zons,count.index)
   cidr_block = element(var.public_subnets,count.index)
   tags = {
     Name = "${var.vpc_name}-public_subnet-${count.index+1}"
     test = "sourav-public"
   }
}
resource "aws_subnet" "private_subnets" {

   count = length(var.private_subnets)
   vpc_id = aws_vpc.t-vpc.id
   availability_zone = element(var.az-zons,count.index)
   cidr_block = element(var.private_subnets,count.index)
   tags = {
     Name = "${var.vpc_name}-private_subnet-${count.index+1}"
     test = "sourav-private"
   }

}
