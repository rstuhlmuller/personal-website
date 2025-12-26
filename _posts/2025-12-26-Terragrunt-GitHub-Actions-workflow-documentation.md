--- 
layout: post 
title: Terragrunt GitHub Actions workflow documentation.
date: 2025-12-26T14:05:41.994-05:00
tags: [homelab, terragrunt, githubactions, infrastructure, automation, security]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces two new GitHub Actions workflows for deploying and planning infrastructure using Terragrunt, along with specifying tool versions in `mise.toml`.

### Technical Details
- **Workflows Added**:
  - `deploy.yml`: Automates the deployment of infrastructure using Terragrunt.
  - `plan.yml`: Automates the planning phase of infrastructure changes using Terragrunt.
- **Workflow Triggers**:
  - `deploy.yml` is triggered on pushes to the `main` branch and manual workflow dispatches.
  - `plan.yml` is triggered on pull requests to the `main` branch and manual workflow dispatches.
- **Jobs and Steps**:
  - Both workflows include a `checks` job to validate Terragrunt HCL files.
  - The `deploy` job in `deploy.yml` configures AWS credentials, sets up Tailscale, installs Terragrunt and OpenTofu, and runs `terragrunt apply`.
  - The `plan` job in `plan.yml` installs Terragrunt and OpenTofu, configures AWS credentials, sets up Tailscale, and runs `terragrunt plan`.
- **mise.toml**: Specifies the versions of Terragrunt and OpenTofu to ensure consistency across environments.

### Key Learnings & Insights
- **Automation of Infrastructure Management**: The introduction of these workflows automates critical phases of infrastructure management, reducing manual effort and potential for human error.
- **Version Control for Tools**: Using `mise.toml` to pin tool versions ensures that all developers and CI environments use the same versions, promoting consistency and reproducibility.
- **Security Best Practices**: The workflows use GitHub Secrets to manage sensitive information like AWS credentials and Tailscale authentication, enhancing security.

### Impact Assessment
- **Efficiency**: Automates deployment and planning, speeding up the infrastructure management process.
- **Consistency**: Ensures that infrastructure changes are validated and applied in a controlled manner.
- **Security**: Utilizes GitHub Secrets for managing sensitive data, improving overall security posture.

### Developer Notes
- **Environment Variables**: Ensure that all required environment variables and secrets are correctly set up in the GitHub repository settings.
- **Dependency Management**: Keep an eye on updates for Terragrunt and OpenTofu, and update `mise.toml` accordingly to maintain compatibility and security.
- **Error Handling**: Implement robust error handling in workflows to manage failures gracefully, especially in the `deploy` job.