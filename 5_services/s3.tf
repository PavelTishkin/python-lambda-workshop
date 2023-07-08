module "WeatherAPI5_S3_Static_Site" {
    source                  = "terraform-aws-modules/s3-bucket/aws"

    bucket                  = var.static_s3_website_bucket
    force_destroy           = true

    block_public_policy     = false
    restrict_public_buckets = false

    attach_policy           = true
    policy                  = jsonencode(
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "PublicGetObject",
                    "Effect": "Allow",
                    "Principal": "*",
                    "Action": "s3:GetObject",
                    "Resource": "arn:aws:s3:::${var.static_s3_website_bucket}/*"
                }
            ]
        }        
    )

    website = {
        index_document      = "index.html"
    }

    tags = {
        owner                 = var.maintainer
    }
}

resource "aws_s3_object" "object" {
    bucket       = var.static_s3_website_bucket
    key          = "index.html"
    source       = "weatherapi_static_site/index.html"
    content_type = "text/html"

    etag   = "${filemd5("weatherapi_static_site/index.html")}"
}

output "website_url" {
    value = module.WeatherAPI5_S3_Static_Site.s3_bucket_website_endpoint
}
