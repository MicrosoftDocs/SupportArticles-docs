---
title: Email cannot be sent
description: Provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Email cannot be sent because the email address of the mailbox requires an approval by an Office 365 administrator

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4052727

## Symptoms

When you attempt to Test and Enable a mailbox in Dynamics 365, one of the following alerts is logged:

- > Email cannot be sent because the email address of the mailbox \<Mailbox Name> requires an approval by an Office 365 administrator. The mailbox didn't synchronize. The owner of the email server profile Microsoft Exchange Online  has been notified.  
**Email Server Error Code:**  OutgoingEmailS2SApprovalNeeded

- > Email cannot be received because the email address of the mailbox \<Mailbox Name> requires an approval by an Office 365 administrator. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.  
**Email Server Error Code:**  IncomingEmailS2SApprovalNeeded

- > Appointments, contacts, and tasks can't be synchronized because the email address of the mailbox \<Mailbox Name> requires an approval by an Office 365 administrator. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.  
**Email Server Error Code:**  ExchangeSyncEmailS2SApprovalNeeded

## Cause

When using Dynamics 365 (online) with Exchange Online, the email address for a mailbox record needs to be approved by an Office 365 user with the [About admin roles](/microsoft-365/admin/add-users/about-admin-roles).

## Resolution

To fix this issue, follow these steps:

1. Sign into Dynamics 365 (online) as a user with the following privileges:

    - Global Administrator or Exchange Administrator role in Office 365
    - System Administrator role in Dynamics 365

1. Navigate to **Settings**, and then select **Email Configuration**.
1. Select **Mailboxes**.
1. Change the view from my **My Active Mailboxes** to **Active Mailboxes**.
1. Select the mailbox, and then select the **Approve Email** button.
1. After the mailbox is approved, you can select the mailbox and then select the **Test & Enable Mailboxes**  button.

> [!NOTE]
> If the test results are something other than success, you can open the mailbox record and select the Alerts section. View the details of any errors that were logged.

For more information about recent changes to approval requirements including how to disable this requirement, see [Changes to Mailbox approval in Dynamics 365](https://support.microsoft.com/help/4506139/).
