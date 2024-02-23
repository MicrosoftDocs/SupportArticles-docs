---
title: Performance issues when you connect to Exchange
description: Resolves an issue in which the CPU or memory usage on the Exchange server is high for some services. This issue occurs if Exchange Server 2013 is installed in Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: charw, marcn, genli, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Windows Server 2012 R2
  - Windows Server 2012
  - Windows Server 2008
  - Exchange Server 2013
ms.date: 01/24/2024
---
# Performance issues or delays when you connect to Exchange Server 2013 that is running in Windows Server

_Original KB number:_ &nbsp; 2995145

## Symptoms

When you connect to an Exchange Server 2013 server that is installed in Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008 in which .NET Framework 4.5 is included, you may experience delays to access email messages or disconnections to the Exchange server. When this issue occurs, the CPU or memory usage on the server is high for some services that include one or more of the W3wp.exe processes.

## Cause

This issue occurs because too many objects are pinned on the .NET Framework 4.5 garbage collector heap. It causes heap fragmentation in addition to an increase in CPU and memory usage by the garbage collector.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

Install the [.NET Framework 4.5.2](https://www.microsoft.com/download/details.aspx?id=42643).

By using this method, you don't have to install hotfix 2803755 or add other registry keys.

### Method 2

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.  

- For Exchange Server 2013 that is installed in Windows Server 2012

  Apply hotfix 2803755 that needs a restart, and then use one of the following methods to enable the hotfix:

  - Create the `COMPLUS_DisableRetStructPinning` environment variable, and set the value of the variable to **1**.
  - Create a DWORD value of the `DisableRetStructPinning` entry at the following registry subkey, and set the DWORD value to 1:
  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework`

  Then, restart the computer.  

- For Exchange Server 2013 that is installed in Windows Server 2012 R2

  Use one of the following methods:

  - Create the `COMPLUS_DisableRetStructPinning` environment variable, and set the value of the variable to **1**.
  - Create a DWORDvalue of the `DisableRetStructPinning` entry at the following registry subkey, and set the DWORD value to **1**:
  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework`

  Then, restart the computer.  

- For Exchange Server 2013 that is installed in Windows Server 2008 R2 or Windows Server 2008

   Apply hotfix 2803754 that needs a restart, and then use one of the following methods to enable the hotfix:
  
  - Create the `COMPLUS_DisableRetStructPinning` environment variable, and set the value of the variable to **1**.
  - Create a DWORD value of the `DisableRetStructPinning` entry at the following registry subkey, and set the DWORD value to **1**:

     `HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework`

     Then, restart the computer.  

## Status

Microsoft has confirmed that this is a problem.

## More information

By default, Exchange Server 2013 collects performance monitor data, and then stores the data in the following location: `C:\Program Files\Microsoft\Exchange Server\V15\Logging\Diagnostics\DailyPerformanceLogs`.

Performance monitor can be used to determine whether there are issues with .Net in garbage collector counter. To do this, follow these steps:

1. Open a log that is in relation to the performance issue, and then add the **.NET CLR Memory - % Time in GC** counter.
2. Add the following instances in the **Instances of selected object** field:

   - Microsoft.Exchange.RpcClientAccess.Service
   - W3wp and all remaining W3wp processes

The average of these counters shouldn't exceed 10.
