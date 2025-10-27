--- 
layout: post 
title: Update PostgreSQL image and Umami revision.
date: 2025-10-27T00:29:45.294-04:00
tags: [homelab, terraform, iac, database, monitoring, configuration]
categories: [Homelab]
author: ai
---
### Change Summary
This update involves modifications to the Terraform configuration files for the database and monitoring modules. Specifically, changes have been made to the `main.tf` files within the `IaC/modules/database` and `IaC/modules/monitoring` directories. The database module now specifies a new image repository, while the monitoring module has been updated to use a newer chart version.

### Technical Details
- **Database Module (`IaC/modules/database/main.tf`):**
  - Added a new parameter to the `argocd_application` resource for the PostgreSQL database.
  - The new parameter specifies the `image.repository` as `bitnamilegacy/postgresql`.
  - This change ensures that the PostgreSQL deployment uses a specific image repository, enhancing control over the image version used.

- **Monitoring Module (`IaC/modules/monitoring/main.tf`):**
  - Updated the `target_revision` for the Umami chart from `5.0.8` to `6.0.1`.
  - This revision update likely includes new features, bug fixes, or security patches provided by the Umami chart maintainers.

### Key Learnings & Insights
- **Version Control for Images:** Specifying the `image.repository` explicitly helps in maintaining consistency across environments and avoids unexpected behavior due to automatic image updates.
- **Keeping Charts Updated:** Regularly updating Helm charts ensures that the deployed applications benefit from the latest improvements and security fixes.
- **Configuration Management:** Using Terraform for infrastructure as code (IaC) allows for version-controlled, reproducible infrastructure deployments.

### Impact Assessment
- **Performance:** The change in the image repository might lead to performance improvements or changes depending on the new image's optimizations.
- **Security:** Updating the Umami chart to a newer version enhances security by incorporating the latest patches.
- **Maintainability:** These changes improve maintainability by ensuring that the infrastructure aligns with the latest standards and best practices.
- **Breaking Changes:** There are no immediate breaking changes, but teams should verify that the new image and chart version are compatible with existing configurations.

### Developer Notes
- **Gotchas:** Ensure that the new image repository `bitnamilegacy/postgresql` is accessible and trusted within your deployment environment.
- **Edge Cases:** Verify that the Umami chart version `6.0.1` does not introduce breaking changes or deprecated features used in the current setup.
- **Future Improvements:** Consider automating the process of updating Helm charts and Docker images to streamline future updates and reduce manual intervention.