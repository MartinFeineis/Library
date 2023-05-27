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
[EC2.yaml](./EC2_CF.yaml). Content for base64 raw UserData File:
```
aws s3 cp s3://bucket/script.sh . && chmod +x script.sh && ./script.sh -w 0
```
Put this in a file called `b64_content`. The Deployment script will base64 encode it and 
put replace the `UserData` in the cloudformation script with it using `sed`
Deployment Script
```bash
#!/bin/sh
if [ "$1" = -d ]
then
	aws cloudformation delete-stack --stack-name ec2-test-stack
else
	B64=$(base64 b64_content | paste -s -d='')
	sed -i "s/UserData: .*/UserData: \"$B64\"/g" cf_ans.yaml
	aws cloudformation deploy --template-file cf_ans.yaml --stack-name ec2-test-stack
fi
```

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

## cloudfront
Create a list of all cloudfront distributions
```
aws cloudfront list-distributions | jq -c '."DistributionList"."Items"[] | {"Id" : ."Id"} '
```
Explanation: 
`.` takes all elemens
`{"Id" : ."Id"}` creates an object with the Key "Id" and the value of `Id` from the List it gets passed
`jq -c`: Does not print a new Line after every Element 
##Cloudwatch
List all metrics where the Namespace contains __Usage__
```
aws cloudwatch list-metrics | jq '."Metrics"[] | select(."Namespace" | contains("Usage"))'
```

## CodeCommit
ssh config for AWS code commit
```
Host git-codecommit.*.amazonaws.com
  User ABCEDEUserKey
  IdentityFile ~/.ssh/privateKey
```
