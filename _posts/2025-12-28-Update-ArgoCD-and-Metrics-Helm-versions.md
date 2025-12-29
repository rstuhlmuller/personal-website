--- 
layout: post 
title: Update ArgoCD and Metrics Helm versions.
date: 2025-12-28T21:18:09.779-05:00
tags: [homelab, infrastructure, helm, argocd, metrics, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This update involves upgrading two Helm chart versions within our Infrastructure as Code (IaC) modules. Specifically, the ArgoCD Helm chart has been updated from version 9.2.2 to 9.2.3, and the Metrics Server Helm chart has been upgraded from version 3.12.2 to 3.13.0.

### Technical Details
- **ArgoCD Module Update**:
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource for ArgoCD from `9.2.2` to `9.2.3`.
  - Implementation: This is a straightforward version bump intended to incorporate the latest features and bug fixes from the ArgoCD project.

- **Metrics Server Module Update**:
  - File: `IaC/modules/metrics/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource for Metrics Server from `3.12.2` to `3.13.0`.
  - Implementation: Similar to the ArgoCD update, this version change aims to leverage improvements and fixes in the Metrics Server chart.

### Key Learnings & Insights
- **Version Management**: Regularly updating Helm charts ensures that the deployed applications benefit from the latest enhancements, security patches, and bug fixes.
- **Automation**: Using IaC for these updates streamlines the process, reducing manual effort and the potential for human error.
- **Change Control**: Version bumps should be thoroughly tested in a staging environment before being promoted to production to mitigate risks associated with new releases.

### Impact Assessment
- **Performance**: The new versions may include performance improvements that could positively impact the overall system.
- **Security**: Updated charts often include security patches, enhancing the system's security posture.
- **Maintainability**: Keeping dependencies up-to-date simplifies future upgrades and maintains compatibility with other system components.
- **Breaking Changes**: It is essential to review the release notes for both ArgoCD and Metrics Server to identify any breaking changes that might require additional configuration adjustments or migration steps.

### Developer Notes
- **Testing**: Ensure comprehensive testing of the new versions in a staging environment to catch any potential issues before deployment.
- **Documentation**: Update the deployment documentation to reflect the new versions and any associated configuration changes.
- **Monitoring**: Post-deployment, monitor the system closely for any anomalies or performance regressions.
- **Future Improvements**: Consider setting up automated checks to notify the team of new Helm chart versions, facilitating timely updates.