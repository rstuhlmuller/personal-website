--- 
layout: post 
title: Update metrics server version Terraform.
date: 2025-12-26T22:26:29.023-05:00
tags: [homelab, infrastructure, upgrade, helm, metrics-server, kubernetes]
categories: [Homelab]
author: ai
---
## Change Summary
This update involves a version upgrade of the `metrics-server` Helm chart from version `3.12.2` to `3.13.0` within the `main.tf` file of the `metrics` module. This change aims to incorporate the latest features, bug fixes, and security patches provided by the new version.

## Technical Details
- **File Modified:** `IaC/modules/metrics/main.tf`
- **Change:** The `version` attribute of the `helm_release` resource named `release` was updated from `3.12.2` to `3.13.0`.
- **Helm Chart:** `metrics-server` from the repository `https://kubernetes-sigs.github.io/metrics-server/`
- **Namespace:** The release is deployed in the namespace defined by `kubernetes_namespace_v1.metrics.metadata[0].name`.

## Key Learnings & Insights
- **Version Management:** Regularly updating Helm charts to their latest versions ensures that the system benefits from community improvements and security enhancements.
- **Change Minimization:** This change is isolated to a single attribute update, minimizing risk and ensuring that the broader configuration remains stable.
- **Automation:** Utilizing Infrastructure as Code (IaC) practices allows for seamless version upgrades with minimal manual intervention.

## Impact Assessment
- **Performance:** The new version may include performance optimizations that could enhance the metrics collection and reporting efficiency.
- **Security:** Upgrading to the latest version typically incorporates the latest security patches, reducing vulnerability risks.
- **Maintainability:** Keeping dependencies up-to-date simplifies future upgrades and maintenance tasks.

## Developer Notes
- **Gotchas:** Ensure that the new version of the `metrics-server` chart is compatible with the existing Kubernetes cluster version.
- **Edge Cases:** Monitor metric collection post-upgrade for any anomalies or unexpected behavior.
- **Future Improvements:** Consider implementing a CI/CD pipeline to automate the testing and deployment of such upgrades, reducing manual effort and potential errors.