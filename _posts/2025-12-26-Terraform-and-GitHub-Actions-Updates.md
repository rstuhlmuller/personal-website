--- 
layout: post 
title: Terraform and GitHub Actions Updates.
date: 2025-12-26T21:50:11.764-05:00
tags: [homelab, terragrunt, opentofu, github-actions, cicd, infrastructure]
categories: [Homelab]
author: ai
---
**Change Summary**

This update introduces significant changes to the CI/CD pipeline for deploying and planning infrastructure using Terragrunt and OpenTofu. Two new GitHub Actions workflows (`deploy.yml` and `plan.yml`) have been added, along with updates to Terraform configurations and dependencies.

**Technical Details**

- **New Workflows:**
  - `deploy.yml`: Automates the deployment process using Terragrunt. It includes steps for checking out the code, validating HCL files, configuring AWS credentials, setting up Tailscale, and applying Terragrunt configurations.
  - `plan.yml`: Automates the planning process for pull requests. It follows a similar structure to `deploy.yml` but generates a plan instead of applying changes.

- **Terraform Configurations:**
  - Added `kube_provider` inclusion in `metrics.hcl`.
  - Updated `helm.hcl` and `kube.hcl` to use `pathexpand` for `config_path`.
  - Changed the version of the `metrics-server` Helm chart from `3.13` to `3.12.2` in `main.tf`.

- **Dependency Updates:**
  - Updated the version of the Argo CD provider from `7.12.3` to `7.12.4` across multiple `.terraform.lock.hcl` files.
  - Added `mise.toml` to manage tool versions, specifying Terragrunt `0.96.1` and OpenTofu `1.11.2`.

**Key Learnings & Insights**

- **Automation of CI/CD Processes:** The introduction of `deploy.yml` and `plan.yml` workflows demonstrates a best practice in automating infrastructure deployment and planning. This reduces manual intervention and ensures consistency across environments.
  
- **Version Management:** The use of `mise.toml` for tool version management ensures that the development and CI environments use consistent tool versions, reducing potential compatibility issues.

- **Path Management:** The switch to `pathexpand` in `helm.hcl` and `kube.hcl` enhances portability and ensures that paths are correctly resolved across different environments.

**Impact Assessment**

- **Performance:** The changes are unlikely to have a direct performance impact but will streamline the deployment and planning processes, leading to more efficient infrastructure management.

- **Security:** Configuring AWS credentials and managing sensitive information through GitHub Secrets enhances security by centralizing and securing access to critical resources.

- **Maintainability:** The automation of deployment and planning processes, along with consistent tool version management, improves maintainability and reduces the risk of configuration drift.

**Developer Notes**

- **Gotchas:** Ensure that all necessary secrets (e.g., `TS_AUTH_KEY`, `KUBE_CONFIG`) are properly set up in the GitHub repository settings to avoid workflow failures.
  
- **Edge Cases:** Monitor the first few deployments closely to ensure that the new workflows and configurations work as expected across all environments.

- **Future Improvements:** Consider adding additional checks or validations within the workflows to further enhance the reliability and security of the deployment process.