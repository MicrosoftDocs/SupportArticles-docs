---
title: Gather information by using TSSv2 for Windows troubleshooting
description: Introduces how to gather information by using the TroubleShootingScript Version 2 (TSSv2) toolset for Windows troubleshooting.
ms.date: 05/11/2023
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, warrenw
ms.custom: sap:windows-troubleshooters, csstroubleshoot
ms.technology: windows-client-troubleshooter
---
# Gather information by using TSSv2 for Windows troubleshooting

This article introduces how to gather information by using the TroubleShootingScript Version 2 (TSSv2) toolset for Windows troubleshooting.

Before contacting Microsoft support, you can gather information about your issue.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSSv2)](introduction-to-troubleshootingscript-toolset-tssv2.md#prerequisites) for prerequisites for the toolset to run properly.

## Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) and extract it in the *C:\\tss_tool* folder. If you've downloaded this tool previously, we recommend downloading the latest version. It doesn't automatically update when running.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
    > [!NOTE]
    > Don't use the Windows PowerShell Integrated Scripting Environment (ISE).
3. Run the following cmdlet:

    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

    Enter A for "Yes to All" for the execution policy change.

Then, run the cmdlets that are listed in the following table according to your issue. The traces are stored in a compressed file in the *C:\\MSDATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.

|Issues  |Cmdlet(s)  |
|---------|---------|
|Remote Desktop session issues     |.\TSSv2.ps1 -Start -Scenario UEX_General -UEX_Auth -UEX_Logon         |
|Terminal Server licensing issues     |.\TSSv2.ps1 -Start -UEX_RDS -Netsh -UEX_Logon -UEX_EVT -UEX_Auth -UEX_WMI -UEX_WinRM         |
|Remote Desktop Session (RDS) session connectivity issues     |.\TSSv2.ps1 -Start -UEX_RDS -Netsh -UEX_Logon -UEX_EVT -UEX_Auth         |
|Printing issues     |.\TSSv2.ps1 -start -UEX_Print -Procmon -netsh -PSR         |
|Remote Desktop disconnection issues     |.\TSSv2.ps1 -CollectLog UEX_EventLog
.\TSSv2.ps1 -Start -Scenario UEX_General|
|Remote Desktop connection configuration issues     |.\TSSv2.ps1 -Start -Scenario UEX_ServerManager -UEX_WMI -UEX_RDS -UEX_ServerManager -UEX_WinRM         |
|WMI issues (with high CPU usage)     |.\TSSv2.ps1 -Scenario UEX_WMIHighCPU         |
|WMI issues (without high CPU usage)     |.\TSSv2.ps1 -Scenario UEX_WMI         |
|Remote Desktop Client connection issues     |.\TSSV2 -CollectLog -UEX_Basic -UEX_RDS -UEX_WinRM -UEX_WMI         |
|WinRM issues     |.\TSSv2.ps1 -scenario UEX_WinRM         |
|PowerShell issues     |```powershell
.\TSSv2.ps1 -Collectlog NET_PowerShell
```<br>.\TSSv2.ps1  -scenario UEX_PowerShell|
