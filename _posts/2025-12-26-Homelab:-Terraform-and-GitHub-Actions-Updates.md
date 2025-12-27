--- 
layout: post 
title: Homelab: Terraform and GitHub Actions Updates
date: 2025-12-26T21:27:37.072-05:00
tags: [homelab, ci-cd, terraform, github-actions, automation, infrastructure]
categories: [Homelab]
author: ai
---
### Change Summary
This commit introduces significant updates to the CI/CD pipeline and Terraform configurations. Key changes include the addition of new GitHub Actions workflows for deploying and planning Terraform changes, updates to Terraform provider configurations, and the introduction of a new `mise.toml` file for managing tool versions.

### Technical Details
- **New GitHub Actions Workflows:**
  - `.github/workflows/deploy.yml`: Automates the deployment of Terraform configurations using Terragrunt. It includes steps for checking out the code, validating HCL syntax, installing necessary tools, configuring AWS credentials, and executing `terragrunt apply`.
  - `.github/workflows/plan.yml`: Automates the planning phase of Terraform changes. Similar to the deploy workflow, it includes steps for checking out the code, validating HCL syntax, installing tools, configuring AWS credentials, and executing `terragrunt plan`.

- **Terraform Configuration Updates:**
  - `IaC/_envcommon/metrics.hcl`: Includes a new `kube_provider` configuration.
  - `IaC/_envcommon/providers/helm.hcl` and `IaC/_envcommon/providers/kube.hcl`: Updated to use `pathexpand` for the `config_path`.
  - `IaC/modules/metrics/main.tf`: Changed the version of the `metrics-server` Helm chart from `3.13` to `3.12.2`.
  - Multiple `.terraform.lock.hcl` files across various modules were updated to reflect changes in provider versions.

- **Tool Version Management:**
  - `mise.toml`: Introduced to manage versions of tools like Terragrunt and OpenTofu. Specifies versions `0.96.1` for Terragrunt and `1.11.2` for OpenTofu.

### Key Learnings & Insights
- **Automation of CI/CD Processes:** The introduction of GitHub Actions workflows streamlines the deployment and planning processes, ensuring consistency and reducing manual errors.
- **Version Management:** Using `mise.toml` for tool version management ensures that all developers and CI environments use the same versions, promoting consistency and reproducibility.
- **Configuration Best Practices:** The use of `pathexpand` in provider configurations enhances portability and reduces hardcoded paths, making the configurations more robust.

### Impact Assessment
- **Performance:** The changes are unlikely to have a direct impact on performance but will ensure that the infrastructure is deployed and planned consistently.
- **Security:** Configuring AWS credentials securely within the GitHub Actions workflows enhances security by managing sensitive information via GitHub Secrets.
- **Maintainability:** The introduction of automated workflows and version management improves maintainability by reducing manual intervention and ensuring consistent tool versions.

### Developer Notes
- **Gotchas:** Ensure that all necessary secrets (e.g., `TS_AUTH_KEY`, `KUBE_CONFIG`) are correctly set up in the GitHub repository settings.
- **Edge Cases:** Monitor the first few runs of the new workflows to ensure that all steps execute correctly, especially the Terragrunt commands.
- **Future Improvements:** Consider adding additional checks or validations within the workflows to further enhance reliability and security.