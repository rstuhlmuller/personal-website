--- 
layout: post 
title: ArgoCD and Metrics Server version update.
date: 2025-12-28T21:18:43.627-05:00
tags: [homelab, argocd, metricsserver, helmcharts, infrastructure, updates]
categories: [Homelab]
author: ai
---
### Change Summary
This update primarily focuses on upgrading two critical components within our infrastructure-as-code (IaC) setup: Argo CD and Metrics Server. The changes involve updating the Helm chart versions for both services to incorporate the latest features, bug fixes, and security patches.

### Technical Details
- **Argo CD Update**:
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the Argo CD Helm chart version from `9.2.2` to `9.2.3`.
  - Implementation: Modified the `version` attribute within the `helm_release` resource for Argo CD.
  
- **Metrics Server Update**:
  - File: `IaC/modules/metrics/main.tf`
  - Change: Updated the Metrics Server Helm chart version from `3.12.2` to `3.13.0`.
  - Implementation: Modified the `version` attribute within the `helm_release` resource for Metrics Server.

### Key Learnings & Insights
- **Reasoning Behind Changes**:
  - Keeping our infrastructure components up-to-date is crucial for security, performance, and feature enhancements. The updates to Argo CD and Metrics Server ensure that we benefit from the latest improvements and fixes.
- **Problem-Solving Approach**:
  - A systematic approach was used to identify the components requiring updates. This involved reviewing release notes and changelogs for both Argo CD and Metrics Server.
- **Best Practices**:
  - Regularly scheduled reviews and updates of Helm chart versions help maintain a secure and efficient infrastructure.
  - Versioning should be managed carefully to avoid breaking changes, ensuring a smooth deployment process.

### Impact Assessment
- **Overall System Impact**:
  - These updates are expected to enhance the stability and security of our CI/CD pipeline (Argo CD) and monitoring capabilities (Metrics Server).
- **Performance & Security**:
  - The new versions may include performance optimizations and security patches, contributing to a more robust system.
- **Breaking Changes**:
  - No breaking changes are anticipated from these minor version updates. However, it is always good practice to test in a staging environment before rolling out to production.

### Developer Notes
- **Gotchas & Edge Cases**:
  - Ensure that all dependencies and configurations are compatible with the new Helm chart versions.
  - Monitor the deployment closely for any unforeseen issues, particularly with custom configurations or values.
- **Future Improvements**:
  - Consider implementing automated version checks and updates for Helm charts to streamline the update process.
  - Explore the possibility of canary releases for critical infrastructure components to minimize risk.