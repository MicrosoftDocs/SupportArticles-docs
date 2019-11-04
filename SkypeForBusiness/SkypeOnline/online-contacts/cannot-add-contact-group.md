---
title: Cannot add contact group, the Contacts list already contains the maximum number of distribution groups
description: Describes an issue in which you receive an error message when you try to add more distribution groups to your contact list in Lync. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# "Cannot add contact group. The Contacts list already contains the maximum number of distribution groups" when a Skype for Business Online user adds a contact group in Lync

## Problem 

When you try to add more distribution groups to your Skype for Business Online (formerly Lync Online) contact list in Lync 2010 or Lync 2013, you receive the following error message:

**Cannot add contact group. The Contacts list already contains the maximum number of distribution groups.**

## Solution

You can't increase the limit in Skype for Business Online. However, users should review the following Office help topics about how to manage contact lists for best practices and guidelines:

- [Manage your contacts and Contacts list in Lync 2010](https://office.microsoft.com/redir/ha101835254.aspx)

- [Create a new group in Lync 2013](https://office.microsoft.com/redir/ha102832427.aspx)

## More information

This issue occurs because the maximum number of distribution groups that a Skype for Business Online user can have in their contact list is set to 10 and can't be changed.

> [!NOTE]
> This restriction applies only to distribution groups from the address book. It doesn't apply to contact groups that are created by the user.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).