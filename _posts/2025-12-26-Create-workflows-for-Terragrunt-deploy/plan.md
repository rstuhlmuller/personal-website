--- 
layout: post 
title: Create workflows for Terragrunt deploy/plan.
date: 2025-12-26T12:55:08.411-05:00
tags: [homelab, terragrunt, github-actions, infrastructure-as-code, automation, terraform]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces two new GitHub Actions workflows for managing Terraform deployments using Terragrunt: `deploy.yml` and `plan.yml`. Additionally, it adds a `mise.toml` configuration file to specify tool versions for Terragrunt and OpenTofu.

### Technical Details
- **`deploy.yml` Workflow:**
  - Triggered by `workflow_dispatch` and `push` events on the `main` branch.
  - Configures permissions for reading contents and writing ID tokens.
  - Sets an environment variable `working_dir` to `IaC/production/homelab`.
  - Includes two jobs: 
    - `checks`: Validates Terragrunt HCL files.
    - `deploy`: Deploys infrastructure using Terragrunt, involving AWS credential configuration and Tailscale setup.

- **`plan.yml` Workflow:**
  - Triggered by `workflow_dispatch` and various `pull_request` events on the `main` branch.
  - Similar permissions and environment setup as `deploy.yml`.
  - Includes two jobs: 
    - `checks`: Validates Terragrunt HCL files.
    - `plan`: Generates a Terraform plan using Terragrunt, with additional steps for Kubernetes configuration.

- **`mise.toml`:**
  - Specifies versions for Terragrunt (`0.91.1`) and OpenTofu (`1.11.1`).

### Key Learnings & Insights
- **Automation of Terraform Workflows:** The introduction of these workflows automates the deployment and planning phases of Terraform, ensuring consistency and reducing manual errors.
- **Version Management:** Using `mise.toml` to pin tool versions ensures that all developers and CI environments use the same versions, promoting reproducibility.
- **Security Considerations:** The workflows securely handle AWS credentials and Tailscale configuration, emphasizing the importance of secure infrastructure as code practices.

### Impact Assessment
- **Efficiency:** Automates repetitive tasks, allowing developers to focus on more complex problems.
- **Consistency:** Ensures that deployments and plans are executed in a standardized manner.
- **Maintainability:** Centralized configuration in `mise.toml` simplifies tool version management across the project.

### Developer Notes
- **Gotchas:** Ensure that all required secrets (`TS_OAUTH_CLIENT_ID`, `TS_OAUTH_SECRET`, `KUBE_CONFIG`) are properly set in the GitHub repository settings.
- **Future Improvements:** Consider adding additional checks or steps to the workflows for enhanced validation and security, such as static code analysis or additional environment variable validations.