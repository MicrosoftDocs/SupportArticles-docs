---
title: Fair Share technologies are enabled by default in Remote Desktop Services
description: Describes how an RDSH server uses Fair Share technology to balance CPU, disk, and network bandwidth resources among multiple Remote Desktop sessions.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Fair Share technologies are enabled by default in Remote Desktop Services

_Original product version:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 4494631

## Summary

Remote Desktop Services (RDS) in Windows Server 2012 use Fair Share technology to manage resources. Fair Share technology for CPU resources was introduced in Windows Server 2008 R2. In Windows Server 2012, RDS builds on the Fair Share technology to add features for allocating network bandwidth and disk resources. Fair Share technologies are enabled by default, but you can disable them using Windows PowerShell and WMI. For more information about the related properties in WMI, see [Win32_TerminalServiceSetting class: Properties](https://docs.microsoft.com/windows/desktop/termserv/win32-terminalservicesetting#properties).

## More information

### Fair Share CPU Scheduling 

Fair Share CPU Scheduling dynamically distributes processor time across all Remote Desktop Services sessions on the same RD Session Host server, based on the number of sessions and the demand for processor time within each session. This process creates a consistent user experience across all of the active sessions, while sessions are being created and deleted dynamically. This feature builds on the Dynamic Fair Share Scheduling technology (DFSS) that was part of Windows Server 2008 R2. 

### Dynamic Disk Fair Share 

When disk-intensive processes run in one or more Remote Desktop sessions, they can starve non-disk intensive processes and prevent them from ever accessing disk resources. To fix this issue, the Dynamic Disk Fair Share feature balances disk access among the different sessions by balancing disk IO and throttling excess disk usage. 

### Dynamic Network Fair Share 

When bandwidth-intensive applications run in one or more Remote Desktop sessions, they can starve applications in other sessions of bandwidth. T o equalize network consumption among the sessions, the Network Fair Share feature uses a round-robin approach to allocate bandwith for each session. 
 In a centralized computing scenario, the Dynamic Network Fair Share feature tries to fairly distribute network interface bandwidth load among the sessions.
