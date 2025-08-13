---
title: IVssBackupComponents returns a value of 0x1 or S_FALSE
description: "This article describes an issue where the IVssBackupComponents::Query method may return a value of 0x1 or S_FALSE."
ms.date: 01/04/2021
ms.reviewer: chrit
ms.custom: sap:Other Driver
---
# IVssBackupComponents::Query returns a value of 0x1 or S_FALSE

This article describes an issue where the `IVssBackupComponents::Query` method may return a value of **0x1** or **S_FALSE**.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 2940851

## Summary

When you use the `IVssBackupComponents::Query` method to query providers on the system and on the completed shadow copies in the system, the query may return a value of **0x1** or **S_FALSE**.

> [!NOTE]
> These values are not listed on the [IVssBackupComponents::Query method (vsbackup.h)](/windows/win32/api/vsbackup/nf-vsbackup-ivssbackupcomponents-query) webpage on the Microsoft Developer Network (MSDN) website.

## More information

The `IVssBackupComponents::Query` method currently returns a list of all available providers and all completed shadow copies. This return value may also mask a failure of a provider that is installed on the system because we query all providers on the system. If the other providers on the system have no snapshots, the query method may return a value of **0x1** or **S_FALSE** instead of the expected return value of **VSS_E_OBJECT_NOT_FOUND**.

## Applies to

- Windows Server 2012 Datacenter
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
- Windows Server 2012 Standard
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 Datacenter
- Windows Server 2008 Enterprise
- Windows Server 2008 Standard
- Windows Server 2003 R2 Datacenter x64 Edition
- Windows Server 2003 R2 Enterprise Edition (32-Bit x86)
- Windows Server 2003 R2 Enterprise x64 Edition
- Windows Server 2003 R2 Standard Edition (32-bit x86)
- Windows Server 2003 R2 Standard x64 Edition
- Windows Server 2003 Datacenter x64 Edition
- Windows Server 2003 Enterprise Edition (32-bit x86)
- Windows Server 2003 Enterprise x64 Edition
