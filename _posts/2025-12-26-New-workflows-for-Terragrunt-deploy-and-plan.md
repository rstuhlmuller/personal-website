--- 
layout: post 
title: New workflows for Terragrunt deploy and plan.
date: 2025-12-26T12:39:17.108-05:00
tags: [homelab, infrastructure, automation, github\_actions, terragrunt, opentofu]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces new GitHub Actions workflows for deploying and planning infrastructure using Terragrunt and OpenTofu. Additionally, it adds a `mise.toml` file to specify tool versions.

### Technical Details
- **deploy.yml**:
  - New workflow named "Terragrunt Deploy".
  - Triggered on `workflow_dispatch` and pushes to the `main` branch.
  - Configures permissions and environment variables.
  - Includes two jobs: `checks` and `deploy`.
  - `checks` job:
    - Checks out the repository.
    - Validates Terragrunt HCL files.
  - `deploy` job:
    - Depends on `checks`.
    - Configures AWS credentials.
    - Sets up Tailscale.
    - Installs Terragrunt and OpenTofu.
    - Runs `terragrunt apply`.

- **plan.yml**:
  - New workflow named "Terragrunt Plan".
  - Triggered on `workflow_dispatch` and pull requests to the `main` branch.
  - Similar structure to `deploy.yml` but runs `terragrunt plan` instead of `apply`.
  - Includes additional step to configure Kubernetes using `kubectl`.

- **mise.toml**:
  - Specifies versions for Terragrunt (`0.91.1`) and OpenTofu (`1.11.1`).

### Key Learnings & Insights
- **Automation**: The introduction of GitHub Actions workflows automates the deployment and planning processes, reducing manual intervention and errors.
- **Validation**: Including a step to validate HCL files ensures configuration integrity before deployment.
- **Tool Versioning**: Using `mise.toml` to specify tool versions ensures consistency across development environments.

### Impact Assessment
- **Efficiency**: Automates infrastructure changes, speeding up the deployment process.
- **Consistency**: Ensures that the correct versions of tools are used, maintaining uniformity across environments.
- **Security**: Utilizes role-based AWS credentials and secrets management to enhance security.

### Developer Notes
- **Dependencies**: Ensure that all required secrets (`TS_OAUTH_CLIENT_ID`, `TS_OAUTH_SECRET`, `KUBE_CONFIG`) are properly set in the GitHub repository settings.
- **Environment**: The `working_dir` environment variable should point to the correct directory containing Terragrunt configurations.
- **Future Improvements**: Consider adding notifications for workflow success or failure and integrating more comprehensive testing steps.