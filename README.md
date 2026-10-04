# kubectl

## Install
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
```

```
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
## Autocomplete
```
# 1. Install bash-completion if you don't have it already
sudo apt update && sudo apt install -y bash-completion

# 2. Setup kubectl completion for all future shell sessions
echo 'source <(kubectl completion bash)' >> ~/.bashrc

# 3. (Optional) If you use the 'k' alias, enable completion for it as well
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc

# 4. Reload your current shell session to apply the changes
source ~/.bashrc
```

## Verify

```
kubectl version
```

# Helm
## Install
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
```

## Autocomplete

```
sudo helm completion bash > /etc/bash_completion.d/helm

helm completion bash > helm_completion
sudo mv helm_completion /etc/bash_completion.d/helm
```

# Push to ECR

```
docker tag nginx:1.16.0 471112874456.dkr.ecr.us-east-1.amazonaws.com/prkwan/nginx:latest

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 471112874456.dkr.ecr.us-east-1.amazonaws.com

docker push 471112874456.dkr.ecr.us-east-1.amazonaws.com/prkwan/nginx:latest

```