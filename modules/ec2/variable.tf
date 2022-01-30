variable "ec2_vpc_id" {
       
}

variable "ami" {
    default = "ami-02e136e904f3da870"
  
}
variable "public_instance_count" {
    default = 1
}
variable "private_instance_count" {
    default = 1
  
}
variable "private_subnet_id" {
    
  
}
variable "public_subnet_id" {
   
  
}

variable "instance_type" {
   default = "t2.micro"
  
}
variable "key_name" {
  
  
}
