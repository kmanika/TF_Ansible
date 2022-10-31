resource "aws_spot_instance_request" "spot_ec2" {
  ami = "ami-074df373d6bafa625"
  instance_type = var.instance_type
  spot_price = data.aws_ec2_spot_price.spot_price
  spot_type = "persistent"
  vpc_security_group_ids          = [var.SG_Name]
  instance_interruption_behavior  = "stop"
  wait_for_fulfillment            = true
  tags = {
    Name = var.Machine_Name
  }
}

