resource "aws_s3_bucket" "images" {
  bucket = "imagesterraform"
#   acl    = "public-read"
  
  policy = file("s3/policies/imagesBucketPolicy.json")

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }
  
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "image_files" {
  bucket   = aws_s3_bucket.images.bucket
  for_each = fileset("s3/images/", "*")
  key      = each.value
  source = "s3/images/${each.value}"
  etag   = filemd5("s3/images/${each.value}")
}
