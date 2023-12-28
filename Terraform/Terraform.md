#Terraform
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

Lambda Function attached to VPC and efs storage with VPC Endpoints for SQS and DynamoDB
[Module](https://github.com/MartinFeineis/ApiGateway/tree/14768330530eb79e63e4345c37790922068f991f/lambda_send_msg)
