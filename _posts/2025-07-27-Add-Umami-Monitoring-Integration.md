--- 
layout: post 
title: Add Umami Monitoring Integration
date: 2025-07-27T13:51:09.001-04:00
tags: [homelab, documentation]
categories: [Homelab]
author: ai
---
### Change Summary
This update introduces the deployment of Umami, a privacy-focused web analytics tool, into the monitoring namespace of a Kubernetes cluster managed via ArgoCD. Key additions include an ArgoCD application for Umami, integration with Cert-Manager for TLS certificates, secrets management using AWS SSM Parameter Store and External Secrets, and a Tailscale ingress for secure access. No removals or major modifications to existing components were made, but the monitoring certificate was extended to include a new domain.

### Technical Details
The changes span two files in the IaC/modules/monitoring directory, focusing on infrastructure-as-code for deploying and securing the Umami application.

- **main.tf**:
  - Added `argocd_application "umami"`: This deploys the Umami Helm chart (version 5.0.8) from the repository `https://charts.christianhuth.de`. It targets the `monitoring` namespace and configures Helm values for ingress (enabled with host `umami.stinkyboi.com` and TLS using a Cert-Manager secret), disables the built-in PostgreSQL, and references an external secret for the database URL. Sync policy is set to automated with pruning and self-healing enabled.
  - Updated `kubernetes_manifest "monitoring_certificate"`: Extended the `dnsNames` list to include `umami.stinkyboi.com`, ensuring TLS certificate coverage for the new Umami domain alongside existing ones like `grafana.stinkyboi.com` and `prometheus.stinkyboi.com`.
  - Added `kubernetes_ingress_v1 "umami_tailscale_funnel"`: Configures a Tailscale ingress in the `monitoring` namespace with annotations for funneling traffic. It sets up a rule for host `umami` routing to the `umami` service on port 80, with TLS enabled for secure access.

- **secrets.tf** (new file):
  - Added `aws_ssm_parameter "umami"`: Creates a secure string parameter in AWS SSM at path `/homelab/monitoring/umami_database_url` for storing the Umami database connection URL. It uses a placeholder value ("update_me") that should be replaced in production.
  - Added `kubernetes_manifest "umami_secret"`: Defines an ExternalSecret resource that pulls the SSM parameter into the Kubernetes cluster. It references the "parameterstore" ClusterSecretStore and refreshes on changes, mapping the secret to key `umami_database_url` for use in the Umami deployment.

These changes leverage ArgoCD for application management, Cert-Manager for certificates, External Secrets for secret injection, and Tailscale for ingress, following a GitOps and zero-trust security model. No new dependencies were introduced beyond existing ones like Helm and the referenced charts.

### Key Learnings & Insights
The primary motivation for these changes is to integrate Umami as a lightweight, open-source alternative to tools like Google Analytics, emphasizing privacy and self-hosting in a homelab or monitoring setup. This addresses the need for tracking website metrics without relying on third-party services, solving potential data privacy concerns.

- **Problem-Solving Approaches**: Secrets are managed externally via AWS SSM and injected dynamically with External Secrets, reducing the risk of hardcoding sensitive data in IaC. The use of ArgoCD's automated sync ensures declarative deployments, allowing self-healing if drifts occur.
- **Best Practices Demonstrated**: Adheres to Infrastructure as Code (IaC) principles with Terraform; separates concerns (e.g., secrets in a dedicated file); uses Helm overrides for customization without forking charts; and implements TLS everywhere via Cert-Manager.
- **Trade-offs and Decisions**: Opted to disable Umami's built-in PostgreSQL in favor of an external database (referenced via URL), trading simplicity for flexibility in database management. Tailscale ingress was chosen for its ease in homelab environments, though it might introduce latency compared to a public ingress controller— a decision prioritizing security over raw performance.

### Impact Assessment
These changes expand the monitoring namespace by adding Umami as a new service, potentially increasing resource usage (e.g., CPU/memory for the pod and database connections) but minimally affecting existing components like Grafana or Prometheus. Performance implications are low, as Umami is lightweight, but expect slight overhead from Tailscale tunneling. Security is enhanced through TLS enforcement and secret externalization, reducing exposure risks. Maintainability improves with GitOps automation, though developers must ensure the external database is provisioned separately.

No breaking changes to existing applications; however, if migrating from another analytics tool, manual data import to Umami might be needed. The new domain requires DNS configuration updates for `umami.stinkyboi.com`.

### Developer Notes
- **Gotchas and Edge Cases**: Ensure the AWS SSM parameter value is updated from "update_me" before deployment to avoid connection failures; also, verify the external database is accessible and compatible with Umami's schema. Tailscale funneling assumes a working Tailscale setup—test ingress access in a non-production environment to catch any networking issues.
- **Context for Future Developers**: This setup assumes a pre-existing `monitoring` namespace and dependencies like ArgoCD, Cert-Manager, and External Secrets. Reference the Umami Helm chart documentation for value customizations, and monitor ArgoCD sync status post-deployment.
- **Potential Improvements**: Add resource requests/limits to the Umami deployment for better Kubernetes scheduling; integrate alerting (e.g., via Prometheus) for Umami uptime; or explore autoscaling if analytics traffic grows. Consider migrating to a dedicated namespace if Umami evolves beyond monitoring tools.