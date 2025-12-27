--- 
layout: post 
title: Workflow and Terraform Config Updates.
date: 2025-12-26T21:36:35.117-05:00
tags: [homelab, terragrunt, githubactions, infrastructure, automation, versioning]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff encompasses several changes aimed at enhancing the deployment and infrastructure management workflows for a homelab environment. Key changes include the introduction of new GitHub Actions workflows for deploying and planning infrastructure changes using Terragrunt, updates to HCL and Terraform configurations, and the addition of a `mise.toml` file for managing tool versions.

### Technical Details
- **GitHub Actions Workflows:**
  - **`deploy.yml`:** Automates the deployment process using Terragrunt. It includes steps for checking out the code, validating HCL files, installing necessary tools, configuring AWS credentials, and executing the Terragrunt apply command.
  - **`plan.yml`:** Similar to `deploy.yml`, but focuses on planning infrastructure changes. It runs on pull requests and includes additional steps for setting up kubeconfig.

- **HCL and Terraform Configurations:**
  - **`metrics.hcl`:** Includes a new provider for Kubernetes.
  - **`helm.hcl` and `kube.hcl`:** Updated to use `pathexpand` for the kubeconfig path.
  - **`main.tf`:** Changed the version of the metrics-server Helm chart.
  - **`.terraform.lock.hcl` files:** Updated the version of the ArgoCD provider across multiple modules.

- **mise.toml:**
  - Added to manage versions of Terragrunt and OpenTofu, ensuring consistency across environments.

### Key Learnings & Insights
- **Automation and CI/CD:** The introduction of GitHub Actions workflows demonstrates a shift towards automating infrastructure deployment and planning, enhancing efficiency and reducing manual errors.
- **Version Management:** The use of `mise.toml` for tool version management reflects a best practice in maintaining consistency and reproducibility across development environments.
- **Path Management:** The change to use `pathexpand` for kubeconfig paths shows an understanding of the importance of handling paths dynamically to improve compatibility across different systems.

### Impact Assessment
- **Efficiency:** The automated workflows will streamline the deployment and planning processes, reducing the time and effort required for manual interventions.
- **Consistency:** The version management through `mise.toml` ensures that all developers and CI environments use the same tool versions, minimizing compatibility issues.
- **Maintainability:** The dynamic path handling improves the robustness of the configurations, making them more portable across different environments.

### Developer Notes
- **Gotchas:** Ensure that the AWS role and Tailscale auth key are correctly configured in GitHub Secrets to avoid deployment failures.
- **Future Improvements:** Consider adding additional checks or validations within the GitHub Actions workflows to further enhance the reliability of the deployment process.
- **Documentation:** Maintain up-to-date documentation for the setup and usage of these workflows to onboard new developers effectively.