--- 
layout: post 
title: Workflows created for Terragrunt Plan and Deploy.
date: 2025-12-26T14:10:10.752-05:00
tags: [homelab, terragrunt, githubactions, infrastructure, automation, kubernetes]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces two new GitHub Actions workflows for deploying and planning infrastructure using Terragrunt. Additionally, it updates the Kubernetes provider configuration and specifies tool versions in `mise.toml`.

### Technical Details
- **Workflows:**
  - `deploy.yml`: Automates the deployment of infrastructure using Terragrunt. It includes steps for checking out code, validating HCL, configuring AWS credentials, and executing `terragrunt apply`.
  - `plan.yml`: Automates the planning phase for infrastructure changes. It includes similar steps but executes `terragrunt plan` instead.
- **Kubernetes Provider Configuration:**
  - Updated `kube.hcl` to specify the Kubernetes API server host.
- **Tool Versions:**
  - Added `mise.toml` to pin Terragrunt and OpenTofu versions.

### Key Learnings & Insights
- **Automation:** The introduction of GitHub Actions workflows streamlines the deployment and planning processes, reducing manual intervention.
- **Configuration Management:** Specifying the Kubernetes API server host in `kube.hcl` enhances configuration clarity and maintainability.
- **Tool Versioning:** Pinning tool versions in `mise.toml` ensures consistency across development environments.

### Impact Assessment
- **Efficiency:** Automated workflows improve deployment efficiency and reduce the risk of human error.
- **Maintainability:** Clear configuration and tool versioning enhance code maintainability and reproducibility.
- **Security:** Using GitHub Secrets for sensitive information (e.g., AWS credentials, Tailscale auth key) improves security posture.

### Developer Notes
- **Gotchas:** Ensure all required secrets are configured in the GitHub repository settings.
- **Future Improvements:** Consider adding additional checks or notifications to the workflows for enhanced monitoring.