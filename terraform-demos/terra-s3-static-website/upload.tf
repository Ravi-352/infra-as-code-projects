#Create a new file (e.g., `upload.tf`) to define the folder upload process:

resource "null_resource" "upload_files" {

#Use the “depends_on” attribute to ensure the S3 bucket is created before uploading files

  depends_on = [aws_s3_bucket.mybucket]

  provisioner "local-exec" {
    interpreter = ["/bin/sh", "-c"]
    command = <<EOT
      aws s3 cp index.html s3://${aws_s3_bucket.mybucket.bucket}/index.html
      aws s3 cp error.html s3://${aws_s3_bucket.mybucket.bucket}/error.html
      aws s3 cp --recursive css s3://${aws_s3_bucket.mybucket.bucket}/css
      aws s3 cp --recursive images s3://${aws_s3_bucket.mybucket.bucket}/images
    EOT
  }
}