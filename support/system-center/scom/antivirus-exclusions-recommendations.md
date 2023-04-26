---
title: Antivirus exclusions (Operations Manager 2012, 2012 R2, and 2016)
description: Describes some antivirus exclusions that relate to Operations Manager. These exclusions include process-based exclusions, directory-specific exclusions, and file name extension-specific exclusions.
ms.date: 04/26/2023
ms.reviewer: adoyle, adoyle, blakedrumm
---
# Antivirus exclusions that relate to Operations Manager 2012, 2012 R2, and 2016

This article shows antivirus exclusions that relate to System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager, and System Center 2016 Operations Manager. For later versions of Operations Manager, see [antivirus exclusions (Operations Manager 2019 and later)](/system-center/scom/plan-security-antivirus).

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager, System Center 2016 Operations Manager  
_Original KB number:_ &nbsp; 975931

## Exclusions by process executable

You must be careful when you add exclusions that are based on executables as incorrect exclusions may prevent some potentially dangerous programs from being detected. Because of this, we do not recommend that you rely on exclusions that are based on any process executables for Operations Manager servers. However, if you have to make exclusions that are based on the process executables, use the following processes:

- Monitoringhost.exe (Operations Manager 2012)
- Monitoringhost.exe (Operations Manager 2012 R2)
- MonitoringHost.exe (Operations Manager 2016)

## Exclusions by directories

The following directory-specific exclusions for Operations Manager include real-time scans, scheduled scans, and local scans. The directories that are listed here are default application directories so you may have to modify these paths based on your specific environment. Only the following Operations Manager related directories should be excluded.

> [!IMPORTANT]
> When a directory that is to be excluded has a directory name greater than 8 characters long, add both the short and long directory names of the directory to the exclusion list. These names are required by some antivirus programs to traverse the subdirectories.

### SQL Server database servers

These exclusions include the SQL Server database files that are used by Operations Manager components and the system database files for the master database and for the tempdb database. To exclude these files by directory, exclude the directory for the .ldf and .mdf files.

For example:

- C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data
- D:\MSSQL\DATA
- E:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log

### Operations Manager (management servers, gateways, and agents)

These exclusions include the Health Service cache, together with its queue and log files that are used by Operations Manager. Examples follow.

#### For Operations Manager 2012

`C:\Program Files\System Center Operations Manager\Agent\Health Service State`  
`C:\Program Files\System Center Operations Manager\Server\Health Service State`

#### For Operations Manager 2012 R2

- For a management server: `C:\Program Files\Microsoft System Center 2012 R2\Operations Manager\Server\Health Service State`

- For a gateway server: `C:\Program Files\System Center Operations Manager\Gateway\Health Service State`

- For an agent: `C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State`

#### For Operations Manager 2016

For the latest list of exclusions, see [Configuring antivirus exclusions for agent and components](/system-center/scom/plan-security-antivirus).

## Exclusion of file type by extensions

The following file name extension-specific exclusions for Operations Manager include real-time scans, scheduled scans, and local scans.

### SQL Server database servers

These exclusions include the SQL Server database files that are used by Operations Manager components and the system database files for the master database and for the tempdb database.

For example:

- MDF
- LDF

### Operations Manager (management servers, gateways, and agents)

These exclusions include the queue and log files that are used by Operations Manager.

For Example:

- EDB
- CHK
- LOG

> [!NOTE]
> Page files should also be excluded from any real-time scans.
