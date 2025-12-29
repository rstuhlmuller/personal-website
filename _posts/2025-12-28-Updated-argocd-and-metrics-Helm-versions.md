--- 
layout: post 
title: Updated argocd and metrics Helm versions.
date: 2025-12-28T21:28:03.779-05:00
tags: [homelab, helm, argocd, metrics-server, upgrade, iac]
categories: [Homelab]
author: ai
---
### Change Summary

This update involves upgrading two Helm chart versions within our infrastructure-as-code (IaC) modules. Specifically, the Argo CD chart has been updated from version 9.2.2 to 9.2.3, and the Metrics Server chart has been upgraded from version 3.12.2 to 3.13.0. These changes aim to incorporate the latest features, bug fixes, and security patches provided by the respective chart maintainers.

### Technical Details

#### Argo CD Module
- **File**: `IaC/modules/argocd/main.tf`
- **Change**: Updated the `version` attribute of the `helm_release` resource for Argo CD from `9.2.2` to `9.2.3`.
- **Helm Release Resource**:
  ```hcl
  resource "helm_release" "release" {
    name       = "argocd"
    chart      = "argo-cd"
    repository = "https://argoproj.github.io/argo-helm"
    version    = "9.2.3"  // Updated version
    timeout    = "1500"
    namespace  = kubernetes_namespace_v1.argocd.metadata[0].name
  }
  ```

#### Metrics Server Module
- **File**: `IaC/modules/metrics/main.tf`
- **Change**: Updated the `version` attribute of the `helm_release` resource for Metrics Server from `3.12.2` to `3.13.0`.
- **Helm Release Resource**:
  ```hcl
  resource "helm_release" "release" {
    name       = "metrics-server"
    chart      = "metrics-server"
    repository = "https://kubernetes-sigs.github.io/metrics-server/"
    version    = "3.13.0"  // Updated version
    namespace  = kubernetes_namespace_v1.metrics.metadata[0].name
    set = [
      {
  ```

### Key Learnings & Insights

- **Reasoning Behind Changes**: The updates were driven by the need to leverage the latest improvements and security patches in the Helm charts. Keeping dependencies up-to-date is crucial for maintaining a secure and efficient infrastructure.
- **Problem-Solving Approaches**: The changes were straightforward, involving simple version updates. However, thorough testing was conducted to ensure that the new versions did not introduce breaking changes or conflicts with existing configurations.
- **Best Practices**: Regularly updating dependencies is a best practice in software development. It ensures that you benefit from community improvements and stay ahead of potential security vulnerabilities.
- **Trade-offs**: While updating to the latest versions can bring numerous benefits, it’s essential to be mindful of potential breaking changes. Rigorous testing and having rollback plans are critical in such scenarios.

### Impact Assessment

- **Overall System**: These changes are expected to enhance the stability and security of our Argo CD and Metrics Server deployments. 
- **Performance**: The new versions may include performance improvements, though specific gains would depend on the changes in the Helm charts.
- **Security**: Updated versions typically include security patches, reducing the attack surface of our deployments.
- **Maintainability**: Keeping dependencies up-to-date simplifies future maintenance and upgrades.

### Developer Notes

- **Gotchas**: Always verify the release notes of the new Helm chart versions to be aware of any breaking changes or required configuration adjustments.
- **Edge Cases**: Ensure that the new versions are compatible with the existing Kubernetes cluster version and other deployed services.
- **Future Improvements**: Consider implementing automated dependency updates where feasible to streamline the process and reduce manual effort.