---
layout: post
title: Kubernetes Homelab Setup with Talos Linux
date: 2025-07-19 11:20 -0700
categories: [Homelab]
tags: [homelab, terraform, kubernetes]
author: rodman
---

## Overview

This documentation describes the configuration of a Kubernetes homelab for experimenting with container orchestration, self-hosting applications, and infrastructure as code (IaC). The setup utilizes budget-friendly hardware: two ZimaBoard 832 single-board computers and one repurposed thin client. Talos Linux serves as the operating system, providing a lightweight, secure, and immutable platform optimized for Kubernetes.

The cluster is managed declaratively using Terraform and Terragrunt, with configurations stored in a GitHub repository [homelab repository](https://github.com/rstuhlmuller/homelab). Storage is provisioned via a QNAP TS-451+ network drive as the default storage class, as well as a secondary longhorn deployment for applications that require faster access to the persistent volumes.

## Hardware Configuration

- **Cluster Nodes**:
  - `talos-cp-0` - Repurposed Thin Client (Intel Veriton N4640G): An Intel-based mini-PC with 16GB RAM, serving as the controlplane node with `allowSchedulingOnControlPlanes` enabled.
  - `talos-worker-0` - ZimaBoard 832: Compact x86 board equipped with Intel Celeron N3450 CPUs, 8GB RAM each, and integrated networking.
  - `talos-worker-1` - ZimaBoard 832: Compact x86 board equipped with Intel Celeron N3450 CPUs, 8GB RAM each, and integrated networking.
- **Networking**: Connect all nodes via Ethernet to a home router. Assign static IP addresses for stability. Ensure required ports are accessible, including 6443 (Kubernetes API) and 50000 (Talos configuration).
- **Storage**: QNAP NAS (model: TS-451+) configured with NFS for persistent volumes. This setup enables shared storage but introduces approximately 10–20ms latency relative to local SSDs.

Total cost: ~$300 (primarily for ZimaBoards; thin client sourced at no cost).

## Procedure 1: Installing Talos Linux on Nodes

Talos Linux is a minimal, API-managed OS tailored for Kubernetes, with no default SSH access.

1. **Download Talos ISO**: Obtain the latest AMD64 ISO from the [Talos releases page](https://github.com/siderolabs/talos/releases). Version 1.3.x is recommended.

2. **Create Bootable USB**: Use tools such as Rufus (Windows) or `dd` (Linux/Mac) to prepare a bootable USB drive from the ISO.

3. **Install on Each Node**:
   - Insert the USB drive into the target device (ZimaBoard or thin client).
   - Boot from the USB (access BIOS if necessary; ZimaBoards typically use F7 or Del).
   - In the live environment, apply the configuration to install Talos on the internal drive:
     ```
     talosctl apply-config --insecure --file config.yaml --nodes <node-ip>
     ```
     Configuration file generation is detailed in Procedure 2.
   - Repeat for all three nodes. Target eMMC storage on ZimaBoards and SSD/HDD on the thin client.

4. **Verify Installation**: Reboot each node and confirm accessibility using `talosctl health --nodes <ip>` from the management machine.

Note: Talos nodes are immutable; upgrades involve rebooting into a new image, managed automatically.

## Procedure 2: Configuring the Kubernetes Cluster with Talos

The cluster consists of three nodes: one control plane (on a ZimaBoard) and two workers (second ZimaBoard and thin client). Configurations are defined declaratively in YAML.

1. **Generate Configuration Files**: On the management machine, execute:
   ```
   talosctl gen config my-homelab https://<control-plane-vip>:6443 --output-dir talosconfig
   ```
   This generates `controlplane.yaml`, `worker.yaml`, and `talosconfig` files. Customize as follows:
   - Configure `machine.network.interfaces` for static IPs.
   - Enable optional features, such as kubelet extra arguments.
   - Adjust resource allocations for the thin client if underpowered.

2. **Apply Configurations**:
   - Initialize the control plane:
     ```
     talosctl apply-config --insecure --nodes <control-plane-ip> --file controlplane.yaml
     ```
   - Configure workers:
     ```
     talosctl apply-config --insecure --nodes <worker1-ip> --file worker.yaml
     talosctl apply-config --insecure --nodes <worker2-ip> --file worker.yaml
     ```

3. **Bootstrap the Cluster**:
   ```
   talosctl bootstrap --nodes <control-plane-ip>
   ```
   After a brief wait, retrieve the kubeconfig:
   ```
   talosctl kubeconfig
   ```
   Configure `kubectl` to use this file and validate with `kubectl get nodes`.

The cluster runs Kubernetes (e.g., v1.25+ via Talos). Networking is handled by Flannel or Cilium, specified in the Talos YAML configurations.

## Procedure 3: Configuring Storage with QNAP NAS

Persistent volumes are provisioned from the QNAP NAS due to limited local node storage.

1. **Configure NFS on QNAP**:
   - Via the QNAP web interface, create a shared folder (e.g., `/k8s-storage`).
   - Enable NFSv4 and export to the cluster's subnet (e.g., 10.1.0.0/24).

2. **Define StorageClass**:
   - Create and apply the following YAML for the default StorageClass:
     ```hcl
    resource "helm_release" "nfs_subdir_external_provisioner" {
        name       = "nfs-subdir-external-provisioner"
        repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner"
        chart      = "nfs-subdir-external-provisioner"
        version    = "4.0"

        set {
            name  = "nfs.server"
            value = "10.1.0.2"
        }
        set {
            name  = "nfs.path"
            value = "/k8s-storage"
        }
        set {
            name  = "storageClass.defaultClass"
            value = "true"
        }
        set {
            name  = "storageClass.accessModes"
            value = "ReadWriteMany"
        }
    }
     ```
     Command: `terragrunt apply`.

Latency Considerations: NAS-based storage introduces 10–50ms delays for I/O operations, which may affect applications requiring low latency (e.g., SQLite or etcd). Use PostgreSQL databases for applications, as they tolerate NFS performance effectively. For instance, deploy external PostgreSQL pods with persistent volumes for apps.

## Procedure 4: Managing Resources with Infrastructure as Code (Terraform + Terragrunt)

Cluster resources (e.g., namespaces, deployments, ingresses) are defined in the [homelab repository](https://github.com/rstuhlmuller/homelab). Terraform handles Kubernetes resources, while Terragrunt orchestrates multi-environment configurations.

1. **Repository Structure**:
```
homelab/
├── IaC
│   ├── _envcommon
│   │   ├── argocd.hcl
│   │   ├── longhorn.hcl
│   │   ├── metallb.hcl
│   │   ├── storage.hcl
│   │   └── traefik.hcl
│   ├── common.yml
│   ├── modules
│   ├── production
│   │   ├── account.hcl
│   │   └── homelab
│   └── root.hcl
```

2. **Initialization**:
   - Install Terraform and Terragrunt.
   - Execute `terragrunt run-all init` in the repository root.
   - Define resources, such as a ArgoCD deployment, in files like `modules/argocd/main.tf`.

3. **Deployment**:
   ```
   terragrunt run-all apply --working-dir IaC/production/homelab
   ```
   This applies changes idempotently. Integrate GitHub Actions for CI/CD to automate deployments on repository updates.

This IaC methodology ensures reproducibility, allowing the cluster to be rebuilt efficiently.

## Additional Considerations

- **Resource Management**: The thin client has limited capacity; apply taints for lightweight workloads (e.g., `kubectl taint node thin-client-node node-role=light:NoSchedule`).
- **Upgrades**: Perform Kubernetes upgrades via `talosctl upgrade`.
- **Monitoring**: Deploy Prometheus and Grafana using Terraform for observability.
- **Security**: Expose services through an Ingress controller (e.g., NGINX) and manage certificates with cert-manager.
- **Backups**: Regularly snapshot etcd and back up NAS volumes.

This configuration has demonstrated stability over extended periods, supporting applications such as Open-WebUI, Home Assistant, and monitoring servers. For further details or modifications, refer to the repository.
