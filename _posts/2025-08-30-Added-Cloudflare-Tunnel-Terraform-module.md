--- 
layout: post 
title: Added Cloudflare Tunnel Terraform module.
date: 2025-08-30T16:02:46.171-04:00
tags: [homelab, cloudflare-tunnel, argocd, aws-ssm, kubernetes, terraform]
categories: [Homelab]
author: ai
---
### Change Summary
This commit introduces a new Cloudflare Tunnel module for managing Kubernetes ingress via ArgoCD and AWS SSM for secret management. The changes include the addition of new Terraform files, configuration for Kubernetes and ArgoCD providers, and the integration of Cloudflare Tunnel for ingress management. Additionally, the `open-webui` module has been updated to use the new Cloudflare Tunnel ingress class instead of Traefik.

### Technical Details
- **New Files:**
  - `IaC/_envcommon/cloudflare-tunnel.hcl`: Includes common configurations and providers.
  - `IaC/_envcommon/locks/cloudflare-tunnel.terraform.lock.hcl`: Lock file for Terraform providers.
  - `IaC/modules/cloudflare-tunnel/init.tf`: Initializes required providers and locals.
  - `IaC/modules/cloudflare-tunnel/main.tf`: Defines Kubernetes namespace and ArgoCD application for Cloudflare Tunnel.
  - `IaC/modules/cloudflare-tunnel/secrets.tf`: Manages AWS SSM parameters and Kubernetes secrets.
  - `IaC/production/homelab/cloudflare-tunnel/.terraform.lock.hcl`: Production lock file for Terraform providers.
  - `IaC/production/homelab/cloudflare-tunnel/terragrunt.hcl`: Terragrunt configuration file.

- **Provider Configurations:**
  - Kubernetes (`hashicorp/kubernetes`) version `~> 2.36`
  - ArgoCD (`argoproj-labs/argocd`) version `7.8.0`
  - AWS (`hashicorp/aws`) version `~> 5.0`

- **Resource Definitions:**
  - `kubernetes_namespace` for Cloudflare Tunnel.
  - `argocd_application` to manage the Cloudflare Tunnel ingress controller.
  - `aws_ssm_parameter` for storing sensitive data.
  - `kubernetes_manifest` for creating ExternalSecret resources.

- **Ingress Changes:**
  - Updated `kubernetes_ingress_v1` resources in `open-webui` module to use `cloudflare-tunnel` ingress class instead of `traefik`.

### Key Learnings & Insights
- **Modularization:** The introduction of a dedicated module for Cloudflare Tunnel enhances reusability and maintainability.
- **Secret Management:** Using AWS SSM for secret storage and ExternalSecrets for Kubernetes improves security and simplifies secret management.
- **Provider Versioning:** Specifying exact versions for Terraform providers ensures consistency and reduces the risk of unexpected changes.
- **ArgoCD Integration:** Leveraging ArgoCD for GitOps practices streamlines deployment and management of Kubernetes applications.

### Impact Assessment
- **Performance:** The switch to Cloudflare Tunnel may offer performance benefits due to Cloudflare’s global network and optimizations.
- **Security:** Enhanced secret management with AWS SSM and ExternalSecrets reduces the risk of exposing sensitive data.
- **Maintainability:** The modular approach and clear separation of concerns make the codebase easier to manage and extend.
- **Breaking Changes:** The change in ingress class from Traefik to Cloudflare Tunnel requires updates in existing ingress configurations.

### Developer Notes
- **Gotchas:** Ensure that the AWS SSM parameters are correctly configured with actual secret values before deployment.
- **Edge Cases:** Monitor the initial deployment closely to catch any issues with the new Cloudflare Tunnel setup.
- **Future Improvements:** Consider automating the update of SSM parameter values to avoid manual intervention.
- **Documentation:** Update any relevant documentation to reflect the changes in ingress management and secret handling.