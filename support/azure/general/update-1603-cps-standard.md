---
title: Update 1603 for Cloud Platform System Standard
description: Describes Update 1603 for Cloud Platform System Standard. Includes updates for Windows Server 2012 R2, System Center 2012 R2, and Windows Azure Pack.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.reviewer: 
---
# Update 1603 for Cloud Platform System Standard

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3145162

Update 1603 for Cloud Platform System (CPS) Standard includes updates for Windows Server 2012 R2, System Center 2012 R2, and the Windows Azure Pack. It also includes functionality that lets you run a health check on the stamp before you perform an update. The list of updates is included at the bottom of this article.

## More information

CPS Standard includes the Patch and Update (P&U) Framework. This framework lets you update the infrastructure components of the CPS Standard stamp with minimal or no disruption to tenant workloads. The framework automates the installation of software, driver, and firmware updates on the physical hosts and on the infrastructure virtual machines. The P&U Framework does not update tenant virtual machines.

When the P&U Framework runs, it does the following:

- Orchestrates the updates so that they are performed in the correct order
- Automatically puts servers in and out of maintenance mode during servicing
- Validates components when servicing is complete

The P&U Framework installs approved software updates for the following products on all infrastructure hosts and virtual machines:

- Windows Server
- Windows Azure Pack
- System Center
- SQL Server

It's important that you avoid installing Windows Server, Windows Azure Pack, System Center, or SQL Server updates by any method other than the P&U Framework. You must install only those update packages that Microsoft and OEMs have tested and approved for CPS Standard.

### Updates for Windows Server 2012 R2

- "STATUS_CONNECTION_RESET" error when an application reads a file in Windows Server 2012 R2 or Windows Server 2012 R2 [https://support.microsoft.com/kb/3076950](https://support.microsoft.com/help/3076950)
- MS15-105: Description of the security update for Hyper-V: September 8, 2015 [https://support.microsoft.com/kb/3087088](https://support.microsoft.com/help/3087088)
- MS15-109: Description of the security update for Windows Shell: October 13, 2015 [https://support.microsoft.com/kb/3080446](https://support.microsoft.com/help/3080446)
- Hyper-V host crashes and has errors when you perform a VM live migration in Windows 8.1 and Windows Server 2012 [https://support.microsoft.com/kb/3031598](https://support.microsoft.com/help/3031598)
- Files aren't fully optimized and a deduplication cache lock contention issue occurs in Windows Server 2012 R2 [https://support.microsoft.com/kb/3094197](https://support.microsoft.com/help/3094197)
- MS15- 115: Description of the security update for Windows: November 10, 2015 [https://support.microsoft.com/kb/3097877](https://support.microsoft.com/help/3097877)
- MS15-128 and MS15-135: Description of the security update for Windows kernel-mode drivers: December 8, 2015 [https://support.microsoft.com/kb/3109094](https://support.microsoft.com/help/3109094)
- MS15-127: Security update for Microsoft Windows DNS to address remote code execution: December 8, 2015 [https://support.microsoft.com/kb/3100465](https://support.microsoft.com/help/3100465)
- MS15-133: Description of the security update for Windows PGM: December 8, 2015 [https://support.microsoft.com/kb/3109103](https://support.microsoft.com/help/3109103)
- MS15-132: Description of the security update for Windows: December 8, 2015 [https://support.microsoft.com/kb/3108347](https://support.microsoft.com/help/3108347)
- MS15-128: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: December 8, 2015 [https://support.microsoft.com/kb/3099864](https://support.microsoft.com/help/3099864)
- MS15- 132: Description of the security update for Windows: December 8, 2015 [https://support.microsoft.com/kb/3108381](https://support.microsoft.com/help/3108381)
- MS16-008: Description of the security update for Windows Kernel: January 12, 2016 [https://support.microsoft.com/kb/3121212](https://support.microsoft.com/help/3121212)
- MS16-007: Description of the security update for Windows: January 12, 2016 [https://support.microsoft.com/kb/3110329](https://support.microsoft.com/help/3110329)
- MS16-007: Description of the security update for Windows: January 12, 2016 [https://support.microsoft.com/kb/3121918](https://support.microsoft.com/help/3121918)
- MS16-005: Description of the security update for Windows kernel-mode drivers: January 12, 2016 [https://support.microsoft.com/kb/3124001](https://support.microsoft.com/help/3124001)
- Hyper-V integration components update for Windows virtual machines that are running on a Windows 10-based host - [https://support.microsoft.com/kb/3063109](https://support.microsoft.com/help/3063109)
- Space doesn't regenerate upon reallocation in Windows Server 2012 R2 - [https://support.microsoft.com/kb/3090322](https://support.microsoft.com/help/3090322)
- Site-to-site VPN goes down in Windows 8.1 or Windows Server 2012 R2 - [https://support.microsoft.com/kb/3091402](https://support.microsoft.com/help/3091402)
- System fails back to a host copy instead of an array copy or storages go down after LUN reset in Windows Server 2012 R2 - [https://support.microsoft.com/kb/3121261](https://support.microsoft.com/help/3121261)
- All disks in a storage pool can't be brought online in a Windows Server 2012 R2-based cluster - [https://support.microsoft.com/kb/3123538](https://support.microsoft.com/help/3123538)
- MS16-035: Description of the security update for the .NET Framework 3.5 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016 - [https://support.microsoft.com/kb/3135985](https://support.microsoft.com/help/3135985)
- MS16-035: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: March 8, 2016 - [https://support.microsoft.com/kb/3135991](https://support.microsoft.com/help/3135991)
- MS16-035: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: March 8, 2016 - [https://support.microsoft.com/kb/3135994](https://support.microsoft.com/help/3135994)
- MS16-028: Description of the security update for Windows PDF Library: March 8, 2016 - [https://support.microsoft.com/kb/3137513](https://support.microsoft.com/help/3137513)
- MS16-033: Description of the security update for Windows USB mass storage class driver: March 8, 2016 - [https://support.microsoft.com/kb/3139398](https://support.microsoft.com/help/3139398)
- MS16-034: Description of the security update for Windows kernel-mode drivers: March 8, 2016 - [https://support.microsoft.com/kb/3139852](https://support.microsoft.com/help/3139852)
- MS16-032: Description of the security update for the Windows Secondary Logon Service: March 8, 2016 - [https://support.microsoft.com/kb/3139914](https://support.microsoft.com/help/3139914)
- MS16-030: Description of the security update for Windows OLE: March 8, 2016 - [https://support.microsoft.com/kb/3139940](https://support.microsoft.com/help/3139940)
- MS16-026: Description of the security update for graphic fonts: March 8, 2016 - [https://support.microsoft.com/kb/3140735](https://support.microsoft.com/help/3140735)
- MS16-019: Description of the security update for the .NET Framework 3.5 in Windows 8.1 and Windows Server 2012 R2: February 9, 2016 - [https://support.microsoft.com/kb/3122651](https://support.microsoft.com/help/3122651)
- MS16-019: Description of the security update for the .NET Framework 4.5.2 in Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: February 9, 2016 - [https://support.microsoft.com/kb/3122654](https://support.microsoft.com/help/3122654)
- MS16-012: Description of the security update for Windows PDF Library: February 9, 2016 - [https://support.microsoft.com/kb/3123294](https://support.microsoft.com/help/3123294)
- MS16-014: Description of the security update for Windows 8.1 and Windows Server 2012 R2: February 9, 2016 - [https://support.microsoft.com/kb/3126434](https://support.microsoft.com/help/3126434)
- MS16-017: Description of the security update for Remote Desktop display driver: February 9, 2016 - [https://support.microsoft.com/kb/3126446](https://support.microsoft.com/help/3126446)
- MS16-014: Description of the security update for Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows Server 2012, Windows 8.1, and Windows Server 2012 R2: February 9, 2016 - [https://support.microsoft.com/kb/3126587](https://support.microsoft.com/help/3126587)
- MS16-014: Description of the security update for Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows Server 2012, Windows 8.1, and Windows Server 2012 R2: February 9, 2016 - [https://support.microsoft.com/kb/3126593](https://support.microsoft.com/help/3126593)
- MS16-021: Security update for NPS RADIUS server to address denial of service: February 9, 2016 - [https://support.microsoft.com/kb/3133043](https://support.microsoft.com/help/3133043)
- MS16-018: Description of the security update for Windows kernel-mode drivers: February 9, 2016 - [https://support.microsoft.com/kb/3134214](https://support.microsoft.com/help/3134214)
- MS16-020: Security update for Active Directory Federation Services to address denial of service: February 9, 2016 - [https://support.microsoft.com/kb/3134222](https://support.microsoft.com/help/3134222)

### Updates for System Center 2012 R2 and the Windows Azure Pack

- Update Rollup 9 for System Center 2012 R2 Data Protection Manager - [https://support.microsoft.com/kb/3112306](https://support.microsoft.com/help/3112306)
- Update Rollup 9 for System Center 2012 R2 Operations Manager - [https://support.microsoft.com/kb/3129774](https://support.microsoft.com/help/3129774)
- Update Rollup 9 for System Center 2012 R2 Orchestrator - Service Provider Foundation - [https://support.microsoft.com/kb/3133705](https://support.microsoft.com/help/3133705)
- Update Rollup 9 for System Center 2012 R2 Virtual Machine Manager - [https://support.microsoft.com/kb/3129784](https://support.microsoft.com/help/3129784)
- Security Update Rollup 9.1 for Windows Azure Pack - [https://support.microsoft.com/kb/3146301](https://support.microsoft.com/help/3146301)

## Known issues

### Issue 1: KBs fail to install on DPM instances

Cause: DPM instances may have a pending required reboot, and anti-malware may have prevented the installation of a patch specific to Active Directory.

Resolution: Reboot the DPM instances one at a time.

### Issue 2: Can't load NewtonSoft.json.dll

Cause: When completing, the P&U engine unloads loaded modules. During an update run that may have failed, the modules were unloaded. Therefore, PowerShell does not try to reload the modules.

Resolution: Start a new PowerShell console.

#### Issue 3: Can't load or find combinedModule.psd1

Cause: While the storage cluster is being updated, the infrastructure share may become unavailable for a brief moment while the share moves from one host to another. The error occurs if P&U tries to access a file on the share.

Resolution: Create a share for the P&U package and run P&U from the newly created share.

To do this, follow these steps:

1. Create a folder on the Console virtual machine that you name PUShare.
2. Right-click the folder, and then select **Properties**.
3. On the **Sharing** tab, select **Share**.
4. Add the "Prefix"-Setup-Admins group, and allow Read/Write permissions.
5. Use this share to run P&U.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
