---
title: Large WinSxS directory causes disk space issues
description: Discusses how to address disk space issues that are caused by a large Windows component store (WinSxS) directory.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca, joscon, jcollins
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# How to address disk space issues that are caused by a large Windows component store (WinSxS) directory

This article provides a resolution to solve the disk space issues that are caused by a large Windows component store (WinSxS) directory.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2795190

## Symptoms

When you examine the size of the C:\Windows folder, you may notice that the C:\Windows\winsxs directory seems to use lots of disk spaces.

## Cause

The Windows component store (C:\Windows\winsxs) directory is used during servicing operations within Windows installations. Servicing operations include, but are not limited to, Windows Update, service pack, and hotfix installations.

The component store contains all the files that are required for a Windows installation. And, any updates to those files are also held within the component store as the updates are installed. This causes the component store to grow over time as more updates, features, or roles are added to the installation. The component store uses NTFS hard links between itself and other Windows directories to increase the robustness of the Windows platform.

The component store will show a large directory size because of how the Windows Explorer shell accounts for hard links. The Windows shell will count each reference to a hard link as a single instance of the file for each directory in which the file resides. For example, if a file that is named advapi32.dll is 700 KB and is contained in the component store and in the \Windows\system32 directory, Windows Explorer would inaccurately report that the file consumes 1,400 KB of hard disk space.

## Resolution

The component store cannot reside on a volume other than the system volume because of the NTFS hard links. If you try to move the component store, this will result in the inability to correctly install Windows updates, service packs, roles, or features. Additionally, we do not recommend that you manually remove or delete files from the component store.

To reduce the size of the component store directory on a Windows installation, you can decide to make the service pack installation permanent and reclaim used space from the service pack files. However, if you make the service pack installation permanent, the service pack is not removable.

To remove the service pack files from a Windows installation, use the following in-box utilities:

- Windows Server 2008 Service Pack 2 installed: Compcln.exe
- Windows 7 Service Pack 1 or Windows Server 2008 R2 Service Pack 1 installed: DISM /online /Cleanup-Image /SpSuperseded or Disk Cleanup Wizard (cleanmgr.exe)

Scavenging may also be performed proactively on Windows Server 2008 installations by forcing a removal event on the system. Scavenging will try to remove any unwanted system binaries from the installation and enable Windows to reclaim the disk space. To issue an uninstall event on a Windows installation, add and remove any unwanted system component that is not already installed, and then restart the Windows installation. Scavenging will be performed during the following restart of the operating system.

> [!NOTE]
> Scavenging is performed automatically on Windows 7 and Windows Server 2008 R2 installations.

## More information

To reclaim additional disk space on your system, follow these steps:

1. Select **Start**, and then in the **Search Programs and Files** text box, type *Disk cleanup*.

2. Click the **Disk Cleanup** icon, and run the Disk Cleanup tool to determine what files you can delete, based on your configuration.

Additional ways to conserve space on the system volume include the following:

- Move the paging file to another volume on the system.
- Disable hibernation on the system.
- Use the dedicated dump file option to capture memory dump files on another volume on the system.
- Offload user profile and program file directories to another volume on the system.
- Disable system restore points on client installations.
- Clean out all temporary directories and folders by using the Disk Cleanup Wizard (cleanmgr.exe).
- Uninstall unused applications or utilities from the installation.

For more information about the WinSxS folder, see:

- [Disk Space](/archive/blogs/e7/disk-space)
- [General guidance on disk provisioning for WinSXS growth](/archive/blogs/joscon/general-guidance-on-disk-provisioning-for-winsxs-growth)

For more information about the system requirements for disks, see:

- [Install Windows Server 2008 and Windows Server 2008 R2](/iis/install/installing-iis-7/install-windows-server-2008-and-windows-server-2008-r2)
- [Windows 7 system requirements](https://support.microsoft.com/help/10737)

> [!NOTE]
>
> - When a product is installed by using Windows Installer, a smaller version of the original .msi data file is stored in the Windows Installer Cache (%windir%\Installer) folder. Over time, this folder may grow larger. Every additional update installation for the installed products such as hotfixes, cumulative updates, or service pack setups also store their relevant .msp or .msi file in the Windows Installer cache. Over time, this folder may grow larger. We do not support and do not recommend that you delete any files in this folder or replace them with files from another computer. Any update to the application relies on the information that is available in the files that are stored in this folder. Without this information, the updates cannot perform their installations correctly.
> - The *%windir%\softwaredistribution\downloads* folder is used by Windows Update to store downloaded updates. Typically, you do not have to manage this folder because it is managed by Windows. The typical size of this folder is determined by several factors such as the operating system version, what updates are available at the time, and so on. Therefore, it is difficult to provide a typical size expectation. If this folder uses lots of disk space, first install all available updates for the system, and then restart the computer. To troubleshoot this issue if the size still remains large, follow these steps:
>
>      1. At an elevated command prompt, run the `Net Stop WUAUSERV` command.
>      2. Delete the contents of the *%windir%\softwaredistribution\downloads* folder.
>      3. At an elevated command prompt, run the `Net Start WUAUSERV` command:

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
