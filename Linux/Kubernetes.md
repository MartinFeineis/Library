# Kuberenetes
## Installing Virtualbox
[virtualbox](https://computingforgeeks.com/install-virtualbox-on-kali-linux-linux-mint/)
or the summary:
```
#!/bin/bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt-get update
sudo apt update
sudo apt install linux-headers-$(uname -r) dkms
sudo apt-get install virtualbox-6.0
cd ~/
wget https://download.virtualbox.org/virtualbox/6.0.0/Oracle_VM_VirtualBox_Extension_Pack-6.0.0.vbox-extpack
```

## AWS Kubernetes EKS
The first command creates a new context entry in `~/.kube/config` the second command displays
the available contexts, then the third command changes the contexts to the one provided context-name
from the output of the second command. The fourth command displays the now active context.
```
aws eks --region us-east-1 update-kubeconfig --name $(StackName)
kubectl config get-contexts
kubectl config use-context __Name from get-contexts__
kubectl config current-context
```

## Kubernetes Objects
### Deployment
Deployments create Pods from Images.
Create Deployments from deployment yaml files, like
```
kubectl create -f deployment.yaml
```
To allow images being pulled from AWS ECR in minikube
```
minikube addons configure registry-creds
minikube addons enable registry-creds
```
The creds have to be referenced in the yaml like this:
```
imagePullSecrets:
  - name: awsecr-cred
containers:
    image: 703292127192.dkr.ecr.us-east-1.amazonaws.com/flaskpy:latest
    ports:
```
Next services
### Services
Services are used to expose Deployments internally or publicly
#### NodePort
Nodeports are used to expose a Service on a Node outside to local Kubernetes cluster.
This can be used for Development on Minikube.
#### ClusterIP
Cluster IP Services are used for Deployments that need to talk to other Services inside Kubernetes but not the outside world
#### Loadbalancer
Loadbalancer Services are only available on supported Cloud Service Provicers. A Loadbalancer Service creates an object in the Cloud
e.g. an AWS Loadbalancer to expose a Kubernetes Deployment publicly through AWS Route53.
