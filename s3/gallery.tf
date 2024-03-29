resource "aws_s3_bucket" "react_bucket"{
    bucket = "mygallery2"
    acl    = "public-read"
    policy = <<EOF
        {
            "Id": "bucket_policy_site",
            "Version": "2012-10-17",
            "Statement": [
                {
                "Sid": "bucket_policy_site_main",
                "Action": [
                    "s3:GetObject"
                ],
                "Effect": "Allow",
                "Resource": "arn:aws:s3:::mygallery2/*",
                "Principal": "*"
                }
            ]
            }
    EOF
    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}

output "website_domain" {
    value = "${aws_s3_bucket.react_bucket.website_domain}"
} 

output "website_endpoint" {
    value = "${aws_s3_bucket.react_bucket.website_endpoint}"
} 
