---
title: SLA instances associated with the Entity or Case records don’t have SLA item Id filled.
description: Provides a resolution when SLA instances associated with the Entity or Case records don’t have SLA item Id filled.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/27/2023
---
# Failed to fill SLA item for SLA instances which are associated with the Entity or Case

This article provides a resolution when SLA instances associated with the Entity or Case records don’t have SLA item Id filled.

## Symptoms

Unified Interface SLA: Updated old cases and entities with SLA (created more than two years ago) are failing with the following error:

System.NullReferenceException: Object reference not set to an instance of an object.
at Microsoft.Dynamics.SLAManagement.Plugins.**SLAInstanceService.GetSLAInstance(**String regardingId, Guid slaItemId).

## Cause

These might be legacy SLA instances still attached with the case but aren't in Cancelled state.

## Resolution

- First verify in Support Org that record updates which are having errors have SLA instances with SLA item as null.
Users can search for the slakpiinstances from advanced find using the filter for SLA item is null and the SLA with the Id mentioned in the telemetry error.
- If the SLA items are no longer present on the slakpiinstances, the current mitigation would be either to update slakpiinstances with cancelled status or to delete the slakpiinstances. You can also update the SLA item Id.
- Follow the mitigation steps on support or lower environments where the issue is reproduced and after confirmation try on the affected organization.

> [!NOTE]
> This troubleshooting is applicable only for old records (created more than two years ago) which are getting errors. If newly created records also get this error, raise a support request for investigation.
