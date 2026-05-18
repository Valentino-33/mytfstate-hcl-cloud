# variable "instancias_ind" {
#   description = "Estos son los nombres de las instancias a crear"
#   type        = set(string)
#   default     = ["docker", "cicd", "db", "apache"]
# }

variable "instancias_ind" {
  description = "Estos son los nombres de las instancias a crear"
  type        = set(string)
  default     = ["apache"]
}


resource "aws_instance" "ec2_ubuntu" {
  for_each               = toset(var.instancias_ind)
  ami                    = var.ec2_defaults.ami_default
  instance_type          = var.ec2_defaults.instance_type_default
  subnet_id              = aws_subnet.subnet_publica.id
  key_name               = data.aws_key_pair.keyacceso.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("userdata.sh")

  tags = {
    Name = "${each.value}-${local.sufix}"
  }
}

# Instancia de monitoreo
resource "aws_instance" "ec2_ubuntu_monitoreo" {
  count                  = var.monitoring_condition == 1 ? 1 : 0
  ami                    = var.ec2_defaults.ami_default
  instance_type          = var.ec2_defaults.instance_type_default
  subnet_id              = aws_subnet.subnet_publica.id
  key_name               = data.aws_key_pair.keyacceso.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("userdata.sh")

  tags = {
    Name = "Monitoring-${local.sufix}"
  }
}