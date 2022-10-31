resource "local_file" "ip" {
  filename  = "ip.txt"
  content   = aws_instance.webserver-1.public_ip
}

resource "null_resource" "nullremote1" {
  depends_on = [aws_instance.webserver-1]
  connection {
    type = "ssh"
    user = "root"
    password = "${var.password}"
      host = "${var.host}"
  }
  provisioner "file" {
    source = "ip.txt"
    destination = "/home/ec2-user/terraform/ec2-spin/TF_Ansible/ip.txt"
  }
}