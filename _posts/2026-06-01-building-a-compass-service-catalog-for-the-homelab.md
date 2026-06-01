---
layout: post
title: Building a Compass service catalog for the homelab
date: 2026-06-01 03:20 -0700
categories: [Homelab]
tags: [homelab, compass, kubernetes, gitops, observability, service-catalog]
author: rodman
---

The homelab has enough moving parts now that a dashboard is not just a nice
extra. I need a quick way to answer simple operational questions: what is
running, where does it live, how is it exposed, and which repository owns the
desired state?

That is the reason I added Compass to the cluster. It gives the homelab a
service catalog that sits next to Grafana, Argo CD, and OpenClaw instead of
trying to replace them. Grafana tells me what is happening, Argo CD tells me
what is reconciling, and Compass gives the workloads a more human index.

## Why a catalog belongs in the loop

The agent operating loop works best when the cluster is legible. Alerts can
start triage, CI can gate the fix, and Argo CD can apply the desired state, but
the agent still needs context about the applications it is touching.

Compass is a good fit for that because the catalog can be built from the same
Kubernetes resources that already describe the platform. Instead of maintaining
a separate hand-written inventory, the service catalog can discover workloads
from the cluster and point back to the GitOps source of truth.

That makes the catalog useful for humans and agents:

- humans get a compact map of the homelab services,
- agents get a cleaner way to reason about ownership and exposure,
- and the cluster keeps the inventory close to the resources that matter.

## Making discovery boring

The first pass was not just installing a chart. I had to make Compass discover
the right things from Kubernetes and line that up with how the homelab is
actually exposed.

The useful shape ended up being ingress-driven discovery. Services are
interesting, but ingress resources say more about what is meant to be reachable
and how a person would find it. That maps better to the questions I ask during
operations: what is public or tailnet-visible, what hostname should I open, and
what workload owns it?

I also had to tighten the chart source configuration and repository allow-list
so Argo CD would reconcile Compass cleanly. That work is the unglamorous part
of running a GitOps homelab, but it matters. A catalog that only works after a
manual kubectl command is not part of the platform yet.

## Where it fits

Compass is now another piece of the same reliability story:

- Grafana watches symptoms and sends alerts.
- OpenClaw can respond to selected alerts and maintenance windows.
- GitHub Actions checks the proposed change.
- Argo CD reconciles the approved state.
- Compass makes the service map easier to browse and reason about.

The thing I like about this setup is that the catalog does not create a second
source of truth. It reflects the cluster, and the cluster reflects the repo.
That keeps the operational path simple enough that automation can help without
turning the homelab into a black box.

## The next layer

The obvious next step is richer metadata. Owners, runbooks, dashboards, and
repository links should become first-class catalog fields instead of trivia
stored in my head. Once those links are dependable, an alert can move from
"something is broken" to "this specific service is unhealthy, here is its
dashboard, here is its runbook, and here is the GitOps path that owns it."

That is the kind of boring context that makes agents more useful. Not smarter
in the abstract, just better grounded in the system they are helping operate.
