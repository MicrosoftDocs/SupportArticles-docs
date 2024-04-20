---
title: Error when using server-side sync
description: Provides a solution to an error that occurs when you use Server-Side Synchronization in Dynamics 365.
ms.reviewer: dmartens
ms.topic: troubleshooting
ms.date: 09/22/2022
ms.subservice: d365-sales-email-office-integration
---
# 401 Unauthorized exception occurs in Microsoft Dynamics 365 when using Server-Side Synchronization

This article provides a solution to an error that occurs when you use Server-Side Synchronization in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3212785

> [!IMPORTANT]
> If you are using Exchange Online and this error occurs after October 1st, 2022, this may be caused by Basic authentication being disabled. For more information about how to temporarily enable Basic authentication again for a limited time, see [Use of Basic authentication with Exchange Online](/power-platform/admin/use-basic-authentication-exchange-online).

## Symptoms

When you use Server-Side Synchronization in Dynamics 365, you receive one of the following errors:

> - The email message "Test Message" cannot be sent. Make sure that the credentials specified in the mailbox \<Mailbox Name> are correct and have sufficient permissions for sending email. Then, enable the mailbox for email processing.

> - Appointments, contacts, and tasks can't be synchronized. Make sure that the credentials specified in the mailbox \<Mailbox Name> are correct and have sufficient permissions. Then, enable the mailbox for appointments, contacts, and tasks synchronization.

> - Email cannot be received for the mailbox \<Mailbox Name>. Make sure that the credentials specified in the mailbox are correct and have sufficient permissions for receiving email. Then, enable the mailbox for email processing.

The message also includes the following error code:

> Email Server Error Code: Http server returned 401 Unauthorized exception.

## Cause

These errors can occur for one of the following reasons:

1. The e-mail address of the mailbox record in Dynamics 365 doesn't match the e-mail address of the mailbox in Exchange.
2. If you're using Dynamics 365 (online) with Exchange Online, this error can occur if you're using an Exchange Server (Hybrid) profile even though the user's mailbox is located in Exchange Online.
3. If you're using Dynamics 365 with Exchange Online, this error can occur if the user doesn't have an Exchange Online license.
4. If you're using Dynamics 365 (online) with Exchange Online, this error can occur if your Dynamics 365 subscription isn't in the same Office 365 tenant as your Exchange Online subscription. When using an Exchange Online email server profile, Dynamics 365 (online) and Exchange Online need to be in the same Office 365 account/tenant.
5. If you're using Dynamics 365 (online) with Exchange on-premises, this error can occur if Basic authentication isn't enabled for EWS (Exchange Web Services).
6. The user or mailbox that had been deleted was later recreated by using the same email address.

    When you try to test and enable the mailbox, you may see that the **NoUserFoundWithGivenClaims** message is included as part of an error level alert. You may also see an alert where the details section shows, "User does not exist in tenant with id '\<_User ID_>'".

## Resolution

To fix this issue, use the following steps:

1. Verify the e-mail address of the mailbox record in Dynamics 365 matches the e-mail address in Exchange. The error includes a link to the mailbox record in Dynamics 365. You can use this link to quickly verify the Email Address field.
2. If you're using Dynamics 365 (online) with Exchange Online, make sure you're using an Exchange Online email server profile. Only use an Exchange Server (Hybrid) profile for users that have mailboxes in Exchange on-premises.
3. If you're using Dynamics 365 with Exchange Online, verify the user has an Exchange Online license. For more information about assigning licenses in Office 365, see [Add users and assign licenses at the same time](/microsoft-365/admin/add-users/add-users).
4. If you're using Dynamics 365 (online) with Exchange Online, verify Dynamics 365 (online) and Exchange Online are in the same Office 365 account/tenant.
5. If you're using Dynamics 365 (online) with Exchange on-premises, verify Basic authentication is enabled for EWS (Exchange Web Services). For more information, see the Prerequisites section of [Connect Dynamics 365 (online) to Exchange Server (on-premises)](/previous-versions/dynamicscrm-2016/administering-dynamics-365/mt622059(v=crm.8)).
6. If the user or mailbox that had been deleted was later recreated by using the same email address:

    1. Make sure that the previously existing user or mailbox was permanently deleted. By default, a user who is deleted from Microsoft Entra ID can have their account restored within 30 days. For more information, see [Permanently delete a user](/azure/active-directory/fundamentals/active-directory-users-restore#permanently-delete-a-user).
    2. After verifying that no user or mailbox uses the same email address, you can try to test and enable the mailbox again. If you still receive the error message, the issue can be caused by the result of caching. It may take up to 72 hours for the cache to be cleared. If you can't wait for 72 hours, contact [Microsoft Support](https://support.microsoft.com).
