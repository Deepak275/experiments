resource "aws_s3_bucket" "bucket" {
  bucket = "text-${terraform.workspace}"
  acl    = "private"
}