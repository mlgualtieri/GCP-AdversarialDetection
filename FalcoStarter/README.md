# Falco Starter for Google Kubernetes Engine
Falco is an open source kubernetes run-time workload adversarial detection tool
https://falco.org/

To generate the required templates verify/update the version number specified in
fetchTemplates.sh and then run `./fetchTemplates.sh`.  The script is configured
to make the required modifications to the templates automatically to make
version upgrades easier.  These scripts are intended to be used with `kustomize`, 
but could be adapted for other use cases.

*Avoid manually editing the files in `templates/` as they may be overwritten
on subsequent runs of fetchTemplates.sh.*

To test falco by appling manually to a test cluster do the following:
`kubectl --context=your-cluster kustomize | kubectl --context=your-cluster apply -f - --prune -l app=falco`

- To remove falco from a cluster, run the following
```
kubectl --context=your-cluster delete daemonset -n falco falco
kubectl --context=your-cluster delete sa -n falco falco
kubectl --context=your-cluster delete cm -n falco falco
kubectl --context=your-cluster delete cm -n falco falco-rules-custom
kubectl --context=your-cluster delete ClusterRole falco
kubectl --context=your-cluster delete ClusterRoleBinding falco
```
- To view Falco logs run:
  `kubectl --context=your-cluster logs -l app=falco -f -n falco`

- To restart the falco daemonset, run:
  `kubectl --context=your-cluster rollout restart daemonset falco -n falco`
