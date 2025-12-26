--- 
layout: post 
title: Create GitHub workflows for Terragrunt deployment.
date: 2025-12-26T12:09:48.062-05:00
tags: [homelab, terragrunt, opentofu, github-actions, automation, security]
categories: [Homelab]
author: ai
---
### Change Summary
This commit introduces two new GitHub Actions workflows for deploying and planning infrastructure using Terragrunt. Additionally, it updates the `mise.toml` configuration file to specify the versions of `terragrunt` and `opentofu`.

### Technical Details
- **New Workflows:**
  - `.github/workflows/deploy.yml`:
    - Triggered by `workflow_dispatch` and `push` events on the `main` branch.
    - Includes jobs for checking Terragrunt HCL syntax and deploying infrastructure.
  - `.github/workflows/plan.yml`:
    - Triggered by `workflow_dispatch` and various `pull_request` events on the `main` branch.
    - Includes jobs for checking Terragrunt HCL syntax and planning infrastructure changes.
- **Configuration:**
  - Both workflows configure AWS credentials and use Tailscale for secure access.
  - The `mise.toml` file is updated to pin `terragrunt` to version `0.91.1` and `opentofu` to version `1.11.1`.

### Key Learnings & Insights
- **Automation Benefits:** Implementing automated workflows for deployment and planning enhances reliability and reduces manual errors.
- **Version Pinning:** Specifying exact versions for `terragrunt` and `opentofu` ensures consistency across environments.
- **Security Practices:** Using GitHub Secrets for sensitive information like OAuth credentials improves security.

### Impact Assessment
- **Efficiency:** Automated workflows streamline the deployment and planning processes, saving time and effort.
- **Consistency:** Version pinning in `mise.toml` ensures that all team members use the same tool versions, reducing compatibility issues.
- **Security:** Proper handling of sensitive information through GitHub Secrets mitigates security risks.

### Developer Notes
- **Workflow Dependencies:** Ensure that the `IaC/production/homelab` directory contains the correct Terragrunt configuration.
- **Environment Variables:** Confirm that all required secrets (`TS_OAUTH_CLIENT_ID`, `TS_OAUTH_SECRET`) are set in the GitHub repository settings.
- **Future Improvements:** Consider adding notifications for workflow success or failure to keep the team informed.