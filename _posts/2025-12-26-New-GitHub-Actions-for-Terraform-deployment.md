--- 
layout: post 
title: New GitHub Actions for Terraform deployment.
date: 2025-12-26T14:18:50.025-05:00
tags: [homelab, ci-cd, terragrunt, github-actions, infrastructure-as-code, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This commit introduces a new CI/CD pipeline for deploying and planning infrastructure changes using Terragrunt. Two new GitHub Actions workflows (`deploy.yml` and `plan.yml`) have been added, and updates have been made to configuration files to support these workflows. Additionally, a new `mise.toml` file has been added to manage tool versions.

### Technical Details
- **deploy.yml**:
  - Triggers on `workflow_dispatch` and `push` to the `main` branch.
  - Performs HCL formatting checks using `gruntwork-io/terragrunt-action`.
  - Configures AWS credentials and runs `terragrunt apply` in the `IaC/production/homelab` directory.
  
- **plan.yml**:
  - Triggers on `workflow_dispatch` and various `pull_request` events on the `main` branch.
  - Performs HCL formatting checks.
  - Configures AWS credentials and runs `terragrunt plan` in the `IaC/production/homelab` directory.
  
- **kube.hcl**:
  - Updates the `config_path` for the Kubernetes provider to use `pathexpand` for better compatibility.
  
- **mise.toml**:
  - Specifies versions for `terragrunt` and `opentofu` to ensure consistent tool versions across environments.

### Key Learnings & Insights
- **Automation of Infrastructure Changes**:
  - The introduction of GitHub Actions workflows automates the deployment and planning of infrastructure changes, reducing manual effort and potential for human error.
  
- **Consistency and Validation**:
  - HCL formatting checks ensure that the configuration files are consistently formatted, improving readability and maintainability.
  
- **Tool Version Management**:
  - Using `mise.toml` to manage tool versions ensures that all developers and CI environments use the same versions, avoiding compatibility issues.

### Impact Assessment
- **Efficiency**:
  - Automated workflows streamline the process of deploying and planning infrastructure changes, saving time and reducing the risk of errors.
  
- **Maintainability**:
  - Consistent tool versions and formatted configuration files improve the maintainability of the infrastructure code.
  
- **Security**:
  - Proper configuration of AWS credentials and use of role-based access control enhance the security posture of the infrastructure deployment process.

### Developer Notes
- **Gotchas**:
  - Ensure that all required secrets (`TS_AUTH_KEY` and `KUBE_CONFIG`) are correctly set up in the GitHub repository settings.
  
- **Future Improvements**:
  - Consider adding additional checks or steps to the workflows, such as linting or security scans, to further enhance the quality and security of the infrastructure code.
  
- **Environment Variables**:
  - Be mindful of the `working_dir` environment variable, as it dictates where the Terragrunt commands are executed. Any changes to this directory path will require updates to the workflows.