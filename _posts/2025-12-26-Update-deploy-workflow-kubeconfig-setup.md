--- 
layout: post 
title: Update deploy workflow kubeconfig setup.
date: 2025-12-26T21:52:26.959-05:00
tags: [homelab, github-actions, kubeconfig, terragrunt, ci-cd, automation]
categories: [Homelab]
author: ai
---
### Change Summary
This commit modifies the GitHub Actions workflow defined in `.github/workflows/deploy.yml`. The primary changes involve updating the setup for kubeconfig and correcting a typo in the Terragrunt command.

### Technical Details
- **Kubeconfig Setup**:
  - The workflow now includes a manual setup for the kubeconfig file instead of using the `actions-hub/kubectl@v1.35.0` action.
  - **Changes**:
    ```yaml
    - uses: actions-hub/kubectl@v1.35.0
      env:
        KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
    + name: Setup kubeconfig
      run: |
        mkdir -p $HOME/.kube
        echo "${{ secrets.KUBE_CONFIG }}" > $HOME/.kube/config
        chmod 600 $HOME/.kube/config
    ```
  - This change ensures that the kubeconfig file is correctly set up in the runner’s home directory with appropriate permissions.

- **Terragrunt Command Typo Fix**:
  - A typo in the Terragrunt command has been fixed by adding a space between `--non-interactive` and `--apply`.
  - **Changes**:
    ```yaml
    - tg_command: 'run --all --non-interactive-- apply'
    + tg_command: 'run --all --non-interactive -- apply'
    ```

### Key Learnings & Insights
- **Automation Best Practices**: Manually setting up the kubeconfig ensures that the workflow is more transparent and easier to debug if issues arise.
- **Attention to Detail**: The typo in the Terragrunt command highlights the importance of careful review of automated scripts to avoid silent failures.
- **Configuration Management**: Storing sensitive configuration data like kubeconfig in GitHub Secrets and setting appropriate permissions is a best practice for security.

### Impact Assessment
- **Positive Impacts**:
  - Improved clarity and reliability in the CI/CD pipeline.
  - Reduced risk of deployment failures due to incorrect kubeconfig setup.
- **Negative Impacts**:
  - None identified; the changes are corrective and enhance the workflow.

### Developer Notes
- **Gotchas**: Ensure that the kubeconfig secret is correctly set up in the GitHub repository secrets.
- **Edge Cases**: Verify that the permissions set for the kubeconfig file do not cause issues in different runner environments.
- **Future Improvements**: Consider adding validation steps to ensure the kubeconfig is correctly loaded before proceeding with deployment steps.