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
.\TSS.ps1 -Scenario HyperV
```

### TSS cmdlet description

To gather information for Hyper-V related issues, follow these steps:

1.  Download the latest version of the TSS tool from the Microsoft website.
2.  Open an elevated PowerShell window.
3.  Navigate to the folder where the TSS tool is located.
4.  Run the command

#### Optional parameters

You can use the following optional parameters with the TSS tool. These optional parameters can perform a quicker and more streamlined collection, which may help the script finish successfully if a certain section stops responding.

- This cmdlet collect only the logs without running diagnostics.

    ```powershell
    .\TSS.ps1 -Scenario HyperV -CollectOnly
    ```

- This cmdlet prevents uploading the collected data to Microsoft.

    ```powershell
    .\TSS.ps1 -Scenario HyperV -NoUpload
    ```

- This cmdlet specifies the output folder for the collected data.

    ```powershell
    .\TSS.ps1 -Scenario HyperV -OutputPath <path>
    ```

> [!NOTE]
> The TSS tool may take several minutes to complete depending on the system configuration and the amount of data being collected.
> After the tool finishes running, it creates a compressed file (.zip) that contains all the collected information.
