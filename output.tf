# SALIDAS OBTENIDAS

output "arn_vpc_virginia" {
  value       = aws_vpc.vpc_virginia.arn
  description = "ARN DE LA VPC VIR"
}
# ARN SUBNETS

output "public_subnet_arn" {
  value       = aws_subnet.subnet_publica.arn
  description = "ARN DE PUBLIC SUBNET virginia"
}

output "private_subnet_arn" {
  value       = aws_subnet.subnet_private.arn
  description = "ARN DE Private SUBNET virginia"
}

output "ec2_public_ips" {
  value       = { for k, instancia in aws_instance.ec2_ubuntu : k => instancia.public_ip }
  description = "IPs publicas de las instancias EC2"
}