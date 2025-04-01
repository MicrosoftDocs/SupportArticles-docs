---
title: Error When Opening 365 App for Outlook
description: Solves the can't load this app error that occurs when you try to open the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/12/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "We can't load this app because your email account isn't configured with Dynamics 365 server-side sync" error

This article provides detailed steps to resolve an error that occurs when you try to open the [Dynamics 365 App for Outlook](/dynamics365/outlook-app/overview).

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4469522, 4469513

## Symptoms

When you try to open the Dynamics 365 App for Outlook, you receive one of the following error messages:

### Error 1

> We're sorry  
> We can't load this app because your email account isn't configured with Dynamics 365 server-side sync for appointments, contacts, and tasks. Ask your system administrator to set up server-side sync for appointments, contacts, and tasks.

If you select **Show more**, you see the following error message:

> Error: Email account isn't configured with server-side sync for appointments, contacts, and tasks Trace: Error: Email account isn't configured with server-side sync for appointments, contacts, and tasks.

### Error 2

> We're sorry  
> We can't load this app because your email account isn't configured with Dynamics 365 server-side sync for incoming email. Ask your system administrator to set up server-side sync for incoming email.

If you select **Show more**, you see the following error message:

> Error: Email account isn't configured with server-side synchronization for incoming email Trace: Error: Email account isn't configured with server-side synchronization for incoming email.

## Cause

The Dynamics 365 App for Outlook requires [server-side synchronization](/power-platform/admin/set-up-server-side-synchronization-of-email-appointments-contacts-and-tasks) to be enabled for your mailbox. This error occurs when your mailbox in Dynamics 365 isn't enabled for synchronization of appointments, contacts, tasks, or incoming emails using server-side synchronization.

> [!NOTE]
> Your mailbox needs to have server-side synchronization configured correctly before the Dynamics 365 App for Outlook can be deployed to your mailbox. However, if the status of your mailbox in Dynamics 365 changes later to a failure status, you will receive this error until the mailbox is correctly configured and enabled again.

## Resolution

Verify your mailbox is enabled for server-side synchronization:

1. Sign in to Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes** and then change the view to **Active Mailboxes**.
4. Locate and open the mailbox record for the user meeting the error.

5. Depending on the error message, verify that the **Incoming Email** or **Appointments, Contacts, and Tasks** option is set to **Server-Side Synchronization or Email Router**.

6. If the **Incoming Email Status** or **Appointments, Contacts, and Tasks Status** isn't shown as  **Success**, select **Test & Enable Mailbox** and make sure to select the checkbox that appears in the dialog.

7. If the mailbox tests don't succeed, review the messages in the **Alerts** section. If an alert includes a **Learn More** link, select this link for more details.

8. After **Incoming Email Status** or **Appointments, Contacts, and Tasks Status** is shown as **Success**, close and reopen Outlook. Then, try to reopen the Dynamics 365 App for Outlook.

## More information

If this message still appears after successfully testing and enabling the mailbox and reopening Outlook, it might be because the user is a member of multiple Dynamics 365 instances, and the app might have been deployed from an instance where the mailbox isn't tested and enabled."

For example, your organization might have multiple Dynamics 365 instances, such as an instance for production (instance A) and another for testing (instance B). If you enable the mailbox for server-side synchronization in instance A, you might still receive this message if the app was last deployed to this user's Exchange mailbox from instance B.

To solve this issue:

1. Open the web application for the instance that the user will be using for their connection to Dynamics 365.
2. Navigate to **Settings** area and select **Dynamics 365 App for Outlook**.
3. Select the user from the **All Eligible Users** list.
4. Select the **Add App to Outlook** button.
5. The **Status** should switch to **Pending**. In about 15 minutes, the app should be redeployed to the user's mailbox and connected to the correct instance.
