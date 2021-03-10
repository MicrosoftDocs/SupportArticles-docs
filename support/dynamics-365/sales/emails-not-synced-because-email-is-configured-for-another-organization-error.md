---
title: Emails aren't being synced error
description: Emails aren't being synced because the email address for the mailbox is configured for another Dynamics 365 organization - this error may occur when you try to Test and Enable a mailbox in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# Emails aren't being synced because email address is configured for another organization error

This article provides a resolution for the error that's listed in this article when you try to Test and Enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4053618

## Symptoms

When you attempt to Test and Enable a mailbox in Microsoft Dynamics 365, one of the following alerts is logged:

> Incoming emails aren't being synced because the email address for the \<Mailbox Name> mailbox is configured for another Dynamics 365 organization. Ask your administrator to test and enable your mailbox for the current organization and to change the sync method for non-primary organizations to None.  
Email Server Error Code: IncomingIncorrectCrmOrgError

> Outgoing mails aren't being sent because the email address \<email address> is configured for another Dynamics 365 organization. Ask your administrator to test and enable your mailbox for the current organization and change the sync method for non-primacy organizations to None.  
Email Server Error Code: OutgoingIncorrectCrmOrgError

> Appointments, contacts, and tasks can't be synchronized because the email address of the mailbox \<Mailbox Name> is configured with another Microsoft Dynamics 365 organization. The best practice is to overwrite the configuration when you test and enable the mailbox in your primary organization. Also, change the synchronization method for your mailbox in non-primary organizations to None.  
Email Server Error Code: ExchangeSyncIncorrectCrmOrgError

If you select **View Details** on the alert, you may also see the following more details:

> Exception : Check and Update configuration folder on exchange failed.

## Cause

An Exchange mailbox can only be configured to use Server-Side Synchronization with one Microsoft Dynamics 365 organization. These alerts are logged if you have multiple Microsoft Dynamics 365 organizations and try to configure your mailbox to use Server-Side Synchronization with multiple organizations.

## Resolution

### Test and Enable the Mailbox in the primary Microsoft Dynamics 365 organization

1. Sign in to the Microsoft Dynamics 365 organization that you want to have configured to use Server-Side Synchronization with the Exchange mailbox.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes**.
4. Change the selected view from My Active Mailboxes to **Active Mailboxes**.
5. Select the mailboxes you want to enable for Server-Side Synchronization and then select the **Test & Enable Mailboxes** button.

    > [!IMPORTANT]
    > Make sure to select the [checkbox](/power-platform/admin/when-would-want-use-check-box) on the dialog that appears and then select **OK**. If your Exchange mailbox was previously configured with another Microsoft Dynamics 365 organization, selecting this checkbox will update your Exchange mailbox to sync with this Microsoft Dynamics 365 organization instead. If you do not select this checkbox and your Exchange mailbox is already configured with another Microsoft Dynamics 365 organization, the tests will fail and log one of the alerts listed in the Symptom section of this article.

6. Wait for the Test & Enable process to complete. If the test results are not Success, review the Alerts area within the mailbox record.

### Change the sync method for non-primary Microsoft Dynamics 365 organizations to None

If you have more than one Microsoft Dynamics 365 organization, configure the user's mailbox in the non-primary organization(s) to be set to **None** for the sync method. For example: If you have a Microsoft Dynamics 365 organization used for production and another used for testing, a user can be enabled to use Server-Side Synchronization in one of the organizations but not both.

1. Sign in to the non-primary Microsoft Dynamics 365 organization as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes**.
4. Change the selected view from My Active Mailboxes to **Active Mailboxes**.
5. Open the mailbox you want to disable for Server-Side Synchronization.
6. Change the synchronization method options to **None** and then select **Save & Close**.
