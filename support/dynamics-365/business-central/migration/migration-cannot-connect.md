---
title: "Can't connect to SQL database"
description: Troubleshooting article for connection issues to SQL database in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/24/2024
---

# "Can't connect to SQL Database, ErrorCode=SqlFailedToConnect"

This article explains how to troubleshoot the **Cannot connect to SQL Database, ErrorCode=SqlFailedToConnect** error message when you try to connect to an SQL database.

## Symptom

You get the **Cannot connect to SQL Database, ErrorCode=SqlFailedToConnect** error message when you try to connect to an SQL database. This error often occurs together with the error **Check the linked service configuration is correct, and make sure the SQL Database firewall allows the integration runtime to access.**

## Cause

There can be several reasons for the error message. The most common reason is returned inside of the long error message, for example:

"Login failed for user …", "The password of the account must be changed", "The account is disabled" - problems with the user account.
"The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections." - the SQL Server isn't running, or remote access to the SQL Server is disabled.

## Resolution

Run the following Windows PowerShell command on the Integration Runtime host. If the Integration Runtime host can't connect, it returns a descriptive error.

```powershell
sqlcmd –S "{SQL Server Name}" -d "{Database Name}" -U "{SQL Server Authenticated User Name}" -P "{PlaceholderSQLServerAuthenticatedPassword}" -Q 'select * from [dbo].[Intelligent Cloud]'
```

To allow the Integration Runtime client IP address to access the SQL server, run the following command on the on-premises master database:

```powershell
sp_set_firewall_rule
```

To allow remote access to the SQL Server:

```powershell
run sp_configure 'remote access', 1; 
```
