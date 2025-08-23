--- 
layout: post 
title: Update Homelab Modules with New Features
date: 2025-08-23T12:27:10.810-04:00
tags: [homelab, infrastructure, terraform, argocd, helm, configuration]
categories: [Homelab]
author: ai
---
### Change Summary
This update involves several modifications across multiple Terraform configuration files within the IaC (Infrastructure as Code) modules. Key changes include updates to ArgoCD application configurations, image tags, and the introduction of new annotations for image update strategies. Additionally, there are changes to resource definitions and the removal of several files related to the `technitium-dns` Helm chart.

### Technical Details
- **Homeassistant Module**:
  - Added annotations for image update strategy in `main.tf`.
- **Litellm Module**:
  - Updated image tag to `main-stable`.
  - Modified Helm values to include new configuration settings for proxy and model lists.
  - Added new models (`gpt-5-2025-08-07`, `gpt-3.5-turbo`, `gpt-image-1`) with API keys fetched from environment variables.
- **Litellm Secrets**:
  - Added `OPENAI_API_KEY` to the list of SSM parameters.
- **Open-WebUI Module**:
  - Set image tag to `0.6`.
  - Added new commands for sequential thinking and fetch operations.
- **Tailscale Module**:
  - Added annotations for image update strategy in `main.tf`.
- **Technitium Module**:
  - Created a Persistent Volume Claim (PVC) for configuration storage.
  - Updated ArgoCD application to point to a new repository and chart path.
  - Removed several Helm chart files (`.helmignore`, `Chart.yaml`, `NOTES.txt`, `_helpers.tpl`, `deployment.yaml`, `pvc.yaml`, `role_config.yaml`, `service.yaml`, `values.yaml`).

### Key Learnings & Insights
- **Image Update Strategies**: The introduction of annotations for image update strategies (`semver`) ensures that applications can automatically update to new compatible image versions, enhancing maintenance and reducing manual intervention.
- **Configuration Management**: The use of environment variables for sensitive data (like API keys) improves security by avoiding hard-coded secrets in the configuration files.
- **Modularization**: The removal of the `technitium-dns` Helm chart files and the introduction of a PVC for configuration indicate a shift towards more modular and reusable infrastructure components.

### Impact Assessment
- **Performance**: The changes are unlikely to have a significant performance impact but may improve maintainability and security through automated updates and better configuration management.
- **Security**: The use of environment variables for sensitive data enhances security by reducing the risk of exposing secrets in configuration files.
- **Maintainability**: The introduction of image update annotations and the modularization of components will likely improve the maintainability of the infrastructure.

### Developer Notes
- **Gotchas**: Ensure that all environment variables, especially `OPENAI_API_KEY`, are correctly set in the deployment environment to avoid configuration errors.
- **Future Improvements**: Consider adding more granular access controls and monitoring for the new configurations to further enhance security and observability.
- **Migration**: The removal of the `technitium-dns` Helm chart files requires verifying that all dependent services are correctly configured with the new PVC and ArgoCD application settings.