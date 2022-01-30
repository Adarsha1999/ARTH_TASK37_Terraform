variable "CIDR" {
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    type = list
    default = ["10.0.1.0/24","10.0.2.0/24"]

}
variable "private_subnets" {
    type = list
    default = ["10.0.3.0/24","10.0.4.0/24"]

}
variable "az-zons" {
    type = list
    default = ["us-east-1a","us-east-1b"]
}

variable "vpc_name" {
    default = "custom"
  
}
