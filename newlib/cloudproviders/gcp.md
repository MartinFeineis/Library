# Gcloud cli toole
[docs](https://cloud.google.com/sdk/docs/install#deb)
```bash
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
```
# Google Compute Engine
[console](https://console.cloud.google.com/home/dashboard?project=my-project-1549060401755)

# Configuration Profiles
Create a new Config Profile, activate it, set default
region and zone
```bash
gcloud config configurations list
gcloud config configurations create personal
gcloud config configurations activate personal
gcloud config set compute/region us-central1
gcloud config set compute/region us-central1-a
```

## Serving Content from bucket
1. Create bucket
2. Create CDN
    2.1 Create new backend bucket that connects to bucket from 1.
    2.2 Create new loadbalancer
3. Creat Url Map for Load balancer