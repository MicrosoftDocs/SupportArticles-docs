---
title: How to restore a Windows 7 installation
description: Describes how to restore a Windows 7 installation.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, keithpe
ms.custom: sap:system-restore-or-resetting-your-computer, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# How to restore a Windows 7 installation

This article describes how to create a system state backup on one computer and how to restore it to the same computer or to a different physical computer of the same make and model.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 249694

## Summary

One of the following problems may occur with your computer:

- Hardware failure
- Software failure
- Computer theft
- Natural disaster
- User error

To recover from one of these problems, you can restore the Microsoft Windows operating system from a system state backup. You can restore a system state backup to the same physical computer from which the system state backup was created, or to a different physical computer that has the same make, model, and configuration (identical hardware).

However, we do not support restoring a system state backup from one computer to a second computer of a different make, model, or hardware configuration. We only provide commercially reasonable efforts to support this process. Even if the source and destination computers seem to be identical makes and models, the source computers may have different drivers, hardware, or firmware than the destination computers.

## The preferred method to restore Windows 7

To restore Windows 7-based computers, the preferred method is a full system restore. Specifically, without using ASR, you can perform a Bare Metal Restore (BMR) to freshly formatted boot volumes and system volumes on the same server that the original backup was taken from. In this case, the volume layouts and identifiers are identical to those used during the backup of the original computer. Additionally, you can perform a BMR that uses ASR to a computer that has different hardware than the original computer.

> [!NOTE]
> BMRs can be performed only when the system is offline.
>
> Both the Target machine being backed up and the Destination machine receiving the restore have to be either Unified Extensible Firmware Interface (UEFI) or BIOS based. You cannot mix the two in a BMR scenario.

## Possible recovery scenarios for Windows 7

- Server unbootable/Server-migration scenario (planned and unplanned)

  In this scenario, you can protect the server by doing a BMR backup of all critical volumes on the server. You then recover the server by doing a BMR recovery through Windows Recovery. In this scenario, BMR is supported to different hardware.

- Server malfunction scenario (bootable) or rollback of server roles

  In this scenario, you can protect the server by doing a System State Backup or a BMR backup. You would then recover the server by doing a System State Recovery from the started operating system.

The following table outlines supported and unsupported system recovery scenarios.

|Scenario|Supported|
|---|---|
|System State Recovery after BMR / Full Server restore to the same hardware|Yes|
|System State Recovery after BMR / Full Server restore to different hardware|No|
|System State Recovery after Full Server restore (without BMR) to the same or different hardware|No|
  
> [!NOTE]
> Windows Server Backup ensures that the system boots successfully after the BMR restore process. Applications/Roles that rely on hardware-specific identifiers like NIC address, and so on, may require additional reconfiguration or recovery to make them functional.

## Guidelines for restoring the Windows 7 operating system

Follow the guidelines in the following sections to help make sure that the restore operation succeeds.

### Hardware abstraction layer

The source and destination computers must use the same type of Hardware Abstraction Layer (HAL). There's one exception to this rule. If one of the computers contains the Advanced Configuration and Power Interface (ACPI) multiprocessor HAL, the other computer can have the ACPI uniprocessor HAL. The same rule applies to MPS multiprocessor and MPS uniprocessor HALs.

For example, if the source is using the MPS multiprocessor HAL, you can restore data to a destination computer that uses the MPS uniprocessor HAL. However, you can't restore data to a destination computer that uses the ACPI multiprocessor HAL.

> [!NOTE]
> If the destination computer's HAL is compatible, but not identical, to the source computer's HAL, you must update the HAL on the destination computer after you finish the restore. For example, if the source computer has a single processor and is using the ACPI uniprocessor HAL, you can restore a backup from that computer to a multiprocessor destination computer. However, the destination computer will not use more than one processor until you update the HAL to an ACPI multiprocessor HAL.

To determine the computer HAL type that you're using on each computer, follow these steps:

1. Select **Start**, point to **Settings**, select **Control Panel**, and then select **System**.
2. On the **Hardware** tab, select **Device Manager**, and then expand the **Computer** branch.

   - ACPI multiprocessor computer = Halmacpi.dll
   - ACPI uniprocessor computer = Halaacpi.dll
   - Advanced Configuration and Power Interface (ACPI) computer = Halacpi.dll
   - MPS multiprocessor computer = Halmps.dll
   - MPS uniprocessor computer Halapic.dll standard computer = Hal.dll
   - Compaq SystemPro multiprocessor or 100% compatible = Halsp.dll

### Operating system version

The source and destination computers must use identical operating system versions and identical Windows stock-keeping units (SKUs). For example, you can't back up Windows 2000 Server and then restore it on a computer that is running Windows 2000 Advanced Server. Also, the source and destination computers should both use retail versions of Windows or the same OEM version of Windows. The best practice is to install Windows on the destination computer by using the same installation media that you used to install Windows on the source computer.

### Filter drivers

Uninstall third-party filter drivers on the source computer before you do the backup. These kinds of drivers can cause problems when the backup is restored to a different computer.

### Windows folder and disk layout

The destination computer must use the same logical drive letter (%systemdrive%) and path (%systemroot%) as the source computer. For domain controllers, the locations of the Active Directory directory service database, Active Directory log files, FRS database, and FRS log files must also be identical for the source and destination computers. For example, if the Active Directory database log files on the source computer were installed on C:\WINNT\NTDS, the destination computer must also use the C:\WINNT\NTDS path.

### Hardware

If you remove any hardware on the destination computer that isn't required to complete the restore process, you increase the probability of a successful restore operation. For example, physically remove or disable all except one network adapter. Install or enable the additional adapters after you restart the operating system after the restore operation.

### Hotfix and service pack level

For example, for Windows 2000 computers, hotfix 810161 or Windows 2000 Service Pack 4 must be installed on the source computer before you back up data. These items must also be installed on the destination computer before you restore the backup. Windows Server 2003 and Windows XP have no hotfix or service pack level requirements for this kind of restore operation. A user doesn't have to bring the destination computer up to the same service pack and hotfix level for Windows Server 2003 or for Windows XP. However, restoring a Windows Server 2003 SP1-based computer requires you to restore the destination computer to Windows Server 2003 SP1.

## Possible issues and the steps to troubleshoot

After you restart the destination computer, you may experience the following symptoms:

- You receive one of the following **Stop** error messages:
  > Stop 0x0000007B Inaccessible_Boot_Device  
  > STOP: 0x00000079 Hal_Mismatch
- The computer stops responding at startup.
- The computer spontaneously restarts when you receive the **Starting Windows 2000** message on a black screen early in the restart process.
- You can't configure your display settings.
- The network adapter doesn't function correctly.

To resolve issues with the display settings or with a network adapter, remove the graphics adapter or the network adapter from Device Manager, and then restart the computer. Windows will detect again the device and possibly prompt you for drivers.

To resolve the **Stop** error or the problem where a computer stops responding, do an in-place upgrade of Windows.

After you finish the in-place upgrade, verify that the `ClientProtocols` registry subkey exists and is populated correctly. To do this, follow these steps:

1. Select **Start**, select **Run**, type _regedit_, and then select **OK**.
2. Locate and then right-click the following registry subkey. Verify that the values in the following list exist:
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Rpc\ClientProtocols`

    |Value name|Value type|Value data|
    |---|---|---|
    |ncacn_ip_tcp|REG_SZ|rpcrt4.dll|
    |ncacn_ip_udp|REG_SZ|rpcrt4.dll|
    |ncacn_nb_tcp|REG_SZ|rpcrt4.dll|
    |ncacn_np|REG_SZ|rpcrt4.dll|

3. If the `ClientProtocols` subkey is missing, add it under the `Rpc` subkey.
4. If values are missing in the `ClientProtocols` subkey, follow these steps:

   1. Right-click **ClientProtocols**, point to **New**, and then select **String Value**.
   2. Type the value name of the entry that is missing, and then press Enter.
   3. Right-click the value name that you typed in step b, and then select **Modify**.
   4. Type the appropriate value data for the value name that you typed in step b, and then select **OK**.

5. Repeat step 4 for each missing value in the `ClientProtocols` subkey.
6. Restart the computer if any registry changes were made.

> [!NOTE]
> If the source computer was upgraded from Windows NT 4.0, the user profiles may be stored in the _%systemroot%\Profiles_ folder instead of in the _%systemdrive%\Documents and Settings_ folder. After an in-place upgrade is performed, you may have to change the following registry value back to **%systemroot%\Profiles**.
>
> `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`
>
> |Value Name|Profiles directory|
> |---|---|
> |Value Type|REG_EXPAND_SZ|
> |Value Data|%systemroot%\Profiles|
