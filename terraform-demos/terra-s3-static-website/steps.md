#CREATING STATIC WEBSITE ON AWS USING TERRAFORM

Prerequisites:
1. AWS Account
2. Terraform Installed
3. A static webpage project (contains html and css scripts)


Overall STEPS:

1. Create provider.tf file - for initiating aws provider with 
```
terrform init
```

2. variable.tf file - to define variables

3. Create main.tf file - where we can implement following things:

```
Creating an s3 bucket: Website files will be stored here

Configuring the s3 bucket for Static Website Hosting: In s3 bucket properties, enable static website hosting and specify the default index document (eg: "index.html") and optional error document (e.g: "error.html")

Upload website files to s3 bucket: Make sure to set appropriate permissions (e.g: "public-read") for the objects make them publicly accessible.

Enable Public Access to s3 bucket and configure Access Control Lists (ACLs)

```

4. Configure DNS, if owning a domain name: example: www.tegonline.in. This can be done using Route53 or any other DNS provider. 
