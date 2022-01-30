resource "aws_vpc" "t-vpc" {

   cidr_block = var.CIDR
   tags = {
       Name = "${var.vpc_name}-vpc"
       test = "sourav"
   }
}
