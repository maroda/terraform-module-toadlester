resource "aws_s3_bucket" "appdata" {
  bucket = var.app

  tags = {
    Name = var.app
  }
}

