variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-09d3b3274b6c5d4aa"
}

variable "key_name" {
  default = "sandbox"
}
variable "region" {
  default = "us-east-1a"
}
variable "password" {
  type = string
}
variable "host" {}