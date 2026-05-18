locals {
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.AZs}"
}

resource "random_string" "sufixs3" {
  length  = 8
  special = false
  upper   = false
}

locals {
  s3-sufix = "${var.tags.project}-${random_string.sufixs3.id}-${var.tags.env}"
}