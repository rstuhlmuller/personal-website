--- 
layout: post 
title: Upgrades, workflow creation, and HCL updates.
date: 2025-12-26T21:14:48.718-05:00
tags: [homelab, infrastructure, github-actions, ci-cd, terragrunt, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This commit introduces several significant changes to the project's infrastructure as code (IaC) and CI/CD workflows. Key changes include the addition of new GitHub Actions workflows for deploying and planning infrastructure using Terragrunt, updates to configuration files for metrics and providers, a version bump for certain dependencies, and the introduction of a `mise.toml` file for managing tool versions.

### Technical Details
- **New Workflows:**
  - `.github/workflows/deploy.yml`: This workflow triggers on pushes to the `main` branch and manual dispatches. It performs checks on Terragrunt HCL files and then deploys the infrastructure.
  - `.github/workflows/plan.yml`: This workflow triggers on pull requests to the `main` branch. It performs the same checks as the deploy workflow but runs a `terragrunt plan` instead of `apply`.

- **Configuration Updates:**
  - `IaC/_envcommon/metrics.hcl`: Included a new `kube_provider` configuration.
  - `IaC/_envcommon/providers/helm.hcl` and `IaC/_envcommon/providers/kube.hcl`: Updated the `config_path` to use `pathexpand` for better compatibility.

- **Dependency Updates:**
  - `IaC/modules/metrics/main.tf`: Downgraded the `metrics-server` Helm chart version from 3.13 to 3.12.2.
  - Various `.terraform.lock.hcl` files: Updated the version of the `argoproj-labs/argocd` provider from 7.12.3 to 7.12.4.
  - `mise.toml`: Added to manage versions of `terragrunt` and `opentofu`.

### Key Learnings & Insights
- **Automation and CI/CD:** The introduction of GitHub Actions workflows for deploying and planning infrastructure demonstrates a shift towards more automated and reliable CI/CD practices. This ensures that infrastructure changes are thoroughly tested before deployment.
- **Version Management:** The use of `mise.toml` for tool version management indicates a best practice for maintaining consistent tool versions across different environments, reducing the risk of version-related bugs.
- **Configuration Best Practices:** The update to use `pathexpand` in provider configurations shows an improvement in path handling, making the configurations more robust and less prone to errors.

### Impact Assessment
- **Performance:** The changes are unlikely to have a direct impact on performance. However, the version updates and configuration changes aim to enhance reliability and maintainability.
- **Security:** Ensuring that HCL files are correctly formatted and that dependencies are up-to-date contributes to a more secure infrastructure.
- **Maintainability:** The introduction of automated workflows and consistent tool version management will make the infrastructure easier to maintain and update in the future.

### Developer Notes
- **Gotchas:** Ensure that the `mise.toml` file is correctly configured and that all developers are using the specified tool versions to avoid compatibility issues.
- **Edge Cases:** Pay attention to the version constraints in `.terraform.lock.hcl` files to ensure that the correct versions of providers are used.
- **Future Improvements:** Consider adding more comprehensive testing to the CI/CD workflows to further enhance the reliability of infrastructure changes.