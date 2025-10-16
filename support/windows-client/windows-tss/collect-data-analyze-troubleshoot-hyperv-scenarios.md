---
title: Collect data to analyze and troubleshoot Hyper-V scenarios
description: This article describes how to gather information by using the Microsoft Troubleshooting Support Script (TSS) for Hyper-V related issues.
ms.date: 10/16/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw
ms.custom: sap:Support Tools\TSS
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Collect data to analyze and troubleshoot Hyper-V scenarios

This article describes how to gather information by using the Microsoft Troubleshooting Support Script (TSS) for Hyper-V related issues.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Scenario: Virtualization and Hyper-V

### TSS cmdlet

```powershell
.\TSS.ps1 -SDP HyperV
```

### TSS cmdlet description

To gather information for Hyper-V related issues, follow these steps:

1. Download [TSS](https://aka.ms/getTSS) and extract it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.  
    > [!NOTE]
    > Don't use the Windows PowerShell Integrated Scripting Environment (ISE).
3. Run the following cmdlets:

    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

    ```powershell
    .\TSS.ps1 -SDP HyperV
    ```

4. Enter *A* for "Yes to All" for the execution policy change.

> [!NOTE]
>
> - The time to collect this script on a given system may vary. It depends on system speed, system size, the number of virtual machines, the amount of data in logs, and so on. Depending on these factors, the average collection time is between 30 and 90 minutes, or even longer, especially if no skip commands are used.
> - The collection is stored in a compressed file in the *C:\\MS_DATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.

#### Optional parameters

You can use the following optional parameters with the TSS tool. These optional parameters can perform a quicker and more streamlined collection, which may help the script finish successfully if a certain section stops responding.

- This cmdlet skips running the Best Practices Analyzer and makes the collection faster.

    ```powershell
    .\TSS.ps1 -SDP HyperV -SkipSDPList skipBPA
    ```

- This cmdlet skips some small collection items that may fail in a regular collection and makes the script more reliable.

    ```powershell
    .\TSS.ps1 -SDP HyperV -SkipSDPList skipHang
    ```

- This cmdlet skips some additional collection parameters that may not be needed.

    ```powershell
    .\TSS.ps1 -SDP HyperV -SkipSDPList skipTS
    ```

- This cmdlet skips testing Server Message Block (SMB) connectivity to any Cluster Shared Volumes (CSVs) in the failover cluster.

    ```powershell
    .\TSS.ps1 -SDP HyperV -SkipSDPList skipCsvSMB
    ```

- This cmdlet skips any data collection related to Hyper-V Replica data and slightly speeds up the collection process.

    ```powershell
    .\TSS.ps1 -SDP HyperV -SkipSDPList skipHVreplica
    ```

> [!NOTE]
> You can combine multiple skip parameters with comma-separated items, such as the following example:
>  
> ```powershell
> .\TSS.ps1 -SDP HyperV -SkipSDPList skipBPA,skipHang,skipTS,skipCsvSMB,skipHVreplica
> ```
