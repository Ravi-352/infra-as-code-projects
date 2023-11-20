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

resource "aws_s3_bucket_ownership_controls" "mybucket_controls" {
  bucket = aws_s3_bucket.mybucket.id

  #depends_on = [ null_resource.upload_files ]
  rule {
    object_ownership = "BucketOwnerPreferred"
    
  }
  
}

#Disabling ACL blocks and providing public access to the s3-bucket content:
#Resource: aws_s3_bucket_acl

resource "aws_s3_bucket_public_access_block" "mybucket_access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  

}

resource "aws_s3_bucket_acl" "mybucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.mybucket_controls,
    aws_s3_bucket_public_access_block.mybucket_access,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "public_read_access" {

  bucket = aws_s3_bucket.mybucket.id
  depends_on = [ aws_s3_bucket_ownership_controls.mybucket_controls ]
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"
            ]
        }
      ]
  }
  EOF

}


#uploading objects (index.html, error.html etc.) to bucket
#Resource: aws_s3_object

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
  
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "error.html"
  source = "error.html"
  content_type = "text/html"
  
}

/*resource "aws_s3_object" "css" {
  bucket = aws_s3_bucket.mybucket.id
  for_each = fileset("css/", "css/*.*")

  key    = each.value
  source = "css/${each.value}"
  content_type = each.value
  
}

resource "aws_s3_object" "images" {
  bucket = aws_s3_bucket.mybucket.id
  for_each = fileset("images/", "images/*.*")

  key    = each.value
  source = "images/${each.value}"
  
  content_type = each.value
  
}*/



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
  
  depends_on = [ aws_s3_bucket_acl.mybucket_acl ]

}

