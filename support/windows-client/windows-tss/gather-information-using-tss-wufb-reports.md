---
title: Collect Data to Analyze and Troubleshoot Windows Update for Business Reports Scenarios
description: Introduces how to gather information by using the TroubleShootingScript (TSS) toolset for Windows Update for Business reports-related issues.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Support Tools\TSS DnD, csstroubleshoot
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Collect data to analyze and troubleshoot Windows Update for Business Reports scenarios

This article introduces how to gather information by using the TroubleShootingScript (TSS) toolset for Windows Update for Business reports-related issues.

Before contacting Microsoft support, you can gather information about your issue.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](./introduction-to-troubleshootingscript-toolset-tss#prerequisites.md) for prerequisites for the toolset to run properly.

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
    .\TSS.ps1 -Collectlog DND_WUfBReport
    ```

4. Enter *A* for "Yes to All" for the execution policy change.

> [!NOTE]
>
> - The traces are stored in a compressed file in the *C:\\MS_DATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.
> - If you've downloaded this tool previously, we recommend downloading the latest version. It doesn't automatically update when running `-Collectlog DND_WUfBReport`.

