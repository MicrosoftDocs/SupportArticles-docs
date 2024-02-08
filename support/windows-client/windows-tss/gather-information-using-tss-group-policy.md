---
title: Gather information by using TSS for Group Policy issues
description: Introduces how to gather information by using the TroubleShootingScript (TSS) toolset for Group Policy issues.
ms.date: 07/13/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:windows-tss-ds, csstroubleshoot
ms.subservice: windows-troubleshooter
---
# Gather information by using TSS for Group Policy issues

This article introduces how to gather information by using the TroubleShootingScript (TSS) toolset for Group Policy issues.

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
    .\TSS.ps1 -Scenario -ADS_GPedit -ADS_GPmgmt -ADS_GPO -ADS_GPsvc -GPresult Both
    ```

4. Enter *A* for "Yes to All" for the execution policy change.

> [!NOTE]
>
> - The traces are stored in a compressed file in the *C:\\MS_DATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.
> - If you've downloaded this tool previously, we recommend downloading the latest version. It doesn't automatically update when running.
