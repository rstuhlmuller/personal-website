--- 
layout: post 
title: Update Octobot module to digest strategy.
date: 2025-12-28T22:11:10.326-05:00
tags: [homelab, argocd, image-update, digest, stability, best-practices]
categories: [Homelab]
author: ai
---
### Change Summary
This change updates the image update strategy for the `octobot` application in the Argo CD configuration. Specifically, the update strategy has been changed from `semver` to `digest`.

### Technical Details
- **File Modified:** `IaC/modules/octobot/main.tf`
- **Resource:** `argocd_application` with the name `octobot`
- **Change:** 
  - The annotation `argocd-image-updater.argoproj.io/octobot.update-strategy` was updated from `semver` to `digest`.

### Key Learnings & Insights
- **Reasoning Behind the Change:**
  - The `semver` strategy updates the image whenever a new semantic version is available. However, this can lead to unintended updates if the new version introduces breaking changes or bugs.
  - The `digest` strategy ensures that the image is updated only when the content of the image (as identified by its digest) changes. This provides more control and stability, ensuring that the application is only updated when the image content has actually changed.

- **Problem-Solving Approach:**
  - The team identified instability issues caused by automatic semantic version updates. By switching to the digest strategy, they aim to reduce the risk of deploying unstable versions.

- **Best Practices Demonstrated:**
  - Using digest-based updates for critical applications to ensure stability and reduce the risk of deploying broken images.
  - Regularly reviewing and adjusting update strategies based on the application's stability and deployment requirements.

### Impact Assessment
- **System Impact:**
  - This change will make the `octobot` application more stable by ensuring that it is only updated when the image content has changed, rather than on every new semantic version release.
- **Performance Implications:**
  - No direct performance changes are expected, but the application should experience fewer unexpected disruptions due to unstable image updates.
- **Security Implications:**
  - Enhanced security through more controlled and verified image updates.
- **Maintainability:**
  - Easier to maintain as developers can be more confident in the stability of the deployed images.

### Developer Notes
- **Gotchas:**
  - Ensure that the CI/CD pipeline is configured to handle digest-based updates correctly.
  - Monitor the update process to confirm that images are only updated when necessary.
- **Future Improvements:**
  - Consider implementing additional checks or automated testing before allowing digest-based updates to proceed.
  - Explore the possibility of combining semver and digest strategies for a hybrid approach that balances automation and control.