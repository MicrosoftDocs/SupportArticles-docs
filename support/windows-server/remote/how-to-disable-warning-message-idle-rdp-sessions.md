---
title: How to disable warning message for idle remote desktop sessions
description: Provides the method to disable warning message for idle remote desktop sessions by using PowerShell.
ms.date: 09/24/2021
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, ishimada, v-lianna
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
ms.subservice: rds
---
# How to disable warning message for idle remote desktop sessions

_Applies to:_ &nbsp; Windows Servers

When a remote desktop session idle session limit is exceeded, a warning message is displayed and the session is disconnected after two minutes. If you want the session to be disconnected immediately and without a warning message, set the **EnableTimeoutWarning** property of the **Win32_TSSessionSettings** WMI class to **0** by using the following PowerShell cmdlet from an elevated PowerShell prompt (as an administrator):

> [!NOTE]
> This change takes effect only after active sessions are disconnected and reconnected.

```powershell
Set-WmiInstance -Path "\\localhost\root\CIMV2\TerminalServices:Win32_TSSessionSetting.TerminalName='RDP-Tcp'" -Argument @{EnableTimeoutWarning=0}
```

You can determine the [idle session limit](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754272(v=ws.11)) by using the following PowerShell cmdlet:

```powershell
Get-WmiObject -ComputerName localhost -Namespace root\CIMV2\TerminalServices -Class Win32_TSSessionSetting  -filter "TerminalName='RDP-Tcp'" | select IdleSessionLimit
```

> [!NOTE]
>
> - The **EnableTimeoutWarning** property has been deprecated for third-party protocol providers starting from Windows 10, version 2004 and Windows Server, version 2004. Contact the protocol provider for help to enable or disable the warning message.
> - If a third-party protocol provider is used, replace "RDP-Tcp" with the relevant protocol name for the provider.
> - If you're running the cmdlet remotely, make sure the server's firewall allows WMI access and replace "localhost" with the server's name.
