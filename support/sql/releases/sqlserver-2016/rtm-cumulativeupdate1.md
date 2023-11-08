---
title: Cumulative update 1 for SQL Server 2016 (KB3164674)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 1 (KB3164674).
ms.date: 10/26/2023
ms.custom: KB3164674
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB3164674 - Cumulative Update 1 for SQL Server 2016

_Release Date:_ &nbsp; July 25, 2016  
_Version:_ &nbsp; 13.0.2149.0

This article describes cumulative update package 1 (build number: **13.0.2149.0**) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=7693722>[7693722](#7693722)</a> | [FIX: Access violation occurs when you run and then cancel a query on distinct count partitions in SSAS (KB3025408)](https://support.microsoft.com/help/3025408) | Analysis Services |
| <a id=7694337>[7694337](#7694337)</a> | [FIX: Selection change on Excel grouping errors out when the data is from a SQL Server Analysis Services ROLAP partition (KB3160874)](https://support.microsoft.com/help/3160874) | Analysis Services |
| <a id=7699226>[7699226](#7699226)</a> | [Analysis Services may crash if the HeapTypeForObjects memory property is configured by a slot allocator in SQL Server 2016 (KB3167113)](https://support.microsoft.com/help/3167113) | Analysis Services |
| <a id=7709923>[7709923](#7709923)</a> | [FIX: Processor group affinity issues in SQL Server 2016 Analysis Services (Tabular mode) (KB3168242)](https://support.microsoft.com/help/3168242) | Analysis Services |
| <a id=7723472>[7723472](#7723472)</a> | [FIX: Error message isn't localized completely when you use Tabular Model Scripting Language (TMSL) in SQL Server 2016 (KB3171932)](https://support.microsoft.com/help/3171932) | Analysis Services |
| <a id=7771531>[7771531](#7771531)</a> | [FIX: Unexpected exception when you make cross-appdomain TOM call in SQL Server 2016 (KB3173781)](https://support.microsoft.com/help/3173781) | Analysis Services |
| <a id=7779859>[7779859](#7779859)</a> | [Can't capture the CommandBegin and CommandEnd events in a JSON-based statement script in SQL Server 2016 (KB3171574)](https://support.microsoft.com/help/3171574) | Analysis Services |
| <a id=7806774>[7806774](#7806774)</a> | [An unexpected error occurs when you execute a DAX query that contains variables in SQL Server 2016 Analysis Services (KB3173784)](https://support.microsoft.com/help/3173784) | Analysis Services |
| <a id=7807302>[7807302](#7807302)</a> | [FIX: Can't create a database with a used database name by using the Create or CreateOrReplace command in SQL Server 2016 (KB3173779)](https://support.microsoft.com/help/3173779) | Analysis Services |
| <a id=7940156>[7940156](#7940156)</a> | [Processing a partition causes data loss on other partitions after the database is restored in SQL Server 2016 (1200) (KB3178934)](https://support.microsoft.com/help/3178934) | Analysis Services |
| <a id=7674716>[7674716](#7674716)</a> | Malformed xml requests may cause an internal error to be raised during parsing, causing a memory dump. | Analysis Services |
| <a id=7760201>[7760201](#7760201)</a> | Vertipaq AV exception while running common queries when row-level security is present and Vertiscan trace events/XEvents are turned on. | Analysis Services |
| <a id=7796665>[7796665](#7796665)</a> | An Excel workbook with an embedded PowerQuery may not be able to get scheduled data refresh. | Analysis Services |
| <a id=7801559>[7801559](#7801559)</a> | Provide support for Database-Scoped credentials in SQL PDW. | Data Warehouse |
| <a id=7678981>[7678981](#7678981)</a> | [FIX: Error 1478 when you add a database back to the AlwaysOn availability group in SQL Server (KB3152965)](https://support.microsoft.com/help/3152965) | High Availability |
| <a id=7705225>[7705225](#7705225)</a> | [FIX: The SEEDING_MODE setting is ignored when you add an AlwaysOn AG replica to an existing AG in SQL Server 2016 (KB3168571)](https://support.microsoft.com/help/3168571) | High Availability |
| <a id=7801571>[7801571](#7801571)</a> | [Performance issues occur when using the sys.dm_hadr_availability_replica_states DMV on an AlwaysOn Availability Group that contains many databases in SQL Server 2016 (KB3173038)](https://support.microsoft.com/help/3173038) | High Availability |
| <a id=7805725>[7805725](#7805725)</a> | [The .NET Framework 3.5 is required when you configure SQL Server 2016 as a secondary in Transaction Log Shipping (KB3173666)](https://support.microsoft.com/help/3173666) | High Availability |
| <a id=7806776>[7806776](#7806776)</a> | [FIX: Availability databases aren't fully started after you restart the server instance of SQL Server 2016 (KB3173989)](https://support.microsoft.com/help/3173989) | High Availability |
| <a id=7710427>[7710427](#7710427)</a> | Multiple reliability improvements in logging, redo, replication in Always On. | High Availability |
| <a id=7520653>[7520653](#7520653)</a> | [FIX: Large disk checkpoint usage occurs for an In-Memory optimized filegroup during heavy non-In-Memory workloads (KB3147012)](https://support.microsoft.com/help/3147012) | In-Memory OLTP |
| <a id=7761773>[7761773](#7761773)</a> | [FIX: Checkpoint files are missing from sys.dm_db_xtp_checkpoint_files on SQL Server 2016 (KB3173975)](https://support.microsoft.com/help/3173975) | In-Memory OLTP |
| <a id=7761776>[7761776](#7761776)</a> | [FIX: Slow database recovery in SQL Server 2016 due to large log when you use In-Memory OLTP on a high-end computer (KB3171001)](https://support.microsoft.com/help/3171001) | In-Memory OLTP |
| <a id=7761777>[7761777](#7761777)</a> | [SQL Server 2016 database log restore fails with the "Hk Recovery LSN is not NullLSN" error message (KB3171002)](https://support.microsoft.com/help/3171002) | In-Memory OLTP |
| <a id=7771534>[7771534](#7771534)</a> | [Data loss or incorrect results occur when you use the sp_settriggerorder stored procedure in SQL Server 2016 (KB3173004)](https://support.microsoft.com/help/3173004) | In-Memory OLTP |
| <a id=7779857>[7779857](#7779857)</a> | [FIX: Fatal Error when you run a query against the sys.sysindexes view in SQL Server 2016 (KB3173976)](https://support.microsoft.com/help/3173976) | In-Memory OLTP |
| <a id=7779858>[7779858](#7779858)</a> | [FIX: Secondary replica in "not healthy" state after you upgrade the primary database in SQL Server 2016 (KB3171863)](https://support.microsoft.com/help/3171863) | In-Memory OLTP |
| <a id=7801567>[7801567](#7801567)</a> | [FIX: Data loss when you alter column operation on a large memory-optimized table in SQL Server 2016 (KB3174963)](https://support.microsoft.com/help/3174963) | In-Memory OLTP |
| <a id=7761774>[7761774](#7761774)</a> | Fixes high CPU and slow recovery on an In-Memory OLTP database where many `DELETE` operations have taken place. | In-Memory OLTP |
| <a id=7705261>[7705261](#7705261)</a> | [Adds the adjusted buffer size to the BufferSizeTuning event when AutoAdjustBufferSize is enabled in SSIS 2016 (KB3170140)](https://support.microsoft.com/help/3170140) | Integration Services |
| <a id=7520608>[7520608](#7520608)</a> | [FIX: "The process cannot access the file" error when an XML task fails in SQL Server (KB3115741)](https://support.microsoft.com/help/3115741) | Integration Services |
| <a id=7600445>[7600445](#7600445)</a> | [FIX: A valid derived column expression may fail in SSIS 2012, 2014 and 2016 (KB3164404)](https://support.microsoft.com/help/3164404) | Integration Services |
| <a id=7687861>[7687861](#7687861)</a> | [FIX: Error 7330 when querying the view that is created by the Data Feed Publishing Wizard in SQL Server 2016 (KB3170132)](https://support.microsoft.com/help/3170132) | Integration Services |
| <a id=7687872>[7687872](#7687872)</a> | [FIX: SSIS package doesn't run when you call it from executable files outside the DTS\Binn folder in SQL Server 2016 (KB3170145)](https://support.microsoft.com/help/3170145) | Integration Services |
| <a id=7693343>[7693343](#7693343)</a> | [Buffer size isn't set correctly when the data flow engine handles blob data when AutoAdjustBufferSize is enabled in SQL Server Data Tools in Visual Studio 2015 (KB3170142)](https://support.microsoft.com/help/3170142) | Integration Services |
| <a id=7735626>[7735626](#7735626)</a> | [FIX: Can't generate an SSIS package when you use SQL Server Import and Export Wizard in SQL Server 2016 (KB3170214)](https://support.microsoft.com/help/3170214) | Integration Services |
| <a id=7750351>[7750351](#7750351)</a> | [FIX: SSMS can't save maintenance plans when you connect to an instance of SQL Server 2008 R2 or earlier versions (KB3171882)](https://support.microsoft.com/help/3171882) | Integration Services |
| <a id=7750361>[7750361](#7750361)</a> | [FIX: Unexpected exception when you add more maintenance plan tasks for an instance of SQL Server 2012 in SSMS 2016 (KB3171884)](https://support.microsoft.com/help/3171884) | Integration Services |
| <a id=7705263>[7705263](#7705263)</a> | Add error codes to diagnostics information for SSIS 2016 package execution failures (KB3171174) | Integration Services |
| <a id=7290668>[7290668](#7290668)</a> | [FIX: "Failed to create a new table" error when you export the cleansing results of a Data Quality Services domain in SQL Server (KB3136205)](https://support.microsoft.com/help/3136205) | Master Data Services (MDS) |
| <a id=7693380>[7693380](#7693380)</a> | [An unhandled exception occurs when you reopen a saved workbook that contains MDS entities in SQL Server 2016 (KB3170061)](https://support.microsoft.com/help/3170061) | MDS |
| <a id=7700604>[7700604](#7700604)</a> | [FIX: Data loss when you run the udpConvertCollectionAndConsolidatedMembersToLeaf stored procedure in SQL Server 2016 MDS (KB3170076)](https://support.microsoft.com/help/3170076) | MDS |
| <a id=7700848>[7700848](#7700848)</a> | [FIX: Exception occurs when you associate an availability database with MDS web application in SQL Server 2016 (KB3170083)](https://support.microsoft.com/help/3170083) | MDS |
| <a id=7700850>[7700850](#7700850)</a> | [SQL Server 2016 can't send diagnostics information for MDS web application and MDS Add-in for Excel (KB3170071)](https://support.microsoft.com/help/3170071) | MDS |
| <a id=7700851>[7700851](#7700851)</a> | [Slow performance occurs when SQL Server 2016 Master Data Services is used for operations on large MDS databases (KB3170080)](https://support.microsoft.com/help/3170080) | MDS |
| <a id=7705223>[7705223](#7705223)</a> | [FIX: Can't insert the value NULL into column "ArgumentScript" when you apply a business rule in SQL Server 2016 MDS (KB3170084)](https://support.microsoft.com/help/3170084) | MDS |
| <a id=7705224>[7705224](#7705224)</a> | [FIX: Permission issues when you use SQL Server 2016 Master Data Services (KB3170079)](https://support.microsoft.com/help/3170079) | MDS |
| <a id=7721158>[7721158](#7721158)</a> | [An unhandled exception occurs after a filter is applied on an attribute in SQL Server 2016 Master Data Services (KB3170068)](https://support.microsoft.com/help/3170068) | MDS |
| <a id=7721161>[7721161](#7721161)</a> | [A deadlock condition occurs when you run certain operations in parallel in SQL Server 2016 Master Data Services (KB3170081)](https://support.microsoft.com/help/3170081) | MDS |
| <a id=7721162>[7721162](#7721162)</a> | [FIX: Permission issue or failure occurs when you upgrade to SQL Server 2016 Master Data Services (KB3170082)](https://support.microsoft.com/help/3170082) | MDS |
| <a id=7721163>[7721163](#7721163)</a> | [Can't create an MDS website by using a low-privilege account in SQL Server 2016 (KB3170078)](https://support.microsoft.com/help/3170078) | MDS |
| <a id=7735621>[7735621](#7735621)</a> | [FIX: Unexpected exception occurs when deploying a package using SQL Server 2016 MDSModelDeploy tool (KB3170074)](https://support.microsoft.com/help/3170074) | MDS |
| <a id=7735625>[7735625](#7735625)</a> | [Domain-based attributes created by MDS Add-in for Excel aren't available for Business Rules Extension feature in SQL Server 2016 (KB3170085)](https://support.microsoft.com/help/3170085) | MDS |
| <a id=7735627>[7735627](#7735627)</a> | [FIX: JavaScript error when you create an MDS subscription view in SQL Server 2016 (KB3170077)](https://support.microsoft.com/help/3170077) | MDS |
| <a id=7735622>[7735622](#7735622)</a> | The Add Annotation button is disabled for the current member version in MDS Explorer (KB3170075) | MDS |
| <a id=7723473>[7723473](#7723473)</a> | [Improvements and fixes for SSRS 2016 mobile report (KB3170359)](https://support.microsoft.com/help/3170359) | Reporting Services |
| <a id=7678915>[7678915](#7678915)</a> | [FIX: PageRequestManagerServerErrorException error when you use an invalid date parameter in SSRS (KB3152042)](https://support.microsoft.com/help/3152042) | Reporting Services |
| <a id=7678934>[7678934](#7678934)</a> | [FIX: Unicode characters are displayed as square blocks after you paste them from an SSRS report (KB3152596)](https://support.microsoft.com/help/3152596) | Reporting Services |
| <a id=7678976>[7678976](#7678976)</a> | [FIX: Shared data sources and stored credentials are removed by the SharePoint daily cleanup jobs in SSRS (KB3162396)](https://support.microsoft.com/help/3162396) | Reporting Services |
| <a id=7699227>[7699227](#7699227)</a> | [FIX: The "Select All" check box doesn't work in the subscriptions page in SSRS 2016 (KB3167175)](https://support.microsoft.com/help/3167175) | Reporting Services |
| <a id=7699246>[7699246](#7699246)</a> | [FIX: Subscriptions that are filtered out are still affected by the actions in SSRS 2016 (KB3167174)](https://support.microsoft.com/help/3167174) | Reporting Services |
| <a id=7699255>[7699255](#7699255)</a> | [FIX: SSRS logs fill up the hard disk and agent jobs aren't recreated after database migration in SQL Server 2016 (KB3167434)](https://support.microsoft.com/help/3167434) | Reporting Services |
| <a id=7711871>[7711871](#7711871)</a> | [SQL Server 2016 Reporting Services doesn't upload Service Quality Monitoring data collections (KB3171470)](https://support.microsoft.com/help/3171470) | Reporting Services |
| <a id=7711872>[7711872](#7711872)</a> | [Can't open an SSRS paginated report from SQL Server 2016 Reporting Services web portal on an iPad (KB3171469)](https://support.microsoft.com/help/3171469) | Reporting Services |
| <a id=7711873>[7711873](#7711873)</a> | [FIX: Only one Boolean parameter can select default value when you have multiple Boolean parameters in SSRS 2016 (KB3168200)](https://support.microsoft.com/help/3168200) | Reporting Services |
| <a id=7711874>[7711874](#7711874)</a> | [The "BackgroundColor" property isn't respected when it's specified by an expression in SQL Server 2016 Reporting Services (KB3170528)](https://support.microsoft.com/help/3170528) | Reporting Services |
| <a id=7711875>[7711875](#7711875)</a> | [Fixes some issues about assistive technology tools in SSRS 2016 (KB3169923)](https://support.microsoft.com/help/3169923) | Reporting Services |
| <a id=7711876>[7711876](#7711876)</a> | [Can't create a new subscription for a report that contains Unicode characters in SQL Server 2016 Reporting Services web portal (KB3169922)](https://support.microsoft.com/help/3169922) | Reporting Services |
| <a id=7711878>[7711878](#7711878)</a> | [Update to fix layout issues in SQL Server 2016 Reporting Services (SSRS) web portal (KB3169921)](https://support.microsoft.com/help/3169921) | Reporting Services |
| <a id=7760202>[7760202](#7760202)</a> | ["HTTP 503: Service unavailable" error message when you open the SSRS web portal after you upgrade to SSRS 2016 (KB3171040)](https://support.microsoft.com/help/3171040) | Reporting Services |
| <a id=7771533>[7771533](#7771533)</a> | [FIX: Can't retrieve favorite KPIs or mobile reports in Power BI Mobile app or GetCatalogItem API in SQL Server 2016 (KB3171480)](https://support.microsoft.com/help/3171480) | Reporting Services |
| <a id=7771535>[7771535](#7771535)</a> | [Can't pin an SSRS report to Power BI dashboards when you aren't a member of any groups on PowerBI.com website (KB3171467)](https://support.microsoft.com/help/3171467) | Reporting Services |
| <a id=7771743>[7771743](#7771743)</a> | [A report configured to automatically refresh causes errors after the web browser idles for a while in SQL Server 2016 Reporting Services (KB3171085)](https://support.microsoft.com/help/3171085) | Reporting Services |
| <a id=7771745>[7771745](#7771745)</a> | [Drilling through from one mobile report to another doesn't respect the embed parameter specified in a URL in SQL Server 2016 Reporting Services (KB3171532)](https://support.microsoft.com/help/3171532) | Reporting Services |
| <a id=7771746>[7771746](#7771746)</a> | [FIX: Can't rename a catalog item with the same name in different case in SSRS 2016 (KB3171475)](https://support.microsoft.com/help/3171475) | Reporting Services |
| <a id=7801558>[7801558](#7801558)</a> | [FIX: Home page of SSRS web portal becomes empty after you enable My Reports feature in SQL Server 2016 (KB3172981)](https://support.microsoft.com/help/3172981) | Reporting Services |
| <a id=7679024>[7679024](#7679024)</a> | FIX: Incorrect page numbers are displayed when you export an SSRS report to PDF or TIFF format (KB3160427) | Reporting Services |
| <a id=7771744>[7771744](#7771744)</a> | FIX: Column becomes empty when the `VerticalAlign` property is set to `Middle` or `Bottom` in SSRS 2016 (KB3172732) | Reporting Services |
| <a id=7801566>[7801566](#7801566)</a> | FIX: Localized user interface of SSRS 2016 web portal doesn't work correctly in Internet Explorer and Microsoft Edge (KB3173046) | Reporting Services |
| <a id=7801569>[7801569](#7801569)</a> | FIX: Date picker on the SSRS 2016 web portal displays invalid characters if the web browser is set to non-English (KB3172939) | Reporting Services |
| <a id=7439700>[7439700](#7439700)</a> | [FIX: The ALTER SERVER CONFIGURATION with SET SOFTNUMA command doesn't work in SQL Server 2016 (KB3158710)](https://support.microsoft.com/help/3158710) | Setup & Install |
| <a id=7722018>[7722018](#7722018)</a> | [Setup UI changes to English if a non-English version of SQL Server 2016 GDR update is installed using the Product Update feature (KB3168257)](https://support.microsoft.com/help/3168257) | Setup & Install |
| <a id=7761775>[7761775](#7761775)</a> | [The Product Update feature doesn't update SQL Server Setup support files during a slipstreamed installation for a non-English version of SQL Server 2016 (KB3170293)](https://support.microsoft.com/help/3170293) | Setup & Install |
| <a id=7824390>[7824390](#7824390)</a> | [FIX: Can't install a non-English version of SQL Server 2016 on a Windows Server that is installed in Server Core mode (KB3173957)](https://support.microsoft.com/help/3173957) | Setup & Install |
| <a id=7649866>[7649866](#7649866)</a> | Executions of `sp_sqlagent_log_jobhistory` or `xp_instance_regread` may cause an access violation due to outdated version of *msvcrt120.dll*. | Setup & Install |
| <a id=7710425>[7710425](#7710425)</a> | Fixes an issue where *LocalDB.msi* package built from CU branch failed to install. | Setup & Install |
| <a id=7381655>[7381655](#7381655)</a> | You may get an access violation in `CBpBatch::PcGetVectorBuffer` when using spatial functions. | SQL Engine |
| <a id=7791519>[7791519](#7791519)</a> | Fixes a failure to upgrade a SQL Telemetry DLL *Microsoft.SqlServer.Configuration.TelemetryConfigExtension.dll*. | SQL Engine |
| <a id=7791521>[7791521](#7791521)</a> | Performance and data improvement of SQL Telemetry queries. | SQL Engine |
| <a id=7795583>[7795583](#7795583)</a> | You may see an access violation exception when performing DML operations on a temporal table with sparse columns and the DML doesn't modify the sparse columns. | SQL Engine |
| <a id=7801551>[7801551](#7801551)</a> | Fixes an issue where SQL Telemetry services aren't successfully patched because it isn't restarted during an update. | SQL Engine |
| <a id=7806257>[7806257](#7806257)</a> | If you use `sp_execute_external_script` with parameters, and the parameter declaration has value assignment in it, you may get an access violation exception. | SQL Engine |
| <a id=7806598>[7806598](#7806598)</a> | When a user creates a new database and creates large number of partitions, the database becomes extremely slow. | SQL Engine |
| <a id=7832337>[7832337](#7832337)</a> | Bulk insert fails with an access violation exception and error 7301 "Cannot obtain the required interface ("IID_IColumnsInfo") from OLE DB provider "BULK" for linked server "(null)"". | SQL Engine |
| <a id=7290754>[7290754](#7290754)</a> | [Query plan generation improvement for some columnstore queries in SQL Server 2014 or 2016 (KB3146123)](https://support.microsoft.com/help/3146123) | SQL performance |
| <a id=7290758>[7290758](#7290758)</a> | [Running multiple UPDATE STATISTICS for different statistics on a single table concurrently is available (KB3156157)](https://support.microsoft.com/help/3156157) | SQL performance |
| <a id=7290582>[7290582](#7290582)</a> | [FIX: "Non-yielding Scheduler" condition when you run a query that contains a UNION operation in SQL Server 2014 or 2016 (KB3138321)](https://support.microsoft.com/help/3138321) | SQL performance |
| <a id=7290744>[7290744](#7290744)</a> | [FIX: An access violation occurs when you run a spatial query that contains OPENQUERY methods through a linked server in SQL Server 2014 or 2016 (KB3152135)](https://support.microsoft.com/help/3152135) | SQL performance |
| <a id=7514884>[7514884](#7514884)</a> | [FIX: Incorrect results when you use a LIKE operator and an "ss" wildcard in SQL Server 2014 or 2016 (KB3160303)](https://support.microsoft.com/help/3160303) | SQL performance |
| <a id=7735628>[7735628](#7735628)</a> | [FIX: Assertion failure when you run UNION or UNION ALL clauses on a Row-Level Security enabled table in SQL Server 2016 (KB3172973)](https://support.microsoft.com/help/3172973) | SQL performance |
| <a id=7770911>[7770911](#7770911)</a> | [Adds trace flag 9358 to disable batch mode sort operations in a complex parallel query in SQL Server 2016 (KB3171555)](https://support.microsoft.com/help/3171555) | SQL performance |
| <a id=7801554>[7801554](#7801554)</a> | [FIX: Can't disable batch mode sorted by session trace flag 9347 or the query hint QUERYTRACEON 9347 in SQL Server 2016 (KB3172787)](https://support.microsoft.com/help/3172787) | SQL performance |
| <a id=7818856>[7818856](#7818856)</a> | [FIX: SQL Server 2016 uses all available memory and crashes when it runs a query that contains HASHBYTES functions (KB3174684)](https://support.microsoft.com/help/3174684) | SQL performance |
| <a id=7290727>[7290727](#7290727)</a> | [Update to change permissions for running sp_readerrorlog and sp_enumerrorlogs in SQL Server 2012 or 2016 (KB3149128)](https://support.microsoft.com/help/3149128) | SQL security |
| <a id=7290649>[7290649](#7290649)</a> | [FIX: SMK initialization fails on one node of a SQL Server 2012, 2014, or 2016 failover cluster (KB3132062)](https://support.microsoft.com/help/3132062) | SQL security |
| <a id=7779871>[7779871](#7779871)</a> | [SECURITY_CRYPTO_CONTEXT_MUTEX waits cause SQL Server 2016 to stop responding to client requests in SQL Server 2016 (KB3173472)](https://support.microsoft.com/help/3173472) | SQL security |
| <a id=7801561>[7801561](#7801561)</a> | [FIX: Wrong "schema_name" and "class_type" values for the CREATE SECURITY POLICY statement in SQL Server 2016 (KB3173043)](https://support.microsoft.com/help/3173043) | SQL security |
| <a id=7705424>[7705424](#7705424)</a> | [An update is available to add FIPS compliant support in SQL Server 2016 (KB3168570)](https://support.microsoft.com/help/3168570) | SQL service |
| <a id=7806778>[7806778](#7806778)</a> | [Behavior changes when you add uniqueidentifier columns in a clustered Columnstore Index in SQL Server 2016 (KB3173436)](https://support.microsoft.com/help/3173436) | SQL service |
| <a id=7831747>[7831747](#7831747)</a> | [Improves the installation process of the SQL Server R Services in SQL Server 2016 (KB3175018)](https://support.microsoft.com/help/3175018) | SQL service |
| <a id=7290565>[7290565](#7290565)</a> | [FIX: Error occurs when you try to drop or delete filegroups or partition schemes and functions in SQL Server (KB3132058)](https://support.microsoft.com/help/3132058) | SQL service |
| <a id=7290686>[7290686](#7290686)</a> | [FIX: "A severe error occurred on the current command" when a Table-Valued User-Defined function is referred to by a synonym (KB3139489)](https://support.microsoft.com/help/3139489) | SQL service |
| <a id=7337506>[7337506](#7337506)</a> | [FIX: "Cannot resolve the collation conflict" error when you apply a snapshot to the subscriber database in SQL Server (KB3131443)](https://support.microsoft.com/help/3131443) | SQL service |
| <a id=7337617>[7337617](#7337617)</a> | [FIX: Log Reader Agent fails when you have Oracle Publishing configured in SQL Server (KB2953354)](https://support.microsoft.com/help/2953354) | SQL service |
| <a id=7513881>[7513881](#7513881)</a> | [FIX: Heavy concurrent OLTP activity runs slowly when delayed durability is enabled in SQL Server 2016 (KB3170999)](https://support.microsoft.com/help/3170999) | SQL service |
| <a id=7520618>[7520618](#7520618)</a> | [FIX: Error 5120 when you create or use a FILESTREAM-enabled database on a dynamic disk in an instance of SQL Server 2014 or 2016 (KB3152377)](https://support.microsoft.com/help/3152377) | SQL service |
| <a id=7520625>[7520625](#7520625)</a> | [FIX: A "Non-yielding Scheduler" condition occurs when you perform a BULK INSERT and the data file exists in a FileTable in SQL Server (KB3150896)](https://support.microsoft.com/help/3150896) | SQL service |
| <a id=7520630>[7520630](#7520630)</a> | [FIX: FileTables in an AlwaysOn availability group become unavailable after failover in an instance of SQL Server (KB3152378)](https://support.microsoft.com/help/3152378) | SQL service |
| <a id=7520647>[7520647](#7520647)</a> | [FIX: Canceling a backup task crashes SQL Server 2014 or 2016 (KB3146404)](https://support.microsoft.com/help/3146404) | SQL service |
| <a id=7593774>[7593774](#7593774)</a> | [AUTOGROW_ALL_FILES and READ_ONLY aren't either updated by DDL or preserved after a database restarts in SQL Server 2016 (KB3163924)](https://support.microsoft.com/help/3163924) | SQL service |
| <a id=7678948>[7678948](#7678948)</a> | [FIX: Memory leak on the AlwaysOn secondary replica when change tracking is enabled in SQL Server (KB3154226)](https://support.microsoft.com/help/3154226) | SQL service |
| <a id=7679011>[7679011](#7679011)</a> | [FIX: MERGE statement to sync tables is unsuccessful when change data capture is enabled in SQL Server 2012, 2014, or 2016 (KB3155503)](https://support.microsoft.com/help/3155503) | SQL service |
| <a id=7694330>[7694330](#7694330)</a> | [FIX: Can't delete a row from a filtered table part of a merge publication in SQL Server 2012, 2014, or 2016 (KB3155209)](https://support.microsoft.com/help/3155209) | SQL service |
| <a id=7694670>[7694670](#7694670)</a> | [FIX: Can't create or delete a table or index when another DDL transaction is running on the same database in SQL Server 2016 (KB3168793)](https://support.microsoft.com/help/3168793) | SQL service |
| <a id=7709918>[7709918](#7709918)</a> | [Creating or updating statistics takes a long time on a large memory-optimized table in SQL Server 2016 (KB3170996)](https://support.microsoft.com/help/3170996) | SQL service |
| <a id=7735631>[7735631](#7735631)</a> | [FIX: ShortestLineTo() and STDistance() methods return incorrect result for the shortest distance in SQL Server 2016 (KB3175203)](https://support.microsoft.com/help/3175203) | SQL service |
| <a id=7735635>[7735635](#7735635)</a> | [FIX: Long query that contains specific expressions receives syntax error if forced parameterization is enabled in SQL Server 2016 (KB3175205)](https://support.microsoft.com/help/3175205) | SQL service |
| <a id=7770910>[7770910](#7770910)</a> | [FIX: Error 8061 when you use BULK INSERT on a table in SQL Server 2016 (KB3172959)](https://support.microsoft.com/help/3172959) | SQL service |
| <a id=7771144>[7771144](#7771144)</a> | [FIX: Error 8624 occurs when you run a query against a nonclustered columnstore index in SQL Server 2016 (KB3171544)](https://support.microsoft.com/help/3171544) | SQL service |
| <a id=7771529>[7771529](#7771529)</a> | [FIX: Error 10635 when you rebuild indexes online for tables that contain large object (LOB) columns in SQL Server 2016 (KB3174433)](https://support.microsoft.com/help/3174433) | SQL service |
| <a id=7771530>[7771530](#7771530)</a> | [FIX: Incorrect number of rows in sys.partitions for a columnstore index in SQL Server 2016 (KB3172974)](https://support.microsoft.com/help/3172974) | SQL service |
| <a id=7771537>[7771537](#7771537)</a> | [FIX: BULK INSERT or OPENROWSET import wrong data if UTF-8 encoded file doesn't have a BOM in SQL Server 2016 (KB3172671)](https://support.microsoft.com/help/3172671) | SQL service |
| <a id=7772133>[7772133](#7772133)</a> | [FIX: PolyBase feature doesn't install when you add a node to a SQL Server 2016 failover cluster (KB3173087)](https://support.microsoft.com/help/3173087) | SQL service |
| <a id=7779868>[7779868](#7779868)</a> | [The Customer Experience Improvement Program is disabled after FIPS compliance is enabled in SQL Server 2016 (KB3174788)](https://support.microsoft.com/help/3174788) | SQL service |
| <a id=7779870>[7779870](#7779870)</a> | [FIX: "The service is not available" error when you use SSRS 2016 Portal after you disconnect from the domain (KB3171505)](https://support.microsoft.com/help/3171505) | SQL service |
| <a id=7788772>[7788772](#7788772)</a> | [The Apply button on the Parameter Properties page isn't localized in SQL Server 2016 Reporting Services web portal (KB3171489)](https://support.microsoft.com/help/3171489) | SQL service |
| <a id=7791531>[7791531](#7791531)</a> | [A query that accesses data in a columnstore index causes the Database Engine to receive a floating point exception in SQL Server 2016 (KB3171759)](https://support.microsoft.com/help/3171759) | SQL service |
| <a id=7795585>[7795585](#7795585)</a> | [A data flush task may cause a deadlock condition when queries are executed on a memory-optimized table in SQL Server 2016 (KB3173841)](https://support.microsoft.com/help/3173841) | SQL service |
| <a id=7795586>[7795586](#7795586)</a> | [A memory leak occurs when DATA_CONSISTENCY_CHECK is being executed for a system-versioned temporal table in SQL Server 2016 (KB3174708)](https://support.microsoft.com/help/3174708) | SQL service |
| <a id=7795587>[7795587](#7795587)</a> | [Audit record is missing when you turn on SYSTEM_VERSIONING for a table by using the ALTER TABLE statement in SQL Server 2016 (KB3174710)](https://support.microsoft.com/help/3174710) | SQL service |
| <a id=7795589>[7795589](#7795589)</a> | [SYSTEM_VERSIONING isn't turned on for a table in a database that has the READ_COMMITTED_SNAPSHOT isolation level enabled in SQL Server 2016 (KB3174711)](https://support.microsoft.com/help/3174711) | SQL service |
| <a id=7795590>[7795590](#7795590)</a> | [A deadlock condition occurs when you make updates on a memory-optimized temporal table and you run the SWITCH PARTITION statement on a history table in SQL Server 2016 (KB3174712)](https://support.microsoft.com/help/3174712) | SQL service |
| <a id=7795591>[7795591](#7795591)</a> | [Data Flush Tasks of a memory-optimized temporal table may consume 100 percent CPU usage in SQL Server 2016 (KB3174713)](https://support.microsoft.com/help/3174713) | SQL service |
| <a id=7801555>[7801555](#7801555)</a> | [FIX: sys.dm_external_script_execution_stats returns an incorrect counter_value in SQL Server 2016 (KB3174395)](https://support.microsoft.com/help/3174395) | SQL service |
| <a id=7801565>[7801565](#7801565)</a> | [Windows Authentication doesn't work when you connect to SQL Server from R Script on SQL Server 2016 Express Edition (KB3174393)](https://support.microsoft.com/help/3174393) | SQL service |
| <a id=7801572>[7801572](#7801572)</a> | [FIX: "A network-related or instance-specific error occurred" when you repair SQL Server 2016 (KB3174829)](https://support.microsoft.com/help/3174829) | SQL service |
| <a id=7806256>[7806256](#7806256)</a> | [SQL Server 2016 generates a dump file when you execute an external script in parallel mode (KB3173065)](https://support.microsoft.com/help/3173065) | SQL service |
| <a id=7806268>[7806268](#7806268)</a> | [FIX: Failed execution of ALTER AUDIT statement causes SQL Server to crash in SQL Server 2016 (KB3174436)](https://support.microsoft.com/help/3174436) | SQL service |
| <a id=7806777>[7806777](#7806777)</a> | [FIX: It takes a long time to compile a query and add it to the Query Store in SQL Server 2016 (KB3175478)](https://support.microsoft.com/help/3175478) | SQL service |
| <a id=7811575>[7811575](#7811575)</a> | [FIX: Error 3456 "Could not redo log record" occurs, causing replicas to be suspended or repeated behavior in SQL Server (KB3173471)](https://support.microsoft.com/help/3173471) | SQL service |
| <a id=7827402>[7827402](#7827402)</a> | [FIX: Error 5283 when you run DBCC CHECKDB on a database that contains non-clustered columnstore index in SQL Server 2016 (KB3174088)](https://support.microsoft.com/help/3174088) | SQL service |
| <a id=7831314>[7831314](#7831314)</a> | [The Full-Text Search feature doesn't always return the expected results in SQL Server 2016 (KB3174674)](https://support.microsoft.com/help/3174674) | SQL service |
| <a id=7837980>[7837980](#7837980)</a> | [FIX: Queries on Stretch Database enabled databases always involve a network round-trip to Azure in SQL Server 2016 (KB3174812)](https://support.microsoft.com/help/3174812) | SQL service |
| <a id=7866996>[7866996](#7866996)</a> | [Query Store automatic data cleanup fails on editions other than Enterprise and Developer edition of SQL Server 2016 (KB3178297)](https://support.microsoft.com/help/3178297) | SQL service |
| <a id=7914931>[7914931](#7914931)</a> | [FIX: Potential loss of historical data when you alter an in-memory temporal table in SQL Server 2016 (KB3178137)](https://support.microsoft.com/help/3178137) | SQL service |
| <a id=7284275>[7284275](#7284275)</a> | FIX: XA transactions aren't cleaned when you exit a Java application in an instance of SQL Server (KB3145492) | SQL service |
| <a id=7337473>[7337473](#7337473)</a> | FIX: The Log Reader Agent stops intermittently and an Access Violation occurs in SQL Server (KB3123309) | SQL service |
| <a id=7710945>[7710945](#7710945)</a> | FIX: Online index operations block DML operations when the database contains a clustered columnstore index (KB3172960) | SQL service |
| <a id=7795584>[7795584](#7795584)</a> | FIX: Infinite recompile occurs when querying a view that references the identity column of a system-versioned temporal table (KB3174669) | SQL service |
| <a id=7801553>[7801553](#7801553)</a> | FIX: Counters for job objects created by SQL Server Trusted Launchpad aren't visible in Windows Performance Monitor (KB3174396) | SQL service |
| <a id=7806775>[7806775](#7806775)</a> | FIX: All data goes to deltastores when you bulk load data into a clustered columnstore index under memory pressure (KB3174073) | SQL service |
| <a id=7811515>[7811515](#7811515)</a> | FIX: Can't query or migrate data from a local Stretch-enabled table after you execute `sys.sp_rda_reconcile_batch` (KB3174076) | SQL service |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for Microsoft SQL Server 2016 now](https://www.microsoft.com/download/details.aspx?id=53338)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 is available at the Download Center.

- Each new CU contains all the fixes that were included with the previous CU for the installed version/Service Pack of SQL Server.
- Microsoft recommends ongoing, proactive installation of CUs as they become available:
  - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.
- We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

</details>

<details>
<summary><b>Hybrid environments deployment</b></summary>

When you deploy the hotfixes to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the hotfixes:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply a CU or SP:
    >
    > - Install the service pack on the passive node.
    > - Install the service pack on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply a CU or SP in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.
- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

    > [!NOTE]
    > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

1. Locate the entry that corresponds to this cumulative update package.
1. Right-click the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

## File information

<details>
<summary><b>Cumulative update package file information</b></summary>

This cumulative update package might not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Database Services Common Core

|                File name               |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.core.dll    | 13.0.2149.0     | 1064648   | 12-Jul-16 | 08:00 | x86      |
| Microsoft.analysisservices.dll         | 13.0.2149.0     | 702656    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.analysisservices.tabular.dll | 13.0.2149.0     | 765120    | 12-Jul-16 | 08:00 | x86      |
| Sql_common_core_keyfile.dll            | 2015.130.2149.0 | 88768     | 12-Jul-16 | 08:00 | x86      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2149.0  | 473280    | 12-Jul-16 | 08:01 | x86      |

SQL Server 2016 Tools and Workstation Components Extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2149.0 | 2631872   | 12-Jul-16 | 08:00 | x86      |
| Dtspipeline.dll                                              | 2015.130.2149.0 | 1059520   | 12-Jul-16 | 08:00 | x86      |
| Dtswizard.exe                                                | 13.0.2149.0     | 895680    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.analysisservices.project.dll                       | 2015.130.2149.0 | 2023104   | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2149.0     | 432840    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2149.0     | 2043584   | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2149.0     | 250048    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2149.0     | 33992     | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2149.0     | 606400    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2149.0     | 445120    | 12-Jul-16 | 08:01 | x86      |
| Msmdlocal.dll                                                | 2015.130.2149.0 | 36954824  | 12-Jul-16 | 08:00 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2149.0 | 6497984   | 12-Jul-16 | 08:01 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2149.0 | 88768     | 12-Jul-16 | 08:00 | x86      |
| Xmsrv.dll                                                    | 2015.130.2149.0 | 32693440  | 12-Jul-16 | 08:00 | x86      |

x64-based versions

SQL Server 2016 Business Intelligence Development Studio

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlsqm_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlwriter_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 Analysis Services

|                   File name                   |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll    | 13.0.2149.0     | 1064136   | 12-Jul-16 | 08:00 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2149.0     | 765640    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 17-Jun-16 | 00:32 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 17-Jun-16 | 00:32 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 15-Jun-16 | 12:46 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 17-Jun-16 | 00:32 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 17-Jun-16 | 00:32 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 15-Jun-16 | 12:46 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 17-Jun-16 | 00:32 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 12:46 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 17-Jun-16 | 00:32 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 12:46 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 17-Jun-16 | 00:32 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 17-Jun-16 | 00:32 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 15-Jun-16 | 12:46 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 17-Jun-16 | 00:32 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 17-Jun-16 | 00:32 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 15-Jun-16 | 12:46 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 17-Jun-16 | 00:32 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 15-Jun-16 | 12:46 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 17-Jun-16 | 00:32 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 17-Jun-16 | 00:32 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 15-Jun-16 | 12:46 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 17-Jun-16 | 00:32 | x86      |
| Msmdlocal.dll                                 | 2015.130.2149.0 | 36954824  | 12-Jul-16 | 08:00 | x86      |
| Msmdlocal.dll                                 | 2015.130.2149.0 | 55971016  | 12-Jul-16 | 08:02 | x64      |
| Msmdsrv.exe                                   | 2015.130.2149.0 | 56515776  | 12-Jul-16 | 08:00 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2149.0 | 7502528   | 12-Jul-16 | 08:00 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2149.0 | 6497984   | 12-Jul-16 | 08:01 | x86      |
| Sql_as_keyfile.dll                            | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |
| Sqlceip.exe                                   | 13.0.2149.0     | 193216    | 12-Jul-16 | 08:00 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 15-Jun-16 | 12:46 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 17-Jun-16 | 00:32 | x86      |
| Tmapi.dll                                     | 2015.130.2149.0 | 4344512   | 12-Jul-16 | 08:00 | x64      |
| Tmcachemgr.dll                                | 2015.130.2149.0 | 2825408   | 12-Jul-16 | 08:00 | x64      |
| Tmpersistence.dll                             | 2015.130.2149.0 | 1069760   | 12-Jul-16 | 08:00 | x64      |
| Tmtransactions.dll                            | 2015.130.2149.0 | 1347264   | 12-Jul-16 | 08:00 | x64      |
| Xmsrv.dll                                     | 2015.130.2149.0 | 32693440  | 12-Jul-16 | 08:00 | x86      |
| Xmsrv.dll                                     | 2015.130.2149.0 | 24012992  | 12-Jul-16 | 08:00 | x64      |

SQL Server 2016 Database Services Common Core

|                File name               |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.core.dll    | 13.0.2149.0     | 1064648   | 12-Jul-16 | 08:00 | x86      |
| Microsoft.analysisservices.dll         | 13.0.2149.0     | 702656    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.analysisservices.tabular.dll | 13.0.2149.0     | 765120    | 12-Jul-16 | 08:00 | x86      |
| Sql_common_core_keyfile.dll            | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2149.0  | 473280    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2149.0  | 473280    | 12-Jul-16 | 08:01 | x86      |

SQL Server 2016 Database Services Core Instance

|             File name            |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Hkcompile.dll                    | 2015.130.2149.0 | 1296576   | 12-Jul-16 | 08:00 | x64      |
| Hkengine.dll                     | 2015.130.2149.0 | 5596864   | 12-Jul-16 | 08:00 | x64      |
| Hkruntime.dll                    | 2015.130.2149.0 | 159424    | 12-Jul-16 | 08:00 | x64      |
| Qds.dll                          | 2015.130.2149.0 | 843456    | 12-Jul-16 | 08:02 | x64      |
| Rsfxft.dll                       | 2015.130.2149.0 | 34496     | 12-Jul-16 | 08:00 | x64      |
| Sql_engine_core_inst_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |
| Sqlaccess.dll                    | 2015.130.2149.0 | 461504    | 12-Jul-16 | 08:00 | x64      |
| Sqlagent.exe                     | 2015.130.2149.0 | 565952    | 12-Jul-16 | 08:00 | x64      |
| Sqlceip.exe                      | 13.0.2149.0     | 193216    | 12-Jul-16 | 08:00 | x86      |
| Sqldk.dll                        | 2015.130.2149.0 | 2583752   | 12-Jul-16 | 08:02 | x64      |
| Sqllang.dll                      | 2015.130.2149.0 | 39278784  | 12-Jul-16 | 08:02 | x64      |
| Sqlmin.dll                       | 2015.130.2149.0 | 37326536  | 12-Jul-16 | 08:00 | x64      |
| Sqlos.dll                        | 2015.130.2149.0 | 26304     | 12-Jul-16 | 08:00 | x64      |
| Sqlscriptdowngrade.dll           | 2015.130.2149.0 | 27840     | 12-Jul-16 | 08:00 | x64      |
| Sqlscriptupgrade.dll             | 2015.130.2149.0 | 5797064   | 12-Jul-16 | 08:00 | x64      |
| Sqlserverspatial130.dll          | 2015.130.2149.0 | 732864    | 12-Jul-16 | 08:00 | x64      |
| Sqlservr.exe                     | 2015.130.2149.0 | 392384    | 12-Jul-16 | 08:00 | x64      |
| Sqltses.dll                      | 2015.130.2149.0 | 8896704   | 12-Jul-16 | 08:00 | x64      |

SQL Server 2016 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2149.0 | 3145408   | 12-Jul-16 | 08:01 | x64      |
| Dtspipeline.dll                                              | 2015.130.2149.0 | 1278152   | 12-Jul-16 | 08:01 | x64      |
| Dtswizard.exe                                                | 13.0.2149.0     | 895168    | 12-Jul-16 | 08:01 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2149.0     | 33984     | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2149.0     | 606400    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2149.0     | 445120    | 12-Jul-16 | 08:00 | x86      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.2149.0 | 1012928   | 12-Jul-16 | 08:01 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |
| Sqlsatellite.dll              | 2015.130.2149.0 | 836800    | 12-Jul-16 | 08:00 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 29-Apr-15 | 02:16 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 29-Apr-15 | 02:16 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 29-Apr-15 | 02:16 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 29-Apr-15 | 02:16 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.2149.0     | 23744     | 12-Jul-16 | 08:00 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                       | 2015.130.2149.0 | 2631872   | 12-Jul-16 | 08:00 | x86      |
| Dts.dll                                                       | 2015.130.2149.0 | 3145408   | 12-Jul-16 | 08:01 | x64      |
| Dtspipeline.dll                                               | 2015.130.2149.0 | 1059520   | 12-Jul-16 | 08:00 | x86      |
| Dtspipeline.dll                                               | 2015.130.2149.0 | 1278152   | 12-Jul-16 | 08:01 | x64      |
| Dtswizard.exe                                                 | 13.0.2149.0     | 895680    | 12-Jul-16 | 08:00 | x86      |
| Dtswizard.exe                                                 | 13.0.2149.0     | 895168    | 12-Jul-16 | 08:01 | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2149.0     | 469704    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2149.0     | 469696    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2149.0     | 33984     | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2149.0     | 33992     | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2149.0     | 606400    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2149.0     | 606400    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2149.0     | 445120    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2149.0     | 445120    | 12-Jul-16 | 08:01 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2149.0     | 216768    | 12-Jul-16 | 08:01 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |
| Sqlceip.exe                                                   | 13.0.2149.0     | 193216    | 12-Jul-16 | 08:00 | x86      |

SQL Server 2016 PolyBase

|  File name  |   File version  | File size |    Date   |  Time | Platform |
|:-----------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqldk.dll   | 2015.130.2149.0 | 2526408   | 12-Jul-16 | 08:00 | x64      |
| Sqlos.dll   | 2015.130.2149.0 | 26304     | 12-Jul-16 | 08:00 | x64      |
| Sqltses.dll | 2015.130.2149.0 | 9064128   | 12-Jul-16 | 08:00 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.authorization.dll             | 13.0.2149.0     | 77000     | 12-Jul-16 | 08:00 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2149.0     | 567488    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2149.0     | 1620160   | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2149.0     | 329408    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2149.0     | 887488    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2149.0     | 76480     | 12-Jul-16 | 08:00 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2149.0     | 76480     | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2149.0     | 122560    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2149.0     | 104136    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2149.0     | 4892864   | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2149.0     | 9644736   | 12-Jul-16 | 08:01 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2149.0     | 93376     | 12-Jul-16 | 08:01 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2149.0     | 5951168   | 12-Jul-16 | 08:01 | x86      |
| Msmdlocal.dll                                             | 2015.130.2149.0 | 36954824  | 12-Jul-16 | 08:00 | x86      |
| Msmdlocal.dll                                             | 2015.130.2149.0 | 55971016  | 12-Jul-16 | 08:02 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2149.0 | 7502528   | 12-Jul-16 | 08:00 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2149.0 | 6497984   | 12-Jul-16 | 08:01 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.2149.0     | 2516680   | 12-Jul-16 | 08:00 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2149.0 | 108744    | 12-Jul-16 | 08:00 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.2149.0 | 114368    | 12-Jul-16 | 08:01 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.2149.0 | 99016     | 12-Jul-16 | 08:00 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2149.0     | 2516168   | 12-Jul-16 | 08:00 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2149.0 | 732864    | 12-Jul-16 | 08:00 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2149.0 | 584384    | 12-Jul-16 | 08:00 | x86      |
| Xmsrv.dll                                                 | 2015.130.2149.0 | 32693440  | 12-Jul-16 | 08:00 | x86      |
| Xmsrv.dll                                                 | 2015.130.2149.0 | 24012992  | 12-Jul-16 | 08:00 | x64      |

SQL Server 2016 R Services

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.2149.0     | 23744     | 12-Jul-16 | 08:00 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |

SQL Server 2016 Tools and Workstation Components Extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2149.0 | 2631872   | 12-Jul-16 | 08:00 | x86      |
| Dts.dll                                                      | 2015.130.2149.0 | 3145408   | 12-Jul-16 | 08:01 | x64      |
| Dtspipeline.dll                                              | 2015.130.2149.0 | 1059520   | 12-Jul-16 | 08:00 | x86      |
| Dtspipeline.dll                                              | 2015.130.2149.0 | 1278152   | 12-Jul-16 | 08:01 | x64      |
| Dtswizard.exe                                                | 13.0.2149.0     | 895680    | 12-Jul-16 | 08:00 | x86      |
| Dtswizard.exe                                                | 13.0.2149.0     | 895168    | 12-Jul-16 | 08:01 | x64      |
| Microsoft.analysisservices.project.dll                       | 2015.130.2149.0 | 2023104   | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2149.0     | 432840    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2149.0     | 432832    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2149.0     | 2043584   | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2149.0     | 2043592   | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2149.0     | 250048    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2149.0     | 250056    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2149.0     | 33984     | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2149.0     | 33992     | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2149.0     | 606400    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2149.0     | 606400    | 12-Jul-16 | 08:01 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2149.0     | 445120    | 12-Jul-16 | 08:00 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2149.0     | 445120    | 12-Jul-16 | 08:01 | x86      |
| Msmdlocal.dll                                                | 2015.130.2149.0 | 36954824  | 12-Jul-16 | 08:00 | x86      |
| Msmdlocal.dll                                                | 2015.130.2149.0 | 55971016  | 12-Jul-16 | 08:02 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2149.0 | 7502528   | 12-Jul-16 | 08:00 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2149.0 | 6497984   | 12-Jul-16 | 08:01 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2149.0 | 100544    | 12-Jul-16 | 08:01 | x64      |
| Xmsrv.dll                                                    | 2015.130.2149.0 | 32693440  | 12-Jul-16 | 08:00 | x86      |
| Xmsrv.dll                                                    | 2015.130.2149.0 | 24012992  | 12-Jul-16 | 08:00 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
