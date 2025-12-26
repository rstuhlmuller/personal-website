--- 
layout: post 
title: Workflows added for Terragrunt CI/CD.
date: 2025-12-26T14:06:48.519-05:00
tags: [homelab, github-actions, terragrunt, opentofu, automation, security]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces two new GitHub Actions workflows (`deploy.yml` and `plan.yml`) for managing the deployment and planning phases of our infrastructure using Terragrunt and OpenTofu. Additionally, the `mise.toml` file has been created to manage tool versions.

### Technical Details
- **deploy.yml**:
  - Triggers on `workflow_dispatch` and `push` to the `main` branch.
  - Configures AWS credentials and uses Tailscale for secure communication.
  - Runs `terragrunt apply` in the `IaC/production/homelab` directory.
- **plan.yml**:
  - Triggers on `workflow_dispatch` and various `pull_request` events on the `main` branch.
  - Similar setup for AWS credentials and Tailscale.
  - Runs `terragrunt plan` in the `IaC/production/homelab` directory.
- **mise.toml**:
  - Specifies versions for `terragrunt` (0.91.1) and `opentofu` (1.11.1).

### Key Learnings & Insights
- **Automation**: The introduction of these workflows automates critical infrastructure tasks, reducing manual intervention and potential errors.
- **Security**: Using GitHub Secrets for AWS credentials and Tailscale ensures secure handling of sensitive information.
- **Version Management**: The `mise.toml` file centralizes tool version management, ensuring consistency across environments.

### Impact Assessment
- **Efficiency**: Automates deployment and planning, saving time and reducing errors.
- **Security**: Enhances security by managing credentials through GitHub Secrets.
- **Maintainability**: Centralized version management improves maintainability and reduces version-related issues.

### Developer Notes
- Ensure all secrets (`TS_OAUTH_CLIENT_ID`, `TS_OAUTH_SECRET`, `TS_AUTH_KEY`, `KUBE_CONFIG`) are correctly set in the repository settings.
- Monitor the workflows for any failures and check logs for detailed error information.
- Consider adding additional checks or notifications for critical deployment steps.