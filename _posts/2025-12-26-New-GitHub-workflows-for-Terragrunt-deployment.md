--- 
layout: post 
title: New GitHub workflows for Terragrunt deployment.
date: 2025-12-26T14:12:55.009-05:00
tags: [homelab, terraform, terragrunt, github-actions, ci/cd, automation]
categories: [Homelab]
author: ai
---
### Change Summary

This commit introduces two new GitHub Actions workflows (`deploy.yml` and `plan.yml`) for automating the deployment and planning phases of a Terraform project using Terragrunt. Additionally, it updates a configuration file (`kube.hcl`) to use a more robust method for expanding the Kubernetes configuration path, and adds a `mise.toml` file to manage tool versions.

### Technical Details

- **deploy.yml**:
  - This workflow is triggered by pushes to the `main` branch or manually via `workflow_dispatch`.
  - It performs a series of checks and deploys infrastructure using Terragrunt.
  - Key steps include checking out the code, validating Terragrunt HCL, configuring AWS credentials, and running `terragrunt apply`.

- **plan.yml**:
  - This workflow is triggered by pull requests targeting the `main` branch.
  - It performs checks and generates a Terraform plan using Terragrunt.
  - Similar steps to `deploy.yml`, but runs `terragrunt plan` instead of `apply`.

- **kube.hcl**:
  - Updates the Kubernetes provider configuration to use `pathexpand` for the config path, ensuring compatibility across different environments.

- **mise.toml**:
  - Introduces version management for Terragrunt and OpenTofu using the `mise` tool.
  - Specifies versions `0.91.1` for Terragrunt and `1.11.1` for OpenTofu.

### Key Learnings & Insights

- **Automation Benefits**:
  - Automating deployment and planning phases reduces manual errors and ensures consistency.
  - Using GitHub Actions for CI/CD pipelines enhances collaboration and maintains up-to-date infrastructure.

- **Path Management**:
  - Utilizing `pathexpand` for configuration paths improves cross-platform compatibility and robustness.

- **Version Management**:
  - Managing tool versions with `mise` ensures that the development environment remains consistent and up-to-date.

### Impact Assessment

- **Performance**:
  - Automation should lead to faster and more reliable deployments.
  
- **Security**:
  - Using GitHub Secrets for sensitive information (e.g., AWS credentials, Tailscale auth key) enhances security.

- **Maintainability**:
  - Clear separation of deployment and planning workflows improves maintainability and allows for easier troubleshooting.

### Developer Notes

- **Gotchas**:
  - Ensure that all required secrets are properly configured in the GitHub repository settings.
  - Validate that the IAM role specified has the necessary permissions for Terraform operations.

- **Future Improvements**:
  - Consider adding additional checks (e.g., linting, security scans) to the workflows.
  - Explore integrating more comprehensive logging and monitoring for the deployment process.