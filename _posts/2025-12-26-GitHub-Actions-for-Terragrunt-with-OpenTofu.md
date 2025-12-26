--- 
layout: post 
title: GitHub Actions for Terragrunt with OpenTofu.
date: 2025-12-26T12:53:21.548-05:00
tags: [homelab, terragrunt, opentofu, githubactions, automation, infrastructure]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt and OpenTofu. Additionally, it configures specific tool versions in the `mise.toml` file.

### Technical Details
- **deploy.yml**:
  - **Triggers**: Activated on `workflow_dispatch` and `push` events to the `main` branch.
  - **Jobs**:
    - **checks**:
      - Checks out the repository.
      - Verifies the HCL format of Terragrunt files.
    - **deploy**:
      - Depends on the `checks` job.
      - Configures AWS credentials.
      - Sets up Tailscale.
      - Installs Terragrunt and OpenTofu.
      - Executes `terragrunt apply` in the specified working directory.
- **plan.yml**:
  - **Triggers**: Activated on `workflow_dispatch` and various `pull_request` events on the `main` branch.
  - **Jobs**:
    - **checks**:
      - Similar to `deploy.yml`, it checks out the repository and verifies HCL format.
    - **plan**:
      - Depends on the `checks` job.
      - Installs Terragrunt and OpenTofu.
      - Configures AWS credentials.
      - Sets up Tailscale.
      - Uses `kubectl` to interact with Kubernetes.
      - Executes `terragrunt plan` in the specified working directory.
- **mise.toml**:
  - Specifies versions for `terragrunt` (0.91.1) and `opentofu` (1.11.1).

### Key Learnings & Insights
- **Automation**: The workflows automate the deployment and planning processes, reducing manual intervention and potential errors.
- **Consistency**: Using GitHub Actions ensures consistent environment setup and execution across different runs.
- **Security**: The workflows securely manage AWS credentials and Tailscale configuration using GitHub Secrets.
- **Tool Management**: `mise.toml` ensures that specific tool versions are used, promoting reproducibility and stability.

### Impact Assessment
- **Efficiency**: Automates repetitive tasks, speeding up the deployment and planning processes.
- **Reliability**: Reduces the risk of human error in infrastructure management.
- **Maintainability**: Clear separation of concerns between deployment and planning workflows makes future modifications easier.

### Developer Notes
- **Dependencies**: Ensure that the specified versions of Terragrunt and OpenTofu are compatible with your infrastructure setup.
- **Secrets Management**: Regularly review and update the secrets used in the workflows to maintain security.
- **Error Handling**: Consider adding error handling and notifications to the workflows for better monitoring and alerting.