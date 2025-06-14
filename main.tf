provider "aws" {
    region = var.region
}

/*variable "create_instance" {
  description = "to terminal the servers"
  type = bool
  default = false
}

resource "aws_instance" "test" {
  count = var.create_instance ? 5:0
  ami = "ami-05fcfb9614772f051"
  instance_type = "t3.micro"

tags = {
  name = "test-${count.index}"
}
}*/

data "aws_ami" "myubuntu" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  } 
}

resource "aws_security_group" "mysecurity" {
  name = "sg"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
      name = "sg"
    }
  }

resource "aws_instance" "test2" {
  count = 2
  ami = data.aws_ami.myubuntu.id
  instance_type = var.instance_type
  key_name = "jenk"

tags = {
  name ="test2-${count.index}"
}
}

terraform {
  backend "s3" {
    bucket         = "aj-terraform-bucket-2025"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

/*output "public_ips_test" {
  value = aws_instance.test[*].public_ip
}

output "private_ips_test" {
  value = aws_instance.test[*].private_ip
}*/