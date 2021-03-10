---
title: Email can't be received for the mailbox error when test and enable mailbox
description: Email can't be received for the mailbox because the associated user doesn't have a valid Microsoft Dynamics 365 license - this error occurs when trying to Test and Enable a mailbox in Microsoft Dynamics 365.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# Email can't be received for the mailbox because the associated user doesn't have a valid Microsoft Dynamics 365 license

This article provides a resolution for the error **Email can't be received for the mailbox because the associated user doesn't have a valid Microsoft Dynamics 365 license that occurs when you try to Test and Enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4053825

## Symptoms

When you attempt to Test and Enable a mailbox in Microsoft Dynamics 365, one of the following alerts is logged:

> Email can't be received for the mailbox \<Mailbox Name> because the associated user doesn't have a valid Microsoft Dynamics 365 license. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.  
  Email Server Error Code: IncomingEmailNoLicenseAssigned

> Email can't be sent for the mailbox "Test Message" because the associated user doesn't have a valid Microsoft Dynamics 365 license. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile.  
Email Server Error Code: OutgoingEmailNoLicenseAssigned

## Cause

The user does not have a Microsoft Dynamics 365 license assigned or the owning user has their Access Mode set to Administrative.

## Resolution

### Verify the user has a Microsoft Dynamics 365 license

Assign a Microsoft Dynamics 365 license to the user. Refer to the **Add a license to a user account** section of the [Create users and assign security roles](/power-platform/admin/create-users-assign-online-security-roles) article.

> [!NOTE]
> After assigning the Microsoft Dynamics 365 license to the user, it may take a few minutes for this change to sync from Office 365 to Microsoft Dynamics 365.

### Verify the user is not in Administrative access mode

1. Sign in to your Microsoft Dynamics 365 organization as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes**.
4. Change the selected view from My Active Mailboxes to **Active Mailboxes**.
5. Open the user's mailbox record.
6. Select the user selected in the **Owner** field to open the User record.
7. Expand the **Administration** tab.
8. Verify the **Access Mode** is set to **Read-Write**.

### Test and Enable the mailbox again

1. Open the mailbox record if it is not already open.
2. Select the **Test & Enable Mailbox** button.
3. Wait for the Test & Enable process to complete. If the test results are not Success, review the **Alerts** area within the mailbox record.
