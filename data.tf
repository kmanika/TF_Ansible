data "aws_ec2_spot_price" "spot_price" {
  instance_type     = var.instance_type
  availability_zone = "us-west-2a"

  filter {
    name   = "product-description"
    values = ["Linux/UNIX"]
  }
}
