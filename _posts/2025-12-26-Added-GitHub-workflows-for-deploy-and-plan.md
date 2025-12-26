--- 
layout: post 
title: Added GitHub workflows for deploy and plan.
date: 2025-12-26T12:08:46.274-05:00
tags: [homelab, terragrunt, githubactions, infrastructure, automation, ci/cd]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces two new GitHub Actions workflows for deploying and planning infrastructure using Terragrunt, along with the addition of a `mise.toml` configuration file specifying tool versions.

### Technical Details
- **Workflows Added**: 
  - `.github/workflows/deploy.yml`: Automates the deployment of infrastructure using Terragrunt.
  - `.github/workflows/plan.yml`: Automates the planning phase of infrastructure changes using Terragrunt.
- **Workflow Triggers**: 
  - `deploy.yml` is triggered on `workflow_dispatch` and `push` to the `main` branch.
  - `plan.yml` is triggered on `workflow_dispatch` and specific `pull_request` events on the `main` branch.
- **Environment Configuration**: 
  - Both workflows set an environment variable `working_dir` to `IaC/production/homelab`.
- **Jobs and Steps**: 
  - Both workflows include a `checks` job to verify Terragrunt HCL formatting.
  - The `deploy` job in `deploy.yml` and the `plan` job in `plan.yml` configure AWS credentials and execute Terragrunt commands (`apply` for deployment and `plan` for planning).
- **mise.toml**: 
  - Specifies versions for `terragrunt` (0.91.1) and `opentofu` (1.11.1).

### Key Learnings & Insights
- **Automation of Infrastructure Management**: 
  - The introduction of these workflows streamlines the deployment and planning processes, ensuring consistency and reducing manual errors.
- **Version Management**: 
  - Using `mise.toml` to pin tool versions enhances reproducibility and maintains a stable development environment.
- **CI/CD Best Practices**: 
  - Implementing checks before deployment or planning ensures that only valid configurations are applied, adhering to CI/CD best practices.

### Impact Assessment
- **Efficiency**: 
  - Automates repetitive tasks, saving time and reducing the potential for human error.
- **Consistency**: 
  - Ensures that infrastructure changes are applied consistently across environments.
- **Security**: 
  - Uses role-based AWS credentials to enhance security by limiting access.

### Developer Notes
- **Gotchas**: 
  - Ensure that secrets (`TS_OAUTH_CLIENT_ID`, `TS_OAUTH_SECRET`) are properly configured in the GitHub repository settings.
- **Future Improvements**: 
  - Consider adding additional checks or steps to further validate configurations before deployment.
  - Explore integrating more comprehensive logging or notifications for workflow statuses.