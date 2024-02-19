---
title: Issues when you migrate to domain with ADMT 3.1
description: Describes issues that you may experience when you use Active Directory Migration Tool 3.1 to migrate Active Directory data to a Windows Server 2008 R2 domain.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scheung
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
---
# Known issues that may occur when you use ADMT 3.1 to migrate to a domain that contains Windows Server 2008 R2 domain controllers

This article describes known issues that you may experience when you use Active Directory Migration Tool 3.1 to migrate Active Directory data to a domain, and provides help to resolve these issues.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 976659

## Summary

Although Active Directory Migration Tool (ADMT) 3.1 is not intended to target Windows Server 2008 R2, Microsoft has verified that this tool can be used to migrate Active Directory data to a domain hosted by one or more Windows Server 2008 R2 domain controllers. However, there are known issues with this approach. This article outlines these issues and provides workarounds.

## More information

The following list describes updated supported scenarios for using ADMT 3.1:

- ADMT 3.1 must be run from a Windows Server 2008-based computer. The computer must be a member server or a domain controller.
- ADMT can be installed on any computer that is running Windows Server 2008, unless the computers are Read-Only domain controllers or in a Server Core configuration.
- The target domain must be based on Windows 2000 Server, Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2.
- The source domain must be based on Windows 2000 Server, Windows Server 2003, or Windows Server 2008.
- The ADMT agent, which is installed by ADMT on computers in the source domains, can operate on computers that are running Windows 2000 Professional, Windows 2000 Server, Windows XP, Windows Server 2003, Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2.  

> [!NOTE]
> If you do not have Windows Server 2008 because you upgraded from Windows 2000 or Windows Server 2003 to Windows Server 2008 R2, you do have downgrade rights. To obtain product keys and media for Windows Server 2008 R2, visit [this site](https://www.microsoft.com/windowsserver2008/en/us/downgrade-rights.aspx).

## Known issues

The following known issues may occur when you use ADMT 3.1 to migrate data to a Windows Server 2008 R2 Active Directory environment:

- The Computer Migration Wizard lists Managed Service Accounts as selectable objects. These objects cannot be migrated by using ADMT 3.1. Although these objects can be selected, the wizard will fail (non-blocking) migrations of these objects and exit with an error.

    Managed Service Account is a new Windows Server 2008 R2 feature. For more information, visit the following Microsoft Web page:

    [What's New in Service Accounts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd367859(v=ws.10))

- Security translation on registry keys may fail (nonblocking). When the issue occurs, the administrator may receive an error message that resembles any of the following:

    ERR3:7330 Failed to open registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009, rc=714 The specified registry key is referenced by a predefined handle.

    ERR3:7330 Failed to open registry key HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Perflib\009, rc=714 The specified registry key is referenced by a predefined handle.

    ERR3:7331 Failed to enumerate registry key HKEY_DYN_DATA, rc=120 This function is not supported on this system.

- Multiple user password migration in a batch may fail for the first user password. When this issue occurs, the administrator may receive an error message that resembles the following:

    Unable to establish a session with the password expert server: The RPC server is unavailable

    To resolve this issue, perform the password migration again.
  - Scripted migration of users to populate the SID History fails when it is performed on a member server in the target domain. When you use the ADMT.EXE command-line tool or script to migrate SID history, you must perform the migration on a Windows Server 2008-based domain controller in the target domain.
  - The Admtdb.exe tool does not validate the version of a remote database instance. The administrator must make sure that the remote database server is running Microsoft SQL Server 2000 with Service Pack 4, SQL Server 2005, or a later version. For more information about migrating user accounts, visit the following Microsoft Web page: [Migrating All User Accounts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc974368(v=ws.10))
