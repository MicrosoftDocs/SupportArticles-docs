---
title: DP in a neighbor boundary group is used
description: Describes an issue in which a distribution point (DP) in a neighbor boundary group is used before the DPs in the current boundary group. Provides a resolution.
ms.date: 12/05/2023
ms.reviewer: kaushika, weiwan, junhe, cmkbreview, delhan
---
# A distribution point in a neighbor boundary group is used before those in the current boundary group

This article provides a solution for the issue that a distribution point (DP) in a neighbor boundary group may be used before the DPs in the current boundary group.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4020762

## Symptoms

If a Configuration Manager DP from a different boundary group is in the same IP subnet as the client, that DP is used before the DPs in the client's current boundary group that is in a different subnet are used.

## Cause

Boundary group relationships define fallback behavior that lets a Configuration Manager client expand its search from its current boundary group to additional boundary groups when it searches for an available site system.

The usual fallback behavior is to use DPs in the current boundary group instead of those DPs from the neighboring and site default boundary groups.

The current boundary group is always intended to be searched first. However, if a DP from a neighboring boundary group is in the same IP subnet that a client is in, that DP is used before the DPs that are in the client's current boundary groups that are not in the same subnet.

## Resolution

To avoid this issue and make sure that the usual fallback behavior occurs, do not define neighboring boundary groups to be in the same subnets as the clients in the current boundary group.

## References

For more information, see these articles:

- [Define network locations as boundaries for Configuration Manager](/mem/configmgr/core/servers/deploy/configure/boundaries)
- [Define site boundaries and boundary groups for Configuration Manager](/mem/configmgr/core/servers/deploy/configure/define-site-boundaries-and-boundary-groups)
- [Configure boundary groups for Configuration Manager](/mem/configmgr/core/servers/deploy/configure/boundary-groups)
