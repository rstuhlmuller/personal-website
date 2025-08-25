--- 
layout: post 
title: Tailscale module revision update documentation.
date: 2025-08-24T21:06:57.727-04:00
tags: [homelab, infrastructure, argocd, tailscale, helm, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff reflects updates to the Tailscale module within an Infrastructure as Code (IaC) setup. Specifically, changes have been made to the `main.tf` file to adjust the Tailscale application configuration in Argo CD. The primary modifications include the removal of certain annotations and an update to the target revision of the Tailscale Helm chart.

### Technical Details
- **File Modified:** `IaC/modules/tailscale/main.tf`
- **Resource:** `argocd_application` named "tailscale"
  - **Removed Annotations:**
    - `argocd-image-updater.argoproj.io/image-list`
    - `argocd-image-updater.argoproj.io/tailscale.update-strategy`
    - `argocd-image-updater.argoproj.io/tailscale.helm.image-name`
    - `argocd-image-updater.argoproj.io/tailscale.helm.image-tag`
  - **Updated Target Revision:**
    - Changed from `1.82.5` to `1.86.5` for the Tailscale Helm chart

### Key Learnings & Insights
- **Simplification of Configuration:** The removal of annotations suggests a simplification of the image update strategy. This could indicate a shift towards a more manual or alternative automated approach for managing image updates.
- **Version Upgrade:** The update to the Tailscale Helm chart revision from `1.82.5` to `1.86.5` likely incorporates new features, bug fixes, or security patches. This demonstrates a commitment to keeping dependencies up-to-date.

### Impact Assessment
- **Performance & Security:** Upgrading to a newer version of the Tailscale Helm chart may introduce performance improvements and security enhancements. However, it is crucial to verify that the new version is compatible with the existing infrastructure.
- **Maintainability:** Removing specific annotations might reduce the complexity of the configuration, making it easier to maintain. However, it could also mean losing some automated update capabilities, which should be carefully considered.
- **Breaking Changes:** Ensure that the new Helm chart version does not introduce breaking changes that could affect the deployment. Thorough testing is recommended.

### Developer Notes
- **Gotchas:** Be aware that the removal of annotations might require manual intervention for future image updates. Ensure that alternative update mechanisms are in place.
- **Future Improvements:** Consider documenting the rationale behind the removal of annotations and the decision-making process for version upgrades. This will help future developers understand the context and make informed decisions.
- **Testing:** Validate the new configuration in a staging environment before deploying to production to ensure compatibility and stability.