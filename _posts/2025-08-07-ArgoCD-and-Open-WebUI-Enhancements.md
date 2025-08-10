--- 
layout: post 
title: ArgoCD and Open-WebUI Enhancements
date: 2025-08-07T17:53:55.240-04:00
tags: [homelab, documentation]
categories: [Homelab]
author: ai
---
### Change Summary
This diff introduces enhancements to the Open WebUI module in an Infrastructure as Code (IaC) setup, primarily enabling a new "MCPO" (likely Multi-Chat Protocol or similar integration) feature within Open WebUI. Key additions include a custom ingress for MCPO, updated Helm chart sourcing from a Git repository, and configuration for MCPO servers. Additionally, the ArgoCD image updater's polling interval is extended to 6 hours for efficiency, and a GitHub-specific file is added to .gitignore to ignore AI-related instructions.

### Technical Details
- **.gitignore**: Added an entry to ignore `.github/copilot-instructions.md`, preventing version control of GitHub Copilot configuration files. This keeps repositories cleaner by excluding tool-specific artifacts.

- **IaC/modules/argocd/main.tf**: In the `helm_release` resource for "argocd_image_updater", added `extraArgs = ["--interval", "6h"]` to the values. This configures the ArgoCD Image Updater to check for image updates every 6 hours instead of the default (likely more frequent) interval, reducing unnecessary API calls.

- **IaC/modules/open-webui/ingress.tf**:
  - Updated the `kubernetes_manifest` for "open_webui_certificate" by adding `"mcpo.chat.stinkyboi.com"` to the `dnsNames` list, extending certificate coverage to this new subdomain.
  - Introduced a new `kubernetes_ingress_v1` resource named "mcpo" in the Open WebUI namespace. It sets up Traefik as the ingress class, routes traffic from host `"mcpo.chat.stinkyboi.com"` to service `"open-webui-mcpo"` on port 8000, and enables TLS using the secret `"open-webui-certificate-secret"`. This creates a secure entry point for MCPO-related traffic.

- **IaC/modules/open-webui/main.tf**:
  - Modified the `argocd_application` "open_webui" source: Changed from a direct Helm repository (`repo_url = "https://helm.openwebui.com/"`, `chart = "open-webui"`, `target_revision = "6.13.0"`) to a Git-based path (`repo_url = "https://github.com/rstuhlmuller/openwebui-helm-charts.git"`, `path = "charts/open-webui"`, `target_revision = "HEAD"`). This allows pulling the latest chart version directly from a custom Git repo, potentially for unreleased features or customizations.
  - Added Helm parameters: `mcpo.enabled = "true"` to activate MCPO functionality, and `config = "{}"` as a placeholder (overridden in values).
  - In the `values` YAML, added a `config` block defining `mcpServers` with a "time" server using command `"uvx"` and args `["mcp-server-time", "--local-timezone=America/Los_Angeles"]`. This configures a specific MCPO server instance for time-related tasks, integrated with Open WebUI's environment variables (e.g., retaining `OPENAI_API_KEY` from OpenRouter).

No architectural changes like new design patterns are evident, but this shifts towards Git-sourced Helm charts for more flexible deployments. Dependencies remain on ArgoCD, Helm, Kubernetes (e.g., ingress v1), and Traefik for routing.

### Key Learnings & Insights
These changes appear driven by the need to extend Open WebUI with MCPO capabilities, possibly for integrating chat or protocol services (e.g., Minecraft Protocol or custom multi-chat). Sourcing the Helm chart from Git instead of a static repo allows rapid iteration on custom features, demonstrating a problem-solving approach of forking/maintaining charts in a personal repo for unreleased enhancements. The 6-hour interval in ArgoCD reduces resource overhead, applying a best practice of tuning polling for production efficiency. A trade-off here is potential delay in image updates versus lower load; this was likely chosen to balance responsiveness with cost in a cloud environment. Lessons include the value of modular IaC (e.g., separating ingress and app config) for scalability, and using annotations in Kubernetes resources for fine-grained control like Traefik entrypoints.

### Impact Assessment
These updates enhance the Open WebUI deployment by adding MCPO support, introducing a new subdomain and ingress path that could handle additional traffic or features without disrupting the main "chat.stinkyboi.com" endpoint. Performance-wise, the longer ArgoCD interval may slightly improve efficiency by reducing checks, but could delay updates in fast-changing environments. Security benefits from extended TLS certificate coverage and secure routing via Traefik. Maintainability improves with Git-sourced charts for easier customizations, though it ties the deployment to a specific Git repo. No breaking changes are apparent, but existing deployments might need re-syncing in ArgoCD to apply the new chart source and MCPO config—no explicit migrations required, assuming the custom repo mirrors the original chart structure.

### Developer Notes
- **Gotchas and Edge Cases**: Watch for Git repo availability issues when using `target_revision = "HEAD"`—pin to a commit hash if stability is critical to avoid pulling breaking changes. The MCPO config assumes "uvx" is available in the container; verify this in staging to prevent runtime errors. Timezone args like `--local-timezone=America/Los_Angeles` should be tested for edge cases involving daylight saving time or international users.
- **Context for Future Developers**: This setup assumes an existing Open WebUI namespace and Traefik ingress controller; extend `mcpServers` for more integrations, but keep configs minimal to avoid overriding defaults. The Copilot ignore in .gitignore is GitHub-specific—remove if not using AI tools.
- **Potential Improvements**: Consider parameterizing the Git repo URL or MCPO args via variables for better reusability. Add monitoring (e.g., Prometheus metrics) for the new ingress to track MCPO traffic, and explore automating certificate renewals if using Cert-Manager.