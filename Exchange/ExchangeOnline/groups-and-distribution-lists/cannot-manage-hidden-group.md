---
title: Can't manage a group hidden from the GAL
description: Provides a workaround for an issue in which the owners of security groups and distribution groups can't view or manage them if the groups are hidden from the global address list.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, kunalsh, ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 08/10/2024
---
# Can't manage a group hidden from the GAL

_Original KB number:_ &nbsp; 2813640

## Symptoms

You see the following scenarios occur:

> - Owners of security groups can't manage a group in the Exchange admin center if the group is hidden from the Global Address List (GAL).
> - The distribution group has to be unhidden from the GAL for owners to manage it in Outlook on the web.

These behaviors are by design. They occur even when the owner is listed in the `ManagedBy` attribute of the groups.

## Workaround

To work around this behavior, the owners of the groups must follow these steps:

1. Create a role group, and then assign the Distribution Group role to that role group. For more information about how to create role groups, see [Manage role groups](/exchange/manage-role-groups-exchange-2013-help).
2. Add to the role group the users who have to manage groups that are hidden from the GAL. For more information about how to add or remove role group members, see [Manage role groups](/exchange/manage-role-groups-exchange-2013-help).
