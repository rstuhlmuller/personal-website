--- 
layout: post 
title: Update Octobot ArgoCD image strategy.
date: 2025-12-28T22:05:04.875-05:00
tags: [homelab, argocd, image-update, digest-strategy, ci-cd, consistency]
categories: [Homelab]
author: ai
---
### Change Summary
This commit modifies the ArgoCD application configuration for the `octobot` module, specifically updating the image update strategy from `semver` to `digest`.

### Technical Details
- **File Modified:** `IaC/modules/octobot/main.tf`
- **Change:** 
  - Updated the `argocd-image-updater.argoproj.io/octobot.update-strategy` annotation from `semver` to `digest`.
- **Implementation:**
  - The `semver` strategy updates the image based on semantic versioning rules, which can lead to updates when a new minor or patch version is released.
  - The `digest` strategy updates the image only when the container image digest changes, ensuring that the exact image is deployed consistently across environments.

### Key Learnings & Insights
- **Reasoning Behind Changes:**
  - The change to the `digest` strategy ensures that the exact same image is deployed across all environments, reducing the risk of discrepancies due to different semantic versions.
- **Problem-Solving Approach:**
  - Identified inconsistency issues in deployments due to semantic version updates.
  - Decided on a more reliable update strategy that ensures image integrity and consistency.
- **Best Practices:**
  - Using image digests for updates is a best practice in CI/CD pipelines to maintain consistency and avoid unexpected behavior from minor version changes.
- **Trade-offs:**
  - While the `digest` strategy provides more reliability, it may require more frequent manual interventions to trigger updates, as opposed to automatic updates with `semver`.

### Impact Assessment
- **System Impact:**
  - Ensures that the `octobot` application will always deploy the exact same image across all environments, improving consistency and reliability.
- **Performance & Security:**
  - No direct performance impact, but enhances security by ensuring that the deployed image is exactly what was tested and approved.
- **Maintainability:**
  - Simplifies troubleshooting by ensuring that the environment is consistent, reducing variables that could cause issues.

### Developer Notes
- **Gotchas:**
  - Remember to update the image digest manually when a new image needs to be deployed.
- **Edge Cases:**
  - Ensure that the CI/CD pipeline is configured to handle image digest updates appropriately.
- **Future Improvements:**
  - Consider automating the process of updating image digests in a controlled manner to balance between automation and consistency.