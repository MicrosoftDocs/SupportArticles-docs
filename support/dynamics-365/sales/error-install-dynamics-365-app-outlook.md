---
title: IncomingEmailS2SApprovalNeeded when you install Dynamics 365 App for Outlook
description: This article provides a resolution for the problem that occurs when you attempt to install Dynamics 365 App for Outlook, the Status column shows Issue when adding to Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# IncomingEmailS2SApprovalNeeded error when attempting to install Dynamics 365 App for Outlook

This article helps you resolve the problem that occurs when you attempt to install Dynamics 365 App for Outlook, the Status column shows **Issue when adding to Outlook**.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3211621  

## Symptoms

When you attempt to install Dynamics 365 App for Outlook, the Status column shows **Issue when adding to Outlook**. When you click the **Learn more** link, you see a dialog with the following details:

> There was an issue when attempting to add the app to Outlook.  
Crm : IncomingEmailS2SApprovalNeeded

## Cause

This error can occur if the Mailbox record has not been approved by an Office 365 Global Administrator.

## Resolution

Approve the Mailbox record as a user with the Global Administrator role in Office 365.

1. Sign in to Dynamics 365 as a user with the Global Administrator role in Office 365.
2. Click **Settings** and then click **Email Configuration**.
3. Within the **Email Configuration** area, click **Mailboxes** and then change the view from **My Active Mailboxes** to **Active Mailboxes**.
4. Select the Mailbox record that encountered the error and then click **Approve Email**.
5. After the email address has been approved, click the **Test & Enable Mailboxes** button.
6. After the mailbox has completed testing, attempt to install Dynamics 365 App for Outlook again. This can be located by clicking **Settings** and then clicking Dynamics 365 App for Outlook.
