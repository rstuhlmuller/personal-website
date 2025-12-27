--- 
layout: post 
title: Homelab Terraform Workflow Update.
date: 2025-12-26T21:42:28.304-05:00
tags: [homelab, terragrunt, github-actions, opentofu, hcl, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces two new GitHub Actions workflows (`deploy.yml` and `plan.yml`) for deploying and planning Terraform configurations using Terragrunt. It also updates several HCL and Terraform files to include new providers and configurations, and upgrades the versions of certain dependencies. Additionally, a new `mise.toml` file is added to manage tool versions.

### Technical Details
- **Workflows:**
  - **deploy.yml:** This workflow triggers on pushes to the `main` branch and manual dispatches. It includes jobs for checking Terragrunt HCL formatting and deploying infrastructure using Terragrunt and OpenTofu. It configures AWS credentials and uses Tailscale for network connectivity.
  - **plan.yml:** This workflow triggers on pull requests to the `main` branch. It includes jobs for checking Terragrunt HCL formatting and planning Terraform changes using Terragrunt and OpenTofu. It also configures AWS credentials and sets up kubeconfig for Kubernetes interactions.
  
- **HCL and Terraform Files:**
  - **metrics.hcl:** Includes a new `kube_provider` configuration.
  - **helm.hcl and kube.hcl:** Update the `config_path` to use `pathexpand` for better compatibility.
  - **main.tf:** Downgrades the `metrics-server` Helm chart version from 3.13 to 3.12.2.
  - **Various `.terraform.lock.hcl` files:** Upgrade the Argo CD provider from version 7.12.3 to 7.12.4.

- **mise.toml:** 
  - Specifies versions for Terragrunt (`0.96.1`) and OpenTofu (`1.11.2`).

### Key Learnings & Insights
- **Automation and CI/CD:** The introduction of GitHub Actions workflows automates the deployment and planning processes, ensuring consistent and reliable infrastructure management.
- **Version Management:** The use of `mise.toml` for tool version management promotes consistency across development environments.
- **Configuration Best Practices:** The changes in HCL files, such as using `pathexpand`, demonstrate best practices for configuration management, enhancing portability and reliability.
- **Dependency Management:** Upgrading dependencies (e.g., Argo CD provider) ensures the use of the latest features and security patches.

### Impact Assessment
- **Performance:** The changes are unlikely to have a significant performance impact but ensure the system uses up-to-date tools and configurations.
- **Security:** Upgrading dependencies and automating deployments can enhance security by reducing manual intervention and ensuring consistent configurations.
- **Maintainability:** The introduction of workflows and version management improves maintainability by automating routine tasks and ensuring consistency.

### Developer Notes
- **Gotchas:** Ensure that the AWS role and Tailscale authentication key are correctly configured in GitHub Secrets to avoid deployment failures.
- **Edge Cases:** Monitor the downgrade of the `metrics-server` Helm chart for any unexpected behavior or compatibility issues.
- **Future Improvements:** Consider adding additional checks or notifications to the workflows for better visibility into the deployment and planning processes.