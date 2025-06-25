---
title: Can't upgrade distribution lists to Microsoft 365 Groups
description: Provides a resolution if you're unable to upgrade a distribution list to a Microsoft 365 group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: subansal, ninob; ritwikraj, v-six
appliesto: 
  - Exchange Online
  - MSfC O365-Exchange Online
search.appverid: MET150
ms.date: 04/07/2025
---
# Can't upgrade distribution lists to Microsoft 365 Groups

_Original KB number:_ &nbsp; 4481100

## Symptoms

You can't upgrade your distribution lists (also known as distribution groups) to [Microsoft 365 Groups](/microsoft-365/admin/create-groups/office-365-groups?view=o365-worldwide&preserve-view=true).

## Cause

You can upgrade only cloud-managed, simple, non-nested distribution lists to Microsoft 365 Groups.  

The following conditions prevent a distribution list from being upgraded:  

* Is nested (has child groups or is a member of another group)
* Is an on-premises, managed distribution list
* Has more than 100 owners
* Has only members but no owner
* Has no members
* Has one or more members whose **RecipientTypeDetails** value isn't **UserMailbox**, **SharedMailbox**, **TeamMailbox**, or **MailUser**
* Is configured to be a forwarding address for a shared mailbox
* Is part of a sender restriction in another distribution list
* Has an alias that contains special characters
* Is a mail-enabled security group
* Is a dynamic distribution group
* Was converted to a room list

This issue can also occur if a custom email address policy is applied to the tenant for the Microsoft 365 Groups.

## Resolution

If the affected distribution lists don't meet any of the conditions that are mentioned in the Cause section, resolve the custom email address policy issue by [removing the policy](/exchange/remove-an-email-address-policy-exchange-2013-help). Then try again to upgrade the distribution lists to Microsoft 365 Groups.
