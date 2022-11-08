---
title: DPM is unable to enumerate SqlServerWriter
description: Fixes an issue in which you receive error 3055 when creating a protection group for a SQL Server database in System Center Data Protection Manager 2010.
ms.date: 07/27/2020
ms.reviewer: dpmsee
---
# Unable to protect a SQL Server database from System Center Data Protection Manager 2010

This article helps you resolve an issue in which you receive error 3055 when creating a protection group for a SQL Server database in System Center Data Protection Manager 2010.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2691955

## Symptoms

While trying to create a protection group for a SQL Server database in System Center Data Protection Manager 2010, you may receive the following error:

> DPM is unable to enumerate SqlServerWriter on computer ServerHostName.contoso.COM (ID: 3055)  

## Cause

This problem occurs when the following conditions are true:

- The SQL Server is in an untrusted domain or a workgroup.
- The SQL Server database is configured with mirroring.
- You are trying to protect a mirrored SQL Server database on the principle server.

## Resolution

Protection of a mirrored SQL Server database in untrusted domains or workgroups, and even protection of a mirrored SQL Server database on a principle server, is not supported by System Center Data Protection Manager 2010. For more supportability information about SQL Server protection, see [Managing Protected Computers in Workgroups and Untrusted Domains](/previous-versions/system-center/data-protection-manager-2010/ff634170(v=technet.10)?redirectedfrom=MSDN).
