---
title: Description of group policy restricted groups
description: This article gives a description of group policy restricted groups.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Group Policy management - GPMC or AGPM
ms.technology: windows-server-group-policy
---
# Description of group policy restricted groups

This article provides a description of group policy restricted groups in Windows Server 2016, Windows Server 2012 R2, and Windows Server 2008 R2 Service Pack 1.

_Original product version:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 279301

## More information

Restricted groups allow an administrator to define the following two properties for security-sensitive (restricted) groups:

- Members
- Member Of

The **Members** list defines who should and should not belong to the restricted group. The **Member Of** list specifies which other groups the restricted group should belong to.

## Use the Members restricted group portion of policy

When a restricted group policy is enforced, any current member of a restricted group that is not on the **Members** list is removed with the exception of administrator in the Administrators group. Any user on the **Members** list that is not currently a member of the restricted group is added.

### Use the Member Of restricted group portion of policy

Only inclusion is enforced in this portion of a restricted group policy. The restricted group is not removed from other groups. It makes sure that the restricted group is a member of groups that are listed in the **Member Of** dialog box.

### Manage membership of domain groups by using restricted groups

Microsoft does not support using restricted groups in this scenario. Restricted Groups is a client configuration means and cannot be used with domain groups. Restricted Groups is designed specifically to work with local groups. Domain objects have to be managed within traditional AD tools. Therefore, we do not plan currently to add or support using restricted groups as a way to manage domain groups.
