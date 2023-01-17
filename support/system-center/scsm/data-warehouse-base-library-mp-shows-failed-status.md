---
title: The Data Warehouse Base Library management pack shows a deployment status of Failed
description: Fixes an issue in which management pack sync jobs fail and the Data Warehouse Base Library management pack shows a deployment status of Failed after you upgrade the data warehouse to System Center 2012 Service Manager SP1.
ms.date: 08/04/2020
ms.reviewer: adoyle
---
# MPSyncJob fails and the Data Warehouse Base Library management pack deployment fails

This article helps you fix an issue in which management pack sync jobs fail and the Data Warehouse Base Library management pack shows a deployment status of **Failed** after you upgrade the data warehouse to System Center 2012 Service Manager Service Pack 1 (SP1).

_Original product version:_ &nbsp; System Center 2012 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 2853442

## Symptoms

After upgrading the data warehouse to System Center 2012 Service Manager SP1, if the data warehouse has been running for more than three months, management pack sync jobs may fail. Additionally, transform and load jobs may also fail. The Data Warehouse Base Library management pack will show a deployment status of **Failed** in the console, and many others that are dependent on this management pack will show a status of **Waiting**.

If you haven't upgraded the data warehouse to System Center 2012 Service Manager SP1 and this problem doesn't yet affect you, see [Scenario 1](#scenario-1-upgrade-to-sp1-has-not-happened-yet) section.

## Cause

This error can occur due to erroneous database grooming.

## Scenario 1: Upgrade to SP1 has not happened yet

If the upgrade hasn't yet occurred, run the following query on `DWRepository` to get the actual SQL Server scripts that are to drop and add constraint of the primary key of fact tables on the `DWRepository` database.

```sql
;WITH FactName
AS (
       select w.WarehouseEntityName from etl.WarehouseEntity w
       join etl.WarehouseEntityType t on w.WarehouseEntityTypeId = t.WarehouseEntityTypeId
       where t.WarehouseEntityTypeName = 'Fact'
),FactList
AS (
    SELECT  PartitionName, p.WarehouseEntityName,
            RANK() OVER ( PARTITION BY p.WarehouseEntityName ORDER BY PartitionName ASC ) AS RK
    FROM    etl.TablePartition p
       join FactName f on p.WarehouseEntityName = f.WarehouseEntityName
)
, FactPKList
AS (
    SELECT  f.WarehouseEntityName, a.TABLE_NAME, a.COLUMN_NAME, b.CONSTRAINT_NAME, f.RK,
            CASE WHEN b.CONSTRAINT_NAME = 'PK_' + f.WarehouseEntityName THEN 1 ELSE 0 END AS DefaultConstraints
    FROM    FactList f
    JOIN    INFORMATION_SCHEMA.KEY_COLUMN_USAGE a ON f.PartitionName = a.TABLE_NAME
    JOIN    INFORMATION_SCHEMA.TABLE_CONSTRAINTS b ON a.CONSTRAINT_NAME = b.CONSTRAINT_NAME AND b.CONSTRAINT_TYPE = 'Primary key'
)
, FactWithoutDefaultConstraints
AS (
    SELECT  a.*
    FROM    FactPKList a
    LEFT JOIN FactPKList b ON b.WarehouseEntityName = a.WarehouseEntityName AND b.DefaultConstraints = 1
    WHERE   b.WarehouseEntityName IS NULL AND a.RK = 1
)
, FactPKListStr
AS (
    SELECT  DISTINCT f1.WarehouseEntityName, f1.TABLE_NAME, f1.CONSTRAINT_NAME, F.COLUMN_NAME AS PKList
    FROM    FactWithoutDefaultConstraints f1
    CROSS APPLY (
                    SELECT  '[' + COLUMN_NAME + '],'
                    FROM    FactWithoutDefaultConstraints f2
                    WHERE   f2.TABLE_NAME = f1.TABLE_NAME
                    ORDER BY COLUMN_NAME
                FOR
                   XML PATH('')
                ) AS F (COLUMN_NAME)
)
SELECT  'ALTER TABLE [dbo].[' + f.TABLE_NAME + '] DROP CONSTRAINT [' + f.CONSTRAINT_NAME + ']' + CHAR(13) + CHAR(10) +
        'ALTER TABLE [dbo].[' + f.TABLE_NAME + '] ADD CONSTRAINT [PK_' + f.WarehouseEntityName + '] PRIMARY KEY NONCLUSTERED (' + SUBSTRING(f.PKList, 1, LEN(f.PKList) -1) + ')' + CHAR(13) + CHAR(10)
FROM    FactPKListStr f
ORDER BY f.WarehouseEntityName
```

> [!NOTE]
> After the first query is run, the output will be another set of queries that need to be run. Copy the results into new query windows and run all of them.

After the default primary keys have been restored, restart the failed base management pack deployment from the Service Manager console.

## Scenario 2: Upgrade to SP1 has occurred without a transform or load job failure

If you have upgraded your system to System Center 2012 Service Manager SP1 and only observed the management pack deployment failure and not a transform or load job failure, you can apply the [Scenario 1](#scenario-1-upgrade-to-sp1-has-not-happened-yet) resolution steps.

## Scenario 3: Upgrade to SP1 has happened with a transform or load job failure

If you have upgraded your system to SP1 and have seen the transform or load job failure, check the `DWStagingAndConfig` to see whether `SystemDerivedMp.Microsoft.SystemCenter.Datawarehouse.Base` exists. To do this, run this query on `DWStagingAndConfig`:

```sql
select * from ManagementPack where mpname like '%SystemDerivedMp.Microsoft.SystemCenter.Datawarehouse.Base%'
```

Most likely the above management pack is missing. If so, you will need to restore your database backups before the upgrade. To do so, follow the steps below:

1. Perform disaster recovery for the database backups.
2. Disable the **MPSyncJob** schedule.
3. Restore all of the missing primary Keys in `DWRepository` using the SQL script found in [Scenario 1](#scenario-1-upgrade-to-sp1-has-not-happened-yet).
4. Restart the failed base management pack deployment from the console.
