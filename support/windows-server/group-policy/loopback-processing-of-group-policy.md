---
title: Loopback processing of Group Policy
description: This article describes why you need to enable loopback processing for Group Policy.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, slight
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.technology: windows-server-group-policy
---
# Loopback processing of Group Policy

This article helps you resolve the problem of applying the Group Policy loopback function when a user signs in to a computer in a specific organizational unit.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 231287

## Summary

Group Policy applies to the user or computer in a manner that depends on where both the user and the computer objects are located in Active Directory. In some cases, users may need policy applied to them based on the location of the computer object alone. You can use the Group Policy loopback feature to apply Group Policy Objects (GPOs) that depend only on which computer the user signs in to.

## More information

To set user configuration per computer, follow these steps:

1. In the Group Policy Microsoft Management Console (MMC), select **Computer Configuration**.
2. Locate **Administrative Templates**, select **System**, select **Group Policy**, and then enable the **Loopback Policy** option.

This policy directs the system to apply the set of GPOs for the computer to any user who logs on to a computer affected by this policy. This policy is intended for special-use computers where you must modify the user policy based on the computer that's being used. For example, computers in public areas, in laboratories, and in classrooms.

> [!NOTE]
> Loopback is supported only in an Active Directory environment. Both the computer account and the user account must be in Active Directory. If a Microsoft Windows NT 4.0 based domain controller manages either account, the loopback does not function. The client computer must be a running one of the following operating systems:
>
> - Windows XP Professional
> - Windows 2000 Professional
> - Windows 2000 Server
> - Windows 2000 Advanced Server
> - Windows Server 2003

When users work on their own workstations, you may want Group Policy settings applied based on the location of the user object. So we recommend you to configure policy settings based on the organizational unit in which the user account resides. When a computer object resides in a specific organizational unit, the user settings of a policy should be applied based on the location of the computer object instead of the user object.

> [!NOTE]
> You cannot filter the user settings that are applied by denying or removing the AGP and Read rights from the computer object specified for the loopback policy.

Normal user Group Policy processing specifies that computers located in their organizational unit have the GPOs applied in order during computer startup. Users in their organizational unit have GPOs applied in order during logon, regardless of which computer they log on to.

This processing order may not be appropriate in some cases. For example, when you don't want applications that have been assigned or published to the users in their organizational unit to be installed when the user is logged on to a computer in a specific organizational unit. With the Group Policy loopback support feature, you can specify two other ways to retrieve the list of GPOs for any user of the computers in this specific organizational unit:

- Merge Mode

  In this mode, when the user logs on, the user's list of GPOs is typically gathered by using the GetGPOList function. The GetGPOList function is then called again by using the computer's location in Active Directory. The list of GPOs for the computer is then added to the end of the GPOs for the user. It causes the computer's GPOs to have higher precedence than the user's GPOs. In this example, the list of GPOs for the computer is added to the user's list.

- Replace Mode

  In this mode, the user's list of GPOs isn't gathered. Only the list of GPOs based on the computer object is used.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
