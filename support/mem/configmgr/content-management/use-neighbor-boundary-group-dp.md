---
title: Configuration Manager client uses a neighbor boundary group DP first
description: Learn why a Configuration Manager client might use a distribution point in a neighbor boundary group first, and how to resolve this issue.
ms.date: 08/21/2026
ai-usage: ai-assisted
ms.topic: troubleshooting-problem-resolution
ms.reviewer: kaushika, weiwan, junhe, cmkbreview
ms.custom: sap:Content Management\Distribution Point Installation, Upgrade or Configuration

#customer intent: As a Configuration Manager administrator, I want clients to prioritize distribution points in their current boundary group so that content uses the intended locations.
---
# Configuration Manager client uses a distribution point in a neighbor boundary group before those in the current boundary group

## Summary

This article helps you resolve an issue where a Configuration Manager client selects a distribution point (DP) from a neighbor boundary group instead of a DP in its current boundary group, even when the current boundary group's DP is preferred.

## Symptoms

If a Configuration Manager DP from a neighbor boundary group is in the same IP subnet as the client, the client might use that DP before DPs in its current boundary group that are in a different subnet. This behavior occurs after the neighbor DP becomes eligible based on the configured fallback time.

## Cause

Boundary group relationships define fallback behavior that lets a Configuration Manager client expand its search from its current boundary group to additional boundary groups when it searches for an available site system.

For a content location request, the management point returns candidate DPs together with their boundary group locality, fallback time, and IP subnet information. Location Services on the client compares each DP's subnets with the client's subnets before it sorts the results.

If a DP is in the same IP subnet as the client, Location Services classifies it as a subnet DP regardless of whether it was returned as a current or neighbor boundary group DP. Subnet DPs are sorted before current boundary group DPs, which are sorted before neighbor boundary group DPs. The classification doesn't change the configured fallback time. Therefore, after a neighbor DP becomes eligible, a neighbor DP in the client's subnet can be selected before an off-subnet DP in the current boundary group.

## Resolution

To maintain boundary group locality as the selection priority, make sure that DPs associated with neighbor boundary groups aren't in the same IP subnets as clients in the current boundary group.

## References

For more information, see these articles:

- [Define network locations as boundaries for Configuration Manager](/intune/configmgr/core/servers/deploy/configure/boundaries)
- [Overview of boundaries and boundary groups](/intune/configmgr/core/servers/deploy/configure/define-site-boundaries-and-boundary-groups)
- [How to configure boundary groups for Configuration Manager](/intune/configmgr/core/servers/deploy/configure/boundary-group-procedures)
