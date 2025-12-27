--- 
layout: post 
title: Workflows, IaC, and tools updates.
date: 2025-12-26T21:33:42.361-05:00
tags: [homelab, terragrunt, opentofu, cicd, infrastructure, hcl]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff encompasses several significant changes, primarily focused on enhancing and standardizing the CI/CD pipeline for deploying and planning infrastructure using Terragrunt and OpenTofu. The changes include the addition of new GitHub Actions workflows, updates to HCL and Terraform configurations, and the introduction of a new `mise.toml` file for managing tool versions.

### Technical Details
- **New GitHub Actions Workflows:**
  - **`deploy.yml`:** This workflow is triggered on pushes to the `main` branch and manual dispatches. It includes jobs for checking Terragrunt HCL and deploying infrastructure using Terragrunt and OpenTofu. It configures AWS credentials and uses Tailscale for networking.
  - **`plan.yml`:** This workflow is triggered on pull requests to the `main` branch. It includes jobs for checking Terragrunt HCL and planning infrastructure changes using Terragrunt and OpenTofu. It also configures AWS credentials and uses Tailscale.

- **HCL and Terraform Configurations:**
  - **`metrics.hcl`:** Includes a new `kube_provider` configuration.
  - **`helm.hcl` and `kube.hcl`:** Updated to use `pathexpand` for the `config_path`.
  - **`main.tf`:** Updated the version of the `metrics-server` Helm chart from `3.13` to `3.12.2`.
  - **Various `.terraform.lock.hcl` files:** Updated the version of the Argo CD provider from `7.12.3` to `7.12.4`.

- **mise.toml:**
  - Introduced to manage tool versions, specifying `terragrunt` version `0.96.1` and `opentofu` version `1.11.2`.

### Key Learnings & Insights
- **Standardization of CI/CD Pipelines:** The introduction of dedicated workflows for deploying and planning infrastructure ensures a standardized and automated process, reducing manual errors and enhancing reliability.
- **Version Management:** The use of `mise.toml` for tool version management promotes consistency across development environments, ensuring that all team members use the same versions of critical tools.
- **Infrastructure as Code Best Practices:** The changes reflect best practices in Infrastructure as Code (IaC), such as using Terragrunt for modular Terraform configurations and OpenTofu for enhanced compatibility and features.
- **Dependency Updates:** Regularly updating dependencies (e.g., Argo CD provider) ensures that the infrastructure benefits from the latest features and security patches.

### Impact Assessment
- **Performance:** The changes are unlikely to have a direct impact on performance but will ensure that the infrastructure is deployed using the latest and most stable tool versions.
- **Security:** Updating dependencies and standardizing the CI/CD pipeline enhances security by reducing the risk of using outdated or vulnerable tools.
- **Maintainability:** The introduction of `mise.toml` and standardized workflows improves maintainability by ensuring consistency and simplifying the process of updating tool versions.

### Developer Notes
- **Gotchas:** Ensure that all team members update their local environments to use the specified versions of Terragrunt and OpenTofu as defined in `mise.toml`.
- **Edge Cases:** Pay attention to any potential issues arising from the version changes in the Argo CD provider and the Helm chart for `metrics-server`.
- **Future Improvements:** Consider automating the update process for tool versions in `mise.toml` to further streamline the development workflow.