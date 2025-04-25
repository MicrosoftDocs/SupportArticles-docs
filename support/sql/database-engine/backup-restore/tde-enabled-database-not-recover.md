---
title: A TDE-enabled database might not recover
description: This article provides a resolution for the problem where a TDE-enabled database might not recover when automatic encryption of the master key by the service master key is removed.
ms.date: 04/25/2025
ms.custom: sap:Database Backup and Restore
ms.reviewer: VenCher, SureshKa 
---
# A TDE-enabled database might not recover in SQL Server

This article helps you resolve the problem where a TDE-enabled database might not recover when automatic encryption of the master key by the service master key (SMK) is removed.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2666213

## Symptoms

In Microsoft SQL Server, a database that's enabled for transparent database encryption (TDE) may not recover. And, the following error message may be logged in the SQL Server error log:

> 2012-01-14 22:16:26.47 spid20s Error: 15581, Severity: 16, State: 3.  
2012-01-14 22:16:26.47 spid20s Please create a master key in the database or open the master key in the session before performing this operation.

## Cause

This issue occurs when service master key encryption for the database master key in the master database is removed when the following command is run:

```sql
USE MASTER
GO
ALTER MASTER KEY DROP ENCRYPTION BY SERVICE MASTER KEY
```

When a database master key (DMK) is first created, it's automatically encrypted with the SMK.

The database master key is used to encrypt the certificate that is used by the Transparent Database Encryption feature. Any attempt to use the TDE-enabled database requires access to the certificate and the database master key in the master database. Under default configuration, the DMK is implicitly opened by the SMK. A master key that isn't encrypted by the service master key must be opened explicitly by using the `OPEN MASTER KEY` statement together with a password on each session that requires access to the master key.

Database recovery occurs on system sessions. If these sessions can't open the certificate and the DMK, the recovery can't be completed on a TDE-enabled database if the automatic decryption of DMK by SMK is removed. In this scenario, the database is marked as **Recovery Pending**.

## Resolution

To resolve the issue, enable automatic decryption of the master key. To do this, run the following commands:

```sql
USE MASTER
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD = '******'
```

```sql
ALTER MASTER KEY ADD ENCRYPTION BY SERVICE MASTER KEY
```

Take the database offline and bring it online using the `ALTER DATABASE <databasename> SET ONLINE` command.

Use the following query to determine whether automatic decryption of the master key by the service master key was disabled for the master database:

```sql
SELECT is_master_key_encrypted_by_server FROM sys.databases WHERE NAME = 'master'
```

If this query returns a value of 0, automatic decryption of the master key by the service master key was disabled.
