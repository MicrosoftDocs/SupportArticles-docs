---
title: A scheduling conflict was found when saving appointment error 
description: Solves the ExchangeSyncSchedulingConflictsError error code that occurs when saving an appointment from Exchange to Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/16/2024
ms.custom: sap:Email and Exchange Synchronization
---
# A scheduling conflict was found when saving appointment from Exchange to Microsoft Dynamics 365

This article provides a resolution for an email server error code "ExchangeSyncSchedulingConflictsError" that occurs when saving an appointment from Exchange to Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4340070

## Symptoms

The following error message is logged in the [Alerts]((/power-platform/admin/monitor-email-processing-errors#view-alerts)) section of a Dynamics 365 mailbox record:

> A scheduling conflict was found when saving appointment [appointment subject] from Exchange to Microsoft Dynamics 365 because [user] is unavailable at this time. Do you want to ignore the conflict and save anyway?
>
> **Email Server Error Code:** ExchangeSyncSchedulingConflictsError

If you view the [Server-Side Synchronization Failures dashboard](troubleshoot-item-level-server-side-synchronization-issues.md#usage), you might see an appointment in the **Appointments, Contacts, and Tasks Failed To Sync** section with a **Sync Error** value of `ExchangeSyncSchedulingConflictsError`.

## Cause

This error is logged if you track an Outlook appointment in Dynamics 365 but server-side synchronization detects a scheduling conflict with another appointment you have at the same time.

## Resolution

To fix this issue, follow these steps:

1. Sign in to the Dynamics 365 web application as a user with the "System Administrator" role.
1. Navigate to **Settings** > **Email Configuration**, and then select **Mailboxes**.
1. Open your mailbox record.
1. Select the **Alerts** section on the left side of the form.
1. Locate the alert mentioned in the [Symptoms](#symptoms) section of this article.
1. Move your mouse over the alert and you should see options for **Yes** or **No**.
1. If you want the appointment to be created in Dynamics 365, select **Yes**.
1. The next time server-side synchronization processes your mailbox, the appointment should be created in Dynamics 365. This might take up to 15 minutes.
