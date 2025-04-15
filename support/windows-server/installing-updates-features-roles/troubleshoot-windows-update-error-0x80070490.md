---
title: Troubleshoot Windows Update Error 0x80070490
description: Learn how to resolve Windows Update error 0x80070490, which occurs due to driver failures during update installations.
ms.date: 04/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# Troubleshoot Windows update error 0x80070490

Windows Update error 0x80070490 typically occurs due to driver failures when users or administrators try to install updates. This document provides a comprehensive guide to identifying and resolving this error, which can manifest in various symptoms such as pending updates, failed servicing stack updates, and feature update installation failures.

:::image type="content" source="./media/troubleshoot-windows-update-error-0x80070490/update-error0x80070490-wusaerror.png" alt-text="Windows Update error 0x80070490":::

## Prerequisites

Before proceeding with the mitigations, ensure you have backed up the OS disk. If you're using Windows in an Azure virtual machine, refer to the [Backup OS Disk](/azure/backup/backup-azure-vms) guide for detailed instructions.

## Root cause

The primary cause of error 0x80070490 is driver failure during Windows Update installations. This failure can occur due to:

- Pending updates that block new installations.
- Stale or incorrect registry entries related to driver operations.
- Corrupted or malformed SetupConfig.ini files.
- Missing driver files or hard links in the system directories.

## Symptom 1: Pending update state

When an update is in an Install Pending state, the driver operation might fail due to an inability to read the identity for driver operation sequence ID 1. Check the CBS logs at `C:\Windows\Logs\CBS\CBS.log` for entries like:

```output
Info CBS Failed reading Identity for driver operation sequenceID 1 [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Info CBS Failed loading a driver operation [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Error CBS Doqi: Failed loading driver operations queue. [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Info CBS Failed loading driver operation queue [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Info CBS Failed initializing driver operation queue [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Info CBS Perf: InstallUninstallChain complete.
```

### Resolution: Resolve pending updates

1. Remove the `1` folder from the registry path: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\DriverOperations\1`.
2. Set the trusted installer to automatic state using the command:

   ```console
   sc config trustedinstaller start=demand
   ```

3. Try install the updates again.

## Symptom 2: Servicing stack update failure

Servicing Stack Updates (SSU) might fail with error 0x80070490. Check the CBS.log for similar entries:

```output
Error CBS Doqi: Failed loading driver operations queue. [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Info CBS Failed initializing driver operation queue [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Info CBS Perf: InstallUninstallChain complete.
Info CSI 000013c6@2020/2/6:18:53:04.849 CSI Transaction @0x1d2174564c0 destroyed
Info CBS Failed to execute execution chain. [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
Error CBS Failed to process single phase execution. [HRESULT = 0x80070490 - ERROR_NOT_FOUND]
```

### Resolution: Reinstall servicing stack update

1. Export and delete the key at `HKLM\SOFTWARE\Microsoft\Windows\Currentversion\Component Based Servcing\Driver Operations\0`.
2. Reinstall the Servicing Stack Update (SSU).

## Symptom 3: Feature update installation failure

Feature updates might fail with error code 0x80070490. This behavior can be observed through "Check for updates" and in Software Center (WSUS). Review the WindowsUpdate.log for entries like:

```output
hh:mm:ss.fffff tt 1092 10968 downloadmanager_cpp16907 [DownloadManager] Preparing update for install, updateId = {0FFD49D9-5418-4D5E-9AA3-0163C0CCF57B}.202.
hh:mm:ss.fffff tt 11736 12104 uhwinsetup_cpp739 [Handler] * START * Windows Setup Install
hh:mm:ss.fffff tt 11736 12104 uhwinsetup_cpp741 [Handler] Updates to install = 1
hh:mm:ss.fffff tt 11736 12104 uhwinsetuppersisteddata_cpp233 [Handler] Loaded state. m_dwState now: Setup360_CompatToolPhase1(5)
hh:mm:ss.fffff tt 11736 12104 uhwinsetupsession_cpp322 [Handler] Starting Windows Setup with command line = "C:\Windows\SoftwareDistribution\Download\4222e87ece5856088671b07affd003c5\WindowsUpdateBox.exe" /ClassId c8bd477b-2805-4b28-94fd-f99d02b19ed2 /ReportId {0FFD49D9-5418-4D5E-9AA3-0163C0CCF57B}.202 /PreDownload /Update /ClientId ce729943-30ea-47ab-8f3b-24890a4c3e14 /CorrelationVector cFZ4O8G6gEWSekro.2.1.2
hh:mm:ss.fffff tt 11736 12104 uhwinsetupsession_cpp1655 [Handler] Registering WinSetup COM server as CLSID {C8BD477B-2805-4B28-94FD-F99D02B19ED2} and APPID {71ABC735-F46A-46BC-95B3-7E435F84FC19}
hh:mm:ss.fffff tt 11736 12104 uhwinsetupsession_cpp1673 [Handler] Successfully registered WinSetup COM server as CLSID {C8BD477B-2805-4B28-94FD-F99D02B19ED2}
hh:mm:ss.fffff tt 11736 12104 uhwinsetupsession_cpp458 [Handler] Installer completed. Process return code = 0x80070490, result = 0x80070490, callback pending = False
hh:mm:ss.fffff tt 11736 12104 setup360installer_cpp490 [Handler] Handler: Setup360 returned unknown error 80070490 for state 5, resetting state to Unknown
hh:mm:ss.fffff tt 11736 12104 uhwinsetuppersisteddata_cpp155 [Handler] State changed. was: Setup360_CompatToolPhase1(5), now: <invalid>(0)
hh:mm:ss.fffff tt 11736 12104 uhwinsetuppersisteddata_cpp296 [Handler] Saved state. m_dwState: <invalid>(0)
hh:mm:ss.fffff tt 11736 12104 uhwinsetup_cpp776 [Handler] Exit code = 0x80070490
```

### Resolution: Fix SetupConfig.ini

1. Remove or fix the `SetupConfig.ini` file located at `C:\Users\Default\AppData\Local\Microsoft\Windows\WSUS\SetupConfig.ini`.
2. If the file is empty, add an entry such as `Show OOBE =None`.

## Symptom 4: Cumulative update failure

Cumulative updates might fail with error code 0x80070490 along with 0x8e5e03fa. Check the Setup Events logs for errors like:

```output
Information XXXXXXX.corp. 1 Microsoft-Windows-Servicing N/A NT AUTHORITY\SYSTEM Initiating changes for package KB5004122. Current state is Resolved. Target state is Installed. Client id: WindowsUpdateAgent.
Information XXXXX.corp. 3 Microsoft-Windows-Servicing N/A NT AUTHORITY\SYSTEM Package KB5004122 failed to be changed to the Installed state. Status: 0x8e5e03fa.
Information XXXXX.corp. 1 Microsoft-Windows-Servicing N/A NT AUTHORITY\SYSTEM Initiating changes for package KB5004298. Current state is Resolved. Target state is Installed. Client id: WindowsUpdateAgent.
Information XXXXX.corp. 3 Microsoft-Windows-Servicing N/A NT AUTHORITY\SYSTEM Package KB5004298 failed to be changed to the Installed state. Status: 0x8e5e03fa.
Error XXXX.corp. 3 Microsoft-Windows-WUSA N/A CORP\xxa790741it5 Windows update "Security Update for Windows (KB5004298)" could not be installed because of error 2388526074 "" (Command line: ""C:\Windows\system32\wusa.exe" "C:\Users\XXXXX\Desktop\WS2012R2-072021\windows8.1-kb5004298-x64_e98bbac284034aac90559c0d311967d97ebfc0e5.msu" ")
```

### Resolution: Repair system corruption

1. Start the corruption repair process:

   ```console
   DISM /Online /Cleanup-Image /RestoreHealth
   SFC /Scannow
   ```

2. Reset the content of the Catroot2 folder:

   ```console
   net stop cryptsvc
   md %systemroot%\system32\catroot2.old
   xcopy %systemroot%\system32\catroot2 %systemroot%\system32\catroot2.old /s
   del %systemroot%\system32\catroot2\* /q
   net start cryptsvc
   ```

3. Rename the Software Distribution folder:

   ```console
   net stop wuauserv
   cd %systemroot%
   ren SoftwareDistribution SoftwareDistribution.old
   net start wuauserv
   ```

4. Install the patch.

## Symptom 5: Monthly rollup update failure

Monthly rollup updates might fail with error code 0x80070490. Check the CBS log for entries like:

```output
Error CBS Shtd: Failed while processing non-critical driver operationsqueue. [HRESULT = 0x80070490 – ERROR_NOT_FOUND]
Info CBS Shtd: Rolling back KTM, because drivers failed.
Info CBS Progress: UI message updated. Operation type: Update. Stage: 1 out of 1. Temporary Rollback.
```

### Resolution: Address missing driver files

1. Create the folder `wvms_pp.inf_amd64_81d18de8dedd4cc4` inside `C:\Windows\System32\DriverStore\FileRepository`.
2. Copy all `.inf` files from `C:\Windows\WinSxS\amd64_wvms_pp.inf_31bf3856ad364e35_6.2.9200.22376_none_bc457897943a83fe`.
3. Load the driver hive and check for the driver `wvms_pp.inf` in the registry path: `HKEY_LOCAL_MACHINE\<Driver Hive>\DriverDatabase\DriverInfFiles\wvms_pp.inf`.

## Next steps

If the issue persists, consider engaging with the WSUS team for further assistance. You can also explore additional resources on Windows Update troubleshooting on [Guidance for troubleshooting Windows Server update](troubleshoot-windows-server-update-guidance.md).
