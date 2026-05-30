---
layout: post
title: Running my homelab with agents and harnesses
date: 2026-05-30 09:50 -0700
categories: [Homelab]
tags: [homelab, agents, openclaw, automation, observability, gitops]
author: rodman
---

My homelab has been slowly turning into a small operations environment instead
of just a pile of self-hosted apps. The newest shift is that I am treating the
agent layer as part of the platform: it monitors the cluster, reacts to alerts,
opens fixes through GitOps, watches CI, and keeps notes about what changed.

The goal is not to make the cluster "hands off." The goal is to make the boring
and repetitive parts legible enough that an agent can help without hiding the
system from me.

## The operating loop

The loop I want is simple:

1. Detect a problem or maintenance opportunity.
2. Gather live state and repository context.
3. Make a small desired-state change in git.
4. Open a pull request, watch CI, and merge only when the checks pass.
5. Let the post-merge apply path reconcile the cluster.
6. Capture the decision so the next round starts with better context.

That loop is why the homelab repo has become the center of gravity. Most of the
interesting work now lands as a branch, a PR, and a post-merge Terragrunt or
Argo CD reconciliation instead of a one-off shell command against the cluster.

## OpenClaw as the resident operator

OpenClaw is the agent runtime I am using inside the cluster. It runs as a
tailnet-only workload and persists its runtime state on the homelab storage
layer. It has Discord wired in for direct conversation, Codex-backed agents for
repository work, and a GitHub App identity for pushing branches and opening pull
requests.

The important design choice is that OpenClaw is not just a chat endpoint. It is
an operator workspace:

- It has durable memory and repo checkouts.
- It can read the homelab documentation and knowledge base before making
  changes.
- It uses a GitHub App instead of a long-lived personal access token.
- It keeps code changes reviewable through normal GitHub pull requests.
- It has enough CPU and memory headroom to run heavier agent tasks without
  squeezing the rest of the cluster.

Some of the practical work has been less glamorous but very necessary. The
OpenClaw pod runs on an NFS-backed persistent volume, so plugin caches and
scratch directories need to avoid ownership issues. Git also needs safe
directory and signing configuration that survives restarts. Those details are
not exciting, but they are what make the agent reliable enough to treat as part
of the homelab rather than a toy process.

## Alerts that can page an agent

Grafana is now more than a dashboard. Alerting is declared in the repo, and the
notification fan-out includes Discord and an authenticated OpenClaw hook. That
means a cluster alert can create a direct agent run with enough context to start
triage.

I added this because passive alerts are easy to miss. If a workload gets stuck
in `CrashLoopBackOff`, the alert should not just sit in a UI. It should reach
the same operator loop that can inspect the pod, check recent PRs, compare the
desired state, and propose a fix.

The pattern I like here is that the alert is still boring infrastructure:
Grafana rule, contact point, secret-backed token, network policy, and normal
GitOps delivery. The agent is downstream of that. I do not want magic; I want a
clear handoff from monitoring to a constrained repair workflow.

## CI as the safety harness

The agent can move quickly, so the harnesses around it matter. The homelab repo
has been growing a set of gates that make agent-authored changes safer:

- Terragrunt plan and apply workflows run through GitHub Actions.
- Same-repository PRs can run trusted live plans; forked PRs stay away from
  secrets.
- Conftest policy checks catch unsafe workflow and Kubernetes patterns.
- Terraform plan JSON is now rendered from saved plans and checked with
  Conftest before a PR plan is considered good.
- Post-merge apply is still the path that changes live infrastructure.

That last point is the important one. Agents should be good at doing the work,
but the work should still pass through the same rails a human would use. A PR
that fails static policy, plan policy, formatting, or release checks is not
finished just because an agent opened it.

## Heartbeats and stewardship

I also use heartbeat prompts as a lightweight stewardship loop. During a
heartbeat, the agent can check the homelab PR queue, look for failed checks,
notice stale work, and decide whether something needs a fix, a merge, or no
message at all.

The standing priority is the homelab repository. Softer checks like email,
weather, or memory maintenance are useful, but the cluster repo comes first
when time is limited. That keeps the agent pointed at the thing that actually
owns the desired state.

## The part I am trying to preserve

The most useful thing about this setup is not "AI fixes my cluster." It is that
the agent has to operate inside a system I can understand:

- alerts are declared,
- changes are reviewed,
- CI is visible,
- rollouts are GitOps-driven,
- and the notes are kept close to the source code.

That is the shape I want to keep improving. As the homelab gets more capable,
the agent layer should stay boring in the right places: authenticated, logged,
reviewable, and bounded by policy.

