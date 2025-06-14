provider "aws" {
    region = "eu-north-1"
}

variable "create_instance" {
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
}

resource "aws_instance" "test2" {
  count = 2
  ami = "ami-05fcfb9614772f051"
  instance_type = "t3.micro"

tags = {
  name ="test2-${count.index}"
}
}

output "public_ips_test" {
  value = aws_instance.test[*].public_ip
}

output "private_ips_test" {
  value = aws_instance.test[*].private_ip
}

output "public_ips_test2" {
  value = aws_instance.test2[*].public_ip
}

output "private_ips_test2" {
  value = aws_instance.test2[*].private_ip
}