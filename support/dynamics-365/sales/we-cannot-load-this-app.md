---
title: We cannot load this app
description: Describes an error that occurs when you try to open the Dynamics 365 App for Outlook. Provides a solution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# We can't load this app because your email account isn't configured with Dynamics 365 server-side sync for incoming email error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to open the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4469513

## Symptoms

When attempting to open the Dynamics 365 App for Outlook, you receive the following error:

> "We're sorry  
We can't load this app because your email account isn't configured with Dynamics 365 server-side sync for incoming email. Ask your system administrator to set up server-side sync for incoming email."

If you select **Show more**, you see more details such as the following message:

> "Error: Email account isn't configured with server-side synchronization for incoming email Trace: Error: Email account isn't configured with server-side synchronization for incoming email"

## Cause

The Dynamics 365 App for Outlook requires Server-Side Synchronization to be enabled for your mailbox. This error occurs when your mailbox in Dynamics 365 isn't enabled for incoming email using [Server-Side Synchronization](/power-platform/admin/set-up-server-side-synchronization-of-email-appointments-contacts-and-tasks).

> [!NOTE]
> Your mailbox needed to have had Server-Side Synchronization configured correctly before the app could be deployed to your mailbox. However, if the status of your mailbox in Dynamics 365 changes later to a failure status, you would receive this error until the mailbox is correctly configured and enabled again.

## Resolution

Verify your mailbox is enabled for incoming email with Server-Side Synchronization.

1. Access Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes** and then change the view to **Active Mailboxes**.
4. Locate and open the mailbox record for the user meeting the error.
5. Verify the **Incoming Email** option is set to **Server-Side Synchronization or Email Router**. If the app will also be used to track Appointments or Contacts in Outlook, verify the Appointments, Contacts, and Tasks setting as well.
6. If the **Incoming Email Status** doesn't already show as **Success**, select **Test & Enable Mailbox** and make sure to select the checkbox that appears in the dialog.
7. If the mailbox tests don't succeed, review the messages in the **Alerts** section. If an alert includes a Learn More link, select this link for more details. If you continue to see failures after selecting **Test & Enable Mailbox**, see [Failure after clicking Test & Enable Mailbox in Dynamics 365](https://support.microsoft.com/help/4091246) for more guidance.
8. After the mailbox shows Success for Incoming Email Status, close and reopen Outlook. Then try to open the Dynamics 365 App for Outlook again.
