## Installation without apt
```sh
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/bin/
```
see as sensitive marked outputs
```
terraform output <module_name>
```
## Providers and backend
the backend gets initiliazed before the providers and therefor needs its own providers definition. Here the `profiles` statement
`backend.tf`
```hcl
terraform {
  backend "s3" {
    bucket = "mfetfbucket"
    key    = "game-nxt-phs/terraform.tfstate"
    region = "us-east-1"
    profile = "tf"
  }
}
```
`providers.tf`
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region     = "us-east-1"
  profile = tf
}
```

Lambda Function attached to VPC and efs storage with VPC Endpoints for SQS and DynamoDB
[Module](https://github.com/MartinFeineis/ApiGateway/tree/14768330530eb79e63e4345c37790922068f991f/lambda_send_msg)
