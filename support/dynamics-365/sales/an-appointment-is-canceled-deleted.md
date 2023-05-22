---
title: An appointment is canceled or deleted
description: Provides a solution to an issue where an appointment is canceled or deleted unexpectedly when using server-side synchronization.
ms.author: dmartens
author: DanaMartens
ms.date: 05/22/2023
---
# An appointment is canceled or deleted unexpectedly during server-side synchronization

This article provides a solution to an issue where an appointment is canceled or deleted unexpectedly when you use server-side synchronization.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345686

## Symptoms

When you use server-side synchronization to synchronize appointments between Microsoft Dynamics 365 and Exchange, an appointment is canceled or deleted unexpectedly.

## Cause

This issue can occur if the appointment no longer meets the conditions of the user's [sync filters](/power-platform/admin/choose-records-synchronize-dynamics-365-outlook-exchange). As mentioned in [Ignore logically deleted items during synchronization](/power-platform/admin/sync-logic#ignore-logically-deleted-items-during-sync), there are multiple reasons an appointment may no longer match your sync filters, such as the organizer of the appointment being changed, the sync filters being modified, or the user no longer having access to the record due to changes in security roles or sharing. By default, server-side synchronization sends a delete operation to Exchange in this scenario, which results in an appointment cancellation.

## Resolution

A configurable setting was introduced to allow you to change this behavior. You can use one of the following tools to change the `DistinctPhysicalAndLogicalDeletesForExchangeSync` setting to **True**:

1. [Organization Settings Editor](https://github.com/seanmcne/OrgDbOrgSettings/releases)
2. [OrgDBOrgSettings tool for Microsoft Dynamics CRM](https://support.microsoft.com/help/2691237)