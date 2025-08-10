--- 
layout: post 
title: Litellm Terraform Module Setup
date: 2025-08-08T01:51:29.463-04:00
tags: [homelab, documentation]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces a new Infrastructure as Code (IaC) module for deploying LiteLLM, an open-source proxy for large language models (LLMs), into a Kubernetes cluster managed by ArgoCD. Key additions include Terraform configurations for creating a dedicated namespace, deploying the LiteLLM application via Helm, managing secrets with AWS SSM Parameter Store and External Secrets Operator, and integrating TLS certificates with cert-manager. Existing Open WebUI configurations are updated to point to the new LiteLLM endpoint instead of OpenRouter, enabling a unified proxy for multiple LLM providers (e.g., AWS Bedrock models). No removals are present; this is primarily additive to support LLM proxying in a homelab environment.

### Technical Details
The changes span multiple files and focus on modular IaC using Terragrunt and Terraform. They leverage Kubernetes, ArgoCD, AWS SSM, and cert-manager for deployment and secrets management.

- **IaC/_envcommon/litellm.hcl and IaC/production/homelab/litellm/terragrunt.hcl**: These new files define a Terragrunt configuration for the LiteLLM module. It includes root and provider configurations (e.g., Kubernetes and ArgoCD providers) and sources the Terraform module from `IaC/modules/litellm`. This setup ensures consistent environment-agnostic deployments while inheriting global settings.

- **IaC/modules/litellm/init.tf**: Initializes Terraform with required providers (Kubernetes ~>2.36 and ArgoCD 7.8.0) and defines local tags for resource labeling (e.g., `Module = "self/litellm"`). This prepares the module for cluster interactions and resource tracking.

- **IaC/modules/litellm/main.tf**: 
  - Creates a Kubernetes namespace `litellm` using `kubernetes_namespace`.
  - Deploys an ArgoCD application `argocd_application.litellm` sourcing from the LiteLLM GitHub repo's Helm chart. Custom Helm values disable the migration job, use a non-root image (`ghcr.io/berriai/litellm-non_root:main-v1.65.3-nightly`), connect to an existing PostgreSQL database (`postgresql.database.svc.cluster.local:5432`), enable Traefik ingress for `litellm.stinkyboi.com`, and configure a model list for AWS Bedrock LLMs (e.g., "Nova Pro" mapped to `bedrock/amazon.nova-pro-v1:0` in us-west-2).
  - Adds a cert-manager Certificate resource (`kubernetes_manifest.litellm_tls`) for TLS on the ingress, referencing a Cloudflare ClusterIssuer and DNS name `litellm.stinkyboi.com`.
  - Enables ArgoCD image updater annotations for automatic updates to the latest LiteLLM image.

- **IaC/modules/litellm/secrets.tf**:
  - Provisions AWS SSM parameters for database credentials (`username`, `password`) and environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION_NAME`) under `/homelab/litellm/...`. Values are placeholders ("update_me") with lifecycle ignores for manual updates.
  - Creates External Secrets manifests (`kubernetes_manifest.litellm_secret` and `litellm_env_secret`) to sync these SSM parameters into Kubernetes secrets (`postgres` and `litellm-env`), using a ClusterSecretStore named `parameterstore` with an "OnChange" refresh policy.

- **IaC/modules/open-webui/main.tf and secrets.tf**: Updates the Open WebUI ArgoCD application to change `openaiBaseApiUrl` from `https://openrouter.ai/api/v1` to `https://litellm.stinkyboi.com/`, routing API calls through the new LiteLLM proxy. Also switches the External Secret refresh policy from "Periodic" (with 10m interval) to "OnChange" for more efficient secret synchronization.

No major architectural changes, but this introduces a proxy layer pattern for LLM access, decoupling clients like Open WebUI from direct provider APIs. Dependencies include ArgoCD for app management, External Secrets for secret injection, and cert-manager for TLS.

### Key Learnings & Insights
The primary motivation is to centralize LLM access through LiteLLM, allowing seamless integration of multiple providers (e.g., AWS Bedrock models like Claude Sonnet 4 and DeepSeek-R1) without client-side changes. This addresses fragmentation in LLM ecosystems by providing a unified OpenAI-compatible API endpoint, reducing vendor lock-in and simplifying model switching.

Problem-solving approaches include using ArgoCD for GitOps-driven deployments, ensuring reproducibility and automated syncing. Secrets management follows best practices by storing sensitive data in AWS SSM (encrypted) and injecting via External Secrets, avoiding hard-coded values in Git. The "OnChange" refresh policy optimizes for efficiency over periodic polling, reducing unnecessary API calls.

Lessons learned emphasize modular IaC: Terragrunt's includes promote reuse across environments, while placeholders like "update_me" encourage secure manual updates post-deployment. Trade-offs include relying on an external Git repo for the Helm chart (risking upstream changes) versus forking for stability, and choosing a non-root container image for security, which might require additional permissions in restrictive environments.

### Impact Assessment
These changes add a new LiteLLM service to the Kubernetes cluster, acting as an intermediary for LLM requests from Open WebUI, potentially improving system flexibility by enabling easy model additions/removals via config. Performance-wise, it introduces minimal latency as a proxy but could enhance efficiency through caching or routing optimizations in LiteLLM. Security benefits from TLS enforcement and secret injection, though it exposes a new ingress endpoint (`litellm.stinkyboi.com`), requiring proper firewalling. Maintainability improves with GitOps, but adds dependencies on AWS SSM and External Secrets.

No breaking changes for existing services, but Open WebUI users must migrate to the new API URL; test thoroughly to ensure model compatibility. Overall, this enhances the homelab's AI capabilities without disrupting core functionality.

### Developer Notes
- **Gotchas and Edge Cases**: Update SSM parameter values manually after deployment (e.g., via AWS Console) as they're ignored in Terraform; failure to do so will cause auth errors. Watch for Bedrock model availability in the specified AWS region (us-west-2) – test with low-traffic requests to avoid rate limits. If the PostgreSQL endpoint changes, update the Helm values accordingly to prevent connection failures.
- **Context for Future Developers**: This module assumes a pre-existing PostgreSQL instance and ClusterSecretStore; extend the `proxy_config.model_list` in main.tf for new models. The non-root image enhances security but monitor pod logs for permission issues.
- **Potential Future Improvements**: Add monitoring (e.g., Prometheus metrics for LiteLLM requests), implement auto-scaling based on traffic, or integrate with more providers like OpenAI directly. Consider versioning the Helm chart's `target_revision` beyond "HEAD" for stability, and add Checkov skips or KMS encryption to SSM parameters for compliance.