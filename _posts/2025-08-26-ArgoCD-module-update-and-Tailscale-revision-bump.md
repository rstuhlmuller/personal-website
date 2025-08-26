--- 
layout: post 
title: ArgoCD module update and Tailscale revision bump.
date: 2025-08-26T00:21:56.125-04:00
tags: [homelab, argocd, azure\_oidc, aws\_ssm, externalsecrets, tailscale]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff introduces significant changes to the ArgoCD module within the IaC (Infrastructure as Code) repository. The primary focus is on enhancing security by integrating Azure OIDC (OpenID Connect) for authentication and managing sensitive data through AWS SSM (Systems Manager Parameter Store) and Kubernetes External Secrets. Additionally, there are updates to the Tailscale module and Terraform provider versions.

### Technical Details
- **ArgoCD Module (`IaC/modules/argocd/main.tf`):**
  - Added an environment variable `dex.azure.clientSecret` sourced from a Kubernetes secret, which references an AWS SSM parameter.
  - Updated the Dex configuration to include an Azure OIDC connector, utilizing the client secret from the environment variable.
  - Introduced an AWS SSM parameter resource for storing the client secret securely.
  - Created a Kubernetes ExternalSecret resource to sync the SSM parameter with a Kubernetes secret.

- **Tailscale Module (`IaC/modules/tailscale/main.tf`):**
  - Updated the Tailscale Helm chart target revision from a specific version (`1.86.5`) to a wildcard version (`1.*`), allowing for more flexible updates.

- **Terraform Lock File (`IaC/production/homelab/argocd/.terraform.lock.hcl`):**
  - Pinned the AWS provider version to `6.10.0` with specific hashes for security.
  - Updated the Helm provider version to `2.17.0`.

### Key Learnings & Insights
- **Security Enhancements:** The integration of Azure OIDC and the use of AWS SSM for sensitive data storage demonstrate a commitment to enhancing security practices. Using ExternalSecrets to manage Kubernetes secrets ensures that sensitive information is handled securely and dynamically.
- **Flexible Versioning:** Changing the Tailscale Helm chart version to a wildcard allows for easier updates and maintenance, reducing the need for frequent manual interventions.
- **Infrastructure as Code Best Practices:** The use of Terraform lock files with specific provider versions and hashes ensures reproducibility and security in the deployment process.

### Impact Assessment
- **Security:** The changes significantly improve the security posture by centralizing the management of sensitive credentials and integrating OIDC for authentication.
- **Maintainability:** The wildcard version for the Tailscale Helm chart and the use of ExternalSecrets enhance maintainability by allowing for easier updates and dynamic secret management.
- **Performance:** There should be no negative performance impact from these changes. Instead, the use of OIDC and secure secret management could lead to more robust and reliable authentication processes.

### Developer Notes
- **Gotchas:** Ensure that the AWS SSM parameter values are correctly set and updated. The ExternalSecret resource depends on the SSM parameter being available.
- **Future Improvements:** Consider automating the update process for the Tailscale Helm chart to ensure it always uses the latest compatible version without manual intervention.
- **Context for Future Developers:** These changes are part of an ongoing effort to enhance the security and maintainability of the ArgoCD and Tailscale modules. Future work should focus on further automating and securing the deployment processes.