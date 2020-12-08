---
title: 
description: Fixes an issue in which you can't add members to a DFS replication group or namespace after you install the .NET Framework 4.7.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# "Value does not fall within the expected range" error when changing a DFS replication group or namespace in Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012

_Original product version:_ &nbsp; Windows Server 2016, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Foundation, Windows Server 2012 Datacenter, Windows Server 2012 Foundation, Windows Server 2012 Standard  
_Original KB number:_ &nbsp; 4049095

## Symptoms

You install the .NET Framework 4.7 on a computer that has Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012 installed. When you try to do one of the following operations in the Distributed File System (DFS) Management console, you receive a "Value does not fall within the expected range." error message:
- Create a new replication group and add (select **Add**) servers to the new replication group.
- Add a new member to an existing replication group and search (select **Browse**) for a server that you want to add.
- Create or edit a new namespace and search (select **Browse**) for a server that you want to add.
 **Note** This issue also occurs when your computer contains the CLR.dll version 4.7.2102.0, even if you have not installed the .NET Framework 4.7.

## Resolution

To fix this issue, install the following cumulative updates or later cumulative updates. 
- 
 Windows Server 2012 R2:
 [February 22, 2018-KB4075212 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4075212) 
- 
 Windows Server 2016:
 [February 22, 2018-KB4077525 (OS Build 14393.2097)](https://support.microsoft.com/help/4077525) 

## Workaround

To work around this issue, use one of the following methods:
- Use PowerShell cmdlets or command-line tools (dfsutil.exe or dfsradmin.exe) instead of the DFS Management console.
- Type the fully qualified domain name (FQDN) of a server that you want to add instead of searching for the server.

**Note** This method does not work for a newly created replication group.
- Uninstall the .NET Framework 4.7.
