output "website-end-point" {

    value = aws_s3_bucket.mybucket.website_endpoint
    #value = aws_s3_bucket_website_configuration.redirect.website_endpoint
    description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
    #value = module.s3_bucket.s3_bucket_website_endpoint
}