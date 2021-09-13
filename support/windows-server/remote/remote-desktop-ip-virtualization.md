---
title: Remote Desktop IP Virtualization in Windows Server 2019
description: Remote Desktop IP Virtualization in Windows Server 2019.
ms.date: 09/09/2021
author: Deland-Han
ms.author: delhan 
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.prod-support-area-path: Remote desktop sessions
ms.technology: windows-server-rds
---
# Remote Desktop IP Virtualization in Windows Server 2019

This article discusses about Remote Desktop IP Virtualization in Windows Server 2019. 

If you want to use IP virtualization on Windows Server 2019, please follow these steps:

1. From an admin Windows PowerShell window, rename the following key: 
```powershell
Rename-Item HKLM:\SYSTEM\ControlSet001\Services\WinSock2\Parameters\AppId_Catalog\2C69D9F1 Backup_2C69D9F1
```
>[!NOTE]
>Deleting the key would achieve the same thing, but the rename provides a way to revert back more easily if desired. This is the data that is there by default:
>       
>HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WinSock2\Parameters\AppId_Catalog\2C69D9F1\
>AppFullPath: C:\Windows\System32\svchost.exe\
>PermittedLspCategories: 0x40000000

2. Restart the computer.

3. Enable the IP Virtualization feature by opening **gpedit.msc**, then going to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Application Compatibility**. Enable the **Turn on Remote Desktop IP Virtualization** policy.

4. Restart the computer.

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4501072

## More information

Remote Desktop IP Virtualization was introduced in Windows Server 2008 R2. In Windows Server 2008, Terminal Server had a single IP address that was shared among all remote desktop users. This made the remote desktop experience different from that of regular desktops, and it introduced some application compatibility problems.

In Windows Server 2008 R2, Remote Desktop Session Host server, formerly known as Terminal Server, supported per-session and per-program Remote Desktop IP Virtualization for Winsock applications. This support was provided by assigning individual IP addresses to user sessions to avoid application incompatibility issues by simulating a single user desktop. This method continues to be used in the current version of Windows Server.
