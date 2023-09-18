---
title: Error when opening 365 App for Outlook
description: Provides a solution to an error that occurs when you try to open the App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# We can't load this app because your email account isn't configured with Dynamics 365 server-side sync for appointments, contacts, and tasks error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to open the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4469522

## Symptoms

When attempting to open the Dynamics 365 App for Outlook, you receive the following error:

> "We're sorry  
We can't load this app because your email account isn't configured with Dynamics 365 server-side sync for appointments, contacts, and tasks. Ask your system administrator to set up server-side sync for appointments, contacts, and tasks."

If you select **Show more**, you see more details such as the following message:

> "Error: Email account isn't configured with server-side sync for appointments, contacts, and tasks Trace: Error: Email account isn't configured with server-side sync for appointments, contacts, and tasks"

## Cause

The Dynamics 365 App for Outlook requires Server-Side Synchronization to be enabled for your mailbox. This error occurs when your mailbox in Dynamics 365 isn't enabled for synchronization of Appointments, Contacts, and Tasks using [Server-Side Synchronization](/power-platform/admin/set-up-server-side-synchronization-of-email-appointments-contacts-and-tasks)

> [!NOTE]
> Your mailbox may have had Server-Side Synchronization configured correctly before. However, if the status of your mailbox in Dynamics 365 changes later to a failure status, you would receive this error until the mailbox is correctly configured and enabled again.

## Resolution

Verify your mailbox is enabled for incoming email with Server-Side Synchronization.

1. Access Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes** and then change the view to **Active Mailboxes**.
4. Locate and open the mailbox record for the user meeting the error.
5. Verify the **Appointments, Contacts, and Tasks** option is set to **Server-Side Synchronization or Email Router**.
6. If the **Appointments, Contacts, and Tasks Status**  doesn't already show as **Success**, select **Test & Enable Mailbox** and make sure to select the checkbox that appears in the dialog.
7. If the mailbox tests don't succeed, review the messages in the **Alerts** section. If an alert includes a Learn More link, select this link for more details. If you continue to see failures after selecting **Test & Enable Mailbox**, see [Failure after clicking Test & Enable Mailbox in Dynamics 365](https://support.microsoft.com/help/4091246) for more guidance.
8. After the mailbox shows Success for Appointments, Contacts, and Tasks Status, close and reopen Outlook. Then try to open the Dynamics 365 App for Outlook again.
9. If this message continues to appear after the mailbox is successfully Tested & Enabled and you closed and reopened Outlook, it could occur if the user is a member of multiple Dynamics 365 instances and the app was deployed from some other instance where the mailbox isn't Tested & Enabled.

## More information

If this message continues to appear after the mailbox is successfully Tested & Enabled and you closed and reopened Outlook, it could occur if the user is a member of multiple Dynamics 365 instances and the app was deployed from some other instance where the mailbox isn't Tested & Enabled.

Example: Your organization has multiple Dynamics 365 instances such as an instance for production (Instance A) and another for testing (Instance B). If you enabled the mailbox for Server-Side Sync in Instance A but are still seeing this message, it could be because the app was last deployed to this user's Exchange mailbox from Instance B.

If it may be the cause, follow these steps:

1. Open the web application for instance that the user will be using for their connection to Dynamics 365.
2. Navigate to **Settings** area and select **Dynamics 365 App for Outlook**.
3. Select the user from the **All Eligible Users** list.
4. Select the **Add App to Outlook** button.
5. The Status should switch to **Pending**. In about 15 minutes, the app should be redeployed to this user's mailbox and be connected to this instance.
