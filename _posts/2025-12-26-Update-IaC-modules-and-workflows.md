--- 
layout: post 
title: Update IaC modules and workflows.
date: 2025-12-26T21:45:55.227-05:00
tags: [homelab, terragrunt, opentofu, githubactions, cicd, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces several significant changes across multiple files and components. The primary focus is on setting up new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt and OpenTofu. Additionally, there are updates to configuration files, version changes for dependencies, and the introduction of a new `mise.toml` file for managing tool versions.

### Technical Details
- **New GitHub Actions Workflows:**
  - `.github/workflows/deploy.yml`: This workflow is triggered on pushes to the `main` branch or manually via `workflow_dispatch`. It includes jobs for checking Terragrunt HCL files and deploying infrastructure using Terragrunt and OpenTofu.
  - `.github/workflows/plan.yml`: This workflow is triggered on pull requests to the `main` branch. It includes jobs for checking Terragrunt HCL files and planning infrastructure changes using Terragrunt and OpenTofu.

- **Configuration Changes:**
  - `IaC/_envcommon/metrics.hcl`: Included a new `kube_provider` configuration.
  - `IaC/_envcommon/providers/helm.hcl` and `IaC/_envcommon/providers/kube.hcl`: Updated the `config_path` to use `pathexpand("~/.kube/config")` instead of a hardcoded path.

- **Module Updates:**
  - `IaC/modules/metrics/main.tf`: Changed the version of the `metrics-server` Helm chart from `3.13` to `3.12.2`.

- **Terraform Lock Files:**
  - Multiple `.terraform.lock.hcl` files across different modules were updated to use version `7.12.4` of the ArgoCD provider.

- **mise.toml**:
  - Introduced a new `mise.toml` file to manage tool versions, specifying `terragrunt` version `0.96.1` and `opentofu` version `1.11.2`.

### Key Learnings & Insights
- **Automation and CI/CD:** The introduction of GitHub Actions workflows for deploying and planning infrastructure changes demonstrates a shift towards automating infrastructure management processes. This reduces manual intervention and ensures consistency across deployments.
- **Version Management:** The use of `mise.toml` for managing tool versions centralizes version control, making it easier to maintain and update dependencies across the project.
- **Configuration Best Practices:** Updating the `config_path` to use `pathexpand` ensures that the configuration is more portable and less prone to errors due to hardcoded paths.
- **Dependency Updates:** Regularly updating dependencies (e.g., ArgoCD provider version) ensures that the project benefits from the latest features, bug fixes, and security patches.

### Impact Assessment
- **Performance:** The changes should not significantly impact performance, as they primarily involve configuration and automation improvements.
- **Security:** Ensuring that dependencies are up-to-date helps mitigate security risks associated with using outdated software.
- **Maintainability:** The introduction of automated workflows and centralized version management improves maintainability by reducing manual configuration efforts and ensuring consistency.

### Developer Notes
- **Gotchas:** Ensure that the `mise.toml` file is correctly configured and that all developers have `mise` installed to manage tool versions effectively.
- **Edge Cases:** Pay attention to any potential issues with path configurations, especially when using `pathexpand`. Test the workflows thoroughly to ensure that they handle different environments correctly.
- **Future Improvements:** Consider extending the GitHub Actions workflows to include additional stages such as testing or linting to further enhance the CI/CD pipeline.