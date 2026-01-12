module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "devops-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  create_igw = true

  # 🚨 THIS IS THE FIX
  map_public_ip_on_launch = true

  enable_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true
}
