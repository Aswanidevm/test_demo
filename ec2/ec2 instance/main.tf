data "aws_ami" "ec2" {
  most_recent = true
  owners      = ["973714476881"]
  name_regex = "Centos-8-DevOps-Practice"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ec2.id
  instance_type = var.instance_type

  tags = {
    Name = var.component
  }
}

variable "instance_type"{}
variable "component"{}