---
title: Gather information by using TSS for user experience-related issues
description: Introduces how to gather information by using the TroubleShootingScript (TSS) toolset for user experience-related issues.
ms.date: 07/13/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:windows-tss-uex, csstroubleshoot
ms.technology: windows-client-troubleshooter
---
# Gather information by using TSS for user experience-related issues

This article introduces how to gather information by using the TroubleShootingScript (TSS) toolset for user experience-related issues.

Before contacting Microsoft support, you can gather information about your issue.

## Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for prerequisites for the toolset to run properly.

## Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) and extract it in the *C:\\tss* folder. If you've downloaded this tool previously, we recommend downloading the latest version. It doesn't automatically update when running.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
    > [!NOTE]
    > Don't use the Windows PowerShell Integrated Scripting Environment (ISE).
3. Run the following cmdlet and enter *A* for "Yes to All" for the execution policy change.

    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

Then, run the cmdlets that are listed in the following table according to your issue. The traces are stored in a compressed file in the *C:\\MS_DATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.

|Issues  |Cmdlet(s)  |
|---------|---------|
|<a id="remote-desktop-session"></a>Remote Desktop session issues     |`.\TSS.ps1 -Scenario UEX_General -UEX_Auth -UEX_Logon`         |
|<a id="terminal-server-licensing"></a>Terminal Server licensing issues     |`.\TSS.ps1 -UEX_RDS -Netsh -UEX_Logon -UEX_EVT -UEX_Auth -UEX_WMI -UEX_WinRM`         |
|<a id="remote-desktop-session-connectivity"></a>Remote Desktop Session (RDS) connectivity issues     |`.\TSS.ps1 -UEX_RDS -Netsh -UEX_Logon -UEX_EVT -UEX_Auth`         |
|<a id="printing"></a>Printing issues     |`.\TSS.ps1 -UEX_Print -Procmon -Netsh -PSR`         |
|<a id="remote-desktop-disconnection"></a>Remote Desktop disconnection issues     |`.\TSS.ps1 -CollectLog UEX_EventLog`<br>`.\TSS.ps1 -Scenario UEX_General`|
|<a id="remote-desktop-disconnection-configuration"></a>Remote Desktop connection configuration issues     |`.\TSS.ps1 -Scenario UEX_ServerManager -UEX_WMI -UEX_RDS -UEX_ServerManager -UEX_WinRM`         |
|<a id="wmi"></a>WMI issues     |`.\TSS.ps1 -Scenario UEX_WMIHighCPU` (with high CPU usage)<br>`.\TSS.ps1 -Scenario UEX_WMI` (without high CPU usage)         |
|<a id="remote-desktop-client-connection"></a>Remote Desktop Client connection issues     |`.\TSS.ps1 -CollectLog -UEX_Basic -UEX_RDS -UEX_WinRM -UEX_WMI`         |
|<a id="winrm"></a>WinRM issues     |`.\TSS.ps1 -Scenario UEX_WinRM`         |
|<a id="powershell"></a>PowerShell issues     |`.\TSS.ps1 -Collectlog NET_PowerShell`<br>`.\TSS.ps1 -Scenario UEX_PowerShell`|
