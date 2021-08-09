---
title: Error message when you run the Distribution Agent
description: This article provides workarounds for the problem when you run the Distribution Agent in SQL Server.
ms.date: 02/22/2021
ms.prod-support-area-path: Replication, change tracking, change data capture
ms.prod: sql
---
# "The distribution agent failed to create temporary files" error message when you run the Distribution Agent in SQL Server

This article helps you work around the problem when you run the Distribution Agent in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956032

## Symptoms

On an instance of Microsoft SQL Server that is installed on a Windows Server -based computer, you configure a transactional publication. You use the `Distribution Profile for OLEDB streaming` profile for the Distribution Agent. When you run the Distribution Agent, you receive an error message like the following:

> The distribution agent failed to create temporary files in C:\Program Files\Microsoft SQL Server\\\<nnn>\COM directory. System returned errorcode 5.

> [!NOTE]
> \<nnn> identifies the version of SQL Server. For more information, see [File Locations for Default and Named Instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

## Cause

When you use the `Distribution Profile for OLEDB streaming` profile for the Distribution Agent or you use OLEDB streaming in a custom profile, the Distribution Agent creates temporary files in the following directory:

`C:\Program Files\Microsoft SQL Server\<nnn>\COM`

If the account that is running SQL Server Agent does not have write access to the COM folder, the Distribution Agent will fail when it is running as a job. If you run the Distribution Agent from a command line by using an account that does not have write access to the COM folder, the same failure will occur.

## Workaround

To work around this issue, grant write permissions to the COM folder for the account that is running the SQL Server Agent service. If you run the Distribution Agent from a command line, grant write permissions to the COM folder for the account that you use to run the Distribution Agent.

> [!NOTE]
> If you change the account that is assigned to the replication job, the account should have write permissions to the COM folder.

If you still encounter this issue intermittently after you follow these steps, you should make sure that the COM folder is excluded from any antivirus scan that occurs on the system.

## More information

Error code 5 indicates that the error is "access is denied."
