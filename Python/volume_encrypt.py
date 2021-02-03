#!/usr/bin/python

import boto3
from time import sleep

aws_access_key_id='<access-key>'
aws_secret_access_key='<secret-key>'
region_name='us-east-1'

ec2 = boto3.resource('ec2',aws_access_key_id=aws_access_key_id,aws_secret_access_key=aws_secret_access_key,region_name=region_name)
client = boto3.client('ec2',aws_access_key_id=aws_access_key_id,aws_secret_access_key=aws_secret_access_key,region_name=region_name)
Filters = [{'Name':'tag:Name', 'Values':['cf-test']}]
response = client.describe_instances(Filters=Filters)
iId = response['Reservations'][0]['Instances'][0]['InstanceId']

alls = ec2.instances.filter(InstanceIds=[iId])
for i in alls:
    if i.state['Name'] == "stopped":
        print("Instance stopped")
    else:
        i.stop()
        sleep(25)


def get_volumes(InstanceId):
    ert = ec2.instances.filter(InstanceIds=[InstanceId])
    for i in ert:
        a_vol = i.volumes.all()
    return a_vol

def det_vol(InsId, VolId):
    respone = ec2.Instance(InsId).detach_volume(VolumeId=VolId)
    return respone


vols = get_volumes(iId)
for j in vols:
    print(j.id)

for i in vols:
    det_vol(iId,i.id)
    print(i)

##TEST THE FOLLOWING ###
snaps = list()
snap_ids = list()
for i in vols:
    snaps.append(i.create_snapshot(Description="Test snapshot"))
    snap_ids.append(snaps[-1].snapshot_id)
print(str(snaps) + "This is snaps")

def get_copy_tag(Id):
    snapshot = ec2.Snapshot(Id)
    try:
        if snapshot.Tags[0]['copied'] == 'true':
            return True
    except KeyError:
        pass


listForNewVolumes = []
for h in range(15):
    sleep(5)
    for i in snap_ids:
        snap_one = ec2.Snapshot(i)
        if snap_one.state == "completed":
            art = snap_one.copy(Encrypted=True,SourceRegion='us-east-1')
            print("Copied SnapId" + str(art))
            Tags = [{'Key' : 'copied', 'Value': 'true'}]
            snap_one.create_tags(Tags=Tags)
            print("Encrypting Snapshot: " + str(snap_one.snapshot_id))
            break
        else:
            print("Wait for it")


def create_volume(snapId,AvZone):
    response = client.create_volume(AvailabilityZone=AvZone,SnapshotId=snapId)
    return respone


# while snap_one.state != "completed":
#     print("wait for it")
# snap_one.copy(Encrypted=True,SourceRegion='us-east-1')
# print("Encrypting Snapshot: " + str(snap_one.snapshot_id))


    #i.copy(Encrypted=True,SourceRegion='us-east-1')
                #    def encrypt_snap(snapId):
                #        snap_orig = ec2.Snapshot(snapId)
                #        snap_orig.copy(Encrypted=True,KmsKeyId='string')
# def lambda_handler(event, context):
#     EC2_Instances = event['Records'][0]
#     try:
#           isinstance(EC2_Instances, list) or isinstance(EC2_Instances, str)
#     except Exception as e:
#         raise  isinstance(EC2_Instances, list):
#
#     def create_snapshots(instance_id):
