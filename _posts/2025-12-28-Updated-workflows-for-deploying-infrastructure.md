--- 
layout: post 
title: Updated workflows for deploying infrastructure.
date: 2025-12-28T22:23:35.280-05:00
tags: [homelab, github, actions, iac, terragrunt, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This update refines the GitHub Actions workflows for deploying and planning Infrastructure as Code (IaC) changes. Specifically, it modifies the `deploy.yml` and `plan.yml` workflows to trigger only when changes are made to the `IaC/` directory or the workflow files themselves. Additionally, it streamlines the steps within these workflows to directly apply or plan Terragrunt configurations without separately installing Terragrunt and OpenTofu.

### Technical Details
- **deploy.yml**:
  - Added path filters to trigger the workflow only on changes to `IaC/**` and `.github/workflows/deploy.yml`.
  - Renamed the step from `Install Terragrunt and OpenTofu` to `Terragrunt Apply` and directly executed the `terragrunt apply` command.
- **plan.yml**:
  - Added path filters to trigger the workflow only on changes to `IaC/**` and `.github/workflows/plan.yml`.
  - Renamed the step from `Install Terragrunt and OpenTofu` to `Terragrunt Plan` and directly executed the `terragrunt plan` command.

### Key Learnings & Insights
- **Path Filters**: By adding path filters, the workflows are optimized to run only when relevant files are changed, reducing unnecessary executions and saving resources.
- **Streamlined Steps**: Directly executing `terragrunt apply` and `terragrunt plan` simplifies the workflows and reduces potential points of failure by eliminating the separate installation step.
- **Efficiency**: These changes demonstrate a best practice of minimizing workflow runtime by triggering them only when necessary and streamlining their steps.

### Impact Assessment
- **Performance**: The workflows will now run more efficiently, only when changes are made to the IaC directory or the workflow files themselves.
- **Maintainability**: Simplifying the steps within the workflows makes them easier to understand and maintain.
- **Resource Usage**: By reducing the number of times the workflows run, there is a positive impact on resource usage and cost, especially in CI/CD environments.

### Developer Notes
- **Path Filters**: Ensure that any future changes to the IaC directory or workflow files are correctly handled by these path filters.
- **Terragrunt Commands**: Verify that the Terragrunt configuration is correctly set up to handle the `apply` and `plan` commands without additional setup steps.
- **Future Improvements**: Consider adding additional checks or steps to the workflows for enhanced security or validation before applying changes.