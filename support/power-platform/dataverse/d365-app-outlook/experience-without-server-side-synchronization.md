---
title: Can't Track and Set Regarding in Dynamics 365 App for Outlook
description: Solves the Track and Set Regarding are currently disabled notification that occurs when using Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/14/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "Track and Set Regarding are currently disabled" occurs in Dynamics 365 App for Outlook

This article explains why you might receive a "Track and Set Regarding are currently disabled" notification in Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4508591

## Symptoms

When using [Dynamics 365 App for Outlook](/dynamics365/outlook-app/overview), you might receive the following notification:

> Track and Set Regarding are currently disabled. To use these features, please contact your admin. You can still view and interact with your Dynamics 365 data.

## Cause 1 - Server-side synchronization is inactive

Dynamics 365 App for Outlook uses [server-side synchronization](/power-platform/admin/set-up-server-side-synchronization-of-email-appointments-contacts-and-tasks) to keep your Exchange items in synchronization with Dynamics 365. For example, when you track a meeting in Outlook, Dynamics 365 App for Outlook relies on server-side synchronization to create the activity in Dynamics 365 and maintain synchronization between the two items.

If server-side synchronization is inactive on your mailbox, you can't track and set regarding on emails and appointments. However, you can still view Dynamics 365 information, such as accounts, contacts, and activities, and continue to create, update, and manage your information, as these actions aren't related to synchronization.

### Resolution

To address this issue, contact your administrator who can check the status of the service and take necessary actions to activate server-side synchronization.

## Cause 2 - Email address doesn't match the primary SMTP address

Another cause is that the email address in Dynamics 365 doesn't match the [primary SMTP address](/Exchange/email-addresses-and-address-books/email-address-policies/email-address-policies#email-address-templates) in Microsoft Exchange.

### Resolution

To resolve this issue, [update the email address in Dynamics 365](/dynamics365/outlook-addin/user-guide/outlook-email-address-should-same#change-the-email-address-in-dynamics-365-apps-to-match-the-outlook-address) to match the primary SMTP email address in Exchange.

> [!TIP]
> To find the primary SMTP email address in Exchange, navigate to the [properties of the mailbox](/exchange/recipients/user-mailboxes/user-mailboxes#change-user-mailbox-properties). The primary SMTP email address is displayed in bold.

## More information

[Test the configuration of mailboxes for server-side synchronization](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes)
