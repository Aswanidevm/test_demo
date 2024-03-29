data "aws_ami" "ec2" {
  most_recent = true
  owners      = ["973714476881"]
  name_regex = "Centos-8-DevOps-Practice"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ec2.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = var.component
  }
}
resource "null_resource" "ansible"{
  depends_on = [aws_instance.web, aws_route53_record.wwww]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = self.public_ip
    }
    inline = [
      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/Aswanidevm/ansible main.yml -e env=dev -e role_name=${var.component}"
    ]
  }
}
resource "aws_security_group" "sg" {

  name        = "${var.component}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "SSH"
    from_port        = 22

    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_route53_record" "wwww" {
  zone_id = "Z04818282BOE8RVGV13K7"
  name    = "${var.component}.myprojecdevops.info"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.ec2.private_ip]
}


variable "instance_type"{}
variable "component"{}