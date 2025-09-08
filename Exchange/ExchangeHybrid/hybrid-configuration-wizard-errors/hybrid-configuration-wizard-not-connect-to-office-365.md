---
title: Hybrid Configuration wizard doesn't connect to Office 365
description: Describes an issue in which the Hybrid Configuration wizard doesn't connect to Office 365 and provides a resolution to fix the issue.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 165936
ms.reviewer: igserr, janogu, ninob, kaushika, meerak, v-trisshores
appliesto: 
  - Exchange Server
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Hybrid Configuration wizard doesn't connect to Office 365

## Symptoms

When you run the Hybrid Configuration wizard (HCW) and try to connect to the Office 365 endpoint, you receive the following error message:

> Connecting to remote server failed with the following error message: Connecting to remote server outlook.office365.com failed with the following error message: The server certificate on the destination computer (outlook.office365.com:443) has the following errors: Encountered an internal error in the SSL library. For more information, see the about_Remote_Troubleshooting Help topic.

The following screenshot shows the error message in the HCW.

:::image type="content" source="./media/hybrid-configuration-wizard-not-connect-to-office-365/hybrid-configuration-wizard-connection-error.png" border="true" alt-text="Screenshot of the error message in the Gathering Configuration Information view of Hybrid Configuration wizard.":::

## Cause

[Office 365 supports only TLS 1.2 connections](/microsoft-365/compliance/tls-1.0-and-1.1-deprecation-for-office-365). Therefore, the Windows system that runs HCW must have TLS 1.2 enabled in the [WinHTTP](/windows/win32/winhttp/about-winhttp) component and at the operating system (OS) level. The following table shows TLS 1.2 support in different Windows systems.

| Windows OS | TLS 1.2 in OS | TLS 1.2 in WinHTTP |
|-|-|-|
| Windows Server 2008 R2, Windows 7 | Disabled by default | Disabled by default |
| Windows Server 2012 | Enabled by default | Disabled by default |
| Windows Server 2012 R2, Windows 8.1, and later | Enabled by default | Enabled by default  |

## Resolution

For Windows Server 2012 R2, Windows 8.1, and later systems, check whether a custom policy has disabled TLS 1.2 in the WinHTTP component or at the OS level.

For earlier Windows systems, refer to the preceding table to determine whether you have to enable TLS 1.2 at the OS level or only in the WinHTTP component.

To enable TLS 1.2 in the WinHTTP component, follow these steps:

1. For Windows Server 2012, Windows Server 2008 R2, and Windows 7, make sure that [update 3140245](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392) is installed.

1. Add a registry key to enable TLS 1.2 in the WinHTTP component:

    [!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

    1. Run regedit.

    1. Navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp`.

    1. Add a DWORD entry that's named `DefaultSecureProtocols`. To enable TLS 1.2, set the DWORD value to `0x00000800` (hexadecimal) or `2048` (decimal). Or, to enable TLS 1.2, TLS 1.1, and TLS 1.0, set the DWORD value to `0x00000A80` (hexadecimal) or `2688` (decimal).

    1. On x64-based computers, also add the `DefaultSecureProtocols` entry (use the same value for `DefaultSecureProtocols` as in the previous step) to the `Wow6432Node` path: `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp`.

To enable TLS 1.2 at the OS level, follow the procedures that are described in [Enabling TLS 1.2](/exchange/exchange-tls-configuration#enabling-tls-12).

Additionally, run `inetcpl.cpl` to make sure that TLS 1.2 is enabled on the **Advanced** tab of **Internet Options**, as shown in the following screenshot.

:::image type="content" source="./media/hybrid-configuration-wizard-not-connect-to-office-365/internet-options-2012.png" border="true" alt-text="Screenshot of the TLS 1.2 option enabled in the Internet Options window.":::

## More information

The HCW returns an error message if the [New-PSSession](/powershell/module/microsoft.powershell.core/new-pssession) cmdlet can't connect to the `outlook.office365.com` endpoint. The `New-PSSession` cmdlet uses WinHTTP to make the connection. The error occurs if TLS 1.2 isn't enabled in the WinHTTP component. You can reproduce the error by using the HCW Diagnostic Tools. In HCW, press **F12** to open the Diagnostic Tools pane, and then select the **Open Exchange Online PowerShell** option.

:::image type="content" source="./media/hybrid-configuration-wizard-not-connect-to-office-365/hybrid-configuration-wizard-diagnostics.png" border="true" alt-text="Screenshot of the Open Exchange Online PowerShell option in the Diagnostic Tools pane of HCW." lightbox="./media/hybrid-configuration-wizard-not-connect-to-office-365/hybrid-configuration-wizard-diagnostics-lrg.png":::

You receive the following error message.

:::image type="content" source="./media/hybrid-configuration-wizard-not-connect-to-office-365/winhttp-shell.png" border="true" alt-text="Screenshot of the PSSession error message in the Exchange Online PowerShell window." lightbox="./media/hybrid-configuration-wizard-not-connect-to-office-365/winhttp-shell-lrg.png":::

If the WinHTTP component has only TLS 1.0 or TLS 1.1 enabled, `New-PSSession` won't connect to the Office 365 endpoint or any other endpoint that has only TLS 1.2 enabled. You can use [netsh](/windows-server/networking/technologies/netsh/netsh) to determine the TLS version that's used by WinHTTP:

1. Open an elevated Command Prompt window.

1. Enable WinHTTP logging by running `netsh winhttp set tracing level=verbose format=hex output=file max-trace-file-size=512000 state=enabled`.

1. Start a trace session by running `netsh trace start scenario=InternetClient`.

1. Open HCW, and try to connect to the Office 365 endpoint.

1. Stop the trace session by running `netsh trace stop`. By default, the trace process saves the trace file to _%LOCALAPPDATA%\Temp\NetTraces\NetTrace.etl_.

1. Use [NetworkMonitor](/windows/win32/ndf/using-network-monitor-to-view-etl-files) to open the trace file, and then filter on `description.contains("EnabledProtocols")` to view the enabled protocols, as follows.

    :::image type="content" source="./media/hybrid-configuration-wizard-not-connect-to-office-365/network-monitor.png" border="true" alt-text="Screenshot of netsh trace output in NetworkMonitor for a search filter that specifies EnabledProtocols in the description field." lightbox="./media/hybrid-configuration-wizard-not-connect-to-office-365/network-monitor-lrg.png":::
