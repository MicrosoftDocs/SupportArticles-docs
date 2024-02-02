---
title: SLA instances associated with a case don't have mapped SLA item in Dynamics 365 Customer Service
description: Provides a resolution for the Object reference not set to an instance of an object error that occurs when updating old cases and entities in Microsoft Dynamics 365 Customer Service.
ms.date: 08/18/2023
ms.reviewer: sdas, ankugupta
ms.author: sdas
---
# Can't fill an SLA item for the SLA instances associated with the entity or case

This article provides a resolution for an issue where the service-level agreement (SLA) instances associated with the entity or case records don't have an SLA item ID filled.

## Symptoms

You can't update cases and entities associated with an old SLA in a Unified Interface SLA, and you receive the following error message:

> System.NullReferenceException: Object reference not set to an instance of an object.  
> at Microsoft.Dynamics.SLAManagement.Plugins.SLAInstanceService.GetSLAInstance(String regardingId, Guid slaItemId).

## Cause

This issue occurs because the legacy SLA instances are still attached to the case but not in the **Cancelled** status.

## Resolution

To solve this issue, take the following steps:

1. Check in test CRM instance whether the record updates that get the error have SLA instances with no SLA item filled.

    You can search for `slakpiinstances` records in **Advanced Find** by applying the filter for *SLA item is null*.

2. If the SLA items are no longer present on `slakpiinstances`, the current mitigation would be either to update the status of `slakpiinstances` to **Cancelled** or to delete `slakpiinstances`. You can also update the SLA item ID.

3. Follow the mitigation steps on test or lower environments where the issue is reproduced, and after confirmation, try them on the affected environment.

> [!NOTE]
> This resolution applies only to old records that are getting errors. If newly created records also get this error, contact [Microsoft support](https://dynamics.microsoft.com/support/) for further assistance.
