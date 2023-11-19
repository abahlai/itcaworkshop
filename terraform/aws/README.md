# AWS EKS terraform

## Prerequisites

* [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [(Optional) aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
* [(Optional) eksctl](https://eksctl.io/installation/)

## Running Terraform

First of all you need to ensure that your `AWS_PROFILE` has been already setup, otherwise run `aws configure` and enter `AWS_ACCESS_KEY_ID`, `AWS_SECRET_KEY_ID`, `AWS_REGION` values. **This is common for all setup.**

1. Next install latest terraform version with `tfswitch --latest`. In case of issues please check [Troubleshoot](https://tfswitch.warrensbox.com/Troubleshoot/).
2. Open `terraform` folder, there execute `terraform init`. It will download remote state to your workstation.
3. After you made the changes run `terraform plan` and `terraform apply`.

## (Optional) Running eksctl

```bash
# Installed locally:
$ eksctl create cluster -f 01_itcaworkshop.yaml

# Running in docker:
$ docker run -it \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -e AWS_REGION=$AWS_REGION \
    -v $(PWD):/root -w /root \
    weaveworks/eksctl create cluster -f 01_itcaworkshop.yaml
```

## Connecting to the EKS cluster

1. Generate `~/.kube/config` executing `aws eks update-kubeconfig --region <region> --name itcaworkshop`.
2. Check the results with `kubectl get nodes`.