--- 
layout: post 
title: Update Homarr ArgoCD with annotations.
date: 2025-10-23T19:56:47.125-04:00
tags: [homelab, infrastructure, argocd, image-management, automation, best-practices]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces changes to the `main.tf` file within the `homarr` module of the Infrastructure as Code (IaC) repository. The primary modification involves updating the ArgoCD application configuration to manage image updates more effectively.

### Technical Details
- **File Modified:** `IaC/modules/homarr/main.tf`
- **Resource Affected:** `argocd_application` named "homarr"
- **Annotations Added:**
  - `argocd-image-updater.argoproj.io/image-list`: Specifies the Docker image for Homarr as `ghcr.io/homarr-labs/homarr:v1`.
  - `argocd-image-updater.argoproj.io/homarr.update-strategy`: Sets the update strategy to "semver" (semantic versioning).
- **Removed Configuration:**
  - The `parameter` block that set `image.tag` to "latest" has been removed.

### Key Learnings & Insights
- **Effective Image Management:** By specifying a concrete version (`v1`) and employing a semantic versioning strategy, the configuration ensures that image updates are controlled and predictable. This reduces the risk associated with pulling the "latest" tag, which can introduce breaking changes.
- **Automation of Updates:** The added annotations leverage ArgoCD's image updater to automate the process of updating container images based on semantic versioning rules. This enhances maintainability and ensures that the deployment pipeline remains up-to-date with minimal manual intervention.
- **Best Practices:** The change demonstrates a best practice in container image management by avoiding the use of the "latest" tag and instead opting for a versioned approach combined with an automated update strategy.

### Impact Assessment
- **System Stability:** The change enhances system stability by ensuring that image updates are managed in a controlled manner, reducing the likelihood of unexpected failures due to new image versions.
- **Maintainability:** Automation of image updates simplifies maintenance tasks, allowing developers to focus on feature development rather than manual update processes.
- **No Breaking Changes:** This change does not introduce breaking changes but requires awareness among team members about the new automated update process.

### Developer Notes
- **Gotchas:** Ensure that the specified Docker image (`ghcr.io/homarr-labs/homarr:v1`) exists and is correctly tagged. Otherwise, the ArgoCD application will fail to deploy.
- **Future Improvements:** Consider extending the semantic versioning strategy to other microservices within the deployment to maintain consistency across the system.
- **Monitoring:** Implement monitoring to track image updates and their impact on the system, allowing for quick rollbacks if necessary.