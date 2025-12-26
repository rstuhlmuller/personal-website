--- 
layout: post 
title: Created workflows for Terragrunt deploy and plan.
date: 2025-12-26T12:19:09.175-05:00
tags: [homelab, terragrunt, opentofu, githubactions, automation, security]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces two new GitHub Actions workflows (`deploy.yml` and `plan.yml`) for deploying and planning infrastructure changes using Terragrunt, along with a configuration file (`mise.toml`) specifying the versions of Terragrunt and OpenTofu.

### Technical Details
- **deploy.yml**:
  - Triggered on `workflow_dispatch` and `push` to the `main` branch.
  - Includes jobs for checking Terragrunt HCL and deploying infrastructure.
  - Uses `gruntwork-io/terragrunt-action` for HCL checks and deployment.
  - Configures AWS credentials and uses Tailscale for secure networking.

- **plan.yml**:
  - Triggered on `workflow_dispatch` and various `pull_request` events on the `main` branch.
  - Includes jobs for checking Terragrunt HCL and planning infrastructure changes.
  - Similar setup to `deploy.yml` but runs `terragrunt plan` instead of `apply`.

- **mise.toml**:
  - Specifies the versions of Terragrunt (`0.91.1`) and OpenTofu (`1.11.1`).

### Key Learnings & Insights
- **Automation**: The introduction of these workflows automates the deployment and planning processes, reducing manual intervention and potential errors.
- **Version Control**: Using `mise.toml` to specify tool versions ensures consistency across environments.
- **Security**: Configuring AWS credentials and using Tailscale enhances the security of the deployment process.

### Impact Assessment
- **Efficiency**: Automates repetitive tasks, allowing developers to focus on more complex issues.
- **Consistency**: Ensures that the same versions of tools are used across different environments.
- **Security**: Improves the security posture by managing credentials and network configurations effectively.

### Developer Notes
- **Environment Variables**: Ensure that all necessary secrets (`TS_OAUTH_CLIENT_ID`, `TS_OAUTH_SECRET`) are correctly set in the GitHub repository settings.
- **Dependency Management**: Keep an eye on updates for Terragrunt and OpenTofu to benefit from new features and security patches.
- **Future Improvements**: Consider adding additional checks or notifications for failed deployments or plans.