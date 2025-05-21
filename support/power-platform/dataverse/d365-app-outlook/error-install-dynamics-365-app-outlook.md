---
title: IncomingEmailS2SApprovalNeeded or IncomingEmailRejected when installing Dynamics 365 App for Outlook
description: Solves errors that occur when you try to install Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# IncomingEmailS2SApprovalNeeded or IncomingEmailRejected error when you install Dynamics 365 App for Outlook

This article helps you resolve errors that might occur when you try to install Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 3211621, 3211627  

## Error: IncomingEmailS2SApprovalNeeded

When you try to [install Dynamics 365 App for Outlook](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook), the **Status** column shows **Issue when adding to Outlook**. When you select the **Learn more** link, you see a dialog with the following details:

> There was an issue when attempting to add the app to Outlook.  
> Crm : IncomingEmailS2SApprovalNeeded

### Cause

This error can occur if the mailbox record isn't approved by a Microsoft 365 Global Administrator.

### Resolution

To solve this issue, approve the mailbox record as a user with the Global Administrator role in Microsoft 365.

1. Sign in to Dynamics 365 as a user with the Global Administrator role in Microsoft 365.
2. Select **Settings** > **Email Configuration**.

3. Within the **Email Configuration** area, select **Mailboxes**, and then change the view from **My Active Mailboxes** to **Active Mailboxes**.

4. Select the mailbox record that encountered the error, and then select **Approve Email**.
5. After the email address is approved, select the **Test & Enable Mailboxes** button.

6. After the mailbox has completed testing, try to install Dynamics 365 App for Outlook again. This can be located by selecting **Settings** > **Dynamics 365 App for Outlook**.

## Error: IncomingEmailRejected

When you try to install Dynamics 365 App for Outlook, the **Status** column shows **Issue when adding to Outlook**. When you select the **Learn more** link, you see a dialog with the following details:

> There was an issue when attempting to add the app to Outlook.  
> Crm : IncomingEmailRejected

### Cause

This error can occur due to one of the following reasons:

- The email address for the mailbox record in Dynamics 365 isn't approved.
- The Exchange mailbox is currently linked to another Dynamics 365 organization. An Exchange mailbox (email address) can only synchronize appointments, contacts, and tasks with one organization, and a user that belongs to that organization can only synchronize appointments, contacts, and tasks with one Exchange mailbox.

### Resolution

Verify the email address for the mailbox is approved and associated with the desired Dynamics 365 organization.

1. Sign in to Dynamics 365 as a user with the System Administrator role.
2. Select **Settings** > **Email Configuration**.

3. Within the **Email Configuration** area, select **Mailboxes**, and then change the view from **My Active Mailboxes** to **Active Mailboxes**.
4. Select the mailbox record that encountered the error, and then select **Approve Email**.
5. After the email address is approved, select the **Test & Enable Mailboxes** button.

6. Within the **Test Email Configuration** dialog, make sure to select the [Sync items with Exchange from this Dynamics 365 Organization only, even if Exchange was set to sync with a different Organization](/dynamics365/customerengagement/on-premises/admin/when-would-want-use-check-box) checkbox, and then select **OK**.

7. After the mailbox has completed testing, try to install Dynamics 365 App for Outlook again. This can be located by selecting **Settings** > **Dynamics 365 App for Outlook**.
