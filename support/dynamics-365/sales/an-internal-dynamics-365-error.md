---
title: An internal Microsoft Dynamics 365 error
description: Provides a solution to an error that occurs after selecting Test & Enable Mailbox on a mailbox record in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks

This article provides a solution to an error that occurs after selecting **Test & Enable Mailbox** on a mailbox record in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4346733

## Symptoms

After selecting **Test & Enable Mailbox** on a mailbox record in Dynamics 365, the Appointments, Contacts, and Tasks test result shows as Failure and the following message appears within the Alerts section:

> "An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks for the mailbox [Mailbox Name]. The mailbox didn't synchronize. The owner of the associated email server profile [Email Server Profile Name] has been notified.  
**Email Server Error Code:** UserPrivilegeError"

## Cause

If you see this error message and the Email Server Error Code shows as UserPrivilegeError, which indicates the user who owns this mailbox doesn't have sufficient privileges. See [PrivilegeDenied error occurs when using Server-Side Synchronization](https://support.microsoft.com/help/4015092) for a list of required privileges.

> [!IMPORTANT]
> Verify the Owner of the mailbox record is the same as the User. Example: If the mailbox is a User mailbox for Paul Cannon, verify the Owner value within the mailbox record for Paul Cannon shows as Paul Cannon. If it is some other user, that user may not have access to this user's mailbox.

## Resolution

To fix this issue, follow these steps:

1. As a user with the System Administrator role, open the mailbox record in Dynamics 365.
    > [!NOTE]
    > The alert includes a link to the mailbox record.
2. Verify the Owner field on the mailbox form is populated with the name of the User. If some other user is listed, change it to be the same as this user.
3. Select the link within the Owner field to open the User record for the owning user.
4. Select **Manage Roles** to see which security role(s) is assigned to this user.
5. Navigate to **Settings**, select **Security**, and then select **Security Roles**.
6. Open the roles found in step 4. See [PrivilegeDenied error occurs when using Server-Side Synchronization](https://support.microsoft.com/help/4015092) for a list of required privileges and verify the user's security role contains these privileges.
7. After verifying the user is the owner of their mailbox record and their security role contains the required privileges, select the **Test & Enable Mailbox** button within their mailbox record again. If the test doesn't result in Success, review the message that appears within the Alerts section.
