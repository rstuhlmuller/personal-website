--- 
layout: post 
title: Update metrics server Helm version.
date: 2025-12-26T22:26:30.482-05:00
tags: [homelab, infrastructure, version-upgrade, metrics-server, helm-chart, kubernetes]
categories: [Homelab]
author: ai
---
### Change Summary
This update involves a version upgrade of the `metrics-server` Helm chart from version `3.12.2` to `3.13.0` in the `main.tf` file located in the `IaC/modules/metrics` directory. This change is aimed at incorporating the latest features, bug fixes, and security patches provided by the new version.

### Technical Details
- **File Modified:** `IaC/modules/metrics/main.tf`
- **Change Made:** Updated the `version` attribute of the `helm_release` resource from `3.12.2` to `3.13.0`.
- **Helm Release Configuration:**
  ```hcl
  resource "helm_release" "release" {
    name       = "metrics-server"
    chart      = "metrics-server"
    repository = "https://kubernetes-sigs.github.io/metrics-server/"
    - version    = "3.12.2"
    + version    = "3.13.0"
    namespace  = kubernetes_namespace_v1.metrics.metadata[0].name
    set = [
      {
  ```

### Key Learnings & Insights
- **Version Management:** Regularly updating dependencies to their latest versions helps in leveraging new features and security improvements.
- **Change Review:** It’s crucial to review release notes for any breaking changes or deprecated features when upgrading versions.
- **Automation:** Using Infrastructure as Code (IaC) allows for seamless and repeatable deployment of updates, reducing manual errors.

### Impact Assessment
- **Performance:** The new version may include performance enhancements that could improve the metrics collection and reporting efficiency.
- **Security:** Upgrading to the latest version typically includes security patches, reducing vulnerability risks.
- **Maintainability:** Staying up-to-date with the latest versions simplifies future upgrades and maintenance.
- **Breaking Changes:** Ensure to check the release notes for any breaking changes that might require additional configuration adjustments.

### Developer Notes
- **Gotchas:** Verify that the new version of the `metrics-server` is compatible with the existing Kubernetes cluster version.
- **Edge Cases:** Monitor the metrics collection post-upgrade for any anomalies or performance issues.
- **Future Improvements:** Consider setting up automated tests to validate the functionality of the `metrics-server` after such upgrades.