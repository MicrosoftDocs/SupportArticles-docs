---
title: Database switchover causes an ExAssertException error
description: Provides a resolution for an issue in which a database switchover fails and the Exchange Information Store service (MSExchangeIS) logs an ExAssertException error for StoreCommonServices.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - CI 183142
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 11/29/2023
---

# Database switchover causes an ExAssertException error

## Symptoms

When you initiate a [database switchover](/exchange/high-availability/manage-ha/switchovers-and-failovers#database-switchovers), the switchover fails and generates event log entries that resemble the following entries.

### Event entry 1

```output
ID: "1001"
Level: "Error"
Source: "MSExchangeIS"
Message: "Microsoft Exchange Server Information Store has encountered an internal logic error. Internal error 
text is (ProcessId perf counter (0) does not match actual process id (34864).) with a call stack of (at 
Microsoft.Exchange.Server.Storage.Common.ErrorHelper.AssertRetail(Boolean assertCondition, String message) at 
Microsoft.Exchange.Server.Storage.Common.Globals.AssertRetail(Boolean assertCondition, String message) at 
Microsoft.Exchange.Server.Storage.StoreCommonServices.PerformanceCounterFactory.CreateDatabaseInstance(StoreDatabase 
database)"
```

### Event entry 2

```output
ID: "1002"
Level: "Error"
Source: "MSExchangeIS"
Message: "Unhandled exception (Microsoft.Exchange.Diagnostics.ExAssertException: ASSERT: ProcessId perf counter (0) 
does not match actual process id (34864) at Microsoft.Exchange.Diagnostics.ExAssert.AssertInternal(String formatString, 
Object[] parameters) at Microsoft.Exchange.Server.Storage.Common.ErrorHelper.AssertRetail(Boolean assertCondition, String 
message) at Microsoft.Exchange.Server.Storage.Common.Globals.AssertRetail(Boolean assertCondition, String message) at 
Microsoft.Exchange.Server.Storage.StoreCommonServices.PerformanceCounterFactory.CreateDatabaseInstance(StoreDatabase database)"
```

### Event entry 3

```output
ID: "4999"
Level: "Error"
Source: "MSExchange Common"
Message: "Watson report about to be sent for process id: <process ID>, with parameters: E12, c-RTL-AMD64, 
15.01.2375.031, M.E.Store.Worker, M.E.S.Storage.StoreCommonServices, 
M.E.S.S.S.PerformanceCounterFactory.CreateDatabaseInstance, M.E.Diagnostics.ExAssertException, 
6c3-dumptidset, 15.01.2375.031."
```

## Cause

The default size of the page file for the performance counters is insufficient. The Microsoft Exchange Information Store service (MSExchangeIS) sets the default size of the page file.

## Resolution

To fix the issue, increase the size of the page file for the performance counters. Follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For protection, back up the registry before you modify it so that you can restore it if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Run regedit.

2. Delete the following registry subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSExchangeIS\<server name>-NonReplicated`

3. (Optional) If another Exchange server that doesn't have the issue is available, copy the *MSExchangeISStorePerfCounters.xml* file from that server to the affected server. The file is in the *%ExchangeInstallPath%Setup\Perf* folder.

4. Increase the size of the page file for the performance counters by running the following PowerShell commands to update the registry:

   ```powershell
   Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Setup
   New-PerfCounters -DefinitionFileName "$env:exchangeinstallpath\Setup\Perf\MSExchangeISStorePerfCounters.xml" -FileMappingSize 10485760
   ```

5. Verify that the `FileMappingSize` registry value under the following registry subkey matches the updated size of the page file:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSExchangeIS Store\Performance`

6. Restart the server.
