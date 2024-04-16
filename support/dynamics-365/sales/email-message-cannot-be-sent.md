---
title: Email message cannot be sent
description: Provides a solution to an error that occurs after you select the Test & Enable Mailbox button in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# The email message "Your mailbox is now connected to Dynamics 365" cannot be sent because the mailbox [Mailbox Name] is deactivated or disabled for outgoing email

This article provides a solution to an error that occurs after you select the **Test & Enable Mailbox** button in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4481318

## Symptoms

After you select the **Test & Enable Mailbox** button in Dynamics 365, the tests fail and the following alert is logged:

> "The email message "Your mailbox is now connected to Dynamics 365" cannot be sent because the mailbox [Mailbox Name] is deactivated or disabled for outgoing email.  
**Email Server Error Code:**  MailboxDisabled"

## Cause

This error occurs if the mailbox is deactivated and the status is now Inactive.

A mailbox could have been deactivated by someone selecting the **Deactivate** button. If it's a user mailbox, the mailbox could have been deactivated automatically if the regarding user was deactivated. For example: If you remove a user's Dynamics 365 license, the user will be deactivated and also their mailbox record.

## Resolution

1. Select the **Activate** button on the mailbox record and verify the status shown in the footer of the page shows as **Active**.
2. Select the **Test & Enable Mailbox** button.
3. If the tests don't succeed, review the alerts that appear.

> [!IMPORTANT]
> If the mailbox had been deactivated because the associated user was disabled, you should also make sure the user is enabled with a valid [Dynamics 365 license](/power-platform/admin/wp-license-management#assign-a-license-to-a-user) and [security role](/power-platform/admin/create-users-assign-online-security-roles#assign-a-security-role-to-a-user).
