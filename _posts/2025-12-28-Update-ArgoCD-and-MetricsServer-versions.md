--- 
layout: post 
title: Update ArgoCD and MetricsServer versions.
date: 2025-12-28T07:48:26.586-05:00
tags: [homelab, infrastructure, helm, argocd, metricsserver, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This update involves upgrading two Helm chart versions in our infrastructure-as-code (IaC) configuration. Specifically, the Argo CD Helm chart has been updated from version 9.2.2 to 9.2.3, and the Metrics Server Helm chart has been upgraded from version 3.12.2 to 3.13.0.

### Technical Details
- **Argo CD Update:**
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `9.2.2` to `9.2.3`.
  - Implementation: This is a straightforward version bump intended to incorporate the latest features and bug fixes from the Argo CD project.
  
- **Metrics Server Update:**
  - File: `IaC/modules/metrics/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `3.12.2` to `3.13.0`.
  - Implementation: Similar to the Argo CD update, this version bump aims to leverage improvements and fixes in the Metrics Server chart.

### Key Learnings & Insights
- **Version Management:** Regularly updating Helm charts ensures that we benefit from the latest improvements, security patches, and features.
- **Minimal Impact Changes:** Version upgrades in Helm charts are typically low-risk, provided that proper testing is conducted. This change demonstrates a best practice in maintaining up-to-date dependencies.
- **Automation:** Using IaC for these updates ensures consistency and reduces the potential for human error during deployment.

### Impact Assessment
- **Performance:** The new versions may include performance enhancements that could positively impact the overall system.
- **Security:** Updated versions often contain critical security patches, thereby improving the system's security posture.
- **Maintainability:** Keeping dependencies up-to-date simplifies future upgrades and ensures compatibility with other system components.
- **Breaking Changes:** It is essential to review the release notes for both Argo CD and Metrics Server to ensure there are no breaking changes that require additional configuration adjustments.

### Developer Notes
- **Testing:** Ensure thorough testing of the upgraded charts in a staging environment before promoting to production.
- **Release Notes:** Review the [Argo CD release notes](https://github.com/argoproj/argo-cd/releases) and [Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases) for any migration steps or deprecated features.
- **Future Improvements:** Consider setting up automated checks to notify the team of new Helm chart versions, facilitating timely updates.