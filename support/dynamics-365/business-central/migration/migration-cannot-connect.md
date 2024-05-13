---
title: Cannot connect to SQL database with SqlFailedToConnect
description: Provides a resolution for a SQL database connection issue in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.date: 05/13/2024
---
# "Cannot connect to SQL Database, ErrorCode=SqlFailedToConnect" error in Business Central cloud migration

This article solves the "Cannot connect to SQL Database, ErrorCode=SqlFailedToConnect" error message that occurs when you try to connect to a SQL database in [Business Central cloud migration](/dynamics365/business-central/dev-itpro/administration/migration-manage).

## Symptoms

When you try to connect to a SQL database in Business Central cloud migration, you receive the following error message:

> Cannot connect to SQL Database, ErrorCode=SqlFailedToConnect.

This error message often occurs together with the following error message:

> Check the linked service configuration is correct, and make sure the SQL Database firewall allows the integration runtime to access.

## Cause

There can be several reasons for the error message. The most common reason is returned inside of the long error message, for example:

- Problems with the user account:

  > Login failed for user...

  > The password of the account must be changed.

  > The account is disabled.

- The SQL Server isn't running, or remote access to the SQL Server is disabled:

  > The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.

## Resolution

To solve this issue, run the following Windows PowerShell command on the Integration Runtime host. If the Integration Runtime host can't connect, it returns a descriptive error.

```powershell
sqlcmd –S "{SQL Server Name}" -d "{Database Name}" -U "{SQL Server Authenticated User Name}" -P "{PlaceholderSQLServerAuthenticatedPassword}" -Q 'select * from [dbo].[Intelligent Cloud]'
```

To allow the Integration Runtime client IP address to access the SQL Server, run the following command on the on-premises master database:

```powershell
sp_set_firewall_rule
```

To allow remote access to the SQL Server, run the following command:

```powershell
run sp_configure 'remote access', 1; 
```
