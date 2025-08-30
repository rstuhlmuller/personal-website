--- 
layout: post 
title: Cloudflare Tunnel Module Documentation.
date: 2025-08-30T16:02:44.497-04:00
tags: [homelab, cloudflare-tunnel, terraform, kubernetes, argocd, infrastructure-as-code]
categories: [Homelab]
author: ai
---
**Change Summary**
This update introduces a new Cloudflare Tunnel module to replace the existing Traefik ingress setup. The changes include the creation of a new Terraform module for managing Cloudflare Tunnel resources, updating provider configurations, and modifying ingress resources to use the Cloudflare Tunnel ingress class.

**Technical Details**
- **New Module Creation**: A new Terraform module located at `IaC/modules/cloudflare-tunnel` has been created. This module includes:
  - `init.tf`: Defines required providers (Kubernetes, ArgoCD, AWS) and local variables.
  - `main.tf`: Creates a Kubernetes namespace and an ArgoCD application for the Cloudflare Tunnel.
  - `secrets.tf`: Manages AWS SSM parameters and Kubernetes secrets for storing Cloudflare Tunnel credentials.
- **Provider Configurations**: 
  - `IaC/_envcommon/cloudflare-tunnel.hcl`: Includes root and provider configurations for Kubernetes, ArgoCD, and AWS.
  - `IaC/modules/cloudflare-tunnel/init.tf`: Specifies required provider versions.
- **Ingress Updates**: 
  - `IaC/modules/open-webui/ingress.tf`: Modifies existing ingress resources to use the `cloudflare-tunnel` ingress class instead of `traefik`. Removes Traefik-specific annotations and TLS configurations.

**Key Learnings & Insights**
- **Modularization**: The introduction of a dedicated module for Cloudflare Tunnel enhances maintainability and reusability. 
- **Provider Management**: Explicitly defining provider versions ensures consistency across environments.
- **Secret Management**: Using AWS SSM parameters and Kubernetes ExternalSecrets improves security by centralizing secret management.

**Impact Assessment**
- **Performance**: Cloudflare Tunnel may offer improved performance and security compared to Traefik, particularly in handling HTTPS traffic.
- **Maintainability**: The modular approach simplifies future updates and management of Cloudflare Tunnel resources.
- **Breaking Changes**: The ingress class change requires updates to any existing ingress configurations to ensure compatibility.

**Developer Notes**
- **Gotchas**: Ensure that Cloudflare Tunnel credentials are correctly set in AWS SSM parameters before applying changes.
- **Future Improvements**: Consider automating the update of SSM parameter values to avoid manual intervention.
- **Context for Future Developers**: Understand the rationale behind switching to Cloudflare Tunnel for improved performance and security.