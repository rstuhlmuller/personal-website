--- 
layout: post 
title: Terraform Workflows Update and Fixes
date: 2025-12-26T21:20:09.667-05:00
tags: [homelab, terragrunt, github-actions, infrastructure-as-code, version-management, automation]
categories: [Homelab]
author: ai
---
**Change Summary**

This commit introduces two new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt. It also updates various HCL and Terraform files to include new providers and configurations, and bumps the versions of certain dependencies. Additionally, a new `mise.toml` file is added to manage tool versions.

**Technical Details**

- **Workflows:**
  - `.github/workflows/deploy.yml`: This workflow triggers on `workflow_dispatch` and `push` events to the `main` branch. It performs checks on Terragrunt HCL files and then deploys the infrastructure.
  - `.github/workflows/plan.yml`: This workflow triggers on `workflow_dispatch` and various `pull_request` events. It also checks Terragrunt HCL files and then plans the infrastructure changes.

- **HCL and Terraform Files:**
  - `IaC/_envcommon/metrics.hcl`: Includes a new `kube_provider`.
  - `IaC/_envcommon/providers/helm.hcl` and `IaC/_envcommon/providers/kube.hcl`: Updates the `config_path` to use `pathexpand`.
  - `IaC/modules/metrics/main.tf`: Changes the version of the `metrics-server` Helm chart.
  - Multiple `.terraform.lock.hcl` files: Updates the version of the Argo CD provider from `7.12.3` to `7.12.4`.

- **Dependency Management:**
  - `mise.toml`: Added to manage versions of `terragrunt` and `opentofu`.

**Key Learnings & Insights**

- **Automation and CI/CD:** The introduction of GitHub Actions workflows for deploying and planning infrastructure changes automates the process, ensuring consistency and reducing manual errors.
- **Version Management:** Using `mise.toml` to manage tool versions centralizes dependency management, making it easier to update and maintain tool versions across the project.
- **Path Expansion:** The use of `pathexpand` in HCL files ensures that paths are correctly resolved, which is crucial for cross-platform compatibility and avoiding hardcoded paths.

**Impact Assessment**

- **Automation:** The new workflows streamline the deployment and planning processes, reducing the likelihood of human error and ensuring that infrastructure changes are consistently applied.
- **Maintainability:** Centralized version management via `mise.toml` simplifies updates and ensures that all developers are using the same tool versions.
- **Compatibility:** The use of `pathexpand` enhances the portability of configurations across different environments.

**Developer Notes**

- **Workflow Dependencies:** Ensure that the necessary secrets (`TS_AUTH_KEY` and `KUBE_CONFIG`) are correctly set up in the GitHub repository settings.
- **Version Updates:** When updating tool versions in `mise.toml`, verify that the new versions are compatible with the existing infrastructure and workflows.
- **Path Resolution:** Be cautious when modifying paths in HCL files to ensure that `pathexpand` is used correctly to avoid path resolution issues.