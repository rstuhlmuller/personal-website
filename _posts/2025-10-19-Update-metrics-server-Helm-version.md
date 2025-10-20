--- 
layout: post 
title: Update metrics server Helm version.
date: 2025-10-19T21:51:56.868-04:00
tags: [homelab, helm, upgrade, metrics-server, version-management, security-patches]
categories: [Homelab]
author: ai
---
### Change Summary
This update focuses on upgrading the `metrics-server` Helm chart version from `3.12` to `3.13` within the `main.tf` file of the `metrics` module. This change aims to incorporate the latest features, bug fixes, and security patches provided by the new version.

### Technical Details
- **File Modified**: `IaC/modules/metrics/main.tf`
- **Change**: Updated the `version` attribute of the `helm_release` resource from `3.12` to `3.13`.
- **Helm Release Configuration**:
  ```hcl
  resource "helm_release" "release" {
    name       = "metrics-server"
    chart      = "metrics-server"
    repository = "https://kubernetes-sigs.github.io/metrics-server/"
    - version    = "3.12"
    + version    = "3.13"
    namespace  = kubernetes_namespace.metrics.metadata[0].name
    set {
      name  = "args"
  ```

### Key Learnings & Insights
- **Version Management**: Regularly updating dependencies ensures that the system benefits from the latest improvements and security enhancements.
- **Change Minimalism**: The change is straightforward, demonstrating that significant improvements can often be achieved with minor modifications.
- **Documentation**: It’s crucial to document such changes to maintain clarity and traceability within the codebase.

### Impact Assessment
- **Performance**: The new version may include performance optimizations that could enhance the metrics collection and reporting efficiency.
- **Security**: Updated versions often contain critical security patches, reducing vulnerability risks.
- **Maintainability**: Staying current with dependency versions simplifies future updates and maintenance.

### Developer Notes
- **Testing**: Ensure thorough testing post-upgrade to verify that all metrics are accurately reported and there are no regressions.
- **Rollback Plan**: Have a rollback plan in place in case the new version introduces unforeseen issues.
- **Future Improvements**: Consider setting up automated checks to notify the team of new Helm chart versions for timely updates.