--- 
layout: post 
title: Update GitHub workflows for Terraform actions.
date: 2025-12-28T22:19:22.465-05:00
tags: [homelab, github, actions, workflows, terragrunt, opentofu]
categories: [Homelab]
author: ai
---
### Change Summary
This update modifies the GitHub Actions workflows for deploying and planning infrastructure changes. Specifically, it refines the triggering conditions and adjusts the steps within these workflows to enhance the deployment process.

### Technical Details
- **deploy.yml**
  - **Triggers:** The workflow now triggers on pushes to the `main` branch specifically when files in the `IaC/` directory or the `deploy.yml` itself are modified.
  - **Steps:** 
    - Renamed the step from `Install Terragrunt and OpenTofu` to `Terragrunt Apply`.
    - The action `gruntwork-io/terragrunt-action` is used with the specific commit `95fc057922e3c3d4cc021a81a213f088f333ddef` to ensure consistency.
    - The `tg_dir` is set to the environment variable `working_dir`.

- **plan.yml**
  - **Triggers:** Similar to `deploy.yml`, this workflow now triggers on pull requests targeting the `main` branch and when files in the `IaC/` directory or the `plan.yml` itself are modified.
  - **Steps:**
    - Renamed the step from `Install Terragrunt and OpenTofu` to `Terragrunt Plan`.
    - Uses the same `gruntwork-io/terragrunt-action` with the commit `95fc057922e3c3d4cc021a81a213f088f333ddef`.
    - The `tg_dir` is set to the environment variable `working_dir`.

### Key Learnings & Insights
- **Granular Triggers:** By specifying paths in the trigger conditions, the workflows become more efficient, running only when relevant files are changed. This reduces unnecessary executions and saves resources.
- **Step Clarity:** Renaming steps to `Terragrunt Apply` and `Terragrunt Plan` provides clearer intent and improves readability for other developers.
- **Version Pinning:** Using a specific commit for the `gruntwork-io/terragrunt-action` ensures that the action version remains consistent across different workflow executions, reducing the risk of unexpected behavior due to updates in the action.

### Impact Assessment
- **Efficiency:** The workflows will now run less frequently, only when necessary, leading to reduced execution times and resource usage.
- **Clarity:** The renamed steps make the workflows more understandable, aiding in maintenance and future updates.
- **Consistency:** Pinning the action version mitigates the risk of breaking changes introduced by future updates to the action.

### Developer Notes
- **Gotchas:** Ensure that the `working_dir` environment variable is correctly set in your GitHub Actions environment to avoid errors during execution.
- **Edge Cases:** Consider handling scenarios where the `IaC/` directory might not contain any changes but other critical files do. Ensure that the workflow logic accounts for such cases if needed.
- **Future Improvements:** Explore the possibility of further optimizing the workflows by incorporating caching mechanisms for dependencies or intermediate results to speed up execution times.