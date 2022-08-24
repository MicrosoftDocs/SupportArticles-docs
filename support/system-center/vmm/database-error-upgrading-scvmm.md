---
title: Can't upgrade to SCVMM 2012 R2 from SCVMM 2012 SP1 
description: Discusses that an upgrade from SCVMM 2012 SP1 to SCVMM 2012 R2 fails because the Virtual Machine Manager database can not be upgraded. Provides a resolution.
ms.date: 04/26/2020
---
# Database can not be upgraded error when upgrading from SCVMM 2012 SP1 to SCVMM 2012 R2

This article helps you fix an issue in which you can't upgrade from Microsoft System Center 2012 Virtual Machine Manager Service Pack 1 to System Center 2012 R2 Virtual Machine Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2960054

## Symptoms

When you try to upgrade from Microsoft System Center 2012 Virtual Machine Manager (SCVMM) Service Pack 1 (SP1) to System Center 2012 R2 Virtual Machine Manager, the process fails, and you receive the following error message:

> The Virtual Machine Manager database can not be upgraded. The Virtual Machine Manager VirtualManagerDB was not upgraded. Try a new database and run setup again.

## Cause

This problem occurs because SCVMM 2012 R2 requires that the `VirtualManagerDB` database and the Microsoft SQL Server instance be at level of SQL Server 2008 R2 Service Pack 2 (SP2) or a later version.

## Resolution

To resolve this problem, follow these steps:

1. Upgrade the SQL Server instance to SQL Server 2008 R2 SP2.
2. Raise the level of the `VirtualManagerDB` database to SQL Server 2008 R2 SP2.

## More Information

For more information about the SQL Server instance level, see the following Microsoft topic:

[System Requirements: VMM Database](/previous-versions/system-center/system-center-2012-R2/gg610574(v=sc.12)?redirectedfrom=MSDN)

> [!NOTE]
> This topic does not mention that the SQL Server-based VMM database must also be at level of SQL Server 2008 R2 SP2 or a later version.
