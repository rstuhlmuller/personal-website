--- 
layout: post 
title: Update terragrunt and opentofu versions.
date: 2025-12-26T21:24:46.809-05:00
tags: [homelab, infrastructure, github-actions, terraform, automation, version-management]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff encompasses several significant changes primarily focused on infrastructure as code (IaC) workflows and configurations. Key changes include the introduction of new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt, updates to HCL and Terraform configurations, and the addition of a new `mise.toml` file for managing tool versions.

### Technical Details
- **New GitHub Actions Workflows:**
  - `deploy.yml`: Automates the deployment process using Terragrunt. It includes steps for checking out code, validating HCL files, installing necessary tools, configuring AWS credentials, and executing the Terragrunt apply command.
  - `plan.yml`: Similar to `deploy.yml` but focuses on planning infrastructure changes. It runs the Terragrunt plan command instead of apply.
  
- **HCL and Terraform Configurations:**
  - Updated `metrics.hcl` to include a new `kube_provider`.
  - Modified `helm.hcl` and `kube.hcl` to use `pathexpand` for the config path.
  - Changed the version of the `metrics-server` Helm chart in `main.tf`.
  - Updated various `.terraform.lock.hcl` files to use a newer version of the ArgoCD provider.

- **mise.toml**:
  - Introduced to manage versions of tools like Terragrunt and OpenTofu.

### Key Learnings & Insights
- **Automation of IaC Processes:** 
  The introduction of GitHub Actions workflows (`deploy.yml` and `plan.yml`) demonstrates a shift towards automating infrastructure deployment and planning processes. This reduces manual intervention and potential human error.

- **Version Management:**
  The use of `mise.toml` for version management of tools like Terragrunt and OpenTofu ensures consistency across development environments, promoting reproducibility and stability.

- **Path Management in HCL:**
  The change from hardcoded paths to using `pathexpand` in `helm.hcl` and `kube.hcl` enhances portability and reduces the risk of path-related errors, especially in diverse development environments.

### Impact Assessment
- **Automation and Efficiency:**
  The new workflows streamline the deployment and planning processes, making them more efficient and reliable.

- **Consistency and Stability:**
  Version management via `mise.toml` and the use of `pathexpand` contribute to more consistent and stable infrastructure configurations.

- **Potential Breaking Changes:**
  The version changes in `.terraform.lock.hcl` files might require adjustments in dependent configurations or scripts. Careful testing is advised to ensure compatibility.

### Developer Notes
- **Workflow Dependencies:**
  Ensure that the secrets (`TS_AUTH_KEY`, `KUBE_CONFIG`) are correctly set up in the GitHub repository settings for the workflows to run successfully.

- **Version Compatibility:**
  When updating tool versions (e.g., Terragrunt, OpenTofu), verify compatibility with existing configurations to avoid unexpected issues.

- **Future Improvements:**
  Consider adding additional checks or validations within the workflows to further enhance reliability and catch potential issues early in the CI/CD pipeline.