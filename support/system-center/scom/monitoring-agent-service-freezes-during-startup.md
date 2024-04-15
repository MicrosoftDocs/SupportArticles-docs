---
title: Microsoft Monitoring Agent service freezes during startup
description: Fixes an issue that causes the Microsoft Monitoring Agent service to hang in the Starting state.
ms.date: 04/15/2024
---
# Microsoft Monitoring Agent service freezes during the startup process

This article provides the steps to solve the issue that the **Microsoft Monitoring Agent** service gets stuck in the **Starting** state in Service Control Manager.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 3058405

## Symptoms

In System Center 2012 R2 Operations Manager (OpsMgr 2012 R2), the **Microsoft Monitoring Agent** service, also known as the health service, gets stuck in the **Starting** state in Service Control Manager. In this situation, you can't stop the service through Service Control Manager or by using a command prompt. If you manually end the Healthservice.exe process in Task Manager and then try to restart the service, the problem recurs.

> [!NOTE]
> The Microsoft Monitoring Agent service was known as System Center Management in versions before Operations Manager 2012 R2.

## Cause

During startup, the Microsoft Monitoring Agent service tries to write to the Operations Manager log. If the **Windows Event Viewer Log** service is not running or cannot start because of event log corruption, the Microsoft Monitoring Agent service gets stuck in the **Starting** state.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the Operations Manager services accounts have the appropriate permissions on the server. For more information about this, see [System Center Operations Manager 2012 SP1 security accounts matrix](/archive/blogs/scarrilho/scom-2012-sp1-security-accounts-matrix).

2. Locate the Windows event log folder on your Windows server (for example, `%SystemRoot%\System32\winevt\Logs`), and then back up the existing event logs in another location.

3. Delete the existing event log files, then restart the **Windows Event Viewer Log** service and the **Microsoft Monitoring Agent** service, in that order.
