---
title: Troubleshoot Shutdown in Progress Windows Error 0x8007045b 
description: Learn how to resolve Windows update error 0x8007045b, indicating that access to an unmanaged server isn't allowed.
ms.date: 08/01/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# Troubleshoot Shutdown in Progress Windows Error 0x8007045b

When installing a Windows update or during an OS upgrade, you may see the error code 0x8007045b (ERROR_SHUTDOWN_IN_PROGRESS) in the CBS log ```output(%windir%\logs\CBS\CBS.log)``` or ```output%windir%\Windows~BT\sources\panther\setupact.log.```

It indicates that the installer or a component has detected an ongoing shutdown process. This behavior is by design and not an error but an exception. The actual issue may differ, commonly related to a CBS Hang or interference from a third-party component. Following the appropriate troubleshooting steps can help resolve this issue effectively.

## Root Cause

The error code 0x8007045b is an exception that signals an ongoing shutdown process. The root cause of the installation failure may vary, often involving a CBS Hang or a third-party component.

:::image type="content" source="../../azure/virtual-machines/windows/media/windows-could-not-configure-system/windows-error-configure.png" alt-text="Windows error":::

## Symptom 1: CBS Hang Detect

 The installation may encounter a 15-minute timeout, leading the Trusted Installer to initiate a reboot due to CBS hang detection. Upon restart, the installation is typically rolled back.

**%windir%\logs\CBS\CBS.log**:

```output
Info CBS Setting HangDetect value to 3 
Info CBS Startup: will attempt a restart to recover.
Info CBS Failed restart attempt. [HRESULT = 0x8007045b - ]
Info CBS Startup: restart attempt failed, allowing the user to logon.
Info CBS Startup: A system shutdown was initiated while waiting for startup to complete
```

### Error 0x8007045b

```outputERROR_SHUTDOWN_IN_PROGRESS winerror.h```: A system shutdown is in progress.

### Mitigation 1

The primary issue is the CBS Hang detect, represented by error code 0x800f0920. This can be addressed by increasing the TrustedInstaller timeout. For more information,  go to [CBS HangDetect](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1511786/Update-Installation-Error-0x800f0920-CBS_E_HANG_DETECTED?anchor=mitigation-1)

## Symptom 2:Third-party Service Interference

 A third-party service may trigger reboots during the Windows OS upgrade setup process.

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

### Mitigation 2

Review the setupact logs to identify the third-party service causing the reboots. Prevent further system reboots by disabling or stopping the identified service.

> [!NOTE]
>The error code 0x8007045b can be disregarded, and the focus should be on identifying the original error that precedes this code.
