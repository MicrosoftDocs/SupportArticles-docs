---
title: Email tracked by Dynamics 365 App for Outlook not showing
description: An email tracked with Dynamics 365 App for Outlook does not appear in Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An email or appointment tracked with Microsoft Dynamics 365 App for Outlook shows as Track pending

This article provides a resolution for the issue that the email or appointment that's tracked with Microsoft Dynamics 365 App for Outlook shows as Track pending.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345569

## Symptoms

When you track an email or appointment using Microsoft Dynamics 365 App for Outlook, the email does not appear in Microsoft Dynamics 365. When you view the item with Microsoft Dynamics 365 App for Outlook, the item shows as **Track pending...**.

## Cause

If the item appears as Track Pending but is eventually created in Microsoft Dynamics 365 and switches to Tracked, this may be expected. Review the Synchronization and tracking section of the [D365 App for Outlook Users Guide](/dynamics365/outlook-app/dynamics-365-app-outlook-user-s-guide#synchronization-and-tracking) to understand if it is expected the item will be created immediately by the app or if Server-Side Synchronization will be responsible for creating/tracking the item. If the item shows as Track Pending instead of Tracked, that is an indication the item will be processed by Server-Side Synchronization on the next sync cycle that could take up to 15 minutes.

If the item appears as Track Pending for more than 20 minutes, refer to the Resolution section.

## Resolution

If an item shows as Tracking pending for more than 20 minutes, verify the user's mailbox record in Dynamics 365 is configured to use Server-Side Synchronization and the mailbox is successfully tested and enabled.

1. Access Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes** and then change the view to **Active Mailboxes**.
4. Locate and open the mailbox record for the user.
5. Verify the **Incoming Email** option is set to **Server-Side Synchronization or Email Router**. If the item is an appointment, verify the Appointments, Contacts, and Tasks setting as well.
6. If the **Incoming Email Status** does not already show as **Success**, select **Test & Enable Mailbox** and make sure to select the checkbox that appears in the dialog.
7. If the mailbox tests do not succeed, review the messages in the **Alerts** section. If an alert includes a Learn More link, select this link for more details.

If the mailbox was already tested and enabled successfully, review the Alerts section within their mailbox record. If Server-Side Synchronization was expected to create the item in Microsoft Dynamics 365, any errors should be shown in the Alerts section.

> [!NOTE]
> If no errors appear within the Alerts section, navigate to **Settings** > **Email Configuration** > **Email Configuration Settings**. In the **Configure alerts** section, verify the **Error** and **Warning** options are selected. If these options were not already selected, enable these options and select **OK**. Then reproduce the issue with another item to see if any errors or warnings are logged after item has shown as **Track pending** for more than 20 minutes.
