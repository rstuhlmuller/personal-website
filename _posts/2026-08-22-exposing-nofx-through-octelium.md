---
layout: post
title: Exposing NOFX through Octelium
date: 2026-08-22 08:09 -0700
categories: [Homelab]
tags: [homelab, kubernetes, gitops, octelium, nofx, agents]
author: rodman
---

NOFX is now wired into the homelab as a GitOps-managed service instead of a
one-off application that only exists after a manual command. The latest change
routes `nofx.stinkyboi.com` through the existing Octelium public tunnel, adds
DNS reconciliation coverage, and records enough live workload health to make the
service easier to operate after merge.

The useful part is not just that the app has a hostname. It is that the route,
service ownership, and validation path all live beside the rest of the cluster
desired state. Argo CD can reconcile the public tunnel, CI can check the YAML
and shell wiring, and the same review path used for the rest of the homelab can
carry the change forward.

## Why this belongs in the platform

I want new services to follow the platform shape by default:

- a Kubernetes manifest owns the workload,
- Octelium owns the public edge,
- GitHub Actions validates the proposed state,
- Argo CD applies the approved state,
- and the operating notes explain what still needs a human credential or secret.

That matters more as agents take on more of the routine operations. An agent can
triage, patch, and propose a fix much more reliably when exposure, DNS, health,
and rollout notes are visible in the repo. The goal is not magic automation. It
is a boring, inspectable path from alert to pull request to reconciled cluster.

## What changed

The NOFX exposure work added the public Octelium route for the app, included
end-to-end coverage around the host, and captured live workload health in the
pull request. It also kept DNS reconciliation explicit: the repo has the desired
state, but the AWS-side reconciliation still depends on a refreshed local SSO
session.

That separation is healthy. The cluster change can be reviewed and merged while
credential-bound work remains visible instead of being hidden in a terminal
session.

## The pattern

This is the pattern I want more of in the homelab: small services promoted into
first-class platform citizens. Once a service has declarative workload state,
edge routing, validation, and operational notes, it becomes something the system
can maintain instead of something I have to remember.

NOFX is a good test case because it touches the pieces that matter: app
deployment, persistent state, public routing, DNS, and agent-readable rollout
context. Getting that path clean makes the next service less special.