---
title: A user disappears in All Eligible Users
description: When viewing the Dynamics 365 App for Outlook section within Settings, a user doesn't appear in the All Eligible Users list.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# A user doesn't appear in the All Eligible Users list within the Microsoft Dynamics 365 App for Outlook area

This article provides a solution to an issue where a user doesn't appear in the All Eligible Users list when viewing the Dynamics 365 App for Outlook section within Settings.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345543

## Symptoms

When viewing the Dynamics 365 App for Outlook section within Settings, a user doesn't appear in the All Eligible Users list.

## Cause

### Cause 1

The user doesn't have a security role assigned that includes the Use Dynamics 365 App for Outlook privilege

> [!NOTE]
> Dynamics 365 App for Outlook is supported for User mailboxes. Queue mailboxes aren't supported.

### Cause 2

The user isn't configured to use Server-Side Synchronization for Incoming Emails.

## Resolution

### Resolution 1

Verify the user has at least one Dynamics 365 security role assigned which includes the Use Dynamics 365 App for Outlook privilege.

> [!NOTE]
> The Use Dynamics 365 App for Outlook privilege is located on the Business Management tab of a security role within the Privacy Related Privileges section.

For more information about how to assign a security role, see [Assign a security role to a user](/power-platform/admin/create-users-assign-online-security-roles#assign-a-security-role-to-a-user). For information about creating or modifying a security role, see [Create or edit a security role to manage access](/power-platform/admin/create-edit-security-role).

### Resolution 2

Verify the user's mailbox record in Dynamics 365 is configured to use Server-Side Synchronization for Incoming Email and the mailbox is Tested and Enabled successfully.

1. Access Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes** and then change the view to **Active Mailboxes**.
4. Locate and open the mailbox record for the user.
5. Verify the **Incoming Email** option is set to **Server-Side Synchronization or Email Router**.
6. If the **Incoming Email Status** doesn't already show as **Success**, select **Test & Enable Mailbox** and make sure to select the checkbox that appears in the dialog.
7. If the mailbox tests don't succeed, review the messages in the **Alerts** section. If an alert includes a Learn More link, select this link for more details.
