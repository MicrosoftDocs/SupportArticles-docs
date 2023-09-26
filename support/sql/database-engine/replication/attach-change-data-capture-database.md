---
title: Can't attach CDC-enabled database
description: This article provides resolutions for the problem where you can't attach a database with Change Data Capture enabled to a SQL Server 2016 or SQL Server 2017 on Windows instance after you detach it on SQL Server 2014 or an earlier version.
ms.date: 03/16/2020
ms.custom: sap:Replication, change tracking, change data capture
---
# Error when you attach a CDC-enabled database to an instance of SQL Server 2016 or SQL Server 2017 on Windows

This article helps you resolve the problem where you can't attach a CDC-enabled database to an instance of SQL Server 2016 or SQL Server 2017 on Windows.

_Original product version:_ &nbsp; SQL Server 2008 and the later versions  
_Original KB number:_ &nbsp; 3200464

## Symptoms

You detach a database with `Change Data Capture` enabled on SQL Server 2014 or an earlier version, and you attach it to a SQL Server 2016 or SQL Server 2017 on Windows instance. In this situation, you encounter the following error when you run the `sp_cdc_enable_table` system procedure:

Command

```sql
EXEC sys.sp_cdc_enable_table @source_schema='<schema name>',
@source_name='<source name>', @role_name='<role name>',  
@supports_net_changes=1, @allow_partition_switch=0;
```

Error message

> Msg 22832, Level 16, State 1, Procedure  
> sp_cdc_enable_table_internal, Line 639 [Batch Start Line 0]  
> Could not update the metadata that indicates table [\<schema name>]. [\<object name>] is enabled for Change Data Capture. The failure occurred when executing the command 'insert into [cdc].[captured_columns]'. The error returned was 213: 'Column name or number of supplied values does not match table definition.'. Use the action and error to determine the cause of the failure and resubmit the request.

## Resolution

To resolve this issue, run `sp_cdc_vupgrade` after you attach a database on an instance of SQL Server 2016 or SQL Server 2017 on Windows that has `Change Data Capture` enabled.

For more information, see [Attach a database](/sql/relational-databases/databases/attach-a-database).
