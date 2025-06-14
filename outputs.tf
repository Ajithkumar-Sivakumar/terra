output "public_ips_test2" {
  value = aws_instance.test2[*].public_ip
}

output "find_ami" {
  value = aws_instance.test2[*].ami
}

output "private_ips_test2" {
  value = aws_instance.test2[*].private_ip
}