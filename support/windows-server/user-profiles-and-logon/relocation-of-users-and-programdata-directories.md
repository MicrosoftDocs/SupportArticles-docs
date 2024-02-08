---
title: Upgrade to Windows versions that is before Windows 10 is blocked if Users and ProgramData directories are changed
description: Describes information about the policy changes for relocation of the Users directory and ProgramData directory to a drive other than the %systemdrive% in Windows.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
ms.subservice: user-profiles
---
# Upgrade to Windows versions that is before Windows 10 is blocked if Users and ProgramData directories are changed

Before Windows 10, using the **ProgramData** unattend setting to redirect folders to a drive other than the system volume will block your ability to upgrade to a later version of Windows that is earlier than Windows 10.

By changing the default location of the *User* directories or *ProgramData* folders to a volume other than the system volume, you cannot service your Windows installation. Any updates, fixes, or service packs cannot be applied to the installation. We recommend that you do not change the location of the user profile directories or program data folders.

Beginning with Windows 10, upgrades are supported even if user profiles are redirected to another drive. For example, if you are using Windows 8.1 with ProfilesDirectory set to D:\\, you can still upgrade to Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows 8.1, Windows Server 2012 R2, Windows 7  
_Original KB number:_ &nbsp; 949977

## More information

*%systemdrive%* is defined as the drive that contains the Windows directory. There are various reasons why you may want to relocate the *Users* directory or the *ProgramData* directory to other drives.

For Windows, the most common reasons are as follows:

- It is easier to back up data from a single drive and from a drive that contains only user files.
- It is easier to rebuild the operating system drive on a user's computer if user data is located on a separate volume. In this case, the drive that contains the Windows directory can be formatted, and Windows can be reinstalled without having to worry about how to remove user data.
- The *%systemdrive%* does not have enough disk space.

For Windows Server, the most common reason is as follows:

- There are performance improvements when you relocate the *Users* directory and the *ProgramData* directory to a drive other than the operating system drive.

For information about how to use the answer file setting, see [Answer Files Overview](/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs).

> [!NOTE]
> If you use the FolderLocations unattend setting to move user data to a location other than the *%systemdrive%* drive, some servicing components may not be installed. These components may include critical updates, security updates, hotfixes, and service packs.

## Information that is documented in the Windows AIK and the Windows OPK

The Windows Automated Installation Kit (AIK) and the Windows OEM Preinstallation Kit (OPK) for Windows and Windows Server contain documentation warnings that are related to the usage of the **ProfilesDirectory** and **ProgramData** unattend settings. These are the settings that let you relocate the *Users* directory and the *ProgramData* directory to locations other than their default locations. This includes other drives.

These warnings were included before the servicing stack update (update [937287](https://support.microsoft.com/help/937287)) was available. This update addresses the issue that is discussed in the warning text. You cannot upgrade such installations to the Windows version that is before Windows 10.

## Reference

For more information, see [FolderLocations](/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-folderlocations).
