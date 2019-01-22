#useful awscli and other commands etc.

# Find out who you are
```aws sts get-caller-identity```

# Windows aws s3 cp
Download several files from a list of Filenams through a For-Each Loop in Powershell
```
$filen = "C:\Users\<filepath>.txt"

foreach($line in Get-Content $filen){
    aws s3 cp s3://<S3-BUcket>/<path>/$line <local-path> $line --profile <aws-profile-name> 
}
```
