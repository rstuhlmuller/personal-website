--- 
layout: post 
title: Update Homelab Terraform and Workflows
date: 2025-12-26T21:15:23.449-05:00
tags: [homelab, github-actions, terraform, automation, deployment, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces several significant changes to the project's CI/CD pipelines and infrastructure-as-code (IaC) configurations. Key modifications include the creation of new GitHub Actions workflows for deployment and planning, updates to Terraform configurations, and the addition of a new `mise.toml` file for managing tool versions.

### Technical Details
- **New GitHub Actions Workflows:**
  - `deploy.yml`: Automates the deployment process using Terragrunt. It includes steps for checking out the code, validating HCL files, installing necessary tools, configuring AWS credentials, and executing the Terragrunt apply command.
  - `plan.yml`: Similar to `deploy.yml`, but tailored for planning changes. It runs the Terragrunt plan command instead of apply.
- **Terraform Configuration Updates:**
  - Inclusion of a new `kube_provider` in `metrics.hcl`.
  - Modifications in `helm.hcl` and `kube.hcl` to use `pathexpand` for the kubeconfig path.
  - Version change for the `metrics-server` Helm chart in `main.tf`.
- **Terraform Lock Files:** Multiple `.terraform.lock.hcl` files were updated to reflect changes in provider versions.
- **mise.toml:** A new file added to manage versions of tools like Terragrunt and OpenTofu.

### Key Learnings & Insights
- **Automation and Consistency:** The introduction of GitHub Actions workflows (`deploy.yml` and `plan.yml`) enhances automation and ensures consistent deployment and planning processes.
- **Configuration Management:** The use of `mise.toml` for version management of tools like Terragrunt and OpenTofu promotes reproducibility and simplifies dependency management.
- **Path Management:** The switch to `pathexpand` in `helm.hcl` and `kube.hcl` improves portability and reduces hardcoded path dependencies.

### Impact Assessment
- **Automation:** The new workflows streamline the deployment and planning processes, reducing manual intervention and potential errors.
- **Maintainability:** The version management via `mise.toml` and the updates to Terraform configurations improve maintainability and ensure the use of up-to-date tool versions.
- **Portability:** The changes in path management enhance the portability of the configurations across different environments.

### Developer Notes
- **Workflow Dependencies:** Ensure that the necessary secrets (e.g., `TS_AUTH_KEY`, `KUBE_CONFIG`) are correctly set up in the GitHub repository settings.
- **Version Management:** When updating tool versions in `mise.toml`, verify compatibility with existing configurations and workflows.
- **Terraform Lock Files:** Regularly review and update `.terraform.lock.hcl` files to align with the latest provider versions and constraints.