---
title: 401 Unauthorized exception when using server-side synchronization
description: Provides a solution to an error that occurs when you use server-side synchronization in Dynamics 365.
ms.reviewer: dmartens
ms.date: 12/11/2024
ms.custom: sap:Email and Exchange Synchronization
---
# 401 Unauthorized exception occurs when using server-side synchronization in Microsoft Dynamics 365

This article presents possible causes and solutions for errors that might occur when you use server-side synchronization in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3212785

> [!IMPORTANT]
> If you use Exchange Online and this error occurs after October 1st, 2022, this may be caused by Basic authentication being disabled. For more information about how to temporarily enable Basic authentication again for a limited time, see [Use of Basic authentication with Exchange Online](/power-platform/admin/use-basic-authentication-exchange-online).

## Symptoms

When you use [server-side synchronization](/power-platform/admin/server-side-synchronization) in Dynamics 365, you receive one of the following errors:

> - The email message "Test Message" cannot be sent. Make sure that the credentials specified in the mailbox \<Mailbox Name> are correct and have sufficient permissions for sending email. Then, enable the mailbox for email processing.

> - Appointments, contacts, and tasks can't be synchronized. Make sure that the credentials specified in the mailbox \<Mailbox Name> are correct and have sufficient permissions. Then, enable the mailbox for appointments, contacts, and tasks synchronization.

> - Email cannot be received for the mailbox \<Mailbox Name>. Make sure that the credentials specified in the mailbox are correct and have sufficient permissions for receiving email. Then, enable the mailbox for email processing.

The message also includes the following error code:

> Email Server Error Code: Http server returned 401 Unauthorized exception.

## Cause 1: The e-mail address in Dynamics 365 doesn't match the one in Exchange

To solve this issue, verify the email address of the mailbox record in Dynamics 365 matches the one in Exchange. The error includes a link to the mailbox record in Dynamics 365. You can use this link to quickly verify the **Email Address** field.

## Cause 2: Using an Exchange Server (Hybrid) profile with a mailbox in Exchange Online

If you use Dynamics 365 (online) with Exchange Online, make sure you use an [Exchange Online email server profile](/power-platform/admin/connect-exchange-online#create-an-email-server-profile-for-exchange-online). Only use an Exchange Server (Hybrid) profile for users that have mailboxes in Exchange on-premises. For more information, see [Connect to Exchange Server (on-premises)](/power-platform/admin/connect-exchange-server-on-premises).

## Cause 3: The user doesn't have an Exchange Online license

If you use Dynamics 365 with Exchange Online, verify the user has an Exchange Online license. For more information about assigning licenses in Microsoft 365, see [Add users and assign licenses at the same time](/microsoft-365/admin/add-users/add-users).

## Cause 4: Dynamics 365 and Exchange Online aren't in the same Microsoft 365 tenant

If you use Dynamics 365 (online) with Exchange Online, verify Dynamics 365 (online) and Exchange Online are in the same Microsoft 365 account or tenant.

## Cause 5: Basic authentication isn't enabled for EWS (Exchange Web Services)

If you use Dynamics 365 (online) with Exchange on-premises, verify Basic authentication is enabled for [EWS (Exchange Web Services)](/exchange/client-developer/exchange-web-services/start-using-web-services-in-exchange). For more information, see the Prerequisites section of [Connect Dynamics 365 (online) to Exchange Server (on-premises)](/previous-versions/dynamicscrm-2016/administering-dynamics-365/mt622059(v=crm.8)#prerequisites).

## Cause 6: A deleted user or mailbox is re-created with the same email address

When you try to test and enable the mailbox, you might see that the **NoUserFoundWithGivenClaims** message is included as a part of an error level alert. You might also see a "User does not exist in tenant with id '\<User ID\>'" message in the **Details** section of the alert.

To solve this issue:

1. Make sure that the previously existing user or mailbox is permanently deleted. By default, a user who is deleted from Microsoft Entra ID can have their account restored within 30 days. For more information, see [Permanently delete a user](/azure/active-directory/fundamentals/active-directory-users-restore#permanently-delete-a-user).

1. After verifying that no user or mailbox uses the same email address, you can try to test and enable the mailbox again. If you still receive the error message, it may be due to caching. It might take up to 72 hours for the cache to be cleared. If you can't wait for 72 hours, contact Microsoft Support through the **Help + Support** experience in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/support).
