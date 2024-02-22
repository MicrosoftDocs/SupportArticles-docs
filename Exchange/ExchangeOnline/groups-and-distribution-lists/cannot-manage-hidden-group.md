---
title: Can't manage a group hidden from GAL
description: Describes an issue in which the owner of a mail-enabled security group or a distribution group can't view or manage the group in Exchange admin center if the group is hidden from the global address list.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, kunalsh, ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# The owner of a mail-enabled security group or distribution group can't manage the group if it's hidden from the GAL

_Original KB number:_ &nbsp; 2813640

## Problem

### Problem 1

The owner of a security group can't view or manage a mail-enabled security group by using the Exchange admin center in Microsoft 365 if the group is hidden from the global address list (GAL). However, a global admin can view the security group in the Exchange admin center. This occurs even though the owner is listed in the `ManagedBy` attribute of the group.

### Problem 2

The owner of a distribution group can't manage the group if it is hidden from the GAL.

## Status

This behavior is by design.

> [!NOTE]
>
> - Owners of security groups can't manage a group in the Exchange admin center if the group is hidden from the GAL.
> - The distribution group has to be unhidden from GAL for owners to manage in OWA.

## Workaround

To work around this behavior, follow these steps:

1. Create a role group, and then assign the Distribution Group role to that role group. For more information about how to create role groups, see [Manage role groups](/exchange/manage-role-groups-exchange-2013-help).
2. Add to the role group the users who have to manage groups that are hidden from the GAL. For more information about how to add or remove role group members, see [Manage role groups](/exchange/manage-role-groups-exchange-2013-help).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
