--- 
layout: post 
title: ArgoCD module updated with Azure OIDC integration.
date: 2025-08-26T00:21:37.239-04:00
tags: [homelab, argocd, oidc, aws_ssm, kubernetes, iac]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces several significant changes to the ArgoCD module within the Infrastructure as Code (IaC) repository. The primary focus is on enhancing the security and flexibility of the ArgoCD deployment by integrating Azure OIDC (OpenID Connect) for authentication and managing sensitive data through AWS Systems Manager Parameter Store and Kubernetes External Secrets.

### Technical Details
- **`IaC/modules/argocd/main.tf`**:
  - Added an environment variable `dex.azure.clientSecret` sourced from a Kubernetes secret, which in turn references an AWS SSM Parameter Store value. This enhances security by avoiding hard-coded secrets in the Terraform configuration.
  - Updated the Dex configuration to include a Microsoft OIDC connector for Azure, utilizing the client secret from the newly added environment variable.
  - Introduced an `aws_ssm_parameter` resource to store the client secret securely in AWS SSM Parameter Store.
  - Added a `kubernetes_manifest` resource to create a Kubernetes ExternalSecret that references the SSM parameter, allowing the secret to be dynamically fetched and used within the cluster.

- **`IaC/modules/argocd/variables.tf`**:
  - The file was deleted, indicating a potential refactoring or consolidation of variables within the module.

- **`IaC/modules/tailscale/main.tf`**:
  - Removed annotations related to image update strategies for the Tailscale application, simplifying the configuration.
  - Changed the Tailscale chart version to a semver range (`1.*`) instead of a specific version, allowing for more flexible updates.

- **`IaC/production/homelab/argocd/.terraform.lock.hcl`**:
  - Updated the AWS provider version to `6.10.0`, ensuring compatibility with the latest features and security patches.

### Key Learnings & Insights
- **Security Best Practices**: The changes demonstrate a commitment to security best practices by externalizing secrets and using secure storage solutions like AWS SSM Parameter Store.
- **Flexibility and Maintainability**: By using semver ranges for chart versions and externalizing configuration through secrets and parameters, the configuration becomes more maintainable and adaptable to changes.
- **Integration of OIDC**: The integration of Azure OIDC showcases the importance of leveraging modern authentication mechanisms to enhance security and user experience.

### Impact Assessment
- **Security**: The changes significantly enhance the security posture by ensuring that sensitive data is not hard-coded and is managed through secure, centralized stores.
- **Maintainability**: The use of semver ranges and externalized configurations reduces the need for frequent updates to the Terraform code, making the system more maintainable.
- **Flexibility**: The system is now more adaptable to changes in dependencies and configurations, reducing the risk of breakages due to updates.

### Developer Notes
- **Gotchas**: Ensure that the AWS SSM Parameter Store values are correctly set and that the Kubernetes cluster has the necessary permissions to access External Secrets.
- **Future Improvements**: Consider automating the update of SSM parameters and External Secrets to further enhance security and reduce manual intervention.
- **Context for Future Developers**: These changes are part of a broader effort to secure and modernize the ArgoCD deployment. Future enhancements should continue to focus on security, maintainability, and flexibility.