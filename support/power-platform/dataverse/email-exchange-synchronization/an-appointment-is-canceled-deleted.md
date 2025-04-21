---
title: Appointment cancellation issue with server-side synchronization in Dynamics 365
description: Provides a solution to an issue where an appointment is canceled or deleted unexpectedly when using server-side synchronization.
ms.author: dmartens
author: DanaMartens
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# An appointment is canceled or deleted unexpectedly during server-side synchronization

This article provides a solution to an issue where an appointment is canceled or deleted unexpectedly when you use server-side synchronization in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345686

## Symptoms

When you use [server-side synchronization](/power-platform/admin/server-side-synchronization) to synchronize appointments between Microsoft Dynamics 365 and Exchange, an appointment is canceled or deleted unexpectedly.

## Cause

This issue can occur if the appointment no longer meets the conditions of the user's [sync filters](/power-platform/admin/choose-records-synchronize-dynamics-365-outlook-exchange). As explained in [Ignore logically deleted items during synchronization](/power-platform/admin/sync-logic#ignore-logically-deleted-items-during-sync), there are multiple reasons why an appointment no longer matches your sync filters. These reasons include changes to the appointment organizer, the sync filters, and security roles or sharing settings, which cause the user to lose access to the record. By default, server-side synchronization sends a delete operation to Exchange in such scenario, leading to the cancellation of the appointment.

## Resolution

As an administrator, you can modify this behavior by changing the `DistinctPhysicalAndLogicalDeletesForExchangeSync` setting to **True** using one of the following tools:

1. [Organization Settings Editor](https://github.com/seanmcne/OrgDbOrgSettings/releases). For more information about how to use the tool to edit the setting, see [Environment database settings](/power-platform/admin/environment-database-settings).
2. [OrgDBOrgSettings tool for Microsoft Dynamics 365](https://support.microsoft.com/topic/orgdborgsettings-tool-for-microsoft-dynamics-crm-20a10f46-2a24-a156-7144-365d49b842ba)

By updating this setting, you can manage how deletions are handled during synchronization and prevent unexpected cancellations of appointments.
