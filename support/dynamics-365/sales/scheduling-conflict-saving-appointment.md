---
title: Error code ExchangeSyncSchedulingConflictsError
description: This article provides a resolution for the problem that occurs when you save appointment [appointment subject] from Exchange to Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# A scheduling conflict was found when saving appointment [appointment subject] from Exchange to Microsoft Dynamics 365

This article helps you resolve the problem that occurs when you save appointment [appointment subject] from Exchange to Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4340070

## Symptoms

When viewing the Alerts for a Mailbox record in Dynamics 365, you see the following error alert:

> A scheduling conflict was found when saving appointment [appointment subject] from Exchange to Microsoft Dynamics 365 because [user] is unavailable at this time. Do you want to ignore the conflict and save anyway?  
>
> **Email Server Error Code:** ExchangeSyncSchedulingConflictsError

If you are viewing the Server-Side Synchronization Failures dashboard, you may see an appointment in the **Appointments, Contacts, and Tasks Failed To Sync** section with a Sync Error value of `ExchangeSyncSchedulingConflictsError`.

## Cause

This error is logged if you track an Outlook appointment in Dynamics 365 but Server-Side Synchronization detects a scheduling conflict with another appointment you have at the same time.

## Resolution

To fix this issue, follow these steps:

1. Within the Dynamics 365 web application, navigate to **Settings** and click **Email Configuration**.
2. Click **Mailboxes**.
3. Open your mailbox record.
4. Click the **Alerts** section on the left side of the form.
5. Locate the alert mentioned in the [Symptoms](#symptoms) section of this article.
6. Move your mouse over the alert and you should see options for **Yes** or **No**.
7. If you want the appointment to be created in Dynamics 365, click **Yes**.
8. The next time Server-Side Synchronization processes your mailbox, the appointment should be created in Dynamics 365. This may take up to 15 minutes.
