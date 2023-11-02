---
title: Script failed error when you merge snapshot
description: This article provides a workaround for the script failed error that occurs when creating merge publication snapshot.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
---
# Merge publication snapshot fails with Script failed error in SQL Server

This article helps you work around the **Script failed** error that occurs when creating merge publication snapshot.

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 3179862

## Symptoms

In SQL Server 2014 or 2012, you create a merge publication that contains a table that has a geometry or geography data type. To copy your spatial index, you have set the article's Copy spatial indexes option to **True**  so that the merge will replicate spatial indexes. However, when the snapshot runs, it fails. If you start Replication Monitor and drill down into the publisher and the publication, locate the Snapshot agent, and view the details of the snapshot execution, you see the following error message:

```console
Source: Microsoft.SqlServer.Smo
Target Site: System.Collections.Generic.IEnumerable`1[System.String] ScriptWithList(Microsoft.SqlServer.Management.Smo.DependencyCollection, Microsoft.SqlServer.Management.Smo.SqlSmoObject[], Boolean)
>Message: Script failed for Server 'CMSQL'.
Stack: at Microsoft.SqlServer.Management.Smo.Scripter.ScriptWithList(DependencyCollection depList, SqlSmoObject[] objects, Boolean discoveryRequired)
at Microsoft.SqlServer.Management.Smo.Scripter.EnumScriptWithList(SqlSmoObject[] objects)
at Microsoft.SqlServer.Replication.Snapshot.SmoScriptingManager.ScriptIndexList(Scripter scripter, SqlSmoObject[] smoObjectList)
at Microsoft.SqlServer.Replication.Snapshot.MergeSmoScriptingManager.GenerateTableArticleDriScriptWithSingleBatchConstraints(Scripter scripter, BaseArticleWrapper articleWrapper, Table smoTable)
at Microsoft.SqlServer.Replication.Snapshot.MergeSmoScriptingManager.GenerateTableArticleScripts(ArticleScriptingBundle articleScriptingBundle)
at Microsoft.SqlServer.Replication.Snapshot.MergeSmoScriptingManager.GenerateArticleScripts(ArticleScriptingBundle articleScriptingBundle)
at Microsoft.SqlServer.Replication.Snapshot.SmoScriptingManager.GenerateObjectScripts(ArticleScriptingBundle articleScriptingBundle)
at Microsoft.SqlServer.Replication.Snapshot.SmoScriptingManager.DoScripting()
at Microsoft.SqlServer.Replication.Snapshot.SqlServerSnapshotProvider.DoScripting()
at Microsoft.SqlServer.Replication.Snapshot.MergeSnapshotProvider.DoScripting()
at Microsoft.SqlServer.Replication.Snapshot.SqlServerSnapshotProvider.GenerateSnapshot()
at Microsoft.SqlServer.Replication.SnapshotGenerationAgent.InternalRun()
at Microsoft.SqlServer.Replication.AgentCore.Run() (Source: Microsoft.SqlServer.Smo, Error number: 0)
Get help: `http://help/0`
Source: Microsoft.SqlServer.Smo
Target Site: Void CheckTargetVersion(Microsoft.SqlServer.Management.Smo.SqlServerVersionInternal, Microsoft.SqlServer.Management.Smo.SqlServerVersionInternal, System.String)
Message: Error with spatial index [IX_GeographicEntity_Outline]. GEOMETRY_AUTO_GRID and GEOGRAPHY_AUTO_GRID are not supported in SQL Server 2008.
Stack: at Microsoft.SqlServer.Management.Smo.SqlSmoObject.CheckTargetVersion(SqlServerVersionInternal targetVersion, SqlServerVersionInternal upperLimit, String exceptionText)
at Microsoft.SqlServer.Management.Smo.Index.SpatialIndexScripter.ScriptIndexDetails(StringBuilder sb)
at Microsoft.SqlServer.Management.Smo.Index.IndexScripter.GetCreateScript()
at Microsoft.SqlServer.Management.Smo.Index.ScriptDdl(StringCollection queries, ScriptingPreferences sp, Boolean notEmbedded, Boolean createStatement)
at Microsoft.SqlServer.Management.Smo.Index.ScriptCreate(StringCollection queries, ScriptingPreferences sp)
at Microsoft.SqlServer.Management.Smo.SqlSmoObject.ScriptCreateInternal(StringCollection query, ScriptingPreferences sp, Boolean skipPropagateScript)
at Microsoft.SqlServer.Management.Smo.ScriptMaker.ScriptCreateObject(Urn urn, ScriptingPreferences sp, ObjectScriptingType& scriptType)
at Microsoft.SqlServer.Management.Smo.ScriptMaker.ScriptCreate(Urn urn, ScriptingPreferences sp, ObjectScriptingType& scriptType)
at Microsoft.SqlServer.Management.Smo.ScriptMaker.ScriptCreateObjects(IEnumerable`1 urns)
at Microsoft.SqlServer.Management.Smo.ScriptMaker.DiscoverOrderScript(IEnumerable`1 urns)
at Microsoft.SqlServer.Management.Smo.ScriptMaker.ScriptWorker(List`1 urns, ISmoScriptWriter writer)
at Microsoft.SqlServer.Management.Smo.ScriptMaker.Script(DependencyCollection depList, SqlSmoObject[] objects, ISmoScriptWriter writer)
at Microsoft.SqlServer.Management.Smo.Scripter.ScriptWithListWorker(DependencyCollection depList, SqlSmoObject[] objects, Boolean discoveryRequired)
at Microsoft.SqlServer.Management.Smo.Scripter.ScriptWithList(DependencyCollection depList, SqlSmoObject[] objects, Boolean discoveryRequired) (Source: Microsoft.SqlServer.Smo, Error number: 0)
Get help: `http://help/0`
```

## Cause

SQL Server does not support spatial indexes that are defined with the `GEOMETRY_AUTO_GRID` or `GEOGRAPHY_AUTO_GRID` keywords.

When you create a publication in SQL Server 2012 or SQL Server 2014, the publication's backward-compatibility level setting (@publication_compatibility_level) allows settings of 90RTM and 100RTM. Therefore, compatibility with SQL Server 2008 is forced when you create a merge publication. But because of backward-compatibility with SQL Server 2008, spatial indexes cannot be copied.

## Workaround

To continue to use this type of data in a merge publication, use one of the following workarounds:

- Define the spatial index by using the `GEOMETRY_GRID` or `GEOGRPAHY_GRID` keywords instead of `GEOMETRY_AUTO_GRID` or `GEOGRAPHY_AUTO_GRID`.
- When you define the publication, configure the article that is defined with a spatial index, setting the **Copy Spatial Indexes** option to **False**. Then, after the subscriptions have been created and the subscription initialized, manually create the spatial index on the subscriber table.

## Applies to

- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Enterprise Core
- SQL Server 2012 Standard
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Standard
