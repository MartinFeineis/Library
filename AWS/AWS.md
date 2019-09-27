#useful awscli and other commands etc.

# Find out who you are
`aws sts get-caller-identity`

# Windows aws s3 cp
Download several files from a list of Filenams through a For-Each Loop in Powershell
```
$filen = "C:\Users\<filepath>.txt"

foreach($line in Get-Content $filen){
    aws s3 cp s3://<S3-BUcket>/<path>/$line <local-path> $line --profile <aws-profile-name> 
}
```

# Cloudformation
## Deploy an EC2 Instance
The linked File deploys an EC2 Instance through Cloudformation
[EC2.yaml](./EC2_CF.yaml)

## Lambda  

## IAM
The file IAMUser.yaml creates a IAM User with admin privileges and programmatic access but no Login Access to the Managment Console. I use this user to deploy to my Laptops through ansible to have awscli Access without configuration overhead.  
[IAMUser.yaml](./IAMUser.yaml)
To deploy the user to the StackName `userStack` run, and use the describe-stack `describe-stack-events` command to recieve the `access-key` and `secret-access-key`
```
aws cloudformation deploy --template-file IAMUser.yaml --stack-name userStack --capabilities CAPABILITY_NAMED_IAM
aws cloudformation describe-stack-events --stack-name userStack
```

## Deleting a Stack
To delete a Stack with `stackName` run  
`aws cloudformation delete-stack --stack-name userStack`  
