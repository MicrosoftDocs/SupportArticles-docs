---
title: Error (Could not load file or assembly) when you run DirSyncConfigShell.psc1 in Windows Server 2008 R2
description: Describes a scenario in which you receive an error when you run DirSyncConfigShell.psc1 after you install version 6765.0006 of the Directory Sync tool on a Windows Server 2008 R2-based computer.
ms.date: 05/22/2020
ms.reviewer: arrenc, willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Error when you run DirSyncConfigShell.psc1 in Windows Server 2008 R2: Could not load file or assembly

This article describes a scenario in which you receive an error when you run `DirSyncConfigShell.psc1` after you install version 6765.0006 of the Directory Sync tool on a Windows Server 2008 R2-based computer.

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2964373

## Symptoms

When you run `DirSyncConfigShell.psc1` after you install version 6765.0006 of the Microsoft Azure Active Directory Sync Tool on a Windows Server 2008 R2-based computer, you receive the following error message:

> WARNING: The following errors occurred when loading console c:\program files\Windows Azure Active Directory Sync\dirsyncfonfigshell.psc1: Cannot load Windows PowerShell snap-in coexistence-configuration because of the following error: could not load file or assembly 'file:///c:\programSync\Microsoft Online.Coexistence.PS.Config.dll' or one of its dependencies. This assembly is built by a runtime newer than the currently loaded runtime and cannot be loaded.
For example, this issue occurs when you run DirSyncConfigShell.psc1 to force directory synchronization.

## Cause

This issue occurs if Windows Management Framework 3.0 is not installed on the Windows Server 2008 R2-based computer.

## Resolution

Do one of the following:

- Install Windows Management Framework 3.0 on the Windows Server 2008 R2-based computer. For more information, see [Windows Management Framework 3.0](https://www.microsoft.com/download/details.aspx?id=34595).
- Run the Directory Sync tool from a Windows Server 2012 R2-based computer. To install the Directory Sync tool, see [Install or upgrade the Directory Sync tool](/azure/active-directory/hybrid/whatis-hybrid-identity).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
