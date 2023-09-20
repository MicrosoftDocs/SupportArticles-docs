---
title: Full-text indexes populate slowly
description: This article introduces you to issues that can occur when working with multiple full-text indexes and solutions to workaround those problems.
ms.date: 09/25/2020
ms.custom: sap:Administration and Management
---
# Full-text indexes stop populating for 30 minutes in SQL Server

This article introduces you to issues that can occur when working with multiple full-text indexes and solutions to workaround those problems.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4045273

## Symptoms

Assume that you have Microsoft SQL Server installed on a server. Consider the following scenarios:  

- Scenario 1:

    You have several full-text indexes across one or more databases, and population of these full-text indexes finishes near the same time.
- Scenario 2:

    You create a full-text catalog that contains many full-text indexes, and population of these full-text indexes finish near the same time.
- Scenario 3:

    You rebuild one or more full-text catalogs in which several of the indexes finish populating at or near the same time.
- Scenario 4:

    You manually run `ALTER FULLTEXT CATALOG REORGANIZE` for a catalog that contains many full-text indexes.

In any of those situations, if you turn on trace flag (TF) 7603 to output the verbose logging for full-text population to the SQL Server error log, you see messages that resemble the following:

> Date/Time SPIDIFTS: CFTWICrawl::Close, Full Crawl has ended, scheduling a Master Merge for CrawlType: 1, DBid 7, catid 5, tid 13847411  
 Date/Time SPID CFTMasterMergeListManager::QueueMasterMerge queued MM item for DBid 7, catalog 5, tblid 13847411  
 Date/Time SPID IFTS: CFTWIAutoCrawlFullPass::ExecUnit::DoUnitWork: Found existing crawl, so return without the autocrawl full pass, DBid 7 Catid 5 Objid 13847411

Additionally, you see a 30-minute wait for master merge, and the log reports that master merge has aborted:

> Date/Time SPID IFTS: Master Merge work items were aborted because it waited in preinit for more than 30 minutes m_DBid 7, m_objid 13847411  
 Date/Time SPID Warning Master Merge operation was not done for DBid 7, objid 13847411, so querying index will be slow. Please run alter fulltext catalog reorganize.  
 Date/Time SPID CFTMasterMergeListManager::RemoveMasterMerge released MM item for DBid 7, catalog 5, tblid 13847411  
 Date/Time SPID The master merge started at the end of the full crawl of table or indexed view '[DB1].[dbo].[Table1]' failed with HRESULT = '0x80000049'. Database ID is '7', table id is 13847411, catalog ID: 5.

## Cause

Master merge runs automatically at the end of a full or incremental population per index. The master merge process reduces the number of fragments for a full-text index to keep queries utilizing the full-text index from becoming negatively affected by the full-text index performance.

The master merge process uses multiple threads to reduce fragmentation per full-text index. SQL Server throttles the number of concurrent master merges that run at the same time. As soon as the threshold is hit, any full-text index that tries to run a master merge will experience a 30-minute wait delay. The full-text index update will not start during this waiting period. Master merge will resume if one of the following two things happens:

- When the next successful incremental population completes and successfully starts a master merge.
- Manually run a master merge by running the following command:

    ```sql
     ALTER FULLTEXT CATALOG catalog_name REORGANIZE
    ```

> [!NOTE]
> The above two options may still hit the master merge limit depending on the number of master merges running at the time.

## Workaround

To work around this, try the following methods:

- Method 1 (**recommended**): Limit the number of full-text indexes in the same catalog. Recommend 7 or less. Large tables should be in their own full-text catalog. This is a best practice for performance when you rebuild or reorganize indexes. This method can help when **Change_tracking** is *Auto*.

- Method 2: Set **Change_Tracking** to *Manual*, by using the following command:

    ```sql
    ALTER FULLTEXT INDEX ON table_name set Change_tracking = Manual
    ```  

    Then, create SQL Server jobs to spread out when incremental populations are run. This results in less overlap when you run master merge following index population.
