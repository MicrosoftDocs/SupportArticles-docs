---
title: An internal Microsoft Dynamics 365 error
description: Resolves an email server error UserPrivilegeError that occurs after selecting Test & Enable Mailbox on a mailbox record in Dynamics 365.
ms.reviewer: 
ms.date: 12/31/2024
ms.custom: sap:Email and Exchange Synchronization
---
# An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks

This article provides a solution to the "UserPrivilegeError" that occurs when selecting **Test & Enable Mailbox** on a mailbox record in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4346733

## Symptoms

When you select [Test & Enable Mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) on a mailbox record in Dynamics 365, the **Appointments, Contacts, and Tasks Status** field shows as **Failure**. The following message is logged in the [Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) section:

> An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks for the mailbox \<Mailbox Name\>. The mailbox didn't synchronize. The owner of the associated email server profile \<Email Server Profile Name\> has been notified.  
> **Email Server Error Code:** UserPrivilegeError

## Cause

The error message with the "UserPrivilegeError" email server error code indicates that the user who owns this mailbox doesn't have sufficient privileges. Refer to [PrivilegeDenied error occurs when using Server-Side Synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync) for a list of required privileges.

> [!IMPORTANT]
> Verify that the owner of the mailbox record matches the user. For example, if the mailbox belongs to Paul Cannon, ensure that the **Owner** value in the record is also Paul Cannon. If it shows a different user, that user might not have access to Paul Cannon's mailbox.

## Resolution

To fix this issue, follow these steps:

1. Open the mailbox record in Dynamics 365 as a user with the "System Administrator" role.

    > [!TIP]
    > The alert includes a link to the mailbox record.

2. Verify that the **Owner** field in the mailbox form is populated with the user's name. If another user is listed, change it to the user's name.

3. Select the link in the **Owner** field to open the user record for that owner.
4. Select **Manage Roles** to see which security role(s) are assigned to this user.
5. Navigate to **Settings** > **Security** > **Security Roles**.

6. Open the roles found in step 4. See [PrivilegeDenied error occurs when using Server-Side Synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync) for a list of required privileges, and then verify that the user's security role contains these privileges.

7. After verifying that the user is the owner of the mailbox record and that their security role contains the required privileges, select **Test & Enable Mailbox** in the mailbox record again. If the test doesn't result in **Success**, review the message that appears in the **Alerts** section for further details.
