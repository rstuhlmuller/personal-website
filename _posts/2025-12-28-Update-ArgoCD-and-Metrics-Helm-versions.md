--- 
layout: post 
title: Update ArgoCD and metrics Helm versions.
date: 2025-12-28T07:48:35.542-05:00
tags: [homelab, argo\_cd, metrics\_server, helm\_chart, version\_update, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff involves updates to the Helm chart versions for two components within our Infrastructure as Code (IaC) setup: Argo CD and Metrics Server. Specifically, the Argo CD Helm chart has been updated from version 9.2.2 to 9.2.3, and the Metrics Server Helm chart has been updated from version 3.12.2 to 3.13.0.

### Technical Details
- **Argo CD Update:**
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `"9.2.2"` to `"9.2.3"`.
  - This indicates a minor version update which typically includes bug fixes and minor enhancements.

- **Metrics Server Update:**
  - File: `IaC/modules/metrics/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `"3.12.2"` to `"3.13.0"`.
  - Similar to the Argo CD update, this is a minor version bump expected to contain bug fixes and performance improvements.

### Key Learnings & Insights
- **Version Management:** Regularly updating Helm charts to their latest minor versions is a best practice to ensure the system benefits from the latest bug fixes and improvements.
- **Change Minimalism:** The changes are confined to version updates, indicating a focus on stability and incremental improvement rather than radical overhauls.
- **Documentation:** Clear versioning in the IaC files allows for easy tracking of changes and rollbacks if necessary.

### Impact Assessment
- **Performance:** Both updates are expected to bring performance improvements and bug fixes, enhancing the overall stability and efficiency of the Argo CD and Metrics Server components.
- **Security:** Minor version updates often include security patches, contributing to a more secure environment.
- **Maintainability:** Keeping dependencies up-to-date simplifies maintenance and reduces technical debt.

### Developer Notes
- **Testing:** Ensure thorough testing of the Argo CD and Metrics Server functionalities post-update to confirm that the new versions do not introduce regressions.
- **Rollback Plan:** Have a rollback plan in place in case the updates introduce unforeseen issues.
- **Future Improvements:** Consider setting up automated tools to monitor and suggest updates for Helm charts and other dependencies.