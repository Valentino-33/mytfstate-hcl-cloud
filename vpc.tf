# VPC DEFAULT PARA INFRA

resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # cidr_block = lookup(var.virginia_cidr,terraform.workspace)
  tags = {
    Name = "${var.names.Name_vpc}-${local.sufix}"
  }
}

# Subnets publicas y privadas
resource "aws_subnet" "subnet_publica" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true # Esta opcion, hace que se generen ips publicas hacia internet.
  tags = {
    Name = "${var.names.Name_subnet_public}-${local.sufix}"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "${var.names.Name_subnet_private}-${local.sufix}"
  }
  depends_on = [aws_subnet.subnet_publica]
}

# Recursos para exposicion de instancia
# INTERNET GATEWAY - Establece el trafico entrante y saliente a la VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "IGW-INFRA-${local.sufix}"
  }
}

# Custom route table - Indica a las subnets como comunicarse con internet
resource "aws_route_table" "crt_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0" # Ruta default, para salir hacia internet a cualquier destino
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "CRT-SUBNET-${local.sufix}"
  }
}
# Route table association, asocia la tabla de enrutamiento, con una subnet, puede hacerse tambien con un IGW

resource "aws_route_table_association" "public_crt_association" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.crt_subnet.id

}
# SG - Establece el trafico entrante en la instancia EC2
resource "aws_security_group" "sg_public_instance" {
  name        = "SG-INSTANCE"
  description = "Security group para acceso SSH a instancia publica"
  vpc_id      = aws_vpc.vpc_virginia.id

  # ingress {
  #   description = "SSH desde mi IP"
  #   protocol    = "tcp"
  #   from_port   = 22
  #   to_port     = 22
  #   cidr_blocks = [var.sg_public_cidr_ingress]
  # }

  dynamic "ingress" {
    for_each = var.sg_apache_ports
    content {
      description = "Ingresses to instance dinamicos"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_public_cidr_ingress]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_private_cidr_egress]
  }

  tags = {
    Name = "SG-INSTANCE-${local.sufix}"
  }
}

