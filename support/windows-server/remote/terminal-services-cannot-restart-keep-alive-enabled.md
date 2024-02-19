---
title: Remote Desktop Service can't be restarted if Keep-Alive feature is enabled
description: Discusses an issue where you can't restart the Remote Desktop Services (Terminal Services) if Keep-Alive is enabled.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: sashalon, kaushika
ms.custom: sap:administration, csstroubleshoot
---
# Remote Desktop Service can't be restarted if Keep-Alive feature is enabled

This article provides a solution to an issue where you can't restart the Remote Desktop Services (Terminal Services) if Keep-Alive is enabled.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2507353

## Symptoms

If the RDP Keep-Alive feature is enabled on a Windows Server 2008 (or Windows Server 2008 R2) server, manually stopping the Remote Desktop Services service (Windows Server 2008 R2) or Terminal Services service (Windows Server 2008) will leave the server in an unstable state: restarting the service won't re-enable RDP functionality, and the server will hang during shutdown.

## Cause

The keep-alive thread is started by the Remote Desktop Services (Terminal Services) service if Keep-Alive is enabled, however it runs in Kernel mode and therefore can't be ended automatically when the service stops.

## Resolution

Don't attempt to stop or restart the Remote Desktop Services (Terminal Services) service if the RDP keep-alive mechanism is enabled.

## More information

When Keep-Alive is enabled and the Remote Desktop Services (Terminal Services) service is stopped, its svchost.exe process will remain in the Task list, even though the service is reported to have stopped correctly. When the service is started again, a new svchost.exe will be started however the server won't accept incoming RDP connections because of inconsistency in the TermDD driver state.

The Keep-Alive feature can be enabled by Group Policy:

- Windows Server 2008 R2

    Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections

    Configure Keep-Alive Connection Interval

- Windows Server 2008

    Computer Configuration\\Administrative Templates\\Windows Components\\Terminal Services\\Terminal Server\\Connections

    Configure Keep-Alive Connection Interval

To configure directly in the registry:

```registry
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server]
"KeepAliveInterval"=dword:00000001
"KeepAliveEnable"=dword:00000001
```
