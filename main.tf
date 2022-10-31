resource "aws_instance" "webserver-1" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.region
  key_name          = var.key_name
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id         = aws_subnet.web-sub-1.id
  iam_instance_profile = "sanbox_access"
  #user_data         = file("install_apache.sh")
  tags              = {
    Name            = "Web-server"
  }
}

resource "aws_ebs_volume" "myvol" {
  availability_zone = aws_instance.webserver-1.availability_zone
  size              = 1

  tags = {
    Name            = "Os-Voulme"
  }
}

resource "aws_volume_attachment" "ec_volume" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.webserver-1.id
  volume_id = aws_ebs_volume.myvol.id
  force_detach = true
}

resource "aws_vpc" "web-app-vpc" {
  cidr_block        = "10.0.0.0/16"
  tags              = {
    Name            = "Web-app"
  }
}

resource "aws_subnet" "web-sub-1" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "web-app-sub-1"
  }
}

resource "aws_subnet" "web-sub-2" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "web-app-sub-2"
  }
}

resource "aws_security_group" "web-sg" {
  name            = "Web-SG"
  description     = "Allow HTTP inbound traffic"
  vpc_id          = aws_vpc.web-app-vpc.id

  ingress         = [
    {
      from_port   = 80
      protocol    = "tcp"
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
      },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description      = "HTTPS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
]
  egress {
    from_port     = 0
    protocol      = "-1"
    to_port       = 0
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags            = {
    Name          = "Web-SG"
  }
}