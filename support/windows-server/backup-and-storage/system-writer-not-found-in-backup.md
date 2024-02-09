---
title: System state backup fails
description: Provides a solution to an issue where you fail to perform a system state backup by using Windows Server Backup.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-nirmsh
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# System state backup by using Windows Server Backup fails with error: System writer is not found in the backup

This article provides a solution to an issue where you fail to perform a system state backup by using Windows Server Backup.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009272

## Symptoms

When you perform a system state backup using Windows Server Backup on Windows Server 2008, the backup fails with the following error:  

> Backup of system state failed [*\<DateTime>*]  
Log of files successfully backed up  
'C:\Windows\Logs\WindowsServerBackup\SystemStateBackup *\<DateTime>*.log'  
Log of files for which backup failed  
'C:\Windows\Logs\WindowsServerBackup\SystemStateBackup_Error *\<DateTime>*.log'  
System writer is not found in the backup.

In the Application event log, the following events are logged:  

> Log Name: Application  
Source: Microsoft-Windows-Backup  
Event ID: 517  
Level: Error  
Description:  
Backup started at '*\<DateTime>*' failed with following error code '2155348226' (System writer is not found in the backup.). Please rerun backup once issue is resolved.
>
> Log Name: Application  
Source: Microsoft-Windows-CAPI2  
Event ID: 513  
Level: Error  
Description:  
Cryptographic Services failed while processing the OnIdentity() call in the System Writer Object.  
Details:  
AddCoreCsiFiles: BeginFileEnumeration() failed.  
System Error:  
Access is denied.  

## Cause

The system writer fails because permissions to files in the `%windir%\winsxs\filemaps\` or `%windir%\winsxs\temp\PendingRenames` directories are incorrect.

## Resolution

To resolve this issue, type the following commands from an elevated command prompt:

```console
Takeown /f %windir%\winsxs\temp\PendingRenames /a
icacls %windir%\winsxs\temp\PendingRenames /grant "NT AUTHORITY\SYSTEM:(RX)"
icacls %windir%\winsxs\temp\PendingRenames /grant "NT Service\trustedinstaller:(F)"
icacls %windir%\winsxs\temp\PendingRenames /grant BUILTIN\Users:(RX)  
Takeown /f %windir%\winsxs\filemaps\* /a  
icacls %windir%\winsxs\filemaps\*.* /grant "NT AUTHORITY\SYSTEM:(RX)"
icacls %windir%\winsxs\filemaps\*.* /grant "NT Service\trustedinstaller:(F)"
icacls %windir%\winsxs\filemaps\*.* /grant BUILTIN\Users:(RX)
net stop cryptsvc
net start cryptsvc
```

Type the following command to verify that the system writer is now listed:

```console
vssadmin list writers
```

If the system writer is missing, check the Application event log for the following event:

> Log Name: Application  
Source: VSS  
Event ID: 8213  
Level: Error  
Description:  
Volume Shadow Copy Service error: The process that hosts the writer with name System Writer and ID {e8132975-6f93-4464-a53e-1050253ae220} does not run under a user with sufficient access rights.  Consider running this process under a local account which is either Local System, Administrator, Network Service, or Local Service.  
Operation:  
   Initializing Writer  
 Context:  
   Writer Class Id: {e8132975-6f93-4464-a53e-1050253ae220}  
   Writer Name: System Writer

The Details section of the event (Binary Data\In Bytes) would show up as:

> 0000: 2D 20 43 6F 64 65 3A 20   - Code:  
0008: 57 52 54 57 52 54 49 43   WRTWRTIC  
0010: 30 30 30 30 30 37 32 39   00000729  
0018: 2D 20 43 61 6C 6C 3A 20   - Call:  
0020: 57 52 54 57 52 54 49 43   WRTWRTIC  
0028: 30 30 30 30 30 36 34 39   00000649  
0030: 2D 20 50 49 44 3A 20 20   - PID:  
0038: 30 30 30 30 31 30 38 34   00001084  
0040: 2D 20 54 49 44 3A 20 20   - TID:  
0048: 30 30 30 31 38 39 37 36   00018976  
0050: 2D 20 43 4D 44 3A 20 20   - CMD:  
0058: 43 3A 5C 57 69 6E 64 6F   C:\Windo  
0060: 77 73 5C 73 79 73 74 65   ws\syste  
0068: 6D 33 32 5C 73 76 63 68   m32\svch  
0070: 6F 73 74 2E 65 78 65 20   ost.exe  
0078: 2D 6B 20 4E 65 74 77 6F   -k Netwo  
0080: 72 6B 53 65 72 76 69 63   rkServic  
0088: 65 20 20 20 20 20 20 20   e  
0090: 2D 20 55 73 65 72 3A 20   - User:  
0098: 4E 54 20 41 55 54 48 4F NT AUTHO  
00a0: 52 49 54 59 5C 4E 45 54 RITY\NET  
00a8: 57 4F 52 4B 20 53 45 52 WORK SER  
00b0: 56 49 43 45 20 20 20 20 VICE  
00b8: 2D 20 53 69 64 3A 20 20   - Sid:  
00c0: 53 2D 31 2D 35 2D 32 30   S-1-5-20

Open Regedit and navigate to the following key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VSS\VssAccessControl`.

Change the value of NT AUTHORITY\NETWORK SERVICE (REG_DWORD) to 1.

You may also want to check the entry for other services (LOCAL SERVICE, NetworkService) as indicated by event 8213.

The System Writer should now show up in the `vssadmin list writers` command:

> Writer name: System Writer  
Writer Id: {e8132975-6f93-4464-a53e-1050253ae220}  
Writer Instance Id: {04cf6316-f0c5-4ce7-bbe4-e56e6334124c}  
State: [1] Stable  
Last error: No error
