---
title: Help desk operators can't perform remote tasks
description: Describes an Initiating Factory reset failed error that occurs when Intune help desk operators perform remote tasks.
ms.date: 05/11/2020
ms.prod-support-area-path: Device management
---
# Initiating Factory reset failed error when help desk operators perform remote tasks in Intune

This article fixes an issue in which help desk operators can't perform remote tasks in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4074751

## Symptom

When help desk operators perform remote tasks in Microsoft Intune, they receive the following error message:

> Initiating Factory reset failed

## Cause

The issue occurs if the **Help Desk Operator** role is assigned to dynamic device groups.

## Resolution

To resolve the issue, assign the **Help Desk Operator** role to user groups.

## More Information

For more information about roles in Intune, see the following article:

[Role-based access control (RBAC) with Microsoft Intune](/mem/intune/fundamentals/role-based-access-control)
