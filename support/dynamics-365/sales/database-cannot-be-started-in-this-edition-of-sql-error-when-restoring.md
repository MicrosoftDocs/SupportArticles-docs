---
title: Database cannot be started in this edition of SQL Server error
description: Describes the issue and resolution for restoring a Microsoft Dynamics CRM 2011 with Microsoft SQL Server Enterprise edition database to a server with Microsoft SQL Server Standard edition.
ms.reviewer: chanson, ehagen
ms.topic: troubleshooting
ms.date: 
---
# "Database cannot be started in this edition of SQL Server" error when restoring a Microsoft Dynamics CRM database

This article provides a resolution for the issue that you can't restore a Microsoft Dynamics CRM 2011 with Microsoft SQL Server Enterprise edition database to a server with Microsoft SQL Server Standard edition.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2567984

## Symptoms

When trying to restore a Microsoft SQL Server Enterprise database to another server running Microsoft SQL Server Standard, you get the following error:

> Restore failed for Server 'SQLServerName'.
>
> Additional information:  
An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo)  
Database 'Org_MSCRM' cannot be started in this edition of SQL Server because it contains a partition function 'AuditPFN'. Only Enterprise edition of SQL Server supports partitioning. Database 'Org_MSCRM' cannot be started because some of the database functionality is not available in the current edition of SQL Server. (Microsoft SQL Server, Error: 905)

## Cause

When Microsoft Dynamics CRM 2011 is installed using a Microsoft SQL Server Enterprise edition, a partition is created for the auditing functionality of Microsoft Dynamics CRM 2011. The AuditBase table uses partitioning that is only available for Microsoft SQL Server Enterprise.

## Resolution

Use the following Steps and Script to remove the partitioning. The following script recreates all the indexes on the Primary partition and then drops the partition.

Be sure to have a database backup of the `'Org_MSCRM'` before performing the following steps.

1. Restore the `'Org_MSCRM'` database to a Microsoft SQL Server Enterprise edition. It is recommended to back up and restore the database instead of running the script on the production database.

2. Run the following script against the restored database.

    ````sql
    IF EXISTS 
    (
       SELECT
          name 
       FROM
          sys.partition_schemes 
       WHERE
          name = 'AuditPScheme'
    )
    BEGIN
       SELECT
          CASE
             WHEN
                ind.type != 1 
             THEN
                'DROP INDEX [dbo].[AuditBase].' + QUOTENAME(ind.name) + ' ' 
             ELSE
                ' ' 
          END
          + 'CREATE ' + 
          CASE
             is_unique 
             WHEN
                1 
             THEN
                'UNIQUE ' 
             ELSE
                '' 
          END
          + ind.type_desc + ' INDEX ' + QUOTENAME(ind.name COLLATE SQL_Latin1_General_CP1_CI_AS ) + ' ON [dbo].' + QUOTENAME(OBJECT_NAME(object_id)) + ' (' + REVERSE(SUBSTRING(REVERSE(( 
          SELECT
             name + 
             CASE
                WHEN
                   sc.is_descending_key = 1 
                THEN
                   ' DESC' 
                ELSE
                   ' ASC' 
             END
             + ',' 
          FROM
             sys.index_columns sc 
             JOIN
                sys.columns c 
                ON sc.object_id = c.object_id 
                AND sc.column_id = c.column_id 
          WHERE
             OBJECT_NAME(sc.object_id) = 'AuditBase' 
             AND sc.object_id = ind.object_id 
             AND sc.index_id = ind.index_id 
          ORDER BY
             index_column_id ASC FOR XML PATH(''))), 2, 8000)) + ')' + 
             CASE
                WHEN
                   ind.type = 1 
                THEN
                   ' WITH (DROP_EXISTING = ON) ON [PRIMARY]' 
                ELSE
                   ' ' 
             END
             as Script INTO # indexesScript 
          FROM
             sys.indexes ind 
             JOIN
                sys.partition_schemes ps 
                on ind.data_space_id = ps.data_space_id 
          WHERE
             OBJECT_NAME(object_id) = 'AuditBase' 
             AND ps.name = 'AuditPScheme' 
             AND is_unique_constraint = 0 
             SELECT
                * 
             FROM
                # indexesScript 
                DECLARE @recreateScript nvarchar(max) 
                DECLARE indScript CURSOR FOR 
                SELECT
                   Script 
                FROM
                   # indexesScript OPEN indScript FETCH NEXT 
                FROM
                   indScript INTO @recreateScript WHILE @@FETCH_STATUS = 0 
                   BEGIN
                      BEGIN
                         TRANSACTION t1 Execute sp_executesql @recreateScript IF @@ERROR > 0 
                         BEGIN
                            ROLLBACK TRAN t1 
                            declare @message varchar(max) 
                set
                   @message = 'Audit history recreate index failed. SQL: ' + @recreateScript RAISERROR (@message, 10, 1) 
                         END
                         ELSE
                            BEGIN
                               COMMIT TRAN 
                            END
                            FETCH NEXT 
                FROM
                   indScript INTO @recreateScript 
                      END
                      DROP PARTITION SCHEME AuditPScheme DROP PARTITION FUNCTION AuditPFN CLOSE indScript DEALLOCATE indScript DROP TABLE # indexesScript 
                   END
    ```

3. Once the script is complete, you can back up the database and now you should be able to restore the database to a Microsoft SQL Server Standard edition.

## More information

The auditing feature is still functional on Microsoft SQL Server Standard edition, however when using the Standard edition the ability to delete an entire partition of the audit history is not available.
