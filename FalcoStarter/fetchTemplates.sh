#!/bin/bash
#
# Retrieve yaml templates for the current version of Falco and prepare them for kustomize
# https://github.com/falcosecurity/deploy-kubernetes/tree/main/kubernetes/falco/templates
#
# Current version:
# CHART           APP VERSION
# falco-2.0.16    0.32.2

# Remove existing templates
[ -d templates ] || mkdir templates
rm $PWD/templates/*.yaml

# Download templates
echo "Downloading default templates..."
curl -s https://raw.githubusercontent.com/falcosecurity/deploy-kubernetes/main/kubernetes/falco/templates/clusterrole.yaml > templates/clusterrole.yaml
curl -s https://raw.githubusercontent.com/falcosecurity/deploy-kubernetes/main/kubernetes/falco/templates/clusterrolebinding.yaml > templates/clusterrolebinding.yaml
curl -s https://raw.githubusercontent.com/falcosecurity/deploy-kubernetes/main/kubernetes/falco/templates/configmap.yaml > templates/configmap.yaml
curl -s https://raw.githubusercontent.com/falcosecurity/deploy-kubernetes/main/kubernetes/falco/templates/daemonset.yaml > templates/daemonset.yaml
curl -s https://raw.githubusercontent.com/falcosecurity/deploy-kubernetes/main/kubernetes/falco/templates/serviceaccount.yaml > templates/serviceaccount.yaml

echo "Edit default templates..."

# Remove Helm annotations
sed -i '/app.kubernetes.io\/managed-by: Helm/d' templates/clusterrole.yaml
sed -i '/app.kubernetes.io\/managed-by: Helm/d' templates/clusterrolebinding.yaml
sed -i '/app.kubernetes.io\/managed-by: Helm/d' templates/configmap.yaml
sed -i '/app.kubernetes.io\/managed-by: Helm/d' templates/daemonset.yaml
sed -i '/app.kubernetes.io\/managed-by: Helm/d' templates/serviceaccount.yaml

sed -i '/helm.sh\/chart/d' templates/clusterrole.yaml
sed -i '/helm.sh\/chart/d' templates/clusterrolebinding.yaml
sed -i '/helm.sh\/chart/d' templates/configmap.yaml
sed -i '/helm.sh\/chart/d' templates/daemonset.yaml
sed -i '/helm.sh\/chart/d' templates/serviceaccount.yaml

# Edit base configmap to set
# - the default priority to 'warning' (instead of debug)
# - json output
sed -i 's/priority: debug/priority: warning/g' templates/configmap.yaml
sed -i 's/json_output: false/json_output: true/g' templates/configmap.yaml

echo "Formatting template yaml..."
kustomize cfg fmt templates/*.yaml

echo "Done!"
