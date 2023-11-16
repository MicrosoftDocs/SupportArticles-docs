---
title: Fix permission problem when you move MSDB database
description: This article provides resolutions for permission problems that occur when you move MSDB database between different instances.
ms.date: 07/22/2020
ms.custom: sap:Security Issues
ms.reviewer: ericbu
---
# Fix permission problems when moving MSDB database between different instances

This article helps you resolve the permission problems that occur when you move MSDB database between different instances.

_Original product version:_ &nbsp; Microsoft SQL Server  
_Original KB number:_ &nbsp; 2000274

## Symptoms

Consider the following scenario:

You move msdb database from one instance to another either using the backup and restore process or by copying over the database files (mdf and ldf). Then, on the destination server, a user who is not part of Sysadmin fixed role in SQL Server tries to do either of the following operations:

- View a job in SQL Server management studio.
- Call SQL agent related stored procedures (for example xp_sqlagent_enum_jobs or sp_get_composite_job_info) directly using T-SQL.

In this scenario, the user will get an error message similar to the following:

> An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo)  
The EXECUTE permission was denied on the object 'xp_sqlagent_enum_jobs', database 'mssqlsystemresource', schema 'sys'. (Microsoft SQL Server, Error: 229)  

## Cause

This issue occurs because the SQL Agent certificate is different on different instances.

## Resolution

To resolve the issue you need to replace the certificate in the master with the certificate from the restored *msdb* database by using the following script at the destination server:  

```sql
use msdb
go
-- Backup the Agent certificate from the remote server to a file
BACKUP CERTIFICATE [##MS_AgentSigningCertificate##] TO FILE = 'MS_AgentSigningCertificate.remote_server.cer'
go
use master
go
-- re-create the agent certificate on master
-- Note: Because we are making these changes using a regular user and not as part of setup, the name
-- cannot include the ## token.
-- Creating a regular certificate in this case should be the equivalent as we only need it to derive a SID
 CREATE CERTIFICATE [MS_AgentSigningCertificate.remote_server] FROM FILE = 'MS_AgentSigningCertificate.remote_server.cer'
go
-- Recreate the user mapped to the cert and grant the same permissions that the regular certificate needs.
CREATE USER [MS_AgentSigningCertificate.remote_server] FROM CERTIFICATE [MS_AgentSigningCertificate.remote_server]
go
GRANT EXECUTE TO [MS_AgentSigningCertificate.remote_server]
go
```

> [!NOTE]
> In a scenario where the certificates in master and model are the same before running the script discussed in the article, executing the script results in the following error message:

> Msg 15232, Level 16, State 1, Line 7  
A certificate with name 'MS_AgentSigningCertificate.remote_server20009' already exists or this certificate already has been added to the database.  

If you experience the symptoms discussed in the article even when the certificates are the same, contact Microsoft Customer Support Services (CSS) for more help.
