---
title: Gather information by using TSS for Windows failover cluster related issues
description: Introduces how to gather information by using TSS for Windows failover cluster related issues.
ms.date: 03/05/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:windows-tss-sha, csstroubleshoot
---
# Gather information by using TSS for Windows failover cluster related issues

This article introduces how to gather information by using the TroubleShootingScript (TSS) toolset for Windows failover cluster related issues.

Before contacting Microsoft support, you can gather information about your issue.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) and extract it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.  
    > [!NOTE]
    > Don't use the Windows PowerShell Integrated Scripting Environment (ISE).
3. Run the following cmdlets:

    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

    ```powershell
    .\TSS.ps1 -SDP Cluster
    ```

4. Enter *A* for "Yes to All" for the execution policy change.

> [!NOTE]
>
> - The time to collect this script on a given system may vary. It depends on system speed, system size, the number of virtual machines, the amount of data in logs, and so on. Depending on these factors, the average collection time is between 30 and 90 minutes, or even longer, especially if no skip commands are used.
> - The collection is stored in a compressed file in the *C:\\MS_DATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.

## Optional parameters

Some parameters are optional to perform a quicker and more streamlined collection, which may help the script finish successfully if a certain section stops responding.

- This cmdlet skips running the Best Practices Analyzer and makes the collection faster.

    ```powershell
    .\TSS.ps1 -SDP Cluster -SkipSDPList skipBPA
    ```

- This cmdlet skips some small collection items that may fail in a regular collection and makes the script more reliable.

    ```powershell
    .\TSS.ps1 -SDP Cluster -SkipSDPList skipHang
    ```

- This cmdlet skips some additional collection parameters that may not be needed.

    ```powershell
    .\TSS.ps1 -SDP Cluster -SkipSDPList skipTS
    ```

- This cmdlet skips testing Server Message Block (SMB) connectivity to any Cluster Shared Volumes (CSVs) in the failover cluster.

    ```powershell
    .\TSS.ps1 -SDP Cluster -SkipSDPList skipCsvSMB
    ```

> [!NOTE]
> You can combine multiple skip parameters with comma-separated items, such as the following example: 
>  
> ```powershell
> .\TSS.ps1 -SDP Cluster -SkipSDPList skipBPA,skipHang,skipTS,skipCsvSMB
> ```
