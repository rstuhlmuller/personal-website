resource "aws_s3_bucket" "my_website" {
  bucket = "rstuhlmuller-s3-use1-personal-site"
}

locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".ico"  = "image/vnd.microsoft.icon"
    ".jpeg" = "image/jpeg"
    ".png"  = "image/png"
    ".svg"  = "image/svg+xml"
  }
}

resource "aws_s3_object" "my_website" {
  for_each     = fileset("../my_website/", "**")
  bucket       = aws_s3_bucket.my_website.bucket
  key          = "my_website/${each.value}"
  source       = "../my_website//${each.value}"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
  etag         = filemd5("../my_website/${each.value}")
}


resource "aws_cloudfront_origin_access_control" "my_website" {
  name                              = "my_website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}