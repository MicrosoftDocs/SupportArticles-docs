---
title: Appointment not synchronized to Exchange or Outlook
description: Works around an issue that appointments created in Microsoft Dynamics 365 aren't synchronized to Microsoft Exchange or Microsoft Outlook.
ms.reviewer: 
ms.date: 12/09/2024
ms.custom: sap:Email and Exchange Synchronization
---
# Appointments aren't synchronized to Exchange or Outlook in Microsoft Dynamics 365

If appointments aren't synchronized to Microsoft Exchange or Outlook after being created in Microsoft Dynamics 365, check the steps in this article to ensure your mailbox is configured correctly.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4509420

## Symptoms

After you [create an appointment in Microsoft Dynamics 365](/dynamics365/customerengagement/on-premises/basics/create-edit-appointment), the appointment isn't synchronized to Exchange or Outlook.

## Cause 1: The mailbox record isn't configured to synchronize appointments, contacts, and tasks

An administrator should verify the mailbox is configured to synchronize appointments, contacts, and tasks:

1. Within the Microsoft Dynamics 365 web application, navigate to **Settings** and then select **Email Configuration**.
2. Select **Mailboxes** and then change the view to **Active Mailboxes**.
3. Open the mailbox record for the user.
4. Verify the **Appointments, Contacts, and Tasks** synchronization method is configured to use **Server-Side Synchronization**, and the mailbox is tested and enabled. The **Appointments, Contacts, and Tasks Status** should be **Success**.

   If the mailbox is configured to use [Dynamics 365 for Outlook](/dynamics365/outlook-addin/admin-guide/install), verify the user has Dynamics 365 for Outlook installed and running on their computer.

## Cause 2: The appointment doesn't meet the conditions used in synchronization filters for the Appointment entity

To solve this issue, you should verify the properties of the appointment record meet the conditions in your synchronization filters:

1. Select the gear icon in the upper-right corner of the screen and then select **Options**.
2. Select the **Synchronization** tab and then select the option to view or manage filters.
3. Locate the filter(s) for the **Returned Type** set to **Appointment**.

   The default filter only synchronizes appointments where you're a party on the appointment but aren't just the owner. This means you need to be in the **Required Attendees** field or the **Organizer** field.

## More information

- [Configure synchronization for appointments, contacts, and tasks](/dynamics365/outlook-addin/admin-guide/configure-synchronization-appointments-contacts-tasks)
- [Synchronization logic for appointments, contacts, and tasks](/power-platform/admin/sync-logic)
- [Set up default sync filters for multiple users for appointments, contacts, or tasks](/power-platform/admin/configure-default-sync-filters)
