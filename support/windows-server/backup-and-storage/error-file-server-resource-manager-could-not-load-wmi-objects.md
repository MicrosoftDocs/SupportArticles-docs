---
title: File Server Resource Manager could not load WMI objects in Windows Server
description: Fixes an error that occurs when starting the File Server Resource Manager on Windows Server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\File Server Resource Manager (FSRM) , csstroubleshoot
---
# File Server Resource Manager could not load WMI objects in Windows Server

This article helps fix an error that occurs when starting the File Server Resource Manager in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2831687

## Symptoms

When starting the File Server Resource Manager in Windows Server, you may receive the following error message:

> File Server Resource Manager could not load WMI objects on "Server Name".

If you query the `MSFT_FSRMSettings` WMI class under root\\Microsoft\\Windows\\FSRM while having the described error reported, you may then receive the following WMI error:

> Error 0x80041001 (Generic failure).

## Cause

This problem occurs because the Windows Management Instrumentation service is restarted after the FSRM Service and a new provider load/registration for the FSRM provider is needed.

## Resolution

To resolve this problem, restart the FSRM Service.

If you notice this is a reoccurring issue, there are two actions needed:

- Verify and investigate the Windows Management Instrumentation Service is restart issue to solve the behavior.
- Add a dependency for the FSRM Service in the registry, so that it gets restarted when the WMI service is restarted. To add the dependency in the registry, follow the steps:
    1. On the **Start** screen, click the **Search** tile.
    2. Type *regedit* in the **Search** window and then double-click regedit.exe.
    3. Locate the following registry entry:
     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\srmsvc`

    4. From the right-side pane, right-click **DependOnService**, and then click **Modify**.
    5. Add WINMGMT to the **Multi-String Value**.
    6. Click **OK** and then exit the registry editor.
    7. Reboot the computer.

## More information

In a particular case, the Windows Management Instrumentation is restarted as part of a WMI Repository Rebuild action. In that case, an investigation would be needed as to why the WMI Repository is being rebuilt.

If you're running SCCM 2012, ensure that you're not running in the behavior described in the following article:

[Configuration Manager management points fail after the Client Health Evaluation task runs](../../mem/configmgr/setup-migrate-backup-recovery/management-points-fail-http-500-errors.md)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
