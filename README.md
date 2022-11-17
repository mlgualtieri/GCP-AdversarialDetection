# Google Cloud Platform (GCP) - Adversarial Detection Resources
This repository contains resources to build adversarial detections for Google Cloud Platform (GCP) and Google Kubernetes Engine (GKE) clusters.  They are provided as supplemental material for my talk "Crafting Adversarial Detections at Scale in Google Cloud Platform" for the SANS Pen Test HackFest Summit - November 2022.

- `GCP-LogBased-Alerts.txt` contains queries that can be configured in Google Cloud Platform as log-based alerts.  These rules are designed to trigger on events during several portions of the Attack Lifecycle.

- `Plans/` contains Bash scripts that can be used as to emulation adversaries in your environment, and test your detection rulesets.

- `FalcoStarter/` contains a default Falco configuration for use with Google Kubernetes Engine (GKE) and kustomize.
