--- 
layout: post 
title: Update Octobot ArgoCD strategy digest.
date: 2025-12-28T22:05:05.698-05:00
tags: [homelab, argocd, image-update, digest, semver, ci/cd]
categories: [Homelab]
author: ai
---
### Change Summary
This change updates the image update strategy for the `octobot` Argo CD application from `semver` to `digest`.

### Technical Details
- **File:** `IaC/modules/octobot/main.tf`
- **Change:** 
  ```diff
  -      "argocd-image-updater.argoproj.io/octobot.update-strategy" = "semver"
  +      "argocd-image-updater.argoproj.io/octobot.update-strategy" = "digest"
  ```
- **Explanation:**
  - The `argocd_application` resource for `octobot` had its update strategy modified.
  - Previously, the strategy was set to `semver`, which updates the image based on semantic versioning.
  - Now, it is set to `digest`, which updates the image only when the image digest changes.

### Key Learnings & Insights
- **Reasoning:** 
  - The change to `digest` ensures that the application uses the exact image that was built and tested, reducing the risk of deploying an unintended version.
  - Semantic versioning (`semver`) can lead to deploying a new patch version that might contain unexpected changes.
- **Problem-Solving Approach:**
  - Identified the need for more precise control over image updates to avoid potential issues with new patch versions.
  - Chose `digest` to ensure that the deployed image is identical to the one that passed all tests.
- **Best Practices:**
  - Using image digests is a best practice for ensuring consistency and reliability in deployments.
  - This approach minimizes the risk associated with automatic updates.

### Impact Assessment
- **System Impact:**
  - The application will now only update when the image digest changes, ensuring that the exact image is deployed.
- **Performance Implications:**
  - No direct performance impact, but potentially fewer updates, which could slightly reduce the load on the CI/CD pipeline.
- **Security & Maintainability:**
  - Enhances security by ensuring that only tested images are deployed.
  - Improves maintainability by reducing the chances of deploying unintended changes.

### Developer Notes
- **Gotchas:**
  - Ensure that the CI/CD pipeline is configured to update the image digest correctly.
  - Verify that the Argo CD application syncs properly after this change.
- **Future Improvements:**
  - Consider automating the process of updating the image digest in the Terraform configuration as part of the CI/CD pipeline.
  - Monitor the deployment frequency and adjust the strategy if necessary based on team feedback and deployment patterns.