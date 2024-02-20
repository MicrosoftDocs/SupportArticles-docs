---
title: Windows devices may fail to boot after installing October 10 version of  KB 4041676 or 4041691 that contained a publishing issue
description: Microsoft is aware of a publishing issue with the October 10, 2017 monthly security updates for Windows 10 versions 1703 (KB4041676) and 1607 (KB4041691), and Windows Server 2016 for WSUS channel managed devices.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Windows devices may fail to boot after installing October 10 version of KB4041676 or KB4041691 that contained a publishing issue

This article provides workarounds for the issue where Windows devices may fail to boot after installing October 10 version of KB4041676 or KB4041691.

_Applies to:_ &nbsp; Windows Server 2016, Windows 10, version 1607, Windows 10, version 1703  
_Original KB number:_ &nbsp; 4049094

## Overview

Microsoft is aware of a publishing issue with the October 10, 2017 monthly security updates for Windows 10 version 1703 (KB4041676) and version 1607 (KB4041691), and Windows Server 2016 (KB4041691) for WSUS/SCCM managed devices. Customers that download updates directly from Windows Update (Home and consumer devices) or Windows Update for Business are not impacted.

We have corrected the publishing issue as of the afternoon of October 10 and have validated the cumulative security updates. We recommend all customers take these cumulative security updates.

We have reports of the following symptoms impacting Windows Server Update Services (WSUS) and System Center Configuration Manager (SCCM) customers. Mitigation plans for the following user reported scenarios can be found below.

1. WSUS/SCCM Administrators that synced the October 10 update (KB4041676 or KB4041691) before 4pm PDT October 10 may still have these KBs cached.
2. WSUS/SCCM managed devices that downloaded the October 10 KB4041676 or KB4041691 update with publishing issues and have devices in a pending reboot state.
3. WSUS/SCCM managed devices that installed the October 10 KB4041676 or KB4041691 update and are unable to boot and/or may land on a recovery screen.

## Issue details  

### Scenario 1

WSUS/SCCM Administrators that synced the Delta Package versions of KB4041676 or KB4041691 before 4pm PDT October 10 may still have these KBs cached.

#### Workaround

WSUS/SCCM administrators should rescan for updates to automatically resolve the publishing issue. The issue is already resolved in WSUS hierarchies that have scanned since 4PM on October 10. Ensure your upstream and downstream servers are in sync.

### Scenario 2

WSUS/SCCM managed devices that have downloaded and staged the Delta Package versions of KB4041676 or KB4041691 but have not rebooted to install.

#### Workaround

If a device has downloaded and staged Delta Package versions of KB4041676 or KB4041691, a user may fail to boot after restarting. System administrators can remove pending updates by running the following commands from an administrative command prompt on the device:

```console
@echo off

REM Stop all update related services
net stop usosvc
net stop wuauserv
net stop trustedinstaller

REM Delete pending.xml if it exists
takeown /f %windir%\winsxs\pending.xml >NUL 2>&1
icacls %windir%\winsxs\pending.xml /grant Everyone:F >NUL 2>&1
del %windir%\winsxs\pending.xml >NUL 2>&1

REM Modify the components hive
reg unload HKLM\Components >NUL 2>&1
reg load HKLM\ComponentsHive %windir%\system32\config\COMPONENTS
reg delete /f HKLM\ComponentsHive /v PendingXmlIdentifier >NUL 2>&1
reg delete /f HKLM\ComponentsHive /v PoqexecFailure >NUL 2>&1
reg delete /f HKLM\ComponentsHive /v ExecutionState >NUL 2>&1
reg delete /f HKLM\ComponentsHive /v RepairTransactionPended >NUL 2>&1
reg delete /f HKLM\ComponentsHive /v AIFailureInformation >NUL 2>&1
reg delete /f HKLM\ComponentsHive\Installers\RegKeySDTable /v Install >NUL 2>&1
reg delete /f HKLM\ComponentsHive\Installers\RegKeySDTable /v Uninstall >NUL 2>&1
reg delete /f HKLM\ComponentsHive\Installers\RegKeySDTable /v Uninstall >NUL 2>&1
reg unload HKLM\ComponentsHive

REM Stop Poqexec from running
reg delete /f HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Configuration /v DontRunPoqexecInSmss >NUL 2>&1
reg delete /f HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Configuration /v PoqexecCmdline >NUL 2>&1
reg delete /f "HKLM\System\CurrentControlSet\Control\Session Manager" /v SETUPEXECUTE >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Control\Session Manager" /v SETUPEXECUTE /t REG_MULTI_SZ /d \0 /f

dism /online /remove-package /PackageName:Package_for_RollupFix_Wrapper~31bf3856ad364e35~amd64~~15063.674.1.8 /norestart >NUL 2>&1
dism /online /remove-package /PackageName:Package_for_RollupFix_Wrapper~31bf3856ad364e35~x86~~15063.674.1.8 /norestart >NUL 2>&1
dism /online /remove-package /PackageName:Package_for_RollupFix_Wrapper~31bf3856ad364e35~amd64~~14393.1770.1.6 /norestart >NUL 2>&1
dism /online /remove-package /PackageName:Package_for_RollupFix_Wrapper~31bf3856ad364e35~x86~~14393.1770.1.6 /norestart >NUL 2>&1
```  

### Scenario 3

WSUS/SCCM managed devices that installed the Delta Package versions of KB4041676 or KB4041691 and are unable to boot and/or see a recovery screen

#### Workaround

> [!Important]
These steps should only be followed on a device that fails to boot.

1. Plug into AC power and turn on the device.

2. If the device fails to boot, Windows will attempt to repair your device and enter the Windows 10 Recovery Environment. Select **Advanced options** on the **Automatic Repair** screen.

    :::image type="content" source="media/windows-devices-fail-boot-after-installing-kb4041676-kb4041691/automatic-repair.png" alt-text="Screenshot of the Automatic repair screen." border="false":::

3. Select **Troubleshoot**, then **Advanced Options**, and then **System Restore**. If a restore point is available prior to the installation of KB4041676 or KB4041691, use the **System Restore** wizard to restore to the earlier Restore Point. If a restore point does not exist, close **System Restore** and continue to the next step.
4. Select **Troubleshoot**, then **Advanced Options** and then **Command Prompt**. You may be asked to enter a BitLocker Recovery Key or username/password. If prompted for a username/password, you must enter a local account. If you do not have credentials, you many need to create and use a [Recovery Drive](https://support.microsoft.com/help/4026852/windows-create-a-recovery-drive).

    :::image type="content" source="media/windows-devices-fail-boot-after-installing-kb4041676-kb4041691/advanced-options.png" alt-text="Screenshot of the Advanced Options screen." border="false":::

5. After the **Command Prompt** launches, run the following to load the software registry hive:

    ```console
    reg load hklm\temp <drive letter for windows directory>\windows\system32\config\software
    ```

    **Example**:

    ```console
    reg load hklm\temp c:\windows\system32\config\software
    ```

6. Run the following command to delete the SessionsPending registry key. If the registry value does not exist, proceed to the next step.

    ```console
    reg delete "HKLM\temp\Microsoft\Windows\CurrentVersion\Component Based Servicing\SessionsPending" /v Exclusive
    ```

7. Run the following to unload the registry:

    ```console
    reg unload HKLM\temp
    ```

8. Run the following command, which will list all pending updates:

    ```console
    dism.exe /image:<drive letter for windows directory> /Get-Packages
    ```

    **Example**:

    ```console
    dism.exe /image:c:\ /Get-Packages
    ```  

9. Run the following command for each package where State = Install Pending:

    ```console
    dism.exe /image:<drive letter for windows directory> /remove-package /packagename:<package name>
    ```

    **Example**:

    ```console
    dism.exe /image:c:\ /remove-package /packagename:Package_for_RollupFix_Wrapper~31bf3856ad365e35~amd64~~15063.674.1.8
    ```  

    ```console
    dism.exe /image:c:\ /remove-package /packagename:Package_for_RollupFix~31bf3856ad365e35~amd64~~15063.674.1.8
    ```

10. Close the **Command Prompt** and click **Continue** to exit the recovery environment.

    :::image type="content" source="media/windows-devices-fail-boot-after-installing-kb4041676-kb4041691/continue-dialog.png" alt-text="Screenshot of the Choose an option screen." border="false":::
