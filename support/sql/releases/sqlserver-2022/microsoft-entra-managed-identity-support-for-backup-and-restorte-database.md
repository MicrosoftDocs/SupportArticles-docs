---
title: Microsoft Entra managed identity support for backup and restore database operations in SQL Server on Azure VM
description: Adds the support of Microsoft Entra managed identity for backup and restore database operations in SQL Server on Azure VM.
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5043526
ms.reviewer: derekw, pcaronauger, v-qianli2
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2019 on Linux
---
# Improvement: Microsoft Entra managed identity support for backup and restore database operations in SQL Server on Azure VMs

## Symptoms

The SQL Server instance might stop responding if you run a backup or restore database operation to Azure Storage using server-level credentials with managed identities. Although this operation isn’t supported for SQL Server 2022, the current T-SQL syntax allows it.

## Resolution

This problem is fixed in the following cumulative update for SQL Server on Azure virtual machines (VMs):

[Cumulative Update 15 for SQL Server 2022](cumulativeupdate15.md)

In the SQL Server 2022 CU15 and later versions, the server-level [credential]( /sql/t-sql/statements/create-credential-transact-sql#e-creating-a-credential-for-managed-identity) is enabled for the Microsoft Entra managed identity authentication with SQL Server on Azure VMs and supports database backup and restore operations to Azure Storage.

To enable the managed identity support for SQL Server on Azure VMs, the following steps are required:

1.	Assign the primary managed identity for the SQL Server on Azure VMs.
2.	Create or use Azure Storage with a blob container.
3.	Assign role-based access control (RBAC) roles for the primary managed identity to access the Azure Storage.
4.	Run the T-SQL command `CREATE CREDENTIAL` with the `WITH IDENTITY = ‘Managed Identity’`  clause using the Azure Storage URL as a credential name.
5.	Rxecute the T-SQL command `BACKUP/RESTORE DATABASE` using the Azure Storage URL.

```SQL
-- Create credential with managed identity and credential name set to
-- URL= https://<storageaccountname>.blob.core.windows.net/<container>   
CREATE CREDENTIAL [https://<storageaccountname>.blob.core.windows.net/<container>]  
 WITH IDENTITY = 'Managed Identity'  
-- Backup the database mydb to URL 
BACKUP DATABASE mydb 
 TO URL = 'https://<storageaccount>.blob.core.windows.net/<container>/mydb.bak'  
-- Restore the database mydb1 from URL
RESTORE DATABASE mydb1  
 FROM URL ='https://<storageaccount>.blob.core.windows.net/<container>/mydb.bak'  
```
Trace flag 4675, disabled by default, allows troubleshooting the server-level credential and can be used to confirm the primary managed identity that is assigned to the SQL Server instance. 

For more information, see [SQL Server backup to URL for Microsoft Azure Blob Storage]( /sql/relational-databases/backup-restore/sql-server-backup-to-url).

> [!NOTE]
> - The managed identity support doesn’t introduce any T-SQL syntax or system view changes, since this functionality already exists for Azure SQL Managed Instance. 
>- Managed identities aren’t supported for the server-level credential on SQL Server on-premises. When accidentally used with backup or restore to Azure Storage, you see the error message “The primary managed identity is not set for the server and refers to the public documentation. ”

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

- [Configure managed identities on Azure virtual machines (VMs)](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities)
- [Enable Microsoft Entra authentication for SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/configure-azure-ad-authentication-for-sql-vm)
- [CREATE CREDENTIAL (Transact-SQL)](/sql/t-sql/statements/create-credential-transact-sql#e-creating-a-credential-for-managed-identity)
- [SQL Server backup to URL for Microsoft Azure Blob Storage](/sql/relational-databases/backup-restore/sql-server-backup-to-url)
- [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql)
