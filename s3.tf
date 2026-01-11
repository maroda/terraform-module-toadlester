resource "aws_s3_bucket" "appdata" {
  bucket = var.app

  tags = {
    Name = var.app
  }
}

output "bucket_name" {
  value = aws_s3_bucket.appdata.id
}
