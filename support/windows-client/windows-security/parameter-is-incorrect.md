---
title: Parameter is incorrect
description: Provides a solution to an error when you try to enable BitLocker if you don't have a separate active partition.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joscon, manojse
ms.custom: sap:Windows Security Technologies\BitLocker, csstroubleshoot
---
# Parameter is incorrect error message when you try to enable  BitLocker if you don't have a separate active partition in Windows Server 2008 Core and Windows 2008 R2 Core Edition

This article provides a solution to an error when you try to enable BitLocker if you don't have a separate active partition.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2019926

## Symptoms

When you try to enable BitLocker drive encryption on the operating system drive (typically drive C) by using the `manage-bde.exe -on` command, you may receive the following error message:

> ERROR: An error occurred \<code 0x80070057\>  
The parameter is incorrect

## Cause

This problem occurs if you don't have a separate active system partition on the operating system drive.

## Resolution

To resolve this issue, create a separate active system partition that can be used by BitLocker. The steps in this process vary, depending on the operating system that you're using and on whether you're using the `manage-bde` command or the BitLocker setup wizard.

Assume that you're upgrading from an earlier version of Windows or that you're installing Windows 7 or Windows Server 2008 R2 on a new computer that has a single partition. When you enable BitLocker from Control Panel or from Windows Explorer in this situation, the BitLocker setup wizard automatically configures the target drive for the separate active system partition. However, in some rare instances, you may have to manually prepare the drive for BitLocker. In this situation, use one of the following methods, as appropriate for your operating system.

**Windows Server 2008 or Windows Vista:**

Use the BitLocker Drive Preparation tool that is discussed in [Description of the BitLocker Drive Preparation Tool](https://support.microsoft.com/help/933246) to create a separate active system partition that can be used by BitLocker.

**Windows 2008 Core or Windows Server 2008 R2 with BitLocker feature installed:**

Use the BitLocker Drive Preparation tool to create a separate active system partition that can be used by BitLocker. You can find this tool in the `C:\Windows\System32` directory.

Use the following `bdehdcg.exe` command line to create a system partition for BitLocker:  
    **bdehdcfg -target c: shrink -newdriveletter s: -size 300**  

> [!NOTE]
> In this command line, "c" represents the operating system drive, "s" represents the drive letter for the new system partition, and "300" represents the size of the partition in megabytes (MB).

You must restart the computer to complete this operation.

> [!NOTE]
> The Bdehdcfg.exe utility not available in Windows Server 2008 R2 Core. To use this utility in Windows Server 2008 R2 Core, copy the following three files from the `C:\Windows\System32` directory of a computer that is running Windows 2008 R2 Enterprise, Windows 2008 R2 Standard, or Windows 2008 R2 Web Full Edition to the `C:\Windows\System32` directory of the Windows 2008 R2 2008 R2 Core-based computer that is generating the error:
>
> - Bdehdcfg.exe
> - Bdehdcfglib.dll
> - Reagent.dll

## More information

- [Enabling BitLocker by Using the Command Line](/previous-versions/windows/it-pro/windows-7/dd894351(v=ws.10))
- [Using the BitLocker Drive Preparation Tool for Windows 7](/previous-versions/windows/it-pro/windows-7/dd875534(v=ws.10))
