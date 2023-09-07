---
title: IncomingEmailRejected when you install Dynamics 365 App for Outlook
description: This article provides a resolution for the problem that occurs when you attempt to install Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# IncomingEmailRejected error when attempting to install Dynamics 365 App for Outlook

This article helps you resolve the problem that occurs when you attempt to install Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3211627

## Symptoms

When you attempt to install Dynamics 365 App for Outlook, the **Status** column shows **Issue when adding to Outlook**. When you click the **Learn more** link, you see a dialog with the following details:

> There was an issue when attempting to add the app to Outlook.  
Crm : IncomingEmailRejected

## Cause

This error can occur for one of the following reasons:

- The email address for the mailbox record in Dynamics 365 has not been approved.
- The Exchange mailbox is currently linked to another Dynamics 365 organization. An Exchange mailbox (email address) can only synchronize appointments, contacts, and tasks with one organization, and a user that belongs to that organization can only synchronize appointments, contacts, and tasks with one Exchange mailbox.

## Resolution

Verify the email address for the Mailbox is approved and associated with the desired Dynamics 365 organization.

1. Sign in to Dynamics 365 as a user with the System Administrator role.
2. Click **Settings** and then click **Email Configuration**.
3. Within the Email Configuration area, click **Mailboxes** and then change the view from **My Active Mailboxes** to Active Mailboxes.
4. Select the Mailbox record that encountered the error and then click **Approve Email**.
5. After the email address has been approved, click the **Test & Enable Mailboxes** button.
6. Within the **Test Email Configuration** dialog, make sure to select the option **Sync items with Exchange from this Dynamics 365 Organization only, even if Exchange was set to sync with a different Organization** and then click **OK**.
7. After the mailbox has completed testing, attempt to install Dynamics 365 App for Outlook again. This can be located by clicking **Settings** and then clicking **Dynamics 365 App for Outlook**.
