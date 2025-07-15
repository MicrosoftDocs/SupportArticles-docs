---
title: Microsoft Entra managed identity support for backup and restore database operations and for EKM with AKV in SQL Server on Azure VMs
description: Adds the support of Microsoft Entra managed identity for backup and restore database operations and for EKM with AKV in SQL Server on Azure Windows VMs.
ms.date: 01/16/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5043526
ms.reviewer: mireks, alswanso, v-qianli2
appliesto:
- SQL Server 2022 on Azure VM (Windows only)
---
# Improvement: Microsoft Entra managed identity support for backup and restore database operations and for EKM with AKV in SQL Server on Azure VMs

## Symptoms

The SQL Server instance might stop responding if you run a backup or restore database operation to Azure Storage or use Extensible Key Management (EKM) with Azure Key Vault (AKV) using server-level credentials with managed identities. Although this operation isn't supported for SQL Server 2022, the current T-SQL syntax allows it.

## Resolution

This problem is fixed in the following cumulative update for SQL Server on Azure virtual machines (VMs):

[Cumulative Update 17 for SQL Server 2022](cumulativeupdate17.md)

In the SQL Server 2022 CU17 and later versions, the Microsoft Entra managed identity authentication with SQL Server on Azure Windows only VMs supports the server-level [credential]( /sql/t-sql/statements/create-credential-transact-sql#e-creating-a-credential-for-managed-identity) for database backup and restore operations to Azure Storage and for EKM with AKV.

To enable the managed identity support for backup or restore database operations for SQL Server on Azure Windows VMs, the following steps are required:

1.	Assign the primary managed identity for the SQL Server on Azure Windows VMs.
2.	Create or use Azure Storage with a blob container.
3.	Assign role-based access control (RBAC) roles for the primary managed identity to access the Azure Storage.
4.	Run the T-SQL command `CREATE CREDENTIAL` with the `WITH IDENTITY = 'Managed Identity'`  clause using the Azure Storage URL as a credential name.
5.	Run the T-SQL command `BACKUP DATABASE` or `RESTORE DATABASE` using the Azure Storage URL.

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

For more information, see [Backup and restore to URL using managed identities](/azure/azure-sql/virtual-machines/windows/backup-restore-to-url-using-managed-identities).

To enable the managed identity support for EKM with AKV for SQL Server on Azure Windows VMs, the following steps are required:

1.	Assign the primary managed identity for the SQL Server on Azure Windows VMs.
2.	Create or use a key vault.   
3.	Assign role-based access control (RBAC) roles for the primary managed identity to access the AKV.
4.	Download the latest [SQL Server Connector for Microsoft Azure Key Vault](https://www.microsoft.com/download/details.aspx?id=45344) (the 1.0.5.0 (November 2024) or later versions). The latest version of the SQL Server Connector is required to support the managed identity.
5.	Run the T-SQL command `CREATE CREDENTIAL` with the `WITH IDENTITY = 'Managed Identity'` clause using the AKV path as a credential name.

```SQL
-- Create credential with managed identity and the credential name for the AKV called 'contoso'
-- with the AKV path = 'contoso.vault.azure.net'  
CREATE CREDENTIAL [contoso.vault.azure.net]  
 WITH IDENTITY = 'Managed Identity'  
 FOR CRYPTOGRAPHIC PROVIDER AzureKeyVault_EKM_Prov 
```
6. Run the rest of the T-SQL setup of EKM with AKV.

For more information, see [Managed Identity Support for Extensible Key Management with Azure Key Vault](/azure/azure-sql/virtual-machines/windows/managed-identity-extensible-key-management).

> [!NOTE]
> - [Trace flag 4675](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql), disabled by default, allows troubleshooting the server-level credential and can be used to confirm the primary managed identity that is assigned to the SQL Server instance. 
> - The managed identity support doesn't introduce any T-SQL syntax or system view changes, since this functionality already exists for Azure SQL Managed Instance. 
> - Managed identities aren't supported for the server-level credential on SQL Server on-premises. When accidentally used with backup or restore to Azure Storage or the EKM with AKV, you see the error message "The primary managed identity is not set for the server..." and are referred to the public documentation.

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

- [Configure managed identities on Azure virtual machines (VMs)](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities)
- [Enable Microsoft Entra authentication for SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/configure-azure-ad-authentication-for-sql-vm)
- [CREATE CREDENTIAL (Transact-SQL)](/sql/t-sql/statements/create-credential-transact-sql#e-creating-a-credential-for-managed-identity)
- [Backup and restore to URL using managed identities](/azure/azure-sql/virtual-machines/windows/backup-restore-to-url-using-managed-identities)
- [Managed Identity Support for Extensible Key Management with Azure Key Vault](/azure/azure-sql/virtual-machines/windows/managed-identity-extensible-key-management)
- [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql)
