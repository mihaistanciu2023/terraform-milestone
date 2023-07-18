
provider "aws" {
  region = "eu-central-1"
}
module "mihai" {
  source = "../module/vpc"
}

module "vpc" {
  source      = "../module/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = module.mihai.aws_vpc.main.id
  subnet_cidr = "192.168.1.0/24"
}

module "ec2" {
  source        = "../module/ec2"
  ec2_count     = 1
  ami_id        = "ami-07ce6ac5ac8a0ee6f"
  instance_type = "t2.micro"
  subnet_id     = module.mihai.aws_subnet.main.id
  
}