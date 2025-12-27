--- 
layout: post 
title: GitHub Actions Terraform Workflow Updates
date: 2025-12-26T21:26:33.907-05:00
tags: [homelab, terragrunt, cicd, terraform, automation, security]
categories: [Homelab]
author: ai
---
**Change Summary**

This update introduces significant changes to the CI/CD workflows for deploying and planning infrastructure using Terragrunt. It also includes updates to various Terraform configurations and dependencies. The primary focus is on improving the deployment process, enhancing configuration management, and updating provider versions.

**Technical Details**

- **Workflows:**
  - **deploy.yml:** New workflow for deploying infrastructure using Terragrunt. It includes steps for checking out code, validating HCL, installing Terragrunt and OpenTofu, configuring AWS credentials, setting up Tailscale, and applying Terragrunt configurations.
  - **plan.yml:** New workflow for planning infrastructure changes. Similar to the deploy workflow but executes a plan instead of an apply.

- **Terraform Configurations:**
  - **metrics.hcl:** Includes a new `kube_provider` configuration.
  - **helm.hcl and kube.hcl:** Updated to use `pathexpand` for the `config_path`.
  - **main.tf:** Updated the version of the `metrics-server` Helm chart from 3.13 to 3.12.2.
  - **Various .terraform.lock.hcl files:** Updated the version of the Argo CD provider from 7.12.3 to 7.12.4.

- **mise.toml:** New file added to manage tool versions, specifying Terragrunt 0.96.1 and OpenTofu 1.11.2.

**Key Learnings & Insights**

- **Automation and Validation:** The introduction of dedicated workflows for deploying and planning infrastructure emphasizes the importance of automating these processes. Validating HCL before deployment ensures configuration integrity.
- **Version Management:** Updating provider versions and tool dependencies is crucial for maintaining compatibility and security. The use of `mise.toml` for version management demonstrates a best practice for keeping tool versions consistent across environments.
- **Path Management:** The switch to `pathexpand` for configuration paths enhances portability and reduces the risk of path-related errors.

**Impact Assessment**

- **Performance:** The changes are unlikely to have a significant performance impact. However, ensuring configurations are valid before deployment can prevent runtime errors and reduce deployment time.
- **Security:** Updating provider versions and tool dependencies enhances security by patching known vulnerabilities.
- **Maintainability:** The new workflows and version management practices improve maintainability by providing clear, automated processes for deployment and planning.

**Developer Notes**

- **Gotchas:** Ensure that all dependencies and secrets (e.g., AWS credentials, Tailscale auth key) are correctly configured in the GitHub repository settings.
- **Edge Cases:** Monitor the first few deployments closely to catch any issues that may arise from the new workflows or configuration changes.
- **Future Improvements:** Consider adding additional validation steps or integrating more comprehensive testing into the workflows to further enhance reliability.