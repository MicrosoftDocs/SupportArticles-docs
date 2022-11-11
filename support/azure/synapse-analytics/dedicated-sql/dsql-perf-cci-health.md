---
title: Assess and correct clustered columnstore index health on dedicated SQL pool
description: Provides methods of assessment and maintenance for CCIs on an Azure Synapse Analytics dedicated SQL pool.
ms.date: 11/08/2022
author: scott-epperly
ms.author: scepperl
ms.reviewer: scepperl
---
<!--
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.14.1
  kernelspec:
    display_name: SQL
    language: sql
    name: SQL
-->

<!-- #region azdata_cell_guid="c517268b-e214-4899-bb22-808df3814f9e" -->
# Assess and correct clustered columnstore index health on dedicated SQL pool

> [!NOTE]
>Before attempting to open this notebook, check that Azure Data Studio is installed on your local machine. To install, go to [Learn how to install Azure Data Studio](/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver16).

> [!div class="nextstepaction"]
> [Open Notebook in Azure Data Studio](azuredatastudio://microsoft.notebook/open?url=https://raw.githubusercontent.com/microsoft/synapse-support/main/dedicated-sql-pool/dsql-perf-cci-health.ipynb)



_Applies to:_ &nbsp; Azure Synapse Analytics

In this assessment, we introduce a slightly different approach to asssessing clustered columnstore index (CCI) health. In general, there are two major factors that impact the quality of a CCI:

* __Compact rowgroups and metadata__: meaning the actual rowgroup count is close to the ideal count for the number of rows in the rowgroup.
* __Compressed rowgroups__: referring to rowgroups that are using columnstore compression

There are other conditions, such as small tables, over-partitioned tables, or under-partitioned tables, which could be argued to be of poor quality/health.  However, these are better classified as design improvement opportunities which can be assessed in [Step 4](#step-4-check-for-design-improvement-opportunities) below.

## Step 1: Analyze a summary of your CCI health

Use the following query to get a single-row of metrics to help get an overview of of the CCI health for your dedicated SQL pool.  This information isn't directly actionable, but does help you gain perspective on how closely your maintenance routines keep you to an ideal state.

| Column name | Description |
| --- | --- |
| tables\_assessed\_count | Count of CCI tables |
| partitions\_assessed\_count | Count of partitions; note: non-partitioned tables will be counted as 1 |
| actual\_rowgroup\_count | Physical count of rowgroups |
| ideal\_rowgroup\_count | Calculated number of rowgroups that would be ideal for the number of rows |
| uncompressed\_rowgroup\_count | Number of rowgroups that contain uncompressed data. (aka: OPEN rows) |
| actual\_size\_in\_mb | Physical size of CCI data in MB |
| uncompressed\_size\_in\_mb | Physical size of uncompressed data in MB |
| excess\_pct | Percent of rowgroups that could be further optimized |
| excess\_size\_in\_mb | Estimated MB from unoptimized rowgroups |

<!-- #endregion -->

```sql azdata_cell_guid="24c873bf-e60b-4844-bc52-cabdd4d8859e"
WITH cci_detail AS (
	SELECT t.object_id ,
          rg.partition_number ,
          count(*) AS total_rowgroup_count ,
          sum(CASE WHEN rg.state = 1 THEN 1 END) AS open_rowgroup_count ,
          CEILING ((SUM(rg.[total_rows]) - sum(rg.deleted_rows))/count(DISTINCT rg.distribution_id)/1048576.) * count(DISTINCT rg.distribution_id) AS [ideal_rowgroup_count] ,
          sum(rg.size_in_bytes/1024/1024.) AS size_in_mb ,
          sum(CASE WHEN rg.state = 1 THEN rg.size_in_bytes END /1024/1024.) AS open_size_in_mb
   FROM sys.pdw_nodes_column_store_row_groups rg
   JOIN sys.pdw_nodes_tables nt ON rg.object_id = nt.object_id
	   AND rg.pdw_node_id = nt.pdw_node_id
	   AND rg.distribution_id = nt.distribution_id
   JOIN sys.pdw_table_mappings mp ON nt.name = mp.physical_name
   JOIN sys.tables t ON mp.object_id = t.object_id
   GROUP BY t.object_id ,
            rg.partition_number
)
SELECT count(DISTINCT object_id) AS tables_assessed_count ,
       count(*) AS partitions_assessed_count ,
       sum(total_rowgroup_count) AS actual_rowgroup_count ,
       sum(ideal_rowgroup_count) AS ideal_rowgroup_count ,
       sum(open_rowgroup_count) AS uncompressed_rowgroup_count ,
       cast(sum(size_in_mb) AS decimal(19, 4)) AS actual_size_in_mb ,
	   cast(sum(open_size_in_mb) AS decimal(19, 4)) AS uncompressed_size_in_mb ,
       cast(((sum(total_rowgroup_count)/sum(ideal_rowgroup_count)) - 1.0) * 100 AS decimal(9, 4)) AS excess_pct ,
       sum(size_in_mb) * cast(((sum(total_rowgroup_count)/sum(ideal_rowgroup_count)) - 1.0) AS decimal(19, 4)) AS excess_size_in_mb
FROM cci_detail
```

<!-- #region language="sql" azdata_cell_guid="f1d25501-0e2a-45ba-9c17-22d0a0b110eb" -->
## Before jumping into details . . .

If you so choose, create the following function on your dedicated SQL pool in order to generate scripts for the three methods to optimize your CCI in place.  You can use this function to not only maintain CCIs, but also clustered (rowstore) indexes.  This table-valued function is referenced the [Step 2: Analyze detailed CCI information](#step-2-analyze-detailed-cci-information) section but is commented out.

### Parameters

| Parameter name | Required | Description |
|----------------|:--------:|-------------|
| @object_id     | Y | `object_id` of the table to target |
| @partition_number | Y | `partition_number` from `sys.partitions` to target.  If the table is not partitioned, specify 1 |

### Output

| Column name | Description |
|-------------|-------------|
| rebuild_script | Generated `ALTER INDEX ALL ... REBUILD` statement for the given table/partition. Non-partitioned heaps will return `NULL`.|
| reorganize_script | Generated `ALTER INDEX ALL ... REORGANIZE` statement for the given table/partition. Non-partitioned heaps will return `NULL`. |
| partition_switch_script | Applies only to partitioned tables; will be `NULL` if table is not partitioned or if an invalid partition number is specified.  If the CCI was create with an ORDER clause, this will be rendered.

<!-- #endregion -->

```sql azdata_cell_guid="f44310e1-4346-4f1c-a62c-c454aa734f86"
create function dbo.fnMs_GenerateIndexMaintenanceScript (@object_id int, @partition_number int = 1)
returns table
as
return(
	with base_info as (
		select
			t.object_id
			,schema_name(t.schema_id) as [schema_name]
			,t.name as table_name
			,i.index_type
			,i.index_cols
			,i.index_type_desc
			,tdp.distribution_policy_desc
			,c.name hash_distribution_column_name
		from sys.tables t
			join (
				select
					i.object_id
					,i.index_id
					,max(i.type) as index_type
					, max(case when i.type = 5 and ic.column_store_order_ordinal != 0 then ' ORDER ' else '' end)
						+ '(' + string_agg(
						case
							when i.type in (1, 5) 
								and (ic.key_ordinal != 0 or ic.column_store_order_ordinal != 0)
								then c.name + case when ic.is_descending_key = 1 then ' DESC' else '' end
						end
						, ',') within group(order by ic.column_store_order_ordinal, ic.key_ordinal) + ')' as index_cols
					,max(i.type_desc)
						+ case
							when max(i.type) in (1, 5) then ' INDEX'
							else ''
						end collate SQL_Latin1_General_CP1_CI_AS as index_type_desc
				from sys.indexes i
					join sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id
					join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
				where i.index_id <= 1
				group by i.object_id, i.index_id
			) as i
				on t.object_id = i.object_id
			join sys.pdw_table_distribution_properties tdp on t.object_id = tdp.object_id
			left join sys.pdw_column_distribution_properties cdp on t.object_id = cdp.object_id and cdp.distribution_ordinal = 1
			left join sys.columns c on cdp.object_id = c.object_id and cdp.column_id = c.column_id
		where t.object_id = @object_id
	)
	,param_data_type as (
		select
			pp.function_id
			,typ.name as data_type_name
			,cast(case
				when typ.collation_name is not null then 1
				when typ.name like '%date%' then 1
				when typ.name = 'uniqueidentifier' then 1
				else 0
			end as bit) as use_quotes_on_values_flag
		from sys.partition_parameters pp
			join sys.types typ on pp.user_type_id = typ.user_type_id
	)
	,boundary as (
		select
			t.object_id
			,c.name as partition_column_name
			,pf.boundary_value_on_right
			,prv.boundary_id
			,prv.boundary_id + case when pf.boundary_value_on_right = 1 then 1 else 0 end as [partition_number]
			,case
				when pdt.use_quotes_on_values_flag = 1 then '''' + cast(
					case pdt.data_type_name
						when 'date' then convert(char(10), prv.value, 120)
						when 'smalldatetime' then convert(varchar, prv.value, 120)
						when 'datetime' then convert(varchar, prv.value, 121)
						when 'datetime2' then convert(varchar, prv.value, 121)
						else prv.value
					end	
					as varchar(32)) + ''''
				else cast(prv.value as varchar(32))
			end as boundary_value
		from sys.tables t
			join sys.indexes i on t.object_id = i.object_id and i.index_id <= 1
			join sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id and ic.partition_ordinal = 1
			join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
			join sys.partition_schemes ps on i.data_space_id = ps.data_space_id
			join sys.partition_functions pf on ps.function_id = pf.function_id
			join param_data_type pdt on pf.function_id = pdt.function_id
			join sys.partition_range_values prv on pf.function_id = prv.function_id
		where t.object_id = @object_id
	)
	, partition_clause as (
		select
			object_id
			,count(*) - 1 -- should always be the 2nd to last partition in stage table
				+ case when max([partition_number]) = @partition_number then 1 else 0 end -- except when last partition
				as [source_partition_number]
			,'where ' + max(partition_column_name)
				+ case when max(cast(boundary_value_on_right as tinyint)) = 1 then 
					' >= ' + min(case when [partition_number] = @partition_number then boundary_value end)
					else 
					' <= ' + max(case when [partition_number] = @partition_number then boundary_value end)
				end
				+ ' and ' + max(partition_column_name)
				+ case when max(cast(boundary_value_on_right as tinyint)) = 1 then 
					' < ' + max(boundary_value)
					else
					' > ' + min(boundary_value)
				end as filter_clause
			,', PARTITION (' + max(partition_column_name) + ' RANGE ' 
				+ case when max(cast(boundary_value_on_right as tinyint)) = 1 then 'RIGHT' else 'LEFT' end 
				+ ' FOR VALUES(' + string_agg(boundary_value, ',') + '))' as [partition_clause]
		from boundary
		where [partition_number] between @partition_number - 1 and @partition_number + 1
		group by object_id
	)
	select
		case when index_type in (1,5) then 'ALTER INDEX ALL ON [' + [schema_name] + '].[' + [table_name] + '] REBUILD' 
			+ case when partition_clause.[object_id] is not null then ' PARTITION = ' + cast(@partition_number as varchar(16)) else '' end + ';' end as [rebuild_script]
		,case when index_type in (1,5) then 'ALTER INDEX ALL ON [' + [schema_name] + '].[' + [table_name] + '] REORGANIZE' 
			+ case when partition_clause.[object_id] is not null then ' PARTITION = ' + cast(@partition_number as varchar(16)) else '' end
			+ case when index_type = 5 then ' WITH (COMPRESS_ALL_ROW_GROUPS = ON)' else '' end + ';' end as [reorganize_script]
		,'create table [' + schema_name + '].[' + table_name + '_p' + cast(@partition_number as varchar(16)) + '_tmp] with(' + index_type_desc + isnull(index_cols, '')
			+ ', distribution=' + distribution_policy_desc + case when distribution_policy_desc = 'HASH' then '(' + hash_distribution_column_name + ')' else '' end
			+ partition_clause.partition_clause + ') as select * from [' + [schema_name] + '].[' + [table_name] + '] ' + filter_clause + case when index_type = 5 and index_cols is not null then ' OPTION(MAXDOP 1)' else '' end +  ';'
			+ ' alter table [' + schema_name + '].[' + table_name + '_p' + cast(@partition_number as varchar(16)) + '_tmp] switch partition ' + cast(source_partition_number as varchar(16))
			+ ' to [' + [schema_name] + '].[' + [table_name] + '] partition ' + cast(@partition_number as varchar(16))
			+ ' with(truncate_target = on);'
			+ ' drop table [' + schema_name + '].[' + table_name + '_p' + cast(@partition_number as varchar(16)) + '_tmp];' as [partition_switch_script]
	from base_info
		left join partition_clause
			on base_info.object_id = partition_clause.object_id
);
go
```

<!-- #region language="sql" azdata_cell_guid="c03de33e-db66-416a-9734-b083b782d4d7" -->
## Step 2: Analyze detailed CCI information

The following query provides detailed report of which table partitions are candidates for rebuilding. This view of CCI detail provides three metrics to help identify and prioritize which tables/partitions would benefit most from maintenance. Set the appropriate threshold values for these metrics in the `WHERE` clause and then `ORDER BY` the metric(s) which are of most interest to you:

| Column name | Quality characteristic | Description |
| --- | --- | --- |
| excess\_pct | Compactness | Percent of rowgroups that could be further compacted |
| excess\_size\_in\_mb | Compactness | Estimated MB from unoptimized rowgroups |
| OPEN\_rowgroup\_size\_in\_mb | Compression | Actual MB of uncompressed data in the index |

The detailed information can also be useful to determine whether your dedicated SQL pool is being impacted by a large number of small, fragmented tables, which can lead to [delays in compilation](/troubleshoot/azure/synapse-analytics/dedicated-sql/troubleshoot-dsql-perf-slow-query#unhealthy-ccis-generally).

> **Note**: As noted above, the reference to `fnMs\_GenerateIndexMaintenanceScript` is commented out on the following query. It can be uncommented (lines 37 & 39) to generate common scripts for maintaining the index.  When running the maintence script, be sure to execute using an appropriately-sized resource class, such as largerc or xlargerc.
<!-- #endregion -->

```sql azdata_cell_guid="5bae09a7-1ebb-42b2-aeea-49682e8e40fc"
WITH cci_info AS(
	SELECT t.object_id AS [object_id] ,
          max(schema_name(t.schema_id)) AS [schema_name] ,
          max(t.name) AS [table_name] ,
          rg.partition_number AS [partition_number] ,
          count(DISTINCT rg.distribution_id) AS [distribution_count] ,
          sum(rg.size_in_bytes/1024/1024) AS [size_in_mb] ,
          SUM(rg.[total_rows]) AS [row_count_total] ,
          count(*) AS [total_rowgroup_count] ,
          CEILING ((SUM(rg.[total_rows]) - sum(rg.[deleted_rows]))/count(DISTINCT rg.distribution_id)/1048576.) * count(DISTINCT rg.distribution_id) AS [ideal_rowgroup_count] ,
          SUM(CASE WHEN rg.[State] = 1 THEN 1 ELSE 0 END) AS [OPEN_rowgroup_count] ,
          SUM(CASE WHEN rg.[State] = 1 THEN rg.[total_rows] ELSE 0 END) AS [OPEN_rowgroup_rows] ,
          cast(SUM(CASE WHEN rg.[State] = 1 THEN rg.[size_in_bytes]/1024./1024. ELSE 0 END) AS decimal(19, 4)) AS [OPEN_rowgroup_size_in_mb] ,
          SUM(CASE WHEN rg.[State] = 2 THEN 1 ELSE 0 END) AS [CLOSED_rowgroup_count] ,
          SUM(CASE WHEN rg.[State] = 2 THEN rg.[total_rows] ELSE 0 END) AS [CLOSED_rowgroup_rows] ,
          cast(SUM(CASE WHEN rg.[State] = 2 THEN rg.[size_in_bytes]/1024./1024. ELSE 0 END) AS decimal(19, 4)) AS [CLOSED_size_in_mb] ,
          SUM(CASE WHEN rg.[State] = 3 THEN 1 ELSE 0 END) AS [COMPRESSED_rowgroup_count] ,
          SUM(CASE WHEN rg.[State] = 3 THEN rg.[total_rows] ELSE 0 END) AS [COMPRESSED_rowgroup_rows] ,
          cast(SUM(CASE WHEN rg.[State] = 3 THEN rg.[size_in_bytes]/1024./1024. ELSE 0 END) AS decimal(19, 4)) AS [COMPRESSED_size_in_mb] ,
          SUM(CASE WHEN rg.[State] = 3 THEN rg.[deleted_rows] ELSE 0 END) AS [COMPRESSED_rowgroup_rows_DELETED]
   FROM sys.[pdw_nodes_column_store_row_groups] rg
   JOIN sys.[pdw_nodes_tables] nt ON rg.[object_id] = nt.[object_id]
	   AND rg.[pdw_node_id] = nt.[pdw_node_id]
	   AND rg.[distribution_id] = nt.[distribution_id]
   JOIN sys.[pdw_table_mappings] mp ON nt.[name] = mp.[physical_name]
   JOIN sys.[tables] t ON mp.[object_id] = t.[object_id]
   GROUP BY t.object_id,
            rg.partition_number
)
,calc_excess AS(
	SELECT * ,
          cast(round((total_rowgroup_count / ideal_rowgroup_count) - 1.0, 4) AS decimal(9, 4)) AS [excess_rowgroup_pct] ,
          cast(round((total_rowgroup_count / ideal_rowgroup_count) - 1.0, 4) AS decimal(19, 4)) * size_in_mb AS [excess_size_in_mb]
   FROM cci_info
)
SELECT calc_excess.* 
	--,script.*
FROM calc_excess
--cross apply dbo.fnMs_GenerateIndexMaintenanceScript(object_id, partition_number) as script
WHERE -- set your own threshold(s) for the following; 0 is the ideal, but usually not practical
 calc_excess.[excess_size_in_mb] > 300
  OR calc_excess.excess_rowgroup_pct > 0.1
  OR calc_excess.OPEN_rowgroup_size_in_mb > 100
ORDER BY calc_excess.[excess_size_in_mb] DESC;
```

<!-- #region language="sql" azdata_cell_guid="d6fe1382-8e83-4074-9cf0-541eba740b66" -->
## Step 3: What to do when maintenance doesn't make the CCI health better

There are conditions under which performing maintenance on a table/partition may result in:

- excess\_rowgroup\_pct or excess\_size\_in\_mb is larger than it was before maintenane or
- the maintenance statement fails with insufficient memory

### Typical Causes

- Insufficient resources
- Insufficient service level (DWU)
- Table is large and not partitioned

### Recommended Mitigations

- Increase resources for the maintenance statement(s) by changing the executing user's [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management) or [workload group](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation) and/or
- Temporarily increase the DWU level to perform the maintenance and/or
- Implement a partitioning strategy for the problematic table and then perform maintenance on the partitions
<!-- #endregion -->

<!-- #region language="sql" azdata_cell_guid="f98d1079-4e2e-434d-8d75-520f1d025e5c" -->
## Step 4: Check for design improvement opportunities

  

Though not comprehensive, the below query can help you identify potential opportunities that are commonly found to cause performance or maintenance issues as it pertains to CCIs.

| Opportunity title | Description | Recommendations |
|-------------------|-------------|-----------------|
| Small table       | Table contains fewer than 15M rows | Consider changing the index from CCI to: <ul><li>heap if used as a staging table</li><li>standard clustered index (rowstore) if dimension or other small lookup</li></ul> |
| Partitioning opportunity | Calculated ideal rowgroup count is greater than 180 (or ~188M rows) | Implement a partitioning strategy that reduces the number of rows per partition to be less than 188M (approximately 3 row groups per partition per distribution) |
| Over-partitioned table | Table contains fewer than 15M rows for the largest partition | Consider <ul><li>changing the index from CCI to standard clustered index (rowstore)</li><li>changing the partition grain so that thaere are closer to 60M+ rows per partition</ul> |
| Partitioning opportunity | Calculated ideal rowgroup count is greater than 180 (or ~188M rows) | Change the partitioning strategy to reduce the number of rows per partition to be less than 188M (approximately 3 row groups per partition per distribution) |
<!-- #endregion -->

```sql azdata_cell_guid="17524a01-8888-42fa-b11f-40e066b98c70"
WITH cci_info AS (
	SELECT t.object_id AS [object_id],
          max(schema_name(t.schema_id)) AS [schema_name],
          max(t.name) AS [table_name],
          rg.partition_number AS [partition_number],
          SUM(rg.[total_rows]) AS [row_count_total],
          CEILING ((SUM(rg.[total_rows]) - sum(rg.[deleted_rows]))/count(DISTINCT rg.distribution_id)/1048576.) * count(DISTINCT rg.distribution_id) AS [ideal_rowgroup_count]
   FROM sys.[pdw_nodes_column_store_row_groups] rg
   JOIN sys.[pdw_nodes_tables] nt ON rg.[object_id] = nt.[object_id]
	   AND rg.[pdw_node_id] = nt.[pdw_node_id]
	   AND rg.[distribution_id] = nt.[distribution_id]
   JOIN sys.[pdw_table_mappings] mp ON nt.[name] = mp.[physical_name]
   JOIN sys.[tables] t ON mp.[object_id] = t.[object_id]
   GROUP BY t.object_id,
            rg.partition_number
)
SELECT object_id ,
       max(SCHEMA_NAME) ,
       max(TABLE_NAME) ,
       count(*) AS number_of_partitions ,
       max(row_count_total) AS max_partition_row_count ,
       max(ideal_rowgroup_count) partition_ideal_row_count ,
       CASE
	       -- non-partitioned tables
           WHEN count(*) = 1 AND max(row_count_total) < 15000000 THEN 'Small table'
           WHEN count(*) = 1 AND max(ideal_rowgroup_count) > 180 THEN 'Partitioning opportunity'
		   -- partitioned tables
           WHEN count(*) > 1 AND max(row_count_total) < 15000000 THEN 'Over-partitioned table'
           WHEN count(*) > 1 AND max(ideal_rowgroup_count) > 180 THEN 'Under-partitioned table'
       END AS warning_category
FROM cci_info
GROUP BY object_id
```

<!-- #region language="sql" azdata_cell_guid="c92a4ee2-fb51-4238-9c6f-5bc9ca94b359" -->
## Additional Resources

To gain a more in-depth understanding and acquire additional assessment tools for of CCI on the dedicated SQL pool, visit the following Microsoft resources:

- [Azure Synapse Toolbox](https://github.com/microsoft/Azure_Synapse_Toolbox)
- [Indexes on dedicated SQL pool tables in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index)
- [Columnstore indexes: Overview](/sql/relational-databases/indexes/columnstore-indexes-overview?toc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Fbreadcrumb%2Ftoc.json&view=azure-sqldw-latest&preserve-view=true)
- [Performance tuning with ordered clustered columnstore index](/azure/synapse-analytics/sql-data-warehouse/performance-tuning-ordered-cci)
- [Columnstore indexes - Design guidance](/sql/relational-databases/indexes/columnstore-indexes-design-guidance?view=sql-server-ver16)
<!-- #endregion -->
