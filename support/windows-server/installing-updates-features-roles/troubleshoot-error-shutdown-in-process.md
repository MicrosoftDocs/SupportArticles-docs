---
title: Troubleshoot Shutdown in Progress Windows Error 0x8007045B 
description: Learn how to resolve Windows update error 0x8007045B that indicates that access to an unmanaged server isn't allowed.
ms.date: 09/04/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot "Shutdown in Progress" Windows error 0x8007045B

## Symptoms

When you install a Windows update, or during an OS upgrade, error code 0x8007045B (ERROR_SHUTDOWN_IN_PROGRESS) is logged in the Component-Based Servicing (CBS) log, ```output(%windir%\logs\CBS\CBS.log)```, or in the Setupact log, ```output%windir%\Windows~BT\sources\panther\setupact.log```.

These log entries indicate that the installer or a component detected an ongoing shutdown process. The troubleshooting steps in this article can help you resolve this issue effectively.

### Symptom 1: Unresponsive installation

The installation might experience a 15-minute time-out that causes the Trusted Installer to initiate a restart because of "CBS hang" detection. Upon restart, the installation is typically rolled back. When this issue occurs, the following entries are logged in the CBS log:

**%windir%\logs\CBS\CBS.log**

```output
Info CBS Setting HangDetect value to 3 
Info CBS Startup: will attempt a restart to recover.
Info CBS Failed restart attempt. [HRESULT = 0x8007045b - ]
Info CBS Startup: restart attempt failed, allowing the user to logon.
Info CBS Startup: A system shutdown was initiated while waiting for startup to complete
```

**Error 0x8007045B**

```outputERROR_SHUTDOWN_IN_PROGRESS winerror.h```: A system shutdown is in progress.

### Symptom 2: Third-party service interference

A third-party service triggers a restart during a Windows OS upgrade. When this issue occurs, the following entry is logged in the Setupact log:

**%windir%\Windows~BT\sources\panther\setupact.log**:

```output
Info MIG Instantiating an ICbsSession9 interface
Error MIG Failed to create CBS session 9. hr = 0x8007045B[gle=0x000003f0]
%systemdrive%\$WINDOWS.~BT\Sources\Rollback\evtlogs:
Information MM/dd /YYYY HH:mm:ss PM User32 1074 None
The process c:\program files (x86)\netinst\mgmtagnt.exe (MACHINENAME) has initiated the restart of computer {MACHINENAME} on behalf of user NT AUTHORITY\SYSTEM for the following reason: Other (Unplanned)
Reason Code: 0x0 Shutdown Type: restart Comment:
Information MM/dd /YYYY HH:mm:ss PM EventLog 6006 None
The Event log service was stopped.
```

## Cause

This behavior is by design. It's not an error but an exception. This issue commonly occurs if the installation stops responding or experiences interference from a third-party component.

:::image type="content" source="../../azure/virtual-machines/windows/media/windows-could-not-configure-system/windows-error-configure.png" alt-text="Windows error":::

## Resolution

To resolve this issue, use the following methods, as appropriate:

- Resolution 1: Nonresponsive system

   If the system stops responding, try to increase the TrustedInstaller time-out value. For more information, see [Windows Update hangs and new updates are uninstalled after a restart](../../windows-client/installing-updates-features-roles/windows-update-hangs-updates-uninstalled.md).

- Resolution 2: Third-party service interference

   Review the Setupact.log file to determine which third-party service causes the restarts. To prevent further system restarts, disable or stop the identified service.

   > [!NOTE]
   > Error code 0x8007045B can be safely ignored. Your troubleshooting focus should be on identifying the original error that precedes this code (error code 0x800F0920).
