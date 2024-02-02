---
title: Cached domain logon information
description: This article describes how cached domain logon information works and how to control cached logon information.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
ms.subservice: user-profiles
---
# Cached domain logon information

This article describes how cached domain logon information works and how to control cached logon information.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 172931

## Summary

Windows caches previous users' logon information locally so that they can log on if a logon server is unavailable during later logon attempts.

If a domain controller is unavailable and a user's logon information is cached, the user will be prompted with a dialog that says:

> A domain controller for your domain could not be contacted. You have been logged on using cached account information. Changes to your profile since you last logged on may not be available.

With caching disabled, the user is prompted with this message:

> The system cannot log you on now because the domain <DOMAIN_NAME> is not available.

## More information

When you log on to Windows by using cached logon information, if the domain controller is unavailable to validate your account, you cannot access network resources that require domain validation. However, you can access network resources that do not require domain validation.

Through the Registry Editor or a Registry Console Tool (reg.exe), you can change the number of previous logon attempts that a server will cache. The valid range of values for this parameter is 0 to 50. A value of 0 turns off logon caching and any value above 50 will only cache 50 logon attempts. By default, all versions of Windows remember 10 cached logons except Windows Server 2008.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

For information about how to edit the registry, view the **Changing Keys And Values** online Help topic in Registry Editor (Regedit.exe) or the **Add and Delete Information in the Registry** and **Edit Registry Data** online Help topics in Regedt32.exe. You must back up the registry before you edit it.

Cached logon information is controlled by the following key:

- Location: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\`
- Value name: CachedLogonsCount
- Data type: REG_SZ
- Values: 0 - 50

Any changes you make to this key require that you restart the computer for the changes to take effect.
