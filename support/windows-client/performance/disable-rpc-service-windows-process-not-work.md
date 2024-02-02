---
title: Windows procedures don't work without RPC service
description: Provides a solution to an issue where some Windows procedures don't work when the Remote Procedure Call (RPC) service is disabled.
ms.date: 10/20/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bhogen
ms.custom: sap:applications, csstroubleshoot
---
# Some Windows procedures don't work if the Remote Procedure Call service is disabled

This article provides a solution to an issue where some Windows procedures don't work when the Remote Procedure Call (RPC) service is disabled.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 830071

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Symptoms

When you restart your computer that runs Microsoft Windows NT 4.0, Microsoft Windows 2000, Microsoft Windows Server 2003, or Microsoft Windows XP, the following conditions may occur:

- You cannot move icons on the desktop.
- You cannot view event log entries.
- You can open the Services Microsoft Management Console (MMC), but you cannot see any services listed.

## Cause

This problem may occur if you disable the RPC service. Many Windows operating system procedures depend on the RPC service.

Microsoft recommends that you don't disable the RPC service.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

To resolve this problem, follow these steps:

1. Click **Start,** click **Run**, type *regedt32*, and then click **OK**.
2. Expand the registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RpcSs\`.
3. Double-click **Start**, type 2 in the **Edit DWORD Value** dialog box, and then click **OK**.
4. Close Registry Editor, and then restart your computer.

If your computer does not start correctly, you can use the Recovery Console to re-enable the RPC service. To use the Recovery Console, follow these steps:

1. Start your computer to the Recovery Console.
2. At the Recovery Console command prompt, type the `Enable RPCSS Service_Auto_Start` command, and then press ENTER.
3. At the Recovery Console command prompt, type `EXIT`, and then press ENTER.
4. Restart your computer.

## More information

The following services depend on the RPC service:

- Background Intelligent Transfer Service
- COM+ Event System
- Distributed Link Tacking Client
- Distributed Transaction Coordinator
- Fax Service
- Indexing Service
- IPSec Policy Agent
- Messenger
- Network Connections
- Print Spooler
- Protected Storage
- Removable Storage
- Routing Information Protocol (RIP) Listener
- Routing and Remote Access
- Task Scheduler
- Telephony
- Telnet
- Windows Installer
- Windows Management Instrumentation

## References

For more information about how to use the Recovery Console in Windows XP, in Windows 2000, or in Windows Server 2003, see [What are the system recovery options in Windows?](https://support.microsoft.com/windows/bd88ffdf-1e8e-34a0-d76f-39a71fb4ed4d) and [How To Use the Recovery Console on a Windows Server 2003-Based Computer That Does Not Start](https://support.microsoft.com/help/326215).
