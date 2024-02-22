---
title: Event ID 106 Performance counter updating error after installing an Exchange Server 2013 CU
description: Resolve an issue that returns event ID 106 errors in the Application log after you install the Exchange Server 2013 Client Access server role.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: ccorp, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 106 errors after you install an Exchange Server 2013 cumulative update: Performance counter updating error

_Original KB number:_ &nbsp;2870416

## Symptoms

After you install the Microsoft Exchange Server 2013 Client Access server role on a new server and then restart the server, you receive many Event ID 106 errors in the Application log. For example, you may receive the following error message:

```console
ID: 106
Level: Error
Source: MSExchange Common
Machine: -
Message: Performance counter updating error. Counter name is Per-Tenant KeyToRemoveBudgets Cache Size, category name is MSExchangeRemotePowershell. Optional code: 3. Exception: The exception thrown is: System.InvalidOperationException: The requested Performance Counter is not a custom counter, it has to be initialized as ReadOnly.\
```

When you check the Exchange Setup log (ExchangeSetup.log), you see the following information:

> [WARNING] The performance counter definition file C:\Program Files\Microsoft\Exchange Server\V15\Bin\Perf\AMD64\GlsPerformanceCounters.xml could not be found.

## Cause

This issue occurs because the performance counters can't be loaded.

## Resolution

> [!NOTE]
> Although the following method resolves the issue, event ID 106 from MSExchange Common will never truly be eliminated from on-premises deployments because some counters are datacenter-only.

To resolve this issue, manually load the missing counters. To do this, follow these steps:

1. Close Performance Monitor, and then stop any other monitoring services that might be trying to use the missing counters.
2. In Exchange Management Shell, type the following command, and then press Enter:

    ```powershell
    Add-Pssnapin Microsoft.Exchange.Management.PowerShell.Setup
    ```  

3. Run `New-PerfCounters` to add the performance counters. For example, if you want to load the performance counters that are defined in GlsPerformanceCounters.xml, run the following cmdlet:

    ```powershell
    New-PerfCounters -definitionfilename "C:\Program Files\Microsoft\Exchange Server\V15\Setup\Perf\GlsPerformanceCounters.xml"
    ```
