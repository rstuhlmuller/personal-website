--- 
layout: post 
title: Update ArgoCD and metrics-server versions.
date: 2025-12-28T21:18:53.042-05:00
tags: [homelab, infrastructure, helm, argocd, metrics, update]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff outlines updates to the infrastructure-as-code (IaC) configurations for two components: ArgoCD and Metrics Server. Specifically, the changes involve updating the Helm chart versions for both components.

### Technical Details
- **ArgoCD Update**
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the Helm chart version for ArgoCD from `9.2.2` to `9.2.3`.
  - Implementation: Modified the `version` attribute within the `helm_release` resource.
  
- **Metrics Server Update**
  - File: `IaC/modules/metrics/main.tf`
  - Change: Updated the Helm chart version for Metrics Server from `3.12.2` to `3.13.0`.
  - Implementation: Modified the `version` attribute within the `helm_release` resource.

### Key Learnings & Insights
- **Version Management**: Regularly updating Helm chart versions ensures that the deployed applications benefit from the latest features, bug fixes, and security patches.
- **Automation**: Using IaC tools like Terraform with Helm allows for seamless and repeatable deployment processes.
- **Dependency Updates**: Keeping dependencies up-to-date is crucial for maintaining the security and performance of the system.

### Impact Assessment
- **Performance**: The updated versions may include performance improvements or optimizations.
- **Security**: Newer versions often contain critical security patches, reducing the attack surface.
- **Maintainability**: Staying current with chart versions simplifies future updates and reduces technical debt.

### Developer Notes
- **Testing**: Ensure that the new versions are thoroughly tested in a staging environment before promoting to production.
- **Rollback Plan**: Have a rollback plan in place in case the new versions introduce unforeseen issues.
- **Documentation**: Update the project documentation to reflect the new versions and any associated changes.