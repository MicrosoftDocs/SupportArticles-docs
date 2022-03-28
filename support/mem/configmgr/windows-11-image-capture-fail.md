---
title: Capture media in Configuration Manager fails to capture Windows 11 image
description: Describes some errors that occur when you capture a Windows 11 image by using capture media in Configuration Manager, and provides solutions.
ms.date: 03/28/2022
ms.reviewer: sccmcsscontent, alpasc
author: helenclu
ms.author: luche
---
# Errors when capturing Windows 11 image by using capture media in Configuration Manager

This article provides solutions for some errors that occur when you capture a Windows 11 image by using capture media in Configuration Manager.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

When you try to capture a Windows 11 image by using capture media in Configuration Manager, one or more of the following errors might occur:

- [VCRUNTIME140_1.dll was not found](#vcruntime140dllwasnotfound)
- [Package \<package name> was installed for a user, but not provisioned for all users](#packagenotprovisionedforallusers)
- [An update or servicing operation may be using reserved storage](#updateisinprocess)
- [Volume '\\\\?\Volume{GUID}\' not found](#volumenotfound)

See the following sections for error details, causes and solutions.

## <a id="vcruntime140dllwasnotfound"></a>VCRUNTIME140_1.dll was not found

When you start the capture process by using TSMBAutoRun.exe, you receive the following error message:

:::image type="content" source="./media/windows-11-image-capture-fail/vcruntime140-1-dll-not-found.png" alt-text="Screenshot of the VCRUNTIME140_1.dll was not found error.":::

Default Visual C++ Runtime components are installed as a prerequisite during the Configuration Manager Client Agent installation. If your reference installation is disconnected from your Configuration Manager environment, these Visual C++ Runtime components will be missing.

### Solution: Install vcredist_x64.exe

To resolve this issue, install vcredist_x64.exe. The installed version has to match the version that's available in the *\\\\\<SCCM-Server>\\<SMS_SiteCode>\Client\x64* share folder.

Restart the capture process after vcredist_x64.exe is installed.

## <a id="packagenotprovisionedforallusers"></a>Package \<package name> not provisioned for all users

Check the setupact.log in *C:\Windows\System32\Sysprep\Panther*. If some applications are blocking the capture process, the "Package \<Package name> was installed for a user, but not provisioned for all users" error will be displayed in the setupact.log like the following output:

```output
02-07-2022 15:18:02.000 SYSPRP Entering SysprepGeneralizeValidate (Appx) - validating whether all apps are also provisioned.
02-07-2022 15:18:03.000 SYSPRP Package Microsoft.OneDriveSync_21220.1024.5.0_neutral__8wekyb3d8bbwe was installed for a user, but not provisioned for all users. This package will not function properly in the sysprep image.
02-07-2022 15:18:03.000 SYSPRP Failed to remove apps for the current user: 0x80073cf2.
02-07-2022 15:18:03.000 SYSPRP Exit code of RemoveAllApps thread was 0x3cf2.
02-07-2022 15:18:03.000 SYSPRP ActionPlatform::LaunchModule: Failure occurred while executing 'SysprepGeneralizeValidate' from C:\Windows\System32\AppxSysprep.dll; dwRet = 0x3cf2
02-07-2022 15:18:03.000 SYSPRP SysprepSession::Validate: Error in validating actions from C:\Windows\System32\Sysprep\ActionFiles\Generalize.xml; dwRet = 0x3cf2
02-07-2022 15:18:03.000 SYSPRP RunPlatformActions:Failed while validating Sysprep session actions; dwRet = 0x3cf2
02-07-2022 15:18:03.000 SYSPRP 983152 (0xf0070) RunDlls:An error occurred while running registry sysprep DLLs, halting sysprep execution. dwRet = 0x3cf2
02-07-2022 15:18:03.000 SYSPRP 983256 (0xf00d8) WinMain:Hit failure while pre-validate sysprep generalize internal providers; hr = 0x80073cf2
```

### Solution: Remove package for current user

To resolve this issue, remove the package by running the `Remove-AppxPackage -Package <package name>` command. For example,

```powershell
Remove-AppxPackage -Package Microsoft.OneDriveSync_21220.1024.5.0_neutral__8wekyb3d8bbwe
```

After the package is removed, restart the capture process and monitor other packages in the same situation.

## <a id="updateisinprocess"></a>An update or servicing operation may be using reserved storage

Check the setupact.log in *C:\Windows\System32\Sysprep\Panther*. If some updates are being installed on the computer, the "An update or servicing operation may be using reserved storage" error is displayed in the setupact.log like the following output:

```output
02-07-2022 14:24:15.000 SYSPRP Sysprep_Clean_Validate_Opk: Audit mode cannot be turned on if reserved storage is in use. An update or servicing operation may be using reserved storage.; hr = 0x800F0975
02-07-2022 14:24:15.000 SYSPRP ActionPlatform::LaunchModule: Failure occurred while executing 'Sysprep_Clean_Validate_Opk' from C:\Windows\System32\spopk.dll; dwRet = 0x975
02-07-2022 14:24:15.000 SYSPRP SysprepSession::Validate: Error in validating actions from C:\Windows\System32\Sysprep\ActionFiles\Cleanup.xml; dwRet = 0x975
02-07-2022 14:24:15.000 SYSPRP RunPlatformActions:Failed while validating Sysprep session actions; dwRet = 0x975
02-07-2022 14:24:15.000 SYSPRP 983152 (0xf0070) RunDlls:An error occurred while running registry sysprep DLLs, halting sysprep execution. dwRet = 0x975
02-07-2022 14:24:15.000 SYSPRP 983256 (0xf00d8) WinMain:Hit failure while pre-validate sysprep cleanup internal providers; hr = 0x80070975
```

### Solution: Ensure computer is up to date

To resolve this issue, install updates on the computer until no updates are available.

Restart the capture process after the computer is up to date and restarted.

## <a id="volumenotfound"></a>Volume '\\\\?\Volume{GUID}\' not found

When you boot into Windows PE (WinPE) and capture the Windows image (.WIM) file, the "Volume '\\\\?\Volume{GUID}\' not found" error is displayed in the SMSTS.log like the following output:

```output
02-07-2022 09:41:51.246 TSBootShell 1136 (0x470) RAM Disk Boot Path: MULTI(0)DISK(0)RDISK(0)PARTITION(3)\_SMSTASKSEQUENCE\WINPE\SOURCES\BOOT.WIM
02-07-2022 09:41:51.246 TSBootShell 1136 (0x470) Volume '\\?\Volume{8c56dc0b-b563-434b-854d-cce57b676849}\' not found
02-07-2022 09:41:51.246 TSBootShell 1136 (0x470) GetVolumePathForVolumeName(szDeviceVolumeId, rsWin32Path), HRESULT=80070490 (X:\bt\1204713\repo\src\Framework\TSCore\devicepath.cpp,167)
02-07-2022 09:41:51.246 TSBootShell 1136 (0x470) DevicePath::DeviceNamespaceWin32Path(sDevicePath, rsWin32Path), HRESULT=80070490 (X:\bt\1204713\repo\src\Framework\TSCore\devicepath.cpp,120)
02-07-2022 09:41:51.246 TSBootShell 1136 (0x470) DevicePath::ArcToWin32Path(pszBootPath, rsLogicalPath), HRESULT=80070490 (X:\bt\1204713\repo\src\Framework\TSCore\bootsystem.cpp,117)
02-07-2022 09:41:51.246 TSBootShell 1136 (0x470) ConvertBootToLogicalPath failed to convert 'MULTI(0)DISK(0)RDISK(0)PARTITION(3)\_SMSTASKSEQUENCE\WINPE\SOURCES\BOOT.WIM' (0x80070490). Retrying (0)...
```

The cause for this error is that there's no drive letter for the C drive in WinPE and the **No Default Drive Letter** attribute is set to **Yes**.

:::image type="content" source="./media/windows-11-image-capture-fail/no-default-drive-letter-attribute.png" alt-text="Screenshot of No Default Drive Letter attribute with Yes value.":::

### Solution: Assign drive letter for C drive

To resolve this issue, restart the computer and then assign the drive letter for C drive by running the following command:

```cmd
diskpart
Select Disk 0
Select Partition 3
GPT attributes=0x0000000000000000
Exit
```

The selected partition should be the partition where the operating system is installed. You can confirm it by using the `list partition` command.

:::image type="content" source="./media/windows-11-image-capture-fail/list-partition-command.png" alt-text="Screenshot of running list partition command.":::

After the assignment is completed, restart the capture process. It's unnecessary to restart the computer before the capture.
