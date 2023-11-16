---
title: Remote Desktop Licensing Service doesn't start
description: Resolves an issue where Remote Desktop Licensing Service fails to start with event ID 623.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, AJAYPS, BHASKARR
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
ms.technology: windows-server-rds
---
# Remote Desktop Licensing Service may not start and event ID 623 may be logged

This article provides a solution to an issue where Remote Desktop Licensing Service fails to start with event ID 623.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3167312

## Symptoms

Consider the following scenario:

- You have a Windows Server 2012 R2 with the Remote Desktop Licensing role installed.
- You restart your Windows Server 2012 R2 or restart the Remote Desktop Licensing Service.

In this scenario, the Remote Desktop Service may fail to start and event ID 623 similar to the below may be logged:

> Name: Application Name: Application  
Source: ESENT  
Event ID: 623  
Task Category: Transaction Manager  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: COMPUTERNAME  
Description:  
svchost (PID) The version store for this instance (0) has reached its maximum size of 2 Mb. It is likely that a long-running transaction is preventing cleanup of the version store and causing it to build up in size. Updates will be rejected until the long-running transaction has been committed or rolled back.

## Cause

This issue may occur if there is a large internal table in the Remote Desktop Licensing Service (RDLS) database.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

1. Start Registry Editor (Regedt32.exe).
2. Locate and click the following registry key:  
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\TermServLicensing\Parameters`
3. On the **Edit** menu, click **Add Value**, and then add the following registry value:
    - Value name: MaxVerPages
    - Data type: REG_DWORD
    - Radix: Decimal
    - Value data: 1024

    Range is from minimum 256 to maximum 2048.
4. Quit Registry Editor.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#terminal-server-licensing).
