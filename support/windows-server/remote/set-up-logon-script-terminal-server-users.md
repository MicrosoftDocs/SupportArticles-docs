---
title: Set up logon script only for Terminal Server users
description: Describes how to set up a logon script only for Terminal Server users.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# How to set up a logon script only for Terminal Server users

This article provides the steps to set up a logon script only for Terminal Server users.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 195461

> [!IMPORTANT]
> This article contains information about editing the registry. Before you edit the registry, make sure you understand how to restore it if a problem occurs. For information about how to do this, view the "Restoring the Registry" Help topic in Regedit.exe or the "Restoring a Registry Key" Help topic in Regedt32.exe.

## Summary

You may want to have a logon script that only runs for users when they connect to a Terminal Server through the Terminal Server client or by the console.

Create your logon script and place it in the %SystemRoot%\System32 folder.  

> [!WARNING]
> Using Registry Editor incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems resulting from the incorrect use of Registry Editor can be solved. Use Registry Editor at your own risk.

For information about how to edit the registry, view the "Changing Keys And Values" Help topic in Registry Editor (Regedit.exe) or the "Add and Delete Information in the Registry" and "Edit Registry Data" Help topics in Regedt32.exe. You should back up the registry before you edit it. If you are running Windows NT, you should also update your Emergency Repair Disk (ERD).

1. Run Regedt32.exe and go to the following value:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion
    \Winlogon\Appsetup`

2. After the last entry in the Appsetup value, place a comma and a space and then enter the name and extension of the logon script you placed in the %SystemRoot%\System32 folder. For example, if the value of Appsetup is:  
`Usrlogon.cmd, Rmvlinks.exe`

    After adding an entry for Termlogon.cmd, the value would look like:  
    `Usrlogon.cmd, Rmvlinks.exe, Termlogon.cmd`

Termlogon.cmd will now run every time a user logs into the Terminal Server.
