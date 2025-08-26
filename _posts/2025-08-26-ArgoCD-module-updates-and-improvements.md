--- 
layout: post 
title: ArgoCD module updates and improvements.
date: 2025-08-26T00:21:50.162-04:00
tags: [homelab, argocd, iac, security, azure, aws]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces significant changes to the ArgoCD module within the Infrastructure as Code (IaC) repository. The primary focus is on enhancing the security and flexibility of the ArgoCD deployment by integrating Azure OIDC (OpenID Connect) for authentication and managing sensitive data through AWS Systems Manager Parameter Store and Kubernetes External Secrets.

### Technical Details
- **`IaC/modules/argocd/main.tf`**:
  - Added an environment variable `dex.azure.clientSecret` sourced from a Kubernetes secret, which in turn retrieves the value from AWS Systems Manager Parameter Store.
  - Updated the Dex configuration to include a Microsoft (Azure) OIDC connector, utilizing the new environment variable for the client secret.
  - Introduced a new resource `aws_ssm_parameter` to store the client secret securely in AWS Systems Manager.
  - Added a `kubernetes_manifest` resource to create an ExternalSecret that pulls the secret from AWS Systems Manager into Kubernetes.

- **`IaC/modules/argocd/variables.tf`**:
  - The file was deleted, indicating a potential refactoring of variable management within the module.

- **`IaC/modules/tailscale/main.tf`**:
  - Updated the Tailscale Helm chart version to use a wildcard (`1.*`) instead of a specific version (`1.86.5`), allowing for more flexible updates.

- **`IaC/production/homelab/argocd/.terraform.lock.hcl`**:
  - Locked the AWS provider version to `6.10.0` with specific hashes for security.

### Key Learnings & Insights
- **Security Enhancements**: The integration of Azure OIDC and the use of AWS Systems Manager Parameter Store for sensitive data demonstrate a commitment to enhancing security practices. Storing secrets externally and referencing them within the deployment reduces the risk of exposing sensitive information in the codebase.
- **Flexibility and Maintainability**: Using a wildcard version for the Tailscale Helm chart allows for easier updates and maintenance, reducing the need for frequent manual interventions.
- **Infrastructure as Code Best Practices**: The changes reflect best practices in IaC, such as using external secret management solutions and locking provider versions to ensure consistency and security across environments.

### Impact Assessment
- **Security**: The changes significantly improve the security posture of the ArgoCD deployment by externalizing sensitive data and integrating a robust authentication mechanism.
- **Maintainability**: The use of wildcard versions for Helm charts and locked provider versions enhances the maintainability of the IaC repository.
- **Potential Breaking Changes**: The deletion of `variables.tf` and the introduction of new resources may require adjustments in other parts of the codebase or deployment processes.

### Developer Notes
- **Gotchas**: Ensure that the AWS Systems Manager Parameter Store and Kubernetes External Secrets are correctly configured and accessible within the deployment environment.
- **Future Improvements**: Consider automating the update of secrets in AWS Systems Manager to further streamline the deployment process.
- **Context for Future Developers**: These changes are part of an ongoing effort to enhance the security and maintainability of the IaC repository. Familiarize yourself with the External Secrets operator and AWS Systems Manager Parameter Store to effectively work with this code.