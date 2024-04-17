module "vpc" {
  source = "../child_modules"
  env = "DEV"
  rgc = "US"
  cid = "ASSESMENT"
  vpc_cidr = "10.0.0.0/16"
  region = "us-east-1"
  managed_by = "IAMOPS"
  public_subnet_cidr = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  public_availability_zone = ["us-east-1a","us-east-1b","us-east-1c"]

  nat_private_subnet_cidr = ["10.0.51.0/24","10.0.52.0/24","10.0.53.0/24"]
  nat_private_subnet_availability_zone = ["us-east-1a","us-east-1b","us-east-1c"]

  private_subnet_cidr = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]
  private_subnet_availability_zone = ["us-east-1a","us-east-1b","us-east-1c"]
}