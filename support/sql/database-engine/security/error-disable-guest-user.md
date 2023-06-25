---
title: Error when you disable the guest user
description: This article describes various issues that can occur when you disable the guest user in the msdb database in SQL Server.
ms.date: 11/19/2020
ms.custom: sap:Security Issues
---
# You should not disable the guest user in the msdb database in SQL Server

This article describes various issues that can occur when you disable the guest user in the msdb database in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2539091

## Symptoms when the guest user is disabled in the msdb database

In order for some Microsoft SQL Server features to work, the guest user _must_ be enabled in the msdb database. This article describes some issues that you may experience if you disable the guest user in the msdb database. The article also provides information about how to resolve those issues.

When the guest user is disabled in the msdb database, you may receive error [MSSQLSERVER_916](/sql/relational-databases/errors-events/mssqlserver-916-database-engine-error) when user expands Databases node in Management Studio expands or when a server application tries to connect to SQL Server. You may experience one or more of the following symptoms in your environment when this issue occurs.

> [!NOTE]
> The text of the error may slightly vary, depending on the scenario. However, the underlying cause is essentially the same. That cause is insufficient privileges in the msdb database. These symptoms occur when Object Explorer tries to show the Policy Based Management status of each database. Object Explorer uses the permissions of the current logon to query the msdb database for this information, which causes the error.

## Symptom 1

In SQL Server 2012 and later environments, when a user who is not a member of the Sysadmin fixed server role in SQL Server and not otherwise granted appropriate permissions in msdb tries to expand the Databases node or any of the folders under that node, they receive an error message that resembles the following:

> Cannot show requested dialog.
ADDITIONAL INFORMATION:
Cannot show requested dialog. (SqlMgmt)
An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo)

The server principal \<username> is not able to access the database msdb under the current security context. (Microsoft SQL Server, Error: 916)

## Symptom 2

In SQL Server 2008 and SQL Server 2008 R2 environments, when a user who is not a member of the Sysadmin fixed server role in SQL Server and not otherwise granted appropriate permissions in msdb tries to expand the Databases node or any of the folders under that node, they receive an error message that resembles the following:

> Failed to retrieve data for this request. (Microsoft.SqlServer.Manager.Sdk.Sfc)  
Additional Information:  
An exception occurred while executing a Transact-SQL statement or batch.  
(Microsoft.SqlServer.ConnectionInfo)  
The server principal \<Servername> is not able to access the database “msdb” under the current security context. (Microsoft SQL Server, Error: 916)

> [!NOTE]
> Expanding the Database node is just one of the activities that requires connect permission for the guest account to the msdb database. A similar error can occur with any activity that requires at least minimal access to the msdb database.

## How to determine the issue

To determine whether the guest user is configured correctly in the msdb database, run the following query as a member of the sysadmin fixed server role:

```sql
USE msdb;

SELECT prins.name AS grantee_name, perms.*

FROM sys.database_permissions AS perms

JOIN sys.database_principals AS prins

ON perms.grantee_principal_id = prins.principal_id

WHERE prins.name = 'guest' AND perms.permission_name = 'CONNECT';

GO
```

If you receive a result set that resembles the following, the guest user has the necessary permissions.

|grantee_name|class|class_desc|major_id|minor_id|grantee_principal_id|grantor_principal_id|type|permission_name|state|state_desc|
|---|---|---|---|---|---|---|---|---|---|---|
|guest|0|DATABASE|0|0|2|1|CO|CONNECT|G|GRANT|

If you receive either an empty result set or if the `state_desc` shows DENY in the result set that is mentioned here, the guest user is disabled in the msdb database. You may receive error 916 when you connect to a database.

## How to resolve the issue

To resolve the issue, run the following query in SQL Server Management Studio as a member of the sysadmin fixed server role:

```sql
USE msdb;

GRANT connect TO guest;

GO
```

## References

- [Guest Permissions on User Databases](/sql/relational-databases/policy-based-management/guest-permissions-on-user-databases)

- [Securing SQL Server](/sql/relational-databases/security/securing-sql-server)
