--- 
layout: post 
title: Terraform and OpenTofu updates documentation.
date: 2025-12-26T21:24:03.521-05:00
tags: [homelab, github-actions, terragrunt, terraform, ci-cd, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces several new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt. Additionally, it includes updates to Terraform configurations, provider versions, and dependencies. The changes aim to enhance the CI/CD pipeline, ensure configuration consistency, and update dependencies to their latest versions.

### Technical Details
- **New GitHub Actions Workflows:**
  - `deploy.yml`: Automates the deployment of infrastructure changes using Terragrunt.
  - `plan.yml`: Automates the planning phase of infrastructure changes using Terragrunt.
  
  Both workflows include steps for checking out the code, validating Terragrunt HCL files, installing necessary tools, configuring AWS credentials, and executing Terragrunt commands.

- **Terraform Configuration Updates:**
  - Added inclusion of the `kube_provider` in `metrics.hcl`.
  - Updated `helm_provider.hcl` and `kube.hcl` to use `pathexpand` for the config path.
  - Changed the version of the `metrics-server` Helm chart in `main.tf` from `3.13` to `3.12.2`.

- **Provider Version Updates:**
  - Updated the version of the ArgoCD provider in multiple `.terraform.lock.hcl` files from `7.12.3` to `7.12.4`.

- **Dependency Management:**
  - Added `mise.toml` to manage tool versions, specifying `terragrunt` version `0.96.1` and `opentofu` version `1.11.2`.

### Key Learnings & Insights
- **Automation of CI/CD Pipelines:** The introduction of GitHub Actions workflows automates the deployment and planning processes, reducing manual intervention and ensuring consistency across environments.
- **Configuration Consistency:** Validating Terragrunt HCL files as part of the workflow ensures that the configuration remains consistent and free of syntax errors.
- **Dependency Management:** Using `mise.toml` to manage tool versions centralizes dependency management, making it easier to update and maintain tool versions across the project.

### Impact Assessment
- **Performance:** The update to the `metrics-server` Helm chart version might have performance implications, depending on the changes between versions `3.13` and `3.12.2`.
- **Security:** Configuring AWS credentials securely within the GitHub Actions workflow enhances security by limiting exposure of sensitive information.
- **Maintainability:** Automated workflows and consistent configuration practices improve the maintainability of the infrastructure code.

### Developer Notes
- **Gotchas:** Ensure that the AWS role specified in the workflow has the necessary permissions to deploy and manage resources.
- **Edge Cases:** Monitor the initial runs of the new workflows to catch any unforeseen issues with the automation process.
- **Future Improvements:** Consider adding additional validation steps or tests to the workflows to further enhance the reliability of the deployment process.