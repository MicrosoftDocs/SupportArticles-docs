---
title: System error 85 with NET USE command
description: This article helps fix the system error 85 that occurs when a non-administrative user attempts to reconnect to a shared network drive that the user has already used by using the net use command.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# System error 85 with the NET USE command

This article helps fix the system error 85 that occurs when a non-administrative user attempts to reconnect to a shared network drive that the user has already used by using the `net use` command.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 253821

## Symptoms

When a non-administrative user attempts to reconnect to a shared network drive that the user has already used, system error 85 (Local device name already in use) may be generated.

For example, running the following sequence of commands in a logon script or from a command prompt illustrates the issue:

```console
net use r: /d
net use r: \\servername\share
net use r: /d
net use r: \\servername\share
```

The behavior does not occur for users with administrative privileges.

## Cause

This behavior is caused by a setting of **1** in the following registry value:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SessionManager\ProtectionMode`

If the setting is **1**, the problem occurs. If you change the setting to **0** and reboot the server, the problem disappears.

> [!NOTE]
> We suggest changing this value to 1 to restrict changes to Base System objects and for solving problems with symbolic links.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Change the entry for `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SessionManager\ProtectionMode` from **1** to **0**.

> [!NOTE]
> If you are running a Windows Server 2003-based Terminal Server, set the `ProtectionMode` to a value of **1**. Error 85 translates to the following:  
> ERROR_ALREADY_ASSIGNED The local device name is already in use.
