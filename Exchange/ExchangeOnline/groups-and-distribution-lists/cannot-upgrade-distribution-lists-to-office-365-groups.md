---
title: Cannot upgrade distribution lists to Microsoft 365 groups
description: If a custom email address policy is applied to the tenant for your distribution lists, the distribution lists can't be upgraded to Microsoft 365 groups.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: subansal, ninob
appliesto: 
  - Exchange Online
  - MSfC O365-Exchange Online
search.appverid: MET150
ms.date: 3/31/2022
---
# Unable to upgrade distribution lists to Microsoft 365 groups

_Original KB number:_ &nbsp; 4481100

## Symptoms

You can't upgrade your distribution lists (which are also known as distribution groups) to Microsoft 365 groups.

## Cause

You can only upgrade cloud-managed, simple, non-nested distribution lists. 

Distribution lists below can't be upgraded:  
* Nested distribution lists. It either has child groups or is a member of another group. 
* On-premises managed distribution list. 
* Has more than 100 owners. 
* Has only members but no owner. 
* One or more members are something other than a user mailbox, shared mailbox, team mailbox, or mail user. In other words, the RecipientTypeDetails   value of any member of the distribution list is not UserMailbox, SharedMailbox, TeamMailbox, or MailUser. 
* Configured to be a forwarding address for a shared mailbox. 
* Part of Sender Restriction in another distribution list. 
* Has an alias that contains special characters. 
* Mail-enabled security groups 
* Dynamic distribution groups. 
* Distribution lists that were converted to RoomLists. 

The issue can also occur if a custom email address policy is applied to the tenant for the Microsoft 365 groups. 

## Resolution

Please note the upgrade will fail if any of the above conditions are true.

To resolve the custom email address policy issue, you have to remove the email address policy for the distribution groups. Then, try again to upgrade the distribution lists to Microsoft 365 groups. For more information about how to remove the email address policy, see [Remove an email address policy](/exchange/remove-an-email-address-policy-exchange-2013-help).

For more information about how to upgrade distribution lists, see [Overview of Microsoft 365 Groups for administrators - Microsoft 365 admin | Microsoft Learn](/microsoft-365/admin/create-groups/office-365-groups?view=o365-worldwide&preserve-view=true).
