---
title: Disk duplication of Windows installations
description: Describes the SID and supported methods for cloning or duplicating a Windows installation.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:deduplication, csstroubleshoot
---
# The Microsoft policy for disk duplication of Windows installations

This article describes the SID and supported methods for cloning or duplicating a Windows installation.

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client  
_Original KB number:_ &nbsp; 314828

## Summary

When you deploy a duplicated or imaged Windows installation, it is required that the System Preparation (Sysprep) tool is used before the capture of the image. Sysprep prepares an installation of Microsoft Windows for duplication, auditing, and customer delivery. For Windows 2000, Windows XP, and Windows Server 2003, Sysprep is included with the latest service pack Deploy.cab. For later versions of Windows, Sysprep is included with the operating system, and Sysprep is located in the folder: `%windir%\system32\sysprep`.

## More information

Sysprep is responsible for removing system-specific data from Windows, such as the Computer SID. During installation of Windows, a computer SID is computed to contain a statistically unique 96-bit number. The computer SID is the prefix of the user account and group account SIDs that are created on the computer. The computer SID is concatenated together with the Relative ID (RID) of the account to create the account's unique identifier.

The following example displays the SIDs for four local user accounts. Only the last four digits are incremented as new accounts are added.

HKEY_USERS on local machine

S-1-5-21-191058668-193157475-1542849698-500 Administrator
S-1-5-21-191058668-193157475-1542849698-1000 User 1a
S-1-5-21-191058668-193157475-1542849698-1001 User 2
S-1-5-21-191058668-193157475-1542849698-1002 User 3

Cloning or duplicating an installation without taking the recommended steps could lead to duplicate SIDs. For removable media, a duplicate SID might give an account access to files even though NTFS permissions for the account specifically deny access to those files. Because the SID identifies both the computer or domain and the user, unique SIDs are necessary to maintain support for current and future programs. For more information about issues that might occur if you clone an installation of Windows 8 or of Windows Server 2012, go to the [Windows 8 and Windows Server 2012 specific information](#windows-8-and-windows-server-2012-specific-information) section.

In addition to the computer SID, many other components and features must be cleaned up, generalized, or specialized in order to be imaged. Some examples include the following:

- Event logs
- Network settings
- Windows Media player settings
- Shell settings
- Licensing

> [!NOTE]
> This is not a comprehensive list.

We support the following operating systems that are prepared by using the Sysprep utility and then imaged:

- Windows NT Workstation 4.0
- Windows NT Server 4.0 (stand-alone server, not primary domain controllers or backup domain controllers)
- Windows 2000 Professional
- Windows 2000 Server (must be imaged before you run DCPromo)
- Windows 2000 Advanced Server
- Windows XP Home Edition
- Windows XP Professional
- Windows Server 2003, Standard Edition
- Windows Server 2003, Datacenter Edition
- Windows Server 2003, Enterprise Edition
- Windows Server 2003, Web Edition
- All versions of Windows Vista
- All versions of Windows Server 2008
- All versions of Windows 7
- All versions of Windows Server 2008 R2
- All versions of Windows 8
- All versions of Windows Server 2012
- All versions of Windows 10
- All versions of Windows Server 2016
- All versions of Windows Server 2019
- All versions of Windows Server 1903
- All versions of Windows Server, version 1909
- All versions of Windows 11

We do not provide support for computers that are set up by using SID-duplicating tools other than the System Preparation tool. For example, this includes the following:

- [NewSID](/sysinternals/downloads/newsid)
- GhostWalker

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

> [!NOTE]
> If an image was created without using Sysprep, we do not support the running of Sysprep after the image is deployed as a way to bring the computer back into compliance. Sysprep must be run before the capture of the image.

## Windows 8 and Windows Server 2012 specific information

If you clone a Windows 8 or Windows Server 2012 image or virtual machine without running `sysprep.exe /generalize`, P2V and keep the physical computer up and running or create a backup of a computer but keep the original computer running you may experience issues in which push notifications do not work. For example, you may experience the following issues:

- Tile, badge, and toast notifications do not update even though Internet connectivity is available.
- Apps that rely on RAW notification do not work as expected. For example, you notice significantly reduced functionality in Mail, Calendar, and Messaging.
- It takes a long time to synchronize changes for roaming and family safety settings.
To resolve these issues, use one of the following methods:
- Configure the computers by using the Sysprep /generalize command, and then deploy the image.
- Replace the existing user account with a new account. The device identifier is stored as part of the user profile. Each new NTUser account that is added to a computer will receive a new identifier.

## References

For more information about the Windows System Preparation Tool, visit the following Microsoft websites:

- Windows Server 2003 [What Is Sysprep?](/previous-versions/windows/it-pro/windows-server-2003/cc783215(v=ws.10))
- Windows 8 and Windows Server 2012 [Sysprep Overview](/previous-versions/windows/it-pro/windows-8.1-and-8/hh825209(v=win.10))

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
