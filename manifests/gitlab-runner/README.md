Add the GitLab Helm repository:

`helm repo add gitlab https://charts.gitlab.io`

## Create runner-token secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: gitlab-runner-secret
  namespace: backend
type: Opaque
data:
  runner-registration-token: "" # need to leave as an empty string for compatibility reasons
  runner-token: "BASE64ENCODEDTOKEN"
```

## Kubernetes pull secret

Create secret in the Kubernetes Cluster
```bash
kubectl create secret docker-registry gitlab-registry \
  --docker-server=https://registry.gitlab.com \
  --docker-username=$GITLAB_DEPLOY_TOKEN_USER \
  --docker-password=$GITLAB_DEPLOY_TOKENPASSWORD \
```