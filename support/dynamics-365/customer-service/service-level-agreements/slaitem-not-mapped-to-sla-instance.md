---
title: SLA instances associated with the Entity/Case records doesn’t have SLA item Id filled.
description: Provides a resolution when SLA instances associated with the Entity/Case records doesn’t have SLA item Id filled.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/23/2023
---
# Failed to fill SLA item for SLA instances which are associated with the Entity/Case

This article provides a resolution when SLA instances associated with the Entity/Case records doesn’t have SLA item Id filled. These might be legacy SLA instances still attached with case but not in cancelled state.

## Symptoms

UCI-SLA: Updated Old cases and entities with SLA (created more than 2+ years ago) are failing with below error:

System.NullReferenceException: Object reference not set to an instance of an object.
at Microsoft.Dynamics.SLAManagement.Plugins.**SLAInstanceService.GetSLAInstance(**String regardingId, Guid slaItemId).

## Cause

This will happen when SLA instances associated with Entity/Case records doesn’t have SLA item Id filled. These might be legacy SLA instances still attached with case but not in cancelled state.

## Resolution

To solve this issue, 
First verify in Support Org that record updates which are having errors, does have SLA instances with SLA item null.
Users can search for the slakpiinstances from advanced find using the filter for SLA item is null and the SLA with the Id mentioned in the telemetry error.
1.	If the SLA items are no longer present on the slakpiinstances, the current mitigation would be either to update slakpiinstances with cancelled status or to delete the slakpiinstances. (If you aware then can update SLA item id as well)
2.	Please follow the mitigation steps on support/lower env where the issue is repro and after confirmation try on the affected org.

> [!NOTE]
> This TSG is applicable only for old records (created more than 2+ years ago) which are getting errors. If newly created records also get this error then please raise a support request for investigation.