---
title: Remote Desktop IP Virtualization does not work
description: Discusses an issue in which Remote Desktop IP Virtualization does not work in Windows Server 2019.
ms.date: 12/07/2020
ms.prod-support-area-path:  Windows Servers/Windows Server 2019/Windows Server Standard 2019/Remote Desktop Services and Terminal Services
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Remote Desktop IP Virtualization does not work in Windows Server 2019

_Original product version:_ &nbsp; Windows Server 2019, all editions  
_Original KB number:_ &nbsp; 4501072

## More information

Remote Desktop IP Virtualization is currently not working in Windows Server 2019. We are investigating this issue.
Remote Desktop IP Virtualization was introduced in Windows Server 2008 R2. In Windows Server 2008, Terminal Server had a single IP address that was shared among all remote desktop users. This made the remote desktop experience different from that of regular desktops, and it introduced some application compatibility problems.
In Windows Server 2008 R2, Remote Desktop Session Host server, formerly known as Terminal Server, supported per-session and per-program Remote Desktop IP Virtualization for Winsock applications. This support was provided by assigning individual IP addresses to user sessions to avoid application incompatibility issues by simulating a single user desktop. This method continues to be used in the current version of Windows Server.
