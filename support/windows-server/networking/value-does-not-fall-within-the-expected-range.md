---
title: Error (Value does not fall within the expected range) when changing a DFS replication group or namespace
description: Fixes an issue in which you can't add members to a DFS replication group or namespace after you install the .NET Framework 4.7.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, takondo, fanx
ms.custom: sap:dfsr, csstroubleshoot
ms.technology: networking
---
# Error "Value does not fall within the expected range" when changing a DFS replication group or namespace in Windows Server 2016 or Windows Server 2012 R2

This article provides help to solve an issue where you can't add members to a Distributed File System (DFS) replication group or namespace after you install the Microsoft .NET Framework 4.7.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4049095

## Symptoms

You install the .NET Framework 4.7 on a computer that has Windows Server 2016 or Windows Server 2012 R2 installed. When you try to do one of the following operations in the DFS Management console, you receive a "Value does not fall within the expected range." error message:

- Create a new replication group and add (select **Add**) servers to the new replication group.
- Add a new member to an existing replication group and search (select **Browse**) for a server that you want to add.
- Create or edit a new namespace and search (select **Browse**) for a server that you want to add.

> [!NOTE]
> This issue also occurs when your computer contains the CLR.dll version 4.7.2102.0, even if you have not installed the .NET Framework 4.7.

## Resolution

To fix this issue, install the following cumulative updates or later cumulative updates.

- Windows Server 2012 R2: [February 22, 2018-KB4075212 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4075212)
- Windows Server 2016: [February 22, 2018-KB4077525 (OS Build 14393.2097)](https://support.microsoft.com/help/4077525)

## Workaround

To work around this issue, use one of the following methods:

- Use PowerShell cmdlets or command-line tools (dfsutil.exe or dfsradmin.exe) instead of the DFS Management console.
- Type the fully qualified domain name (FQDN) of a server that you want to add instead of searching for the server.

    > [!NOTE]
    > This method does not work for a newly created replication group.
- Uninstall the .NET Framework 4.7.
