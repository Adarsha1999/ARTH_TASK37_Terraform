
module "vpc-full-setup" {
    source = "../modules/vpc-setup"


    vpc_name = "custom"
    CIDR =  "10.0.0.0/16"
    public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
    private_subnets = ["10.0.3.0/24","10.0.4.0/24"]
    az-zons = ["us-east-1a","us-east-1b"]


}

module "ec2-setup" {
    source = "../modules/ec2"
    
    ec2_vpc_id = tolist(data.aws_vpcs.foo.ids)[0]
    public_subnet_id = tolist(data.aws_subnet_ids.public.ids)[0]
    private_subnet_id = tolist(data.aws_subnet_ids.private.ids)[0]
    public_instance_count = 1
    ami           = "ami-02e136e904f3da870"
    instance_type = "t2.micro"
    key_name = "adarsha"
    private_instance_count = 1
    
  
}



data "aws_vpcs" "foo" {
  depends_on = [
    module.vpc-full-setup
  ]
  tags = {
    test = "sourav"
  }
}

data "aws_subnet_ids" "public" {
  depends_on = [
    module.vpc-full-setup
  ]
  vpc_id = tolist(data.aws_vpcs.foo.ids)[0]

  tags = {
    test = "sourav-public"
  }
}
data "aws_subnet_ids" "private" {
  depends_on = [
    module.vpc-full-setup
  ]
  vpc_id = tolist(data.aws_vpcs.foo.ids)[0]

  tags = {
     test = "sourav-private"
  }
}




