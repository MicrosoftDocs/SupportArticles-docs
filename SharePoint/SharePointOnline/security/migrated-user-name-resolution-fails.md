---
title: Migrated user across forests is not found in People Picker
description: The user does not exist or is not unique error for migrated users across forests in SharePoint.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint Server 2010
  - SharePoint Online
ms.date: 12/17/2023
---

# User accounts migrated with their SID history across forests are not resolved in SharePoint

## Symptoms

Consider the following scenario:

- You have two forests, ForestA and ForestB.
- There is a two-way forest trust between the forests.
- You have SharePoint installed in ForestB.
- You migrate the user accounts together with their security identifier (SID) history from ForestA to ForestB.
- The ForestA\user1 and ForestB\user1 user accounts are both enabled.

In this scenario, when you try to add the ForestA\user1 user account to SharePoint resources, you experience errors during the user name resolution. For example, the People Picker displays the following error message:

**The user does not exist or is not unique.**

## Cause

This behavior is expected.

When you migrate a user from ForestA to ForestB together with its SID history, the ForestB\user1 account has a new SID in the new domain and its **SIDHistory** attribute is populated by using the SID of ForestA\user1. Then, the new SID is resolved to ForestB\user1 by a local domain controller (DC) in ForestB.

For more information about mapping the SID to the user account, see [LookupAccountSid function](/windows/win32/api/winbase/nf-winbase-lookupaccountsida).

## Resolution

To work around the issue, don't have both accounts enabled at the same time.

## References

[SharePoint People Picker shows old domain account during Active Directory migration](/archive/blogs/rgullick/sharepoint-people-picker-shows-old-domain-account-during-active-directory-migration)

[SharePoint and SID History not playing well together](/archive/blogs/craigf/sharepoint-and-sid-history-not-playing-well-together)

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).