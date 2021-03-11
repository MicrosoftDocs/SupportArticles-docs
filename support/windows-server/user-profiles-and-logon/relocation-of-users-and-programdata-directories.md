---
title: Relocation of Users and ProgramData directories
description: Describes information about the relocation of the Users directory and ProgramData directory to a drive other than the %systemdrive% in Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User profiles
ms.technology: windows-server-user-profiles
---
# Relocation of the Users and the ProgramData directories to a drive other than the drive that has the Windows directory

This article describes the changes in policy for the relocation of the Users directory and the `ProgramData` directory to a drive other than the %systemdrive% drive in Windows operating systems.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 949977

> [!CAUTION]
> Using the `ProgramData` setting to redirect folders to a drive other than the system volume will block your ability to upgrade to future versions of Windows.
>
> By changing the default location of the user profile directories or program data folders to a volume other than the system volume, you cannot service your Windows installation. Any updates, fixes, or service packs cannot be applied to the installation. We recommend that you do not change the location of the user profile directories or program data folders.
>
> Beginning with Windows 10, OS upgrades are supported even if user profiles are redirected to another drive. For example, if you are using Windows 8.1 with ProfilesDirectory set to D:\\, you can upgrade to Windows 10.

## More information

%systemdrive% is defined as the drive that contains the Windows directory. There are various reasons why you may want to relocate the `Users` directory or the `ProgramData` directory to other drives.

For Windows, the most common reasons are as follows:

- It is easier to back up data from a single drive and from a drive that contains only user files.
- It is easier to rebuild the operating system drive on a user's computer if user data is located on a separate volume. In this case, the drive that contains the Windows directory can be formatted, and Windows can be reinstalled without having to worry about how to remove user data.

For Windows Server, the most common reason is as follows:

- There are performance improvements when you relocate the `Users` directory and the `ProgramData` directory to a drive other than the operating system drive.

For information about how to use the answer file setting, see [Answer Files Overview](/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs).

> [!NOTE]
> If you use the FolderLocations unattend setting to move user data to a location other than the %systemdrive% drive, some servicing components may not be installed. These components may include critical updates, security updates, hotfixes, and service packs.

## Information that is documented in the current release of the Windows AIK and the Windows OPK

The Windows Automated Installation Kit (AIK) and the Windows OEM Preinstallation Kit (OPK) for Windows and Windows Server contain documentation warnings that are related to the usage of the Profile Directory and `ProgramData` unattend settings. These are the settings that let you relocate the `Users` directory and the `ProgramData` directory to locations other than their default locations. This includes other drives.

These warnings were included before the servicing stack update (update [937287](https://support.microsoft.com/help/937287)) was available. This update addresses the issue that is discussed in the warning text. Windows AIK and the Windows OPK documentation reads as follows. You cannot upgrade such installations to the next version of Windows.

Setting information from the Windows AIK and Windows OPK documentation:

### The Profiles Directory setting

The Profiles Directory setting specifies the path of the user profile folder.

Use this setting to move the user profile folder (typically %SYSTEMDRIVE%\Users) to another location during Setup or Sysprep. The destination path can be on a volume other than the system drive, as long as it meets the following requirements:

- It must be on an NTFS volume.
- It must not be the path of another operating system user profile folder.
- It must not contain any serviceable components.

This setting can be used to keep system data separate from user data. If Windows is reinstalled on the system volume, a user who has administrative rights can manually recover data from this location.

> [!CAUTION]
> Using ProfilesDirectory to redirect folders to a drive other than the system volume blocks upgrades. Using ProfilesDirectory to point to a directory that is not the system volume will block SKU upgrades and upgrades to future versions of Windows. For example, if you use Windows 8 together with ProfilesDirectory set to D:\\, you cannot upgrade to Windows 8 Pro or to the next version of Windows. The servicing stack does not handle cross-volume transactions, and it blocks upgrades.

### The ProgramData setting

The `ProgramData` setting specifies the path of the program data folder.

> [!IMPORTANT]
> These settings should be used only in a test environment. By changing the default location of the user profile directories or program data folders to a volume other than the System volume, you cannot service your Windows installation. Any updates, fixes, or service packs cannot be applied to the installation. Microsoft recommends that you do not change the location of the user profile directories or program data folders. This is especially true for Microsoft Store apps. Changing the location of %programdata% will cause errors when you install, uninstall, or update these apps.

> [!NOTE]
> If you use the unattend settings to set up the operating systems that are listed in this article, we will provide commercially reasonable efforts to support your scenario.
