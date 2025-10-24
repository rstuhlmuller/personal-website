--- 
layout: post 
title: Updated ArgoCD and ExternalSecrets versions.
date: 2025-10-24T11:55:30.065-04:00
tags: [homelab, infrastructure, helm, argocd, externalsecrets, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff reflects updates to the Helm chart versions for two key components in our infrastructure-as-code (IaC) setup: Argo CD and External Secrets. Specifically, the Argo CD Helm chart has been updated from version 9.0.3 to 9.0.5, and the External Secrets Helm chart has been updated from version 0.20.3 to 0.20.4. These updates aim to incorporate the latest features, bug fixes, and security patches provided by the respective chart maintainers.

### Technical Details
- **Argo CD Update**:
  - File: `IaC/modules/argocd/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `9.0.3` to `9.0.5`.
  - Implementation: This is a straightforward version bump within the Terraform configuration, ensuring that the Argo CD deployment utilizes the latest chart version available.

- **External Secrets Update**:
  - File: `IaC/modules/external-secrets/main.tf`
  - Change: Updated the `version` attribute of the `helm_release` resource from `0.20.3` to `0.20.4`.
  - Implementation: Similar to the Argo CD update, this involves a version change in the Terraform configuration to adopt the newer Helm chart version.

### Key Learnings & Insights
- **Importance of Regular Updates**: Keeping Helm charts up-to-date is crucial for leveraging the latest improvements and security enhancements. This practice helps maintain a robust and secure infrastructure.
- **Simplicity in Version Management**: The changes demonstrate how simple it can be to update dependencies in IaC configurations, emphasizing the importance of regular audits and updates.
- **Documentation and Change Management**: Clear documentation of such changes ensures that the team is aware of the updates and their implications, fostering a culture of transparency and collaboration.

### Impact Assessment
- **Performance**: The updates are unlikely to have a significant performance impact, as they primarily incorporate incremental improvements and bug fixes.
- **Security**: These updates may include critical security patches, enhancing the overall security posture of the deployed applications.
- **Maintainability**: Regularly updating Helm charts simplifies maintenance by ensuring compatibility with the latest Kubernetes versions and ecosystem changes.
- **Breaking Changes**: It is essential to review the release notes for both Argo CD and External Secrets to identify any breaking changes that might require additional configuration adjustments or migration steps.

### Developer Notes
- **Review Release Notes**: Before applying these changes, developers should review the release notes for both Argo CD and External Secrets to understand the full scope of changes, including any breaking changes or new features.
- **Testing**: Ensure comprehensive testing post-update to verify that the new versions do not introduce regressions or unforeseen issues.
- **Future Improvements**: Consider implementing a automated process for regularly checking and updating Helm chart versions to streamline this process further.