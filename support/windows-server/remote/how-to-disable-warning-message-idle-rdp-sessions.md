---
title: How to disable warning message for idle remote desktop sessions
description: Provides the method to disable warning message for idle remote desktop sessions by using PowerShell.
ms.date: 4/30/2021
author: v-lianna 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ishimada
ms.prod-support-area-path: Remote desktop sessions
ms.technology: windows-server-rds
--- 
# How to disable warning message for idle remote desktop sessions

_Applies to:_ &nbsp;Windows Servers  

When a remote desktop session is idle and the idle session limit is exceeded, a warning message will be displayed and then the session will be disconnected in two minutes. If you don't want the message to be displayed and you want the session to be disconnected right away, you can set the **EnableTimeoutWarning** property of the **Win32_TSSessionSettings** WMI class to **0** by using the following PowerShell cmdlet from an elevated PowerShell prompt (as an administrator):

> [!NOTE]
> This change does not take effect for active sessions until they are disconnected and reconnected.

```powershell
Set-WmiInstance -Path "\\localhost\root\CIMV2\TerminalServices:Win32_TSSessionSetting.TerminalName='RDP-Tcp'" -Argument @{EnableTimeoutWarning=0}
```

You can determine the [idle session limit](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754272(v=ws.11)) by using the following PowerShell cmdlet:

```powershell
Get-WmiObject -ComputerName localhost -Namespace root\CIMV2\TerminalServices -Class Win32_TSSessionSetting  -filter "TerminalName = 'RDP-Tcp'" | select IdleSessionLimit
```

> [!NOTE]
>
> - Starting from Windows 10, version 2004 and Windows Server, version 2004, the **EnableTimeoutWarning** property is deprecated for third-party protocol providers. You can contact the vendor of the protocol provider for the mechanism to enable or disable the warning message.
> - If a third-party protocol provider is used, replace the "RDP-Tcp" with the appropriate protocol name for the provider.
> - If you run the cmdlet remotely, ensure the server firewall allow WMI access and replace the "localhost" with the server name.
