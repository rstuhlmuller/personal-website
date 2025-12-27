--- 
layout: post 
title: Enhanced GitHub Actions for IaC Deployment.
date: 2025-12-26T21:29:55.194-05:00
tags: [homelab, infrastructure, github-actions, terragrunt, terraform, ci-cd]
categories: [Homelab]
author: ai
---
### Change Summary

This update introduces several significant changes to the infrastructure-as-code (IaC) deployment and management workflows. Key changes include the creation of new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt, updates to configuration files for improved path handling, and version updates for various Terraform providers and modules. Additionally, the mise.toml file has been added to manage tool versions.

### Technical Details

- **New GitHub Actions Workflows:**
  - `deploy.yml`: Automates the deployment of infrastructure changes using Terragrunt. It includes steps for checking out the code, validating HCL files, installing necessary tools, configuring AWS credentials, and executing the Terragrunt apply command.
  - `plan.yml`: Automates the planning phase of infrastructure changes. Similar to the deploy workflow, it includes steps for checking out the code, validating HCL files, installing tools, configuring AWS credentials, and running the Terragrunt plan command.

- **Configuration File Updates:**
  - `metrics.hcl`: Includes a new `kube_provider` configuration.
  - `helm.hcl` and `kube.hcl`: Updated to use `pathexpand` for the `config_path` to ensure correct path resolution.
  - `main.tf` in the `metrics` module: Changed the version of the `metrics-server` Helm chart from `3.13` to `3.12.2`.

- **Terraform Lock Files:**
  - Multiple `.terraform.lock.hcl` files across different modules have been updated to use version `7.12.4` of the Argo CD provider.

- **mise.toml:**
  - Added to manage versions of tools like Terragrunt (`0.96.1`) and OpenTofu (`1.11.2`).

### Key Learnings & Insights

- **Automation and CI/CD Integration:**
  - The introduction of GitHub Actions workflows for deploying and planning infrastructure changes highlights the importance of CI/CD practices in IaC management. This automation ensures that changes are validated and applied consistently.

- **Path Handling Improvements:**
  - The use of `pathexpand` in configuration files demonstrates a best practice for handling paths in scripts and configurations, ensuring compatibility across different environments.

- **Version Management:**
  - The addition of `mise.toml` for tool version management shows a commitment to maintaining consistent and reproducible environments, which is crucial for development and operations.

### Impact Assessment

- **Performance and Reliability:**
  - The changes are expected to improve the reliability and performance of the deployment process by ensuring that infrastructure changes are thoroughly planned and validated before application.

- **Maintainability:**
  - The introduction of automated workflows and consistent tool versions will enhance the maintainability of the IaC repository, making it easier for team members to contribute and manage changes.

- **Breaking Changes:**
  - The version changes in Terraform providers and modules might require adjustments in dependent configurations. Teams should verify that all components are compatible with the new versions.

### Developer Notes

- **Gotchas and Edge Cases:**
  - Ensure that AWS credentials and permissions are correctly configured to avoid deployment failures.
  - Verify that all dependent modules and providers are compatible with the new versions specified in the lock files and `mise.toml`.

- **Future Improvements:**
  - Consider adding additional validation steps or tests to the GitHub Actions workflows to further ensure the quality of infrastructure changes.
  - Explore the possibility of integrating more advanced features of Terragrunt and OpenTofu to enhance the IaC management process.