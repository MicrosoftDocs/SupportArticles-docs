---
title: Database cannot be started in this edition of SQL Server error
description: Describes the issue and resolution for restoring a Microsoft Dynamics CRM 2011 with Microsoft SQL Server Enterprise edition database to a server with Microsoft SQL Server Standard edition.
ms.reviewer: chanson, ehagen
ms.topic: troubleshooting
ms.date: 3/31/2021
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
    IF Object_id('tempdb..#indexesScript', 'U') IS NOT NULL
      DROP TABLE #indexesScript
    
    IF EXISTS (SELECT NAME
               FROM   sys.partition_schemes
               WHERE  NAME = 'AuditPScheme')
      BEGIN
          SELECT CASE WHEN ind.type != 1 THEN 'DROP INDEX [dbo].[AuditBase].' +
                 Quotename(ind.NAME) + ' ' ELSE ' ' END + 'CREATE ' + CASE is_unique
                 WHEN
                 1 THEN
                 'UNIQUE '
                 ELSE '' END + ind.type_desc + ' INDEX '
                 + Quotename(ind.NAME COLLATE sql_latin1_general_cp1_ci_as )
                 + ' ON [dbo].'
                 + Quotename(Object_name(object_id)) + ' ('
                 + Reverse(Substring(Reverse(( SELECT NAME + CASE WHEN
                 sc.is_descending_key = 1
                 THEN ' DESC' ELSE ' ASC' END + ',' FROM sys.index_columns sc JOIN
                 sys.columns c
                 ON sc.object_id = c.object_id AND sc.column_id = c.column_id WHERE
                 Object_name(
                 sc.object_id) = 'AuditBase' AND sc.object_id = ind.object_id AND
                 sc.index_id =
                 ind.index_id ORDER BY index_column_id ASC FOR xml path(''))), 2,
                 8000
                 )) +
                 ')' +
                 CASE WHEN ind.type = 1 THEN
                 ' WITH (DROP_EXISTING = ON) ON [PRIMARY]'
                 ELSE ' '
                 END AS Script
          INTO   #indexesScript
          FROM   sys.indexes ind
                 JOIN sys.partition_schemes ps
                   ON ind.data_space_id = ps.data_space_id
          WHERE  Object_name(object_id) = 'AuditBase'
                 AND ps.NAME = 'AuditPScheme'
                 AND is_unique_constraint = 0
    
          SELECT *
          FROM   #indexesScript
    
          DECLARE @recreateScript NVARCHAR(max)
          DECLARE indscript CURSOR FOR
            SELECT script
            FROM   #indexesScript
    
          OPEN indscript
    
          FETCH next FROM indscript INTO @recreateScript
    
          WHILE @@FETCH_STATUS = 0
            BEGIN
                BEGIN TRANSACTION t1
    
                EXECUTE Sp_executesql
                  @recreateScript
    
                IF @@ERROR > 0
                  BEGIN
                      ROLLBACK TRAN t1
    
                      DECLARE @message VARCHAR(max)
    
                      SET @message = 'Audit history recreate index failed. SQL: '
                                     + @recreateScript
    
                      RAISERROR (@message,10,1)
                  END
                ELSE
                  BEGIN
                      COMMIT TRAN
                  END
    
                FETCH next FROM indscript INTO @recreateScript
            END
    
          DROP partition scheme auditpscheme
    
          DROP partition FUNCTION auditpfn
    
          CLOSE indscript
    
          DEALLOCATE indscript
    
          DROP TABLE #indexesScript
      END
    ```

3. Once the script is complete, you can back up the database and now you should be able to restore the database to a Microsoft SQL Server Standard edition.

## More information

The auditing feature is still functional on Microsoft SQL Server Standard edition, however when using the Standard edition the ability to delete an entire partition of the audit history is not available.
