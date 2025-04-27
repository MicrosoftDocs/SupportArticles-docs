---
title: Email message cannot be sent MailboxDisabled error
description: Provides a solution to a MailboxDisabled error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# MailboxDisabled error when you test and enable a mailbox in Dynamics 365

This article provides a solution to a MailboxDisabled error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4481318

## Symptoms

When you try to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dynamics 365, the test fails, and the following alert is logged:

> The email message "Your mailbox is now connected to Dynamics 365" cannot be sent because the mailbox \<Mailbox Name\> is deactivated or disabled for outgoing email.  
> **Email Server Error Code:**  MailboxDisabled

## Cause

This error occurs if the mailbox is deactivated and the status is **Inactive**.

A mailbox can be deactivated if someone selects the **Deactivate** button. If it's a user mailbox, the mailbox can also be deactivated automatically when the user is deactivated. For example, if you remove a user's Dynamics 365 license, the user and their mailbox record will be deactivated.

## Resolution

1. Select the **Activate** button on the mailbox record and verify that the status shown in the footer of the page is **Active**.
2. Select the **Test & Enable Mailbox** button.
3. If the test doesn't succeed, review the alerts that appear.

> [!IMPORTANT]
> If the mailbox was deactivated because the associated user was disabled, ensure the user is re-enabled with a valid [Dynamics 365 license](/power-platform/admin/wp-license-management#assign-a-license-to-a-user) and [security role](/power-platform/admin/create-users-assign-online-security-roles#assign-a-security-role-to-a-user).
