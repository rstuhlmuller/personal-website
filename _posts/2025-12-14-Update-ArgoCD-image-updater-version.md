--- 
layout: post 
title: Update ArgoCD image updater version.
date: 2025-12-14T19:46:07.279-05:00
tags: [homelab, helm, argocd, image-updater, version-update, kubernetes]
categories: [Homelab]
author: ai
---
### Change Summary
This change updates the Helm chart version for the Argo CD Image Updater from `0.14.0` to `1.0.2`. The update is made in the `main.tf` file within the Argo CD module.

### Technical Details
- **File Modified:** `IaC/modules/argocd/main.tf`
- **Change:** The version of the `argocd-image-updater` Helm chart was updated from `0.14.0` to `1.0.2`.
- **Helm Release Configuration:**
  ```hcl
  resource "helm_release" "argocd_image_updater" {
    name       = "argocd-image-updater"
    chart      = "argocd-image-updater"
    repository = "https://argoproj.github.io/argo-helm"
    - version    = "0.14.0"
    + version    = "1.0.2"
    namespace  = kubernetes_namespace.argocd.metadata[0].name
    wait       = true
  }
  ```

### Key Learnings & Insights
- **Reason for Update:** The update to version `1.0.2` likely includes bug fixes, new features, and security patches that were not present in version `0.14.0`.
- **Problem-Solving Approach:** Regularly updating Helm charts ensures that the deployed applications benefit from the latest improvements and security updates.
- **Best Practices:** 
  - Always check the release notes of new versions before applying them to understand the changes and potential impacts.
  - Use version control and testing environments to validate updates before deploying them to production.

### Impact Assessment
- **System Performance:** The new version may include optimizations that could improve the performance of the Argo CD Image Updater.
- **Security:** Updating to a newer version typically incorporates the latest security patches, reducing vulnerabilities.
- **Maintainability:** Staying up-to-date with the latest chart versions simplifies future updates and maintenance.
- **Breaking Changes:** It’s crucial to review the release notes for any breaking changes that might require adjustments in the configuration or code.

### Developer Notes
- **Gotchas:** Ensure that the new version is compatible with the existing Kubernetes cluster and other dependencies.
- **Edge Cases:** Test the update in a staging environment to catch any unforeseen issues before rolling it out to production.
- **Future Improvements:** Consider setting up automated checks to regularly monitor for new Helm chart versions and assess their impact on the current setup.