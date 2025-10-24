--- 
layout: post 
title: Update Helm chart versions in Terraform.
date: 2025-10-24T11:55:37.068-04:00
tags: [homelab, argocd, externalsecrets, helmcharts, iac, versionupdate]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff reflects updates to the Helm chart versions for two key components in our infrastructure-as-code (IaC) setup: Argo CD and External Secrets. Specifically, the Argo CD Helm chart has been updated from version 9.0.3 to 9.0.5, and the External Secrets Helm chart has been updated from version 0.20.3 to 0.20.4.

### Technical Details
- **Argo CD Update**:
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `9.0.3` to `9.0.5`.
  - This update ensures that the Argo CD deployment utilizes the latest features and bug fixes available in version 9.0.5.
  
- **External Secrets Update**:
  - File: `IaC/modules/external-secrets/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `0.20.3` to `0.20.4`.
  - This modification aligns the External Secrets deployment with the newest version, incorporating recent enhancements and security patches.

### Key Learnings & Insights
- **Importance of Regular Updates**:
  - Keeping Helm charts up-to-date is crucial for leveraging the latest improvements and security fixes.
- **Minimal Impact Changes**:
  - These version updates are typically minor and should not introduce breaking changes, but it’s important to verify compatibility with the existing setup.
- **Automation and CI/CD**:
  - Incorporating version update checks within CI/CD pipelines can help maintain up-to-date dependencies with minimal manual intervention.

### Impact Assessment
- **Performance**:
  - Minor version updates like these are unlikely to have a significant performance impact but may include optimizations that offer slight improvements.
- **Security**:
  - These updates may include critical security patches, enhancing the overall security posture of the deployment.
- **Maintainability**:
  - Staying current with Helm chart versions simplifies future updates and reduces technical debt.

### Developer Notes
- **Verification**:
  - After applying these changes, verify that the Argo CD and External Secrets deployments function as expected within the Kubernetes cluster.
- **Rollback Plan**:
  - Ensure a rollback plan is in place in case the new versions introduce unforeseen issues.
- **Future Improvements**:
  - Consider automating the version update process to streamline dependency management in the future.