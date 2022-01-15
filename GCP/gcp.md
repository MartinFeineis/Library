# Google Compute Engine
[console](https://console.cloud.google.com/home/dashboard?project=my-project-1549060401755)

# Configuration Profiles
Create a new Config Profile, activate it, set default
region and zone
```
gcloud config configurations list
gcloud config configurations create personal
gcloud config configurations activate personal
gcloud config set compute/region us-central1
gcloud config set compute/region us-central1-a
```
