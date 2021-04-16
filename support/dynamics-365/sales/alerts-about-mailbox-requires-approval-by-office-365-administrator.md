---
title: Mailbox requires approval by Office 365 administrator
description: You receive an alert indicating the mailbox requires approval by an Office 365 administrator. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Mailbox requires an approval by an Office 365 administrator alerts occur after selecting Test & Enable Mailbox

This article provides a resolution for the issue that you may receive an error after you select the Test & Enable Mailbox button on a mailbox record in Microsoft Dynamics 365 (online).

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4014483

## Symptoms

After you select the Test & Enable Mailbox button on a mailbox record in Microsoft Dynamics 365 (online), you encounter one of the following error alerts:

> Email cannot be received because the email address of the mailbox \<Mailbox Name> requires an approval by an Office 365 administrator. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.

> Email cannot be sent because the email address of the mailbox \<Mailbox Name> requires an approval by an Office 365 administrator. The mailbox didn't synchronize. The owner of the email server profile Microsoft Exchange Online has been notified.

> Appointments, contacts, and tasks can't be synchronized because the email address of the mailbox \<Mailbox Name> requires an approval by an Office 365 administrator. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.

You may also see the following notification within the mailbox record:

> Email won't be processed for this mailbox until the email address of the mailbox is approved by an Office 365 administrator. For more information, contact your system administrator.

## Cause

When using Microsoft Dynamics 365 (online) with Exchange Online, the email address for a mailbox record needs to be approved by an Office 365 user with the Global Administrator or Exchange Administrator role.

## Resolution

1. Sign in to Microsoft Dynamics 365 (online) as a user with the following privileges:
    - Global Administrator or Exchange Administrator role in Office 365
    - System Administrator role in Microsoft Dynamics 365
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes**.
4. Change the view from my My Active Mailboxes to **Active Mailboxes**.
5. Select the mailbox and then select the **Approve Email** button.
6. After the mailbox is approved, you can select the mailbox and then select the **Test & Enable Mailboxes** button.

> [!NOTE]
> If the test results are something other than success, you can open the mailbox record and click the Alerts section. View the details of any errors that were logged.
For more information on recent changes to approval requirements including how to disable this requirement, see [Changes to Mailbox approval in Dynamics 365](https://support.microsoft.com/help/4506139/).

## More information

For more information on the Global Administrator and Exchange Administrator roles and assigning admin roles in Office 365, see the following resources:

- [About admin roles](/microsoft-365/admin/add-users/about-admin-roles)
- [Assign admin roles](/microsoft-365/admin/add-users/assign-admin-roles)
