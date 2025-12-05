--- 
layout: post 
title: Update Kubernetes provider version 3.0.
date: 2025-12-04T20:54:19.596-05:00
tags: [homelab, kubernetes, terraform, upgrade, modules, infrastructure]
categories: [Homelab]
author: ai
---
### Change Summary
This update involves upgrading the `kubernetes` provider version across multiple Terraform modules from `~> 2.36` to `~> 3.0`. The change is consistent across all modules, ensuring uniformity and leveraging the latest features and bug fixes provided by the new version.

### Technical Details
- **Files Modified:** 
  - `IaC/modules/*/init.tf` (where `*` represents various module names such as `argocd`, `cert-manager`, `cloudflare-tunnel`, etc.)
- **Change Implemented:**
  - Updated the `kubernetes` provider version in the `required_providers` block from `~> 2.36` to `~> 3.0`.
- **Affected Modules:**
  - argocd
  - cert-manager
  - cloudflare-tunnel
  - database
  - descheduler
  - external-secrets
  - homarr
  - homeassistant
  - litellm
  - longhorn
  - metallb
  - metrics
  - monitoring
  - n8n
  - octobot
  - open-webui
  - tailscale
  - technitium
  - traefik

### Key Learnings & Insights
- **Reasoning Behind the Change:**
  - The upgrade to `kubernetes` provider version `~> 3.0` was driven by the need to access new features, improvements, and bug fixes not available in version `2.36`.
- **Problem-Solving Approach:**
  - A systematic approach was taken to identify all modules using the `kubernetes` provider and ensure a uniform upgrade across the board.
- **Best Practices:**
  - Versioning with `~>` ensures compatibility with minor version updates, reducing the risk of breaking changes.
  - Centralized management of provider versions enhances maintainability and simplifies future updates.

### Impact Assessment
- **Performance:** 
  - Potential performance improvements and bug fixes from the new provider version.
- **Security:**
  - Enhanced security patches and features included in the latest provider version.
- **Maintainability:**
  - Simplified maintenance by ensuring all modules use the same provider version.
- **Breaking Changes:**
  - Careful testing is required to ensure no breaking changes affect the existing infrastructure. 

### Developer Notes
- **Gotchas:**
  - Verify compatibility of other dependencies with the new `kubernetes` provider version.
- **Edge Cases:**
  - Pay attention to any custom configurations or resource types that might be affected by the upgrade.
- **Future Improvements:**
  - Consider automating the version update process for providers to streamline future upgrades.