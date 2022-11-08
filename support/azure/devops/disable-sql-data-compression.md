---
title: Disabling SQL Server Data Compression
description: This article provides the steps to disable SQL Server Data Compression in Azure DevOps Server databases.
ms.date: 08/18/2020
ms.custom: sap:Installation, Migration, and Move
ms.reviewer: chandrur
ms.topic: how-to
ms.service: azure-devops-server
---
# Disabling SQL Server Data Compression in Azure DevOps Server databases

This article describes how to disable SQL Server Data Compression in Azure DevOps Server databases.

_Original product version:_ &nbsp; Microsoft Azure DevOps Server  
_Original KB number:_ &nbsp; 2712111

## Summary

Azure DevOps Server has been designed to make use of SQL Enterprise Edition features such as page compression, which is not available in other editions of SQL Server. When moving one or more Azure DevOps Server databases from an Enterprise Edition of SQL Server to a non-Enterprise Edition of SQL Server (as part of a collection detach/attach operation, for example) it is necessary to disable that compression.

To disable compression on a Azure DevOps Server databases, you can execute `[dbo].[prc_EnablePrefixCompression]` against it. This stored procedure has a parameter, `@online`, which should be set to **true** if you want to disable compression while you continue using the collection database through your Azure DevOps Server deployment, but can be set to **false** otherwise in order to speed up the operation. In either case, the steps to execute this stored procedure will be:

1. Launch SQL Server Management Studio.

2. Locate the Azure DevOps Server databases that will be moved. Right click on the database and select **New Query**.

3. Type one of the following:

   ```sql
   EXEC [dbo].[prc_EnablePrefixCompression] @online = 0, @disable = 1

   EXEC [dbo].[prc_EnablePrefixCompression] @online = 1, @disable = 1
   ```

    > [!NOTE]
    > Depending on whether you plan to continue using the database while disabling compression or not.
  
4. Run (Execute) the query and verify success under messages.

5. Repeat steps 1 through 4 for all required databases that will be moved.

Disabling compression will require additional disk space. The below query, which can be executed using the same steps as above, will provide you an estimate about the amount of additional disk space that will be required after disabling compression.

```sql
select sum(used_page_count) * 8 * 2 /1024.0
from sys.partitions p
join sys.dm_db_partition_stats s
on s.partition_id = p.partition_id
and s.object_id = p.object_id
and s.index_id = p.index_id
where p.data_compression_desc = 'page'
```

> [!NOTE]
>
> 1. The size returned by the above query is in Megabytes (MB).
> 2. It is advisable to run this query against each Azure DevOps Server databases before disabling data compression, and then to ensure that enough disk space will be available before actually disabling compression.

## More information

- [SQL Server requirements for Team Foundation Server](/previous-versions/visualstudio/visual-studio-2013/dd631889(v=vs.120)).

- [Data Compression](/sql/relational-databases/data-compression/data-compression)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
