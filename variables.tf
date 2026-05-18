variable "virginia_cidr" {
  description = "CIDR VIRGINIA"
  type        = string
  sensitive   = false
}
variable "subnets" {
  description = "lista de subredes"
  type        = list(string)
}

# Variable MAP:

variable "tags" {
  description = "tags por del proyecto"
  type        = map(string)
  default = {
    "owner"       = "Valentino-IAC"
    "env"         = "testing"
    "cloud"       = "AWS"
    "IAC"         = "Terraform"
    "IAC_Version" = "1.14.19"
    "project"     = "logio-sf"
    "AZs"         = "virginia"
  }
}

variable "names" {
  description = "nombres de cada resource"
  type        = map(string)
  default = {
    "Name_subnet_public"  = "Valentino-subnet-public"
    "Name_subnet_private" = "Valentino-subnet-private"
    "Name_vpc"            = "Virginia-VPC"
    "Name_EC2"            = "Ubuntu-tier-public"
  }
}

# CIDR PARA SECURITY GROUPS

variable "sg_public_cidr_ingress" {
  type        = string
  description = "segmento cidr para ingress en SG"
}

variable "sg_private_cidr_egress" {
  type        = string
  description = "segmento cidr para egress en SG"
}

# ENVS para EC2 dinamicos
variable "ec2_defaults" {
  description = "variables para la instancia ec2"
  type        = map(string)
  default = {
    "ami_default"           = "ami-091138d0f0d41ff90"
    "instance_type_default" = "t3.micro"
    "default_user_data"     = "userdata.sh"
  }
}

variable "monitoring_condition" {
  type        = number
  default     = 0
  description = "Desplegar o no, una instancia dedicada para el monitoreo"
}

variable "sg_apache_ports" {
  type        = list(number)
  description = "Puertos para servidor HTTP APACHE"
}

## Terraform cloud ## 

variable "access_key" {
}

variable "secret_key" {
}

