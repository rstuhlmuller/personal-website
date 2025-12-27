--- 
layout: post 
title: Enhanced deploy.yml with kubeconfig setup.
date: 2025-12-26T21:52:39.310-05:00
tags: [homelab, deployment, kubeconfig, terragrunt, ci/cd, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff highlights updates to the deployment workflow, specifically focusing on changes within the `.github/workflows/deploy.yml` file. The modifications primarily involve the setup of the kubeconfig and the correction of a command syntax for Terragrunt.

### Technical Details
- **Kubeconfig Setup**:
  - **Old Method**: Previously, the `actions-hub/kubectl` action was used directly with environment variables.
    ```yaml
    - uses: actions-hub/kubectl@v1.35.0
      env:
        KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
    ```
  - **New Method**: The new approach involves manually setting up the kubeconfig by creating a directory, writing the kubeconfig content to a file, and ensuring proper permissions.
    ```yaml
    - name: Setup kubeconfig
      run: |
        mkdir -p $HOME/.kube
        echo "${{ secrets.KUBE_CONFIG }}" > $HOME/.kube/config
        chmod 600 $HOME/.kube/config
    ```
- **Terragrunt Command Correction**:
  - **Old Command**: 
    ```yaml
    tg_command: 'run --all --non-interactive-- apply'
    ```
  - **New Command**: 
    ```yaml
    tg_command: 'run --all --non-interactive -- apply'
    ```
  The change corrects a syntax error by adding a space between `--non-interactive` and `--apply`.

### Key Learnings & Insights
- **Manual Kubeconfig Setup**: The switch to manually setting up the kubeconfig offers more control and clarity over the configuration process. This approach ensures that the kubeconfig is correctly placed and secured, reducing potential issues related to environment variable handling.
- **Syntax Attention**: The correction of the Terragrunt command underscores the importance of meticulous attention to syntax in CLI commands. Small errors can lead to significant issues during deployment.

### Impact Assessment
- **Enhanced Security**: By manually setting permissions on the kubeconfig file, the deployment process is more secure, ensuring that sensitive configuration data is properly protected.
- **Reliability**: The corrected Terragrunt command ensures that the deployment steps are executed as intended, reducing the risk of deployment failures due to syntax errors.

### Developer Notes
- **Environment Variables**: Ensure that the `KUBE_CONFIG` secret is correctly set up in the GitHub repository settings.
- **Permissions**: Verify that the script has the necessary permissions to create directories and write files in the specified paths.
- **Future Improvements**: Consider automating the kubeconfig setup further or integrating it into a more comprehensive CI/CD tool to streamline the process.