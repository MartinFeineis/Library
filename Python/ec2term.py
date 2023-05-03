#!/usr/bin/env python3

import boto3

response = list()

client = boto3.client('ec2')
termTag = [{'Name':'tag:terminate','Values':['True','true','yes','1']}]
markedDelte = client.describe_instances(Filters=termTag)
for ins in markedDelte['Reservations'][0]['Instances']:
    response.append(ins['InstanceId'])
 
print(response)

client.terminate_instances(InstanceIds=response)