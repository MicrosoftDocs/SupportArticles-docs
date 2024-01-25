---
title: Support policy for 4K sector hard drives
description: Provides support information for the large-sector (4K) drives when they're used with Windows and other Microsoft products. Compatibility information is included.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:storage-hardware, csstroubleshoot
ms.subservice: backup-and-storage
---
# Microsoft support policy for 4K sector hard drives in Windows

This article describes the support information for the large-sector (4K) drives when they're used with Windows and other Microsoft products.

_Applies to:_ &nbsp; Windows 10, version 1809, and later versions, Windows Server 2019, Windows 7 Service Pack 1, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2510009

## Summary

Over the next few years, the data storage industry will be transitioning the physical format of hard disk drives from 512-byte sectors to 4,096-byte sectors (also known as 4K, or 4KB sectors). This transition is driven by several factors, including increases in storage density and reliability. This transition causes incompatibility issues with existing software (including operating systems and applications).

This article describes the current Microsoft support policy for these new drive types in Windows. Applications and hardware devices may have reliability and performance issues when they're connected to these new kinds of drives. Contact your application and hardware vendors about their support policies for these new drive types.

There are three drive types that we'll discuss here. Because Microsoft support policy differs for each, you should verify the drive type that you've installed before you read any further.

|Common Names|Reported Logical Sector Size|Reported Physical Sector Size|Windows Version with Support|
|---|---|---|---|
|512-byte Native, 512n|512 bytes|512 bytes|All Windows versions|
|Advanced Format, 512e, AF, 512-byte Emulation|512 bytes|4 KB|Windows Vista with update KB 2553708 installed<br/><br/>Windows Server 2008*with update KB 2553708 installed<br/><br/>Windows 7 with update KB 982018 installed<br/><br/>Windows Server 2008 R2* with update KB 982018 installed<br/><br/>All Windows versions from Windows 7 Server Pack 1 and later versions.<br/><br/>All Server versions from Server 2008 R2 Server Pack 1 and later versions.<br/><br/>*Except for Hyper-V. See the [Application support requirements for large-sector drives](#application-support-requirements-for-large-sector-drives) section.|
|Advance Format, AF, 4K Native, 4Kn|4 KB|4 KB|All Windows versions from Windows 8 and later versions. All Server versions from Server 2012 and later versions.|
|Other|Not 4 KB or 512 bytes|Not 4 KB or 512 bytes|Not Supported|
  
To verify the kind of drive that you have, follow these steps:

1. Install [KB 982018](https://support.microsoft.com/help/982018).
2. Run the following command from elevated command prompt:

    ```console
    Fsutil fsinfo ntfsinfo x:
    ```

    where `x:` represents the drive that you're checking.

3. Use the following values to determine the kind of drive that you have.
  
   - Bytes Per Sector
   - Bytes per Physical Sector
  
    To do so, use the following table:

   | Bytes Per Sector value| Bytes per Physical Sector value| Drive type |
   |---|---|---|
   |4096|4096|4K native|
   |512|4096|Advanced Format (also known as 512E)|
   |512|512|512-byte native|

## Specific requirements for Microsoft support by operating system version

- Windows 8, Windows Server 2012 and later versions

    The below list summarizes the new features delivered as part of Windows 8 and Windows Server 2012 to help improve customer experience with large sector disks. For more detailed description for each item, see [Advanced format (4K) disk compatibility update](/windows/win32/w8cookbook/advanced-format--4k--disk-compatibility-update).

  - Builds upon the Windows 7 SP1 support for 4K disks with emulation (512e). And it provides full inbox support for disks with 4K sector size without emulation (4K Native). Some supported apps and scenarios include:

    - Ability to install Windows to and boot from a 4K sector disk without emulation (4K Native Disk)
    - New VHDx file format
    - Full Hyper-V support
    - Windows backup
    - Full support with the NT File System (NTFS)
    - Full support with the Resilient File System (ReFS)
    - Full support with Storage Spaces
    - Full support with Windows Defender
    - Inbox application support

- Windows 7 and Windows Server 2008 R2

  - Install Service Pack 1 (SP1), or install the update [982018](https://support.microsoft.com/help/982018).

  - Make sure that the drivers and firmware for your storage controller and other hardware components are updated. Also, make sure that the drives and firmware support large-sector drives.

  - Use the updated Windows Preinstallation Environment (Windows PE) for SP1 that will be released as part of the updated pieces of the [Windows Automated Installation Kit (AIK) Supplement for Windows&reg; 7 SP1](https://www.microsoft.com/download/details.aspx?id=5188) and of the Windows OEM Preinstallation Kit (OPK). Or, embed update 982018 into Windows PE.

## Application support requirements for large-sector drives

In addition to Windows operating system support, administrators and users should make sure that their applications support these large-sector drives. Scenarios and issues to be aware of include performance, reliability, backup, and recovery. Support statements for some Microsoft applications and products include:

- Hyper-V: [Using Hyper-V with large-sector drives in Windows Server 2008 and Windows Server 2008 R2](https://support.microsoft.com/help/2515143)

- SQL Server: [SQL Server - New Drives Use 4K Sector Size](/archive/blogs/psssql/sql-server-new-drives-use-4k-sector-size)

- Exchange Server: [Exchange Server storage configuration options](/Exchange/plan-and-deploy/deployment-ref/storage-configuration)

- Third-party applications and hardware: Applications and hardware devices may have reliability and performance issues when they're connected to these new drives. Contact your application and hardware vendors about their support policy for these drives.

## Known compatibility issues

The following are known compatibility issues that may occur when you use large-sector drives:

- If your Windows partitions were created using a version of Windows PE (or Windows Setup) based on a Windows codebase before Windows Vista SP1 (including Windows Vista RTM and all versions of Windows XP), the default partitions will be unaligned. Therefore, all I/O issued to the volume, even with the hotfixes (if applicable to your platform), will by nature be unaligned. It's recommended that you create the partitions using a Windows PE version based on the Windows Vista SP1 codebase or newer.

- On Windows 7 and Windows 2008 R2, installation will fail with an error **Windows Setup could not configure Windows on this computer's hardware**. This issue occurs under the conditions that are outlined in the following article:

  ["Windows Setup could not configure Windows on this computer's hardware" installation error on a Windows 7 or Windows Server 2008 R2 computer](https://support.microsoft.com/help/2466753).

- If you're using a logical sector drive of a size other than 512 bytes, Windows system image backup and restore operations may fail. And you receive the following error message:

    > One of the backup files could not be created.  
    > Details: The request could not be performed because of an I/O device error.  
    > Error code: 0x8078002A

- If you create a virtual hard disk (VHD) on a native 4K sector drive by using Disk Management or Hyper-V in Windows Server 2008 R2, the operation fails with an **Incorrect Function** error.

  - In Disk Management, the following error message is generated:
  
    > Virtual Disk Manager Incorrect function

  - In Hyper-V, the following error message is generated when the New Virtual Hard Disk Wizard is used:
  
    > The server encountered an error trying to create the virtual hard disk. The system failed to create 'I:\Disk0.vhd.' Error Code: Incorrect function.

  - In Hyper-V, the following error message is generated when the New Virtual Machine Wizard is used:

    > The server encountered an error while configuring hard disk on TestVM. The system failed to create 'I:\TestVM\TestVM.vhd.' Error Code: Incorrect function.

- If fsutil.exe continues to display **Bytes Per Physical Sector: \<Not Supported>** after you apply the latest storage driver and the required hotfixes, make sure that the following registry path exists:

  - Location: `HKEY_LOCAL_MACHINE\CurrentControlSet\Services\<miniport's service name>\Parameters\Device\`
  - Name: EnableQueryAccessAlignment
  - Type: REG_DWORD
  - Value: 1: Enable

## Unsupported scenarios

If your storage device and operating system are noted as unsupported, Microsoft Support will offer troubleshooting tips if the customer requests them. Microsoft doesn't guarantee that a resolution will be found for problems that involve unsupported storage devices. If no resolution is found, the cost of investigating the incident isn't refunded. If it's not agreed that a solution isn't guaranteed, Microsoft Support won't troubleshoot the issue and will refund the cost of investigating the incident.

Microsoft Support will use standard troubleshooting processes to isolate the storage issue. Some typical troubleshooting methods that Microsoft Support will use include:

- Consulting the Microsoft Knowledge Base. The Microsoft Knowledge Base is available to customers through [Microsoft Support](https://support.microsoft.com).

- Determining whether the problem can be replicated on supported storage (when it's possible).

    > [!NOTE]
    > If the storage is unsupported, there's no hotfix support available. Microsoft Support will be unable to determine whether the problem is caused by a hardware incompatibility or by unwanted software behavior.

If there's no solution to the problem, Microsoft Support may recommend some constructive alternatives, including:

- Asking the customer to reproduce the problem on a supported storage device
- Asking the customer to work with the storage provider for a solution
