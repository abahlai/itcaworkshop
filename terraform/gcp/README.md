# Google Kubernetes Engine terraform

[$300 credit for free. Put Google Cloud to work with $300 in credit to spend over the next 90 days.](https://console.cloud.google.com/freetrial/signup/tos)

## (Optional) Deploy GKE using cli

* Download and install [gcloud cli](https://cloud.google.com/sdk/docs/install).
* Set your *PROJECT_ID* with `gcloud config set project PROJECT_ID`.
* Create GKE cluster with `gcloud container clusters create-auto itcaworkshop --location=europe-west3`.
* Get authentication credentials for the cluster `gcloud container clusters get-credentials itcaworkshop --location=europe-west3`.