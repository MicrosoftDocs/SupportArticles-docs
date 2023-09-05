---
title: Trusted domains don't appear in Available List
description: Provides a solution to an issue where trusted domains don't appear in the Available List for domain logon or setting security permissions.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-and-forest-trusts, csstroubleshoot
ms.technology: windows-server-security
---
# Trusted domains don't appear in the Available List for domain logon or setting security permissions

This article provides a solution to an issue where trusted domains don't appear in the Available List for domain logon or setting security permissions.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 310611

## Symptoms

When logging on to a Windows 2000 domain, other trusted domains (for both Windows 2000 and Windows NT 4.0 domains) are not displayed in the drop-down list of available logon options, and the only domain logon option that is available is for the one to which you, the currently logged on user, belongs. Also, when trying to add or change security permissions by clicking Add on the Security tab, the current domain is the only domain choice that is displayed in the Look in window.

## Cause

This problem occurs because the Netlogon.ftl file may not have the proper permissions to open, and therefore the list of trusted domains can't be displayed. The file may also show that no permissions are set on it at all.

## Resolution

To resolve this problem, it's necessary to give both the System and the Administrators accounts full control on this file. To grant both accounts full control on this file, locate the %SystemRoot%\System32\Config\Netlogon.ftl file.

If the file doesn't have any permissions set on it, you may have to take ownership of the file to set these permissions. You may also have to log on to the system with administrator privileges to set these permissions if the user account with which are logged on doesn't have the necessary permissions.

To take ownership of this file, click Advanced, and then on the Owner tab, select an administrator account in the Change owner to list, and then click OK.

After setting the permissions on this file so that both the System and the Administrator accounts have full control, log off from and then back on to the computer to see that the list of trusted domains is displayed for both the Domain logon and when you attempt to set the security permissions.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
