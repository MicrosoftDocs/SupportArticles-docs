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
# Can't upgrade distribution lists to Microsoft 365 groups

_Original KB number:_ &nbsp; 4481100

## Symptoms

You can't upgrade your distribution lists (also known as distribution groups) to Microsoft 365 groups.

## Cause

You can upgrade only cloud-managed, simple, non-nested distribution lists to groups in Microsoft 365 Groups.  

The following conditions prevent a distribution list from being upgraded:  
* Is nested (has child groups or is a member of another group)
* Is an on-premises, managed distribution list
* Has more than 100 owners
* Has only members but no owner
* Has one or more members that are something other than a user mailbox, shared mailbox, team mailbox, or mail user (that is, the **RecipientTypeDetails** value of any member of the distribution list is not UserMailbox, SharedMailbox, TeamMailbox, or MailUser) 
* Is configured to be a forwarding address for a shared mailbox
* Is part of Sender Restriction in another distribution list
* Has an alias that contains special characters
* Is a mail-enabled security group 
* Is a dynamic distribution group 
* Was converted to a room list

This issue can also occur if a custom email address policy is applied to the tenant for the Microsoft 365 groups. 

## Resolution

If the affected distribution lists don't meet any of the conditions that are mentioned in the "Cause" section, you can resolve the custom email address policy issue by removing the policy. Then, try again to upgrade the distribution lists to Microsoft 365 groups. For more information about how to remove an email address policy, see [Remove an email address policy](/exchange/remove-an-email-address-policy-exchange-2013-help).

For more information about how to upgrade distribution lists, see [Overview of Microsoft 365 Groups for administrators](/microsoft-365/admin/create-groups/office-365-groups?view=o365-worldwide&preserve-view=true).
