---
title: How to track users logon/logoff
description: Describes how to track users logon/logoff.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# How to track users logon/logoff

This article describes how to track users logon/logoff.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 556015

This article was written by [Yuval Sinay](https://mvp.microsoft.com/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Summary

The following article will help you to track users logon/logoff.  

## Tips

### Option 1  

1. Enable Auditing on the domain level by using Group Policy:

   **Computer Configuration/Windows Settings/Security Settings/Local Policies/Audit Policy**  

   There are two types of auditing that address logging on, they are **Audit Logon Events** and **Audit Account Logon Events**.

   Audit "logon events" records logons on the PC(s) targeted by the policy and the results appear in the Security Log on that PC(s).

   Audit "Account Logon" Events tracks logons to the domain, and the results appear in the Security Log on domain controllers only.

2. Create a logon script on the required domain/OU/user account with the following content:

   `echo %date%,%time%,%computername%,%username%,%sessionname%,%logonserver% >>`

3. Create a logoff script on the required domain/OU/user account with the following content:

   `echo %date%,%time%,%computername%,%username%,%sessionname%,%logonserver% >>`

> [!Note]
> Please be aware that unauthorized users can change this scripts, due the requirement that the SHARENAME$ will be writeable by users.

### Option 2  

Use WMI/ADSI to query each domain controller for logon/logoff events.

[!INCLUDE [Community solutions content disclaimer](../../includes/community-solutions-content-disclaimer.md)]
