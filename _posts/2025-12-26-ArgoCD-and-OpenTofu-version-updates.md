--- 
layout: post 
title: ArgoCD and OpenTofu version updates.
date: 2025-12-26T21:20:55.800-05:00
tags: [homelab, infrastructure, github-actions, terraform, kubernetes, ci-cd]
categories: [Homelab]
author: ai
---
**Change Summary**

This git diff introduces several changes to the infrastructure as code (IaC) workflows and configurations for a homelab environment. Key changes include the addition of new GitHub Actions workflows for deploying and planning infrastructure changes, updates to HCL files for including Kubernetes providers, version changes for certain Helm charts and Terraform providers, and the addition of a `mise.toml` file for managing tool versions.

**Technical Details**

- **GitHub Actions Workflows**:
  - `deploy.yml`: A new workflow for deploying infrastructure changes using Terragrunt. It includes steps for checking out code, validating HCL files, installing Terragrunt and OpenTofu, configuring AWS credentials, setting up Tailscale, and applying Terragrunt configurations.
  - `plan.yml`: A new workflow for planning infrastructure changes. Similar to the deploy workflow, it includes steps for checking out code, validating HCL files, installing necessary tools, configuring AWS credentials, setting up Tailscale, and running a Terragrunt plan.

- **HCL Files**:
  - `metrics.hcl`: Includes a new Kubernetes provider configuration.
  - `helm_provider.hcl` and `kube_provider.hcl`: Updated to use `pathexpand` for the Kubernetes config path to ensure compatibility across different environments.

- **Terraform Configurations**:
  - Various `.terraform.lock.hcl` files were updated to reflect changes in provider versions, specifically updating the `argoproj-labs/argocd` provider from version `7.12.3` to `7.12.4`.
  - The `main.tf` file in the `metrics` module was updated to use a different version of the `metrics-server` Helm chart.

- **Tool Versions**:
  - A new `mise.toml` file was added to specify versions for Terragrunt (`0.91.1`) and OpenTofu (`1.11.1`).

**Key Learnings & Insights**

- **Automation and CI/CD**: The introduction of GitHub Actions workflows for deploying and planning infrastructure changes demonstrates a commitment to automating infrastructure management and integrating CI/CD practices into IaC workflows.
- **Version Management**: The use of `mise.toml` for specifying tool versions highlights the importance of version control for development tools to ensure consistency and reproducibility across different environments.
- **Configuration Management**: The changes to HCL files and Terraform configurations show an emphasis on maintaining up-to-date and compatible provider versions, which is crucial for the stability and security of infrastructure deployments.

**Impact Assessment**

- **Automation**: The new workflows streamline the process of deploying and planning infrastructure changes, reducing the potential for human error and speeding up the deployment cycle.
- **Maintainability**: By specifying tool versions in `mise.toml`, the project ensures that all developers and CI/CD pipelines use the same versions of critical tools, enhancing maintainability and reducing compatibility issues.
- **Compatibility and Security**: Updating provider versions and configurations ensures that the infrastructure uses the latest features and security patches, improving overall system security and compatibility.

**Developer Notes**

- **Workflow Dependencies**: Ensure that the necessary secrets (e.g., `TS_AUTH_KEY`, `KUBE_CONFIG`) are properly configured in the GitHub repository settings for the workflows to execute successfully.
- **Version Consistency**: When updating tool versions in `mise.toml`, verify that the changes are compatible with existing configurations and workflows to avoid breaking changes.
- **Future Improvements**: Consider adding additional checks or steps to the workflows for further validation or testing of infrastructure changes before deployment.