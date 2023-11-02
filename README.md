# infra-as-code-projects

Primary tools to create and manage infrastructure as code (IaC) are Terraform, Ansible, Puppet, AWS CloudFormation, Google Cloud Platform etc.
In the current demos, we are using ##Terraform## with ubuntu terminal mounted on WSL in a Windows Machine
1st demo is created in - 
`terraform-demos/terra-demo1/main.tf`

## Pre-requisites
```
aws-cli -->  install and configure - Ref: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html, 
terraform installed --> Ref: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

```

Once Terraform is installed, the Terraform usage lifecycle is as follows:
```
terraform init # To initialize terraform in existing directory
terraform plan  # to assess the execution plan as specified in main.tf -- it is like a dry run to understand what is going to happen to current infra if implemented
terraform apply # executes the main.tf
terraform destroy  # destroys all the infra created by terraform using the main.tf
```

### Note: Once infra created using the terraform script, manual intervention should be avoided to add or delete existing infra. the same should only be done through the scripts so that terraform can track what it is creating or deleting.
