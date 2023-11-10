#Creating a s3-bucket
#Resource: aws_s3_bucket

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
  

  tags = {
    Name        = var.bucketname
    Environment = "Dev"
  }
}

#Setting ownership to avoid unauthorized control: 
#Resource: aws_s3_bucket_ownership_controls

resource "aws_s3_bucket_ownership_controls" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Disabling ACL blocks and providing public access to the s3-bucket content:
#Resource: aws_s3_bucket_acl

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "mybucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.mybucket,
    aws_s3_bucket_public_access_block.mybucket,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}


#uploading objects (index.html, error.html etc.) to bucket
#Resource: aws_s3_object

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
  
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
  
}

resource "aws_s3_object" "profile" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "profile.png"
  source = "profile.png"
  acl = "public-read"
  
}


#Enabling website configuration for s3-bucket
#Resource: aws_s3_bucket_website_configuration

resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  
  depends_on = [ aws_s3_bucket_acl.mybucket ]

}

