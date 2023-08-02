---
title: Can't restore backups from SQL Server that uses SQL Server Connector for Key Vault
description: This article helps you resolve the error 33111 while restoring backups from the previous versions of SQL Server.
ms.date: 10/11/2022
ms.custom: sap:Administration and Management
ms.reviewer: v-jayaramanp
---

# Error 33111 when restoring backups from older versions of SQL Server Connector for Microsoft Azure Key Vault

_Original KB number:_ &nbsp;  4470999

This article discusses an error that occurs when you try to restore a Transparent Data Encryption (TDE) backup that's made on servers that use older versions of SQL Server Connector for the Microsoft Azure Key Vault.

## Symptoms

You experience problems when you try to restore a database backup from SQL Server that uses SQL Server Connector for Key Vault 1.0.4.0 or an earlier version to SQL Server Connector for Microsoft Azure Key Vault 1.0.5.0.

Assume that you deploy the following instances of Microsoft SQL Server:

- SQL Server instance `sql1` has SQL Server Connector for Key Vault 1.0.4.0 deployed.

- SQL Server instance `sql2` has SQL Server Connector for Key Vault 1.0.5.0 deployed.

- Use the following query to deploy an asymmetric key on both `sql1` and `sql2` instances from the same asymmetric key source in Key Vault:

    ```sql
    CREATE ASYMMETRIC KEY TDE_KEY 
    FROM PROVIDER AzureKeyVaultProvider 
    WITH PROVIDER_KEY_NAME = 'key1', 
    CREATION_DISPOSITION = OPEN_EXISTING
   ```

If you review the value of thumbprints on both servers, you will notice that the thumbprint lengths differ though they're created from the same source. The version 1.0.5.0 thumbprint is longer than version 1.0.4.0.

Example of 1.0.4.0 thumbprint:

`0x2C5677D76F76D77F80`

Example of 1.0.5.0 thumbprint:

`0x373B314B78E8D59A0925494558FEF14B726216C5`

The change causes problems to occur during backup and restore operations.

Example:

You have a database backup that is encrypted by an asymmetric key in Key Vault in the `sql1` instance.

The `sql2` instance has an asymmetric key created.

If you try to restore the backup on the `sql2` instance, the operation fails and returns an error message that resembles the following message:

> Msg 33111, Level 16, State 4, Line \<LineNumber>
>
> Cannot find server asymmetric key with thumbprint '0x2C5677D76F76D77F80'.

Notes:

The query to retrieve the thumbprint of each key is as follows:

```sql
SELECT thumbprint, * FROM master.sys.asymmetric_keys
```

The query to retrieve the thumbprint of each TDE database is as follows:

```sql
SELECT DatabaseName(ddek.database_id) AS DatabaseName, ak.name
AS [Asymmetric key Name], ak.thumbprint FROM
sys.dm_database_encryption_keys ddek INNER JOIN
master.sys.asymmetric_keys ak ON
ak.thumbprint = ddek.encryptor_thumbprint
```

## Cause

An update was introduced in version 1.0.5.0 of SQL Server Connector for Key Vault that changes the way that the program calculates thumbprints. In version 1.0.5.0, this calculation matches the logic that's used by the program engine to support the following migration scenario:

From: On-premises Microsoft SQL Server that uses Extensible Key Management (EKM)

To: Microsoft Azure SQL Database that uses Bring Your Own Key (BYOK) support for Transparent Data Encryption (TDE)

Because of this change, you might experience problems when you try to restore database backups from version 1.0.4.0 or an earlier version.

## Resolution

1. Copy the SQL Server Connector for Key Vault 1.0.4.0 or an earlier version to the `sql2` instance server.

1. Run the following query on the `sql2` server to change the `CRYPTOGRAPHIC PROVIDER` to version 1.0.4.0:

     ```sql
     ALTER CRYPTOGRAPHIC PROVIDER AzureKeyVaultProvider
     FROM FILE =
     'FilePath\FileName\SQL Server Connector for Microsoft Azure Key Vault\1.0.4.0\Microsoft.AzureKeyVaultService.EKM.dll'
    ```

   1. Restart SQL Server.

   1. Create a new asymmetric key by using `CRYPTOGRAPHIC PROVIDER` 1.0.4.0.

         ```sql
           CREATE ASYMMETRIC KEY TDE_KEY_1040 
           FROM PROVIDER AzureKeyVaultProvider 
           WITH PROVIDER_KEY_NAME = 'key1', 
           CREATION_DISPOSITION = OPEN_EXISTING
        ```

1. You can confirm the existence of both the asymmetric keys by using the following query:

    ```sql
    SELECT thumbprint,* FROM master.sys.asymmetric_keys
    ```

1. Add credentials to asymmetric-key mapped login (TDE_Login in the following example) by using a query similar to the following query:

    ```sql
    ALTER LOGIN [Contoso\DomainUser] DROP CREDENTIAL sysadmin_ekm_cred; 
    ALTER LOGIN TDE_Login ADD CREDENTIAL sysadmin_ekm_cred;
    ```

1. You should now be able to restore the backup.

1. Run the following query on `sql2` to revert the `CRYPTOGRAPHIC PROVIDER` to version 1.0.5.0:

    ```sql
    ALTER CRYPTOGRAPHIC PROVIDER AzureKeyVaultProvider 
    FROM FILE =
    'FilePath\FileName\SQL Server Connector for Microsoft Azure Key Vault\1.0.5.0\Microsoft.AzureKeyVaultService.EKM.dll'
   ```

1. Restart SQL Server.

1. To use the new thumbprint, run the following query by using either the same asymmetric key or the new version asymmetric key.

    ```sql
    ALTER DATABASE ENCRYPTION KEY
    ENCRYPTION BY SERVER ASYMMETRIC KEY <KeyName_1.0.5.0_version>
    ```
