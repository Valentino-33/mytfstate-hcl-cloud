resource "aws_s3_bucket" "logio-bucket" {
  bucket = local.s3-sufix

  tags = {
    Name = "${local.s3-sufix}"
  }
}
