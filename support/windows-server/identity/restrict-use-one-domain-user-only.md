---
title: Restrict use of a computer to one domain user only
description: Describes how to restrict use of a computer to one domain user only.
ms.date: 11/08/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to restrict use of a computer to one domain user only

This article describes how to restrict use of a computer to one domain user only.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 555317

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Symptoms

When you create trust connection/s from one domain(forest) to another, users have the option to sign in different domain/s than their home domain (The domain that host their account/s).

## Cause

Trust connection/s from one domain to another or/and one forest to another enable user to log in different domain/s than their home domain (The domain that host their account/s).
The "Authenticated Users" group on each computer allow users from trusted domain to be authenticated and logon to computer.

## Resolution

### Option A: Domain-Wide Policy  

By using group policy capabilities in Windows 2000/2003 Domain, you can prevent from user/s to sign in to different domain/s than their home domain.

   1. Create a new domain-wide GPO and enable "Deny logon locally" user right to the source domain user account/sIn the target domain.  

      > [!NOTE]
      > Some services (Like Backup software services) may effect by this policy, and wouldn't function.
       To eliminate future problems, apply this policy and use GPO security filter feature.

       Deny logon locally

       Filter using security groups

   2. Run on `Gpupdate /force` on the domain controller.

### Option B: Remove "NT AUTHORITY\Authenticated Users" uses from the list of users group  

To eliminate the option of logging in one or few computers, follow the instructions bellow:

   1. Right-click "**My Computer**" icon on the desktop.

   2. Choose on "**Manage**".

   3. Extract "**Local Users and Groups**".

   4. Select on "**Groups**".

   5. On the right side of the screen, double-click "**Users**" group.

   6. Remove: "**NT** **AUTHORITY\Authenticated Users**" from the list.

   7. Add the require user/s or and group/s to the "**Users**" local group.

### Option C: Configure "Deny logon locally" user right on the local computer/s  

To eliminate the option of logging on one or few computers, follow the instructions bellow:

   1. Go to "**Start**" -> "**Run**".

   2. Write "**Gpedit.msc**"

   3. Enable "**Deny logon locally**" user right to the source domain user accounts.

      > [!NOTE]
      > Some services (Like Backup software services) may effect by this policy, and wouldn't function.

      Deny logon locally

   4. Run `Gpupdate /force` on the local computer.

### Option D: Use Selective Authentication when use Forest Trust  
  
   Creating Forest Trusts
  
## More information  

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
