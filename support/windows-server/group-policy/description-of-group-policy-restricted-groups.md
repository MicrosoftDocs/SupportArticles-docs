---
title: Description of group policy restricted groups
description: This article gives a description of group policy restricted groups.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.subservice: group-policy
---
# Description of group policy restricted groups

This article provides a description of group policy restricted groups in Windows Server 2016, Windows Server 2012 R2, and Windows Server 2008 R2 Service Pack 1.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 279301

Restricted groups allow an administrator to define the following two properties for security-sensitive (restricted) groups:

- Members
- Member Of

The **Members** list defines who should and shouldn't belong to the restricted group. The **Member Of** list specifies which other groups the restricted group should belong to.

## Use the Members restricted group portion of policy

When a restricted group policy is enforced, any current member of a restricted group that isn't on the **Members** list is removed, except for administrator in the Administrators group. Any user on the **Members** list that isn't currently a member of the restricted group is added.

## Use the Member Of restricted group portion of policy

Only inclusion is enforced in this portion of a restricted group policy. The restricted group isn't removed from other groups. It makes sure that the restricted group is a member of groups that are listed in the **Member Of** dialog box.

## Manage membership of domain groups by using restricted groups

Microsoft doesn't support using restricted groups in this scenario. Restricted Groups is a client configuration means, and can't be used with domain groups. Restricted Groups is designed specifically to work with local groups. Domain objects must be managed within traditional AD tools. We don't plan currently to add or support using restricted groups as a way to manage domain groups.
