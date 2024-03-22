---
title: Applications aren't deployed to users who are logged on to domain controllers
description: Describes an issue in which applications aren't deployed to users who are logged on to domain controllers because user policies aren't retrieved.
ms.date: 12/05/2023
ms.custom: sap:Application Management\Application Deployment (Users)
ms.reviewer: kaushika
---
# Applications aren't deployed to users who are logged on to domain controllers

This article provides a solution for an issue that applications aren't deployed to users who are logged on to domain controllers in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4508855

## Symptoms

When you deploy applications to a user collection in Configuration Manager, the applications aren't deployed to users who are logged on to domain controllers. When this issue occurs, the following entry is logged in the PolicyAgent.log file:

> Skipping request for user policy assignments for local user \<User SID>.

Additionally, you may not see any applications that are deployed to user collections in **Software Center** on the domain controller.

## Cause

This issue occurs because the user policies aren't retrieved on domain controllers.

## Resolution

To fix this issue, update to [Configuration Manager current branch version 1906](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1906).

## Workaround

To work around this issue without updating, deploy applications to a device collection that contains the domain controllers.
