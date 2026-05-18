virginia_cidr          = "10.10.0.0/16"
subnets                = ["10.10.0.0/24", "10.10.1.0/24"]
sg_private_cidr_egress = "0.0.0.0/0"
sg_public_cidr_ingress = "0.0.0.0/0"

# virginia_cidr          = {
#     "dev" = "172.16.0.0/16"
#     "prod" = "10.10.0.0/16"
# }
sg_apache_ports = [22, 80, 443]