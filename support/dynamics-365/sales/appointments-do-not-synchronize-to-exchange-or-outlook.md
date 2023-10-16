---
title: Appointment not synchronized to Exchange or Outlook
description: Appointments that are created in Microsoft Dynamics 365 can't synchronize to Microsoft Exchange or Microsoft Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Appointments do not synchronize to Exchange or Outlook after being created in Microsoft Dynamics 365

This article provides resolutions for the issue that appointments created in Microsoft Dynamics 365 don't synchronize to Microsoft Exchange or Microsoft Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4509420

## Symptoms

After creating an appointment in Microsoft Dynamics 365, the appointment is not synchronized to Exchange or Outlook.

## Cause

Cause 1

Your mailbox record in Microsoft Dynamics 365 is not configured to synchronize Appointments, Contacts, and Tasks.

Cause 2

The appointment does not meet the conditions used in your synchronization filters for the Appointment entity.

## Resolution 1 - Verify the mailbox is configured to synchronize appointments, contacts, and tasks

1. Within the Microsoft Dynamics 365 web application, navigate to **Settings** and then select **Email Configuration**.
2. Select **Mailboxes** and then change the view to **Active Mailboxes**.
3. Open the mailbox record for the user.
4. Verify the **Appointments, Contacts, and Tasks** synchronization method is configured to use **Server-Side Synchronization** and the mailbox has been tested and enabled. The Appointments, Contacts, and Tasks Status should be Success.

   If the mailbox is configured to use Microsoft Dynamics 365 for Outlook, verify the user has Microsoft Dynamics 365 for Outlook installed and running on their computer.

## Resolution 2 - Verify the properties of the appointment record meet the conditions in your synchronization filters

You can view your synchronization filters in the Microsoft Dynamics 365 web application by following these steps:

1. Select gear icon and then select **Options**.
2. Select the **Synchronization** tab and then select the option to view or manage filters.
3. Locate the filter(s) for the **Returned Type** set to **Appointment**.

   The default filter is to only sync appointments where you are a party on the appointment but are not just the owner. This means you need to be on the **Required Attendees** field or the **Organizer** field.
