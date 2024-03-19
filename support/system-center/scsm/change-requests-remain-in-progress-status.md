---
title: A change request remains in the In Progress status
description: Fixes an issue where a change request in Service Manager remains with a status of In Progress and can't be closed.
ms.date: 03/14/2024
ms.reviewer: RPesenko, khusmeno
---
# Service requests with circular relationships cannot be closed in System Center Service Manager

This article helps you fix an issue where a change request in Service Manager remains with a status of **In Progress** and can't be closed if it has a circular relationship with another open change request in the **Relationships** tab.

_Original product version:_ &nbsp; System Center Service Manager  
_Original KB number:_ &nbsp; 2466715

## Symptoms

A change request in System Center Service Manager will remain with a status of **In Progress** and cannot be closed even if all activities have been completed.

## Cause

The change request cannot be closed if there is an open change request in the **Relationships** tab. The open change request in the **Relationships** tab is a dependency of the change request trying to be closed. If this second change request shows the first change request in its own **Relationships** tab, the two change requests will have a circular relationship and neither can be closed.

## Resolution

The second change request should be removed from the **Relationships** tab of the change request to be closed. If it doesn't change from **In Progress** to **Completed** after a few minutes, create a new manual activity and complete it. The change request should then change the status and can be closed.
