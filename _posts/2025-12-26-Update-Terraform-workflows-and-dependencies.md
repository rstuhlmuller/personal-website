--- 
layout: post 
title: Update Terraform workflows and dependencies.
date: 2025-12-26T21:25:17.481-05:00
tags: [homelab, infrastructure, automation, github-actions, terraform, configuration-management]
categories: [Homelab]
author: ai
---
### Change Summary
This commit introduces several significant changes to the project's infrastructure-as-code (IaC) workflows and configurations. Key updates include the addition of new GitHub Actions workflows for deploying and planning Terraform configurations using Terragrunt, modifications to HCL and Terraform files for improved provider configurations, and updates to tool versions in `mise.toml`.

### Technical Details
- **New GitHub Actions Workflows:**
  - `deploy.yml`: Automates the deployment of Terragrunt configurations. It includes steps for checking out the code, validating HCL files, installing Terragrunt and OpenTofu, configuring AWS credentials, and executing the `terragrunt apply` command.
  - `plan.yml`: Automates the planning phase of Terragrunt configurations. Similar to `deploy.yml`, it checks out the code, validates HCL files, installs necessary tools, configures AWS credentials, and runs the `terragrunt plan` command.

- **HCL and Terraform Changes:**
  - `metrics.hcl`: Includes a new `kube_provider` configuration.
  - `helm.hcl` and `kube.hcl`: Updated to use `pathexpand` for the `config_path` to ensure compatibility across different environments.
  - `main.tf` in the `metrics` module: Downgraded the `metrics-server` Helm chart version from 3.13 to 3.12.2.
  - Multiple `.terraform.lock.hcl` files across different modules: Updated the version of the Argo CD provider from 7.12.3 to 7.12.4.

- **Tool Versions:**
  - `mise.toml`: Specified versions for Terragrunt (0.96.1) and OpenTofu (1.11.2).

### Key Learnings & Insights
- **Automation and CI/CD:** The introduction of GitHub Actions workflows (`deploy.yml` and `plan.yml`) demonstrates a shift towards automating infrastructure deployment and planning processes. This approach enhances reliability and reduces manual intervention.
- **Configuration Management:** The changes in HCL and Terraform files, particularly the use of `pathexpand`, showcase best practices in configuration management. This ensures that paths are correctly resolved in different environments, improving portability and maintainability.
- **Version Management:** Specifying tool versions in `mise.toml` ensures consistency across development and production environments, reducing the risk of version-related issues.

### Impact Assessment
- **System Reliability:** Automating deployment and planning processes with GitHub Actions improves the reliability and consistency of infrastructure changes.
- **Maintainability:** The use of `pathexpand` and specified tool versions enhances the maintainability of the codebase by reducing environment-specific issues and ensuring consistent tool versions.
- **Performance and Security:** Downgrading the `metrics-server` Helm chart version might impact performance or features. It's essential to monitor the system post-deployment for any adverse effects.

### Developer Notes
- **Gotchas:** Ensure that AWS credentials and Tailscale auth keys are correctly set up in GitHub Secrets to avoid authentication issues during workflow execution.
- **Future Improvements:** Consider adding additional checks or validations in the GitHub Actions workflows to further enhance the deployment process. Exploring the use of Terragrunt's experimental features could also provide additional benefits.