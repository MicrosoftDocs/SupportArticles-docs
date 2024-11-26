---
title: Appointment not synchronized to Exchange or Outlook
description: Appointments that are created in Microsoft Dynamics 365 can't synchronize to Microsoft Exchange or Microsoft Outlook. Provides a resolution.
ms.reviewer: 
ms.date: 11/26/2024
ms.custom: sap:Email and Exchange Synchronization
---
# Appointments don't synchronize to Exchange or Outlook after being created in Microsoft Dynamics 365

This article provides resolutions for the issue that appointments created in Microsoft Dynamics 365 don't synchronize to Microsoft Exchange or Microsoft Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4509420

## Symptoms

After you [create an appointment in Microsoft Dynamics 365](/dynamics365/customerengagement/on-premises/basics/create-edit-appointment), the appointment isn't synchronized to Exchange or Outlook.

## Cause 1

Your mailbox record in Dynamics 365 isn't configured to synchronize appointments, contacts, and tasks.

### Resolution

To sovle this issue, verify the mailbox is configured to synchronize appointments, contacts, and tasks:

1. Within the Microsoft Dynamics 365 web application, navigate to **Settings** and then select **Email Configuration**.
2. Select **Mailboxes** and then change the view to **Active Mailboxes**.
3. Open the mailbox record for the user.
4. Verify the **Appointments, Contacts, and Tasks** synchronization method is configured to use **Server-Side Synchronization** and the mailbox has been tested and enabled. The **Appointments, Contacts, and Tasks Status** should be **Success**.

   If the mailbox is configured to use [Dynamics 365 for Outlook](/dynamics365/outlook-addin/admin-guide/install), verify the user has Dynamics 365 for Outlook installed and running on their computer.

## Cause 2

The appointment doesn't meet the conditions used in your synchronization filters for the Appointment entity.

### Resolution

To sovle this issue, verify the properties of the appointment record meet the conditions in your synchronization filters:

1. Select the gear icon in the upper-right corner of the screen and then select **Options**.
2. Select the **Synchronization** tab and then select the option to view or manage filters.
3. Locate the filter(s) for the **Returned Type** set to **Appointment**.

   The default filter is to only synchronize appointments where you're a party on the appointment but aren't just the owner. This means you need to be in the **Required Attendees** field or the **Organizer** field.

## More information

[Synchronization logic for appointments, contacts, and tasks](/power-platform/admin/sync-logic)
