---
title: Cumulative update 8 for SQL Server 2016 (KB4040713)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 8 (KB4040713).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4040713
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2016 Express
- SQL Server 2016 Business Intelligence
---

# KB4040713 - Cumulative Update 8 for SQL Server 2016

_Release Date:_ &nbsp; September 18, 2017  
_Version:_ &nbsp; 13.0.2213.0

This article describes cumulative update package 8 (build number: 13.0.2213.0) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area|
|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=10729319>[10729319](#10729319) </a> | FIX: Reporting Services "SortExpression" cause rsComparisonError when there's a NULL value in a column set as "DataTimeOffset" (KB4017827) | Reporting Services|
| <a id=10817781>[10817781](#10817781) </a> | [FIX: Indirect checkpoints on the tempdb database cause "Non-yielding scheduler" error in SQL Server 2016 (KB4040276)](https://support.microsoft.com/help/4040276)| SQL Engine|
| <a id=10682296>[10682296](#10682296) </a> | [FIX: Excel crashes when you save a workbook as a PDF file by using the Adobe Acrobat PDFMaker add-in if the MDS add-in for Excel in SQL Server 2014 or 2016 is also installed (KB4022895)](https://support.microsoft.com/help/4022895) | Data Quality Services (DQS) |
| <a id=10682302>[10682302](#10682302) </a> | [FIX: Unable to drop stored procedure execution article from P2P publication in SQL Server 2014 or 2016 (KB4023926)](https://support.microsoft.com/help/4023926)| SQL Engine|
| <a id=10682256>[10682256](#10682256) </a> | FIX: DBCC CHECKFILEGROUP reports false inconsistency error 5283 on a database that contains a partitioned table in SQL Server (KB3108537) | SQL Engine|
| <a id=10682300>[10682300](#10682300) </a> | [FIX: "Non-yielding Scheduler" condition occurs on spinlock contention in Microsoft SQL Server 2014 or 2016 (KB4024311)](https://support.microsoft.com/help/4024311)| SQL Engine|
| <a id=10716344>[10716344](#10716344) </a> | [FIX: Access violation occurs when a DDL trigger is raised by the CREATE EXTERNAL TABLE command in SQL Server 2016 (KB4039966)](https://support.microsoft.com/help/4039966) | SQL Engine|
| <a id=10729323>[10729323](#10729323) </a> | [FIX: Fails to resume a suspended availability database after a write error in SQL Server 2014 or 2016 (KB4022935)](https://support.microsoft.com/help/4022935) | High Availability |
| <a id=10679744>[10679744](#10679744) </a> | [FIX: Returns incorrect results when computed column is queried after installing hotfix that's described in KB3213683 and enabling TF 176 in SQL Server 2016 (KB4040533)](https://support.microsoft.com/help/4040533)| SQL Engine|
| <a id=10682282>[10682282](#10682282) </a> | [FIX: Unhandled exception when you export a SSRS report to a .pdf file if the page height is set to 8.5 inches in SQL Server 2014 or 2016 (KB4024563)](https://support.microsoft.com/help/4024563)| Reporting Services|
| <a id=10682251>[10682251](#10682251) </a> | [FIX: Access violation with query to retrieve data from a clustered columnstore index in SQL Server 2014 or 2016 (KB4024184)](https://support.microsoft.com/help/4024184) | SQL Engine|
| <a id=10479291>[10479291](#10479291) </a> | [FIX: An unexpected exception error occurs when a XIRR measure processes too many records in SSAS 2016 (KB4034789)](https://support.microsoft.com/help/4034789) | Analysis Services |
| <a id=10682270>[10682270](#10682270) </a> | [FIX: SSAS 2014 or 2016 crashes when you execute an MDX query that refers to a calculated member that is a child member of another hierarchy (KB4022753)](https://support.microsoft.com/help/4022753)| Analysis Services |
| <a id=10682266>[10682266](#10682266) </a> | [FIX: Timeout when you back up a large database to URL in SQL Server 2014 or 2016 (KB4023679)](https://support.microsoft.com/help/4023679)| SQL Engine|
| <a id=10682259>[10682259](#10682259) </a> | [FIX: Error 574 when you try to install Service Pack 2 for SQL Server 2014 (KB4023170)](https://support.microsoft.com/help/4023170) | Management Tools|
| <a id=10682322>[10682322](#10682322) </a> | [FIX: Can't disable "change data capture" if any column is encrypted by "Always Encrypted" feature in SQL Server (KB4034376)](https://support.microsoft.com/help/4034376) | SQL Engine|
| <a id=10271367>[10271367](#10271367) </a> | [Update to improve the performance for columnstore dynamic management views "column_store_row_groups" and "dm_db_column_store_row_group_physical_stats" in SQL Server 2016 (KB4024860)](https://support.microsoft.com/help/4024860) | SQL Performance |
| <a id=10988058>[10988058](#10988058) </a> | [FIX: CDC components in SSIS do not function in SQL Server after a cumulative update is applied (KB4053693)](https://support.microsoft.com/help/4053693)| Integration Services|
| <a id=10988062>[10988062](#10988062) </a> | FIX: Change Data Capture functionality doesn't work in SQL Server (KB4038932)| Change Data Capture |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for Microsoft SQL Server 2016 now](https://www.microsoft.com/download/details.aspx?id=53338)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 is available at the Download Center.

- Each new CU contains all the fixes that were included with the previous CU for the installed version/Service Pack of SQL Server.

- Microsoft recommends ongoing, proactive installation of CUs as they become available:

  - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.

  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.

  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.

- Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.

- We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

</details>

<details>
<summary><b>Hybrid environments deployment</b></summary>

When you deploy the hotfixes to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the hotfixes:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

  > [!NOTE]
  > If you don't want to use the rolling update process, follow these steps to apply a CU or SP: </br></br>1. Install the service pack on the passive node. </br></br>2. Install the service pack on the active node (requires a service restart).

- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On with SSISDB catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for more information about how to apply a CU or SP in these environments.

- [Apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)

- [Apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)

- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)

- [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

</details>

<details>
<summary><b>Language support</b></summary>

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available for specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that do not qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

   > [!NOTE]
   > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

2. Locate the entry that corresponds to this cumulative update package.

3. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016.

</details>

<details>
<summary><b>Restart information</b></summary>

You may have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

## File information

<details>
<summary><b>Cumulative update package file information</b></summary>

This cumulative update package may not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Browser Service

| File   name            | File version    | File size | Date     | Time | Platform |
|------------------------|-----------------|-----------|----------|------|----------|
| Msmdsrv.rll            | 2015.130.2213.0 | 1295040   | 06-Sep-2017 | 02:08 | x86      |
| Msmdsrvi.rll           | 2015.130.2213.0 | 1291976   | 06-Sep-2017 | 02:08 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.2213.0 | 88768     | 06-Sep-2017 | 02:08 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date     | Time | Platform |
|--------------------------------------------|-----------------|-----------|----------|------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2213.0     | 1023176   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2213.0     | 1344200   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2213.0     | 702664    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2213.0     | 765640    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2213.0     | 707264    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2213.0     | 37064     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2213.0     | 46280     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2213.0 | 72904     | 06-Sep-2017 | 02:09 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2213.0 | 60096     | 06-Sep-2017 | 02:08 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2213.0 | 88768     | 06-Sep-2017 | 02:08 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2213.0 | 364232    | 06-Sep-2017 | 02:08 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2213.0 | 267464    | 06-Sep-2017 | 02:09 | x86      |
| Sqltdiagn.dll                              | 2015.130.2213.0 | 60616     | 06-Sep-2017 | 02:09 | x86      |
| Svrenumapi130.dll                          | 2015.130.2213.0 | 854208    | 06-Sep-2017 | 02:09 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date     | Time | Platform |
|-------------------------------|--------------|-----------|----------|------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2213.0  | 473280    | 06-Sep-2017 | 02:11 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2213.0  | 1876680   | 06-Sep-2017 | 02:11 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date     | Time | Platform |
|--------------------------------------------------------------|-----------------|-----------|----------|------|----------|
| Autoadmin.dll                                                | 2015.130.2213.0 | 1311432   | 06-Sep-2017 | 02:08 | x86      |
| Dtaengine.exe                                                | 2015.130.2213.0 | 167112    | 06-Sep-2017 | 02:08 | x86      |
| Dteparse.dll                                                 | 2015.130.2213.0 | 99016     | 06-Sep-2017 | 02:08 | x86      |
| Dtepkg.dll                                                   | 2015.130.2213.0 | 115912    | 06-Sep-2017 | 02:08 | x86      |
| Dts.dll                                                      | 2015.130.2213.0 | 2631872   | 06-Sep-2017 | 02:08 | x86      |
| Dtsconn.dll                                                  | 2015.130.2213.0 | 391872    | 06-Sep-2017 | 02:08 | x86      |
| Dtslog.dll                                                   | 2015.130.2213.0 | 103112    | 06-Sep-2017 | 02:08 | x86      |
| Dtspipeline.dll                                              | 2015.130.2213.0 | 1059520   | 06-Sep-2017 | 02:08 | x86      |
| Dtswizard.exe                                                | 13.0.2213.0     | 895688    | 06-Sep-2017 | 02:08 | x86      |
| Dtuparse.dll                                                 | 2015.130.2213.0 | 80072     | 06-Sep-2017 | 02:08 | x86      |
| Exceldest.dll                                                | 2015.130.2213.0 | 216264    | 06-Sep-2017 | 02:08 | x86      |
| Excelsrc.dll                                                 | 2015.130.2213.0 | 232648    | 06-Sep-2017 | 02:08 | x86      |
| Flatfiledest.dll                                             | 2015.130.2213.0 | 334528    | 06-Sep-2017 | 02:08 | x86      |
| Flatfilesrc.dll                                              | 2015.130.2213.0 | 345288    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.applocal.core.dll                 | 13.0.2213.0     | 1308864   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.applocal.dll                      | 13.0.2213.0     | 696520    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll              | 13.0.2213.0     | 763584    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.project.dll                       | 2015.130.2213.0 | 2023112   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2213.0     | 432840    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2213.0     | 2044104   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2213.0     | 33480     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2213.0     | 250048    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2213.0     | 33984     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2213.0     | 606400    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2213.0     | 445128    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2213.0 | 138952    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2213.0 | 144576    | 06-Sep-2017 | 02:09 | x86      |
| Msmdlocal.dll                                                | 2015.130.2213.0 | 37020360  | 06-Sep-2017 | 02:08 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2213.0 | 6501576   | 06-Sep-2017 | 02:11 | x86      |
| Msolap130.dll                                                | 2015.130.2213.0 | 6968000   | 06-Sep-2017 | 02:08 | x86      |
| Oledbdest.dll                                                | 2015.130.2213.0 | 216776    | 06-Sep-2017 | 02:08 | x86      |
| Oledbsrc.dll                                                 | 2015.130.2213.0 | 235712    | 06-Sep-2017 | 02:08 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2213.0 | 88768     | 06-Sep-2017 | 02:08 | x86      |
| Txdataconvert.dll                                            | 2015.130.2213.0 | 255176    | 06-Sep-2017 | 02:10 | x86      |
| Xe.dll                                                       | 2015.130.2213.0 | 558784    | 06-Sep-2017 | 02:08 | x86      |
| Xmsrv.dll                                                    | 2015.130.2213.0 | 32696008  | 06-Sep-2017 | 02:10 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name  | File version    | File size | Date     | Time | Platform |
|--------------|-----------------|-----------|----------|------|----------|
| Keyfile.dll  | 2015.130.2213.0 | 88768     | 06-Sep-2017 | 02:08 | x86      |
| Msmdsrv.rll  | 2015.130.2213.0 | 1295040   | 06-Sep-2017 | 02:08 | x86      |
| Msmdsrvi.rll | 2015.130.2213.0 | 1291976   | 06-Sep-2017 | 02:08 | x86      |

SQL Server 2016 Business Intelligence Development Studio

| File   name        | File version    | File size | Date     | Time | Platform |
|--------------------|-----------------|-----------|----------|------|----------|
| Sqlsqm_keyfile.dll | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date     | Time | Platform |
|-----------------------|-----------------|-----------|----------|------|----------|
| Sqlboot.dll           | 2015.130.2213.0 | 186560    | 06-Sep-2017 | 02:10 | x64      |
| Sqlvdi.dll            | 2015.130.2213.0 | 197320    | 06-Sep-2017 | 02:08 | x64      |
| Sqlvdi.dll            | 2015.130.2213.0 | 168640    | 06-Sep-2017 | 02:09 | x86      |
| Sqlwriter_keyfile.dll | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |
| Sqlwvss.dll           | 2015.130.2213.0 | 336072    | 06-Sep-2017 | 02:06 | x64      |

SQL Server 2016 Analysis Services

| File   name                                   | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll    | 13.0.2213.0     | 1343680   | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2213.0     | 765640    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 16-Jun-2016 | 14:21 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 17-Jun-2016 | 17:30 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 16-Jun-2016 | 14:21 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 17-Jun-2016 | 17:30 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 16-Jun-2016 | 14:21 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 17-Jun-2016 | 17:30 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 17-Jun-2016 | 17:30 | x86      |
| Microsoft.powerbi.adomdclient.dll             | 13.0.2213.0     | 985288    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.powerbi.adomdclient.dll             | 13.0.2213.0     | 985288    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 16-Jun-2016 | 14:21 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 17-Jun-2016 | 17:30 | x86      |
| Msmdlocal.dll                                 | 2015.130.2213.0 | 37020360  | 06-Sep-2017  | 02:08  | x86      |
| Msmdlocal.dll                                 | 2015.130.2213.0 | 56109768  | 06-Sep-2017  | 02:10  | x64      |
| Msmdsrv.exe                                   | 2015.130.2213.0 | 56656584  | 06-Sep-2017  | 02:08  | x64      |
| Msmgdsrv.dll                                  | 2015.130.2213.0 | 7499976   | 06-Sep-2017  | 02:09  | x64      |
| Msmgdsrv.dll                                  | 2015.130.2213.0 | 6501576   | 06-Sep-2017  | 02:11  | x86      |
| Msolap130.dll                                 | 2015.130.2213.0 | 6968000   | 06-Sep-2017  | 02:08  | x86      |
| Msolap130.dll                                 | 2015.130.2213.0 | 8590016   | 06-Sep-2017  | 02:10  | x64      |
| Sql_as_keyfile.dll                            | 2015.130.2213.0 | 100544    | 06-Sep-2017  | 02:10  | x64      |
| Sqlboot.dll                                   | 2015.130.2213.0 | 186560    | 06-Sep-2017  | 02:10  | x64      |
| Sqlceip.exe                                   | 13.0.2213.0     | 249024    | 06-Sep-2017  | 02:09  | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 16-Jun-2016 | 14:21 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 17-Jun-2016 | 17:30 | x86      |
| Tmapi.dll                                     | 2015.130.2213.0 | 4344520   | 06-Sep-2017  | 02:06  | x64      |
| Tmcachemgr.dll                                | 2015.130.2213.0 | 2825416   | 06-Sep-2017  | 02:06  | x64      |
| Tmpersistence.dll                             | 2015.130.2213.0 | 1069760   | 06-Sep-2017  | 02:06  | x64      |
| Tmtransactions.dll                            | 2015.130.2213.0 | 1349832   | 06-Sep-2017  | 02:06  | x64      |
| Xe.dll                                        | 2015.130.2213.0 | 626376    | 06-Sep-2017  | 02:08  | x64      |
| Xmsrv.dll                                     | 2015.130.2213.0 | 24015552  | 06-Sep-2017  | 02:06  | x64      |
| Xmsrv.dll                                     | 2015.130.2213.0 | 32696008  | 06-Sep-2017  | 02:10  | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date     | Time | Platform |
|--------------------------------------------|-----------------|-----------|----------|------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2213.0     | 1023176   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2213.0     | 1023168   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2213.0     | 1344200   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2213.0     | 702664    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2213.0     | 765640    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2213.0     | 707264    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2213.0     | 707264    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2213.0     | 37064     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2213.0     | 46280     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2213.0 | 75456     | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2213.0 | 72904     | 06-Sep-2017 | 02:09 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2213.0 | 60096     | 06-Sep-2017 | 02:08 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2213.0 | 72896     | 06-Sep-2017 | 02:10 | x64      |
| Sql_common_core_keyfile.dll                | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2213.0 | 404168    | 06-Sep-2017 | 02:06 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2213.0 | 364232    | 06-Sep-2017 | 02:08 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2213.0 | 348872    | 06-Sep-2017 | 02:06 | x64      |
| Sqlsvcsync.dll                             | 2015.130.2213.0 | 267464    | 06-Sep-2017 | 02:09 | x86      |
| Sqltdiagn.dll                              | 2015.130.2213.0 | 67784     | 06-Sep-2017 | 02:06 | x64      |
| Sqltdiagn.dll                              | 2015.130.2213.0 | 60616     | 06-Sep-2017 | 02:09 | x86      |
| Svrenumapi130.dll                          | 2015.130.2213.0 | 1115840   | 06-Sep-2017 | 02:06 | x64      |
| Svrenumapi130.dll                          | 2015.130.2213.0 | 854208    | 06-Sep-2017 | 02:09 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date     | Time | Platform |
|-------------------------------|--------------|-----------|----------|------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2213.0  | 473288    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2213.0  | 473280    | 06-Sep-2017 | 02:11 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2213.0  | 1876680   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2213.0  | 1876680   | 06-Sep-2017 | 02:11 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date     | Time | Platform |
|----------------------------------------------|-----------------|-----------|----------|------|----------|
| Backuptourl.exe                              | 13.0.2213.0     | 41160     | 06-Sep-2017 | 02:08 | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 9-Dec-16 | 1:46 | x64      |
| Datacollectorcontroller.dll                  | 2015.130.2213.0 | 224960    | 06-Sep-2017 | 02:10 | x64      |
| Dcexec.exe                                   | 2015.130.2213.0 | 74440     | 06-Sep-2017 | 02:08 | x64      |
| Fssres.dll                                   | 2015.130.2213.0 | 81608     | 06-Sep-2017 | 02:10 | x64      |
| Hadrres.dll                                  | 2015.130.2213.0 | 177864    | 06-Sep-2017 | 02:08 | x64      |
| Hkcompile.dll                                | 2015.130.2213.0 | 1297088   | 06-Sep-2017 | 02:08 | x64      |
| Hkengine.dll                                 | 2015.130.2213.0 | 5600456   | 06-Sep-2017 | 02:10 | x64      |
| Hkruntime.dll                                | 2015.130.2213.0 | 158920    | 06-Sep-2017 | 02:10 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.2213.0     | 231624    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.2213.0 | 391880    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.2213.0 | 71368     | 06-Sep-2017 | 02:09 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.2213.0 | 65224     | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.2213.0 | 150208    | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.2213.0 | 158920    | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.2213.0 | 272072    | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.2213.0 | 74944     | 06-Sep-2017 | 02:08 | x64      |
| Msvcp120.dll                                 | 12.0.40649.5    | 660128    | 06-Jul-2017 | 04:20 | x64      |
| Msvcr120.dll                                 | 12.0.40649.5    | 963744    | 06-Jul-2017 | 04:20 | x64      |
| Qds.dll                                      | 2015.130.2213.0 | 845000    | 06-Sep-2017 | 02:10 | x64      |
| Rsfxft.dll                                   | 2015.130.2213.0 | 34504     | 06-Sep-2017 | 02:08 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |
| Sqlaccess.dll                                | 2015.130.2213.0 | 462536    | 06-Sep-2017 | 02:08 | x64      |
| Sqlagent.exe                                 | 2015.130.2213.0 | 565952    | 06-Sep-2017 | 02:08 | x64      |
| Sqlboot.dll                                  | 2015.130.2213.0 | 186560    | 06-Sep-2017 | 02:10 | x64      |
| Sqlceip.exe                                  | 13.0.2213.0     | 249024    | 06-Sep-2017 | 02:09 | x86      |
| Sqldk.dll                                    | 2015.130.2213.0 | 2585280   | 06-Sep-2017 | 02:10 | x64      |
| Sqllang.dll                                  | 2015.130.2213.0 | 39337160  | 06-Sep-2017 | 02:10 | x64      |
| Sqlmin.dll                                   | 2015.130.2213.0 | 37366984  | 06-Sep-2017 | 02:06 | x64      |
| Sqlos.dll                                    | 2015.130.2213.0 | 26312     | 06-Sep-2017 | 02:08 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.2213.0 | 27848     | 06-Sep-2017 | 02:06 | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.2213.0 | 5797568   | 06-Sep-2017 | 02:08 | x64      |
| Sqlserverspatial130.dll                      | 2015.130.2213.0 | 732864    | 06-Sep-2017 | 02:08 | x64      |
| Sqlservr.exe                                 | 2015.130.2213.0 | 393416    | 06-Sep-2017 | 02:08 | x64      |
| Sqltses.dll                                  | 2015.130.2213.0 | 8896712   | 06-Sep-2017 | 02:06 | x64      |
| Sqsrvres.dll                                 | 2015.130.2213.0 | 251072    | 06-Sep-2017 | 02:06 | x64      |
| Stretchcodegen.exe                           | 13.0.2213.0     | 55496     | 06-Sep-2017 | 02:09 | x86      |
| Xe.dll                                       | 2015.130.2213.0 | 626376    | 06-Sep-2017 | 02:08 | x64      |
| Xpstar.dll                                   | 2015.130.2213.0 | 422088    | 06-Sep-2017 | 02:08 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Bcp.exe                                                      | 2015.130.2213.0 | 120008    | 06-Sep-2017  | 02:10  | x64      |
| Commanddest.dll                                              | 2015.130.2213.0 | 249032    | 06-Sep-2017  | 02:10  | x64      |
| Datacollectortasks.dll                                       | 2015.130.2213.0 | 188104    | 06-Sep-2017  | 02:10  | x64      |
| Dteparse.dll                                                 | 2015.130.2213.0 | 109768    | 06-Sep-2017  | 02:10  | x64      |
| Dtepkg.dll                                                   | 2015.130.2213.0 | 137416    | 06-Sep-2017  | 02:10  | x64      |
| Dts.dll                                                      | 2015.130.2213.0 | 3145416   | 06-Sep-2017  | 02:10  | x64      |
| Dtsconn.dll                                                  | 2015.130.2213.0 | 492232    | 06-Sep-2017  | 02:10  | x64      |
| Dtslog.dll                                                   | 2015.130.2213.0 | 120520    | 06-Sep-2017  | 02:10  | x64      |
| Dtspipeline.dll                                              | 2015.130.2213.0 | 1278152   | 06-Sep-2017  | 02:10  | x64      |
| Dtswizard.exe                                                | 13.0.2213.0     | 895176    | 06-Sep-2017  | 02:09  | x64      |
| Dtuparse.dll                                                 | 2015.130.2213.0 | 87752     | 06-Sep-2017  | 02:10  | x64      |
| Exceldest.dll                                                | 2015.130.2213.0 | 263368    | 06-Sep-2017  | 02:10  | x64      |
| Excelsrc.dll                                                 | 2015.130.2213.0 | 285384    | 06-Sep-2017  | 02:10  | x64      |
| Execpackagetask.dll                                          | 2015.130.2213.0 | 166080    | 06-Sep-2017  | 02:10  | x64      |
| Flatfiledest.dll                                             | 2015.130.2213.0 | 389320    | 06-Sep-2017  | 02:10  | x64      |
| Flatfilesrc.dll                                              | 2015.130.2213.0 | 401608    | 06-Sep-2017  | 02:10  | x64      |
| Logread.exe                                                  | 2015.130.2213.0 | 616648    | 06-Sep-2017  | 02:08  | x64      |
| Microsoft.analysisservices.applocal.core.dll                 | 13.0.2213.0     | 1308864   | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.analysisservices.applocal.dll                      | 13.0.2213.0     | 696520    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll              | 13.0.2213.0     | 763592    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2213.0     | 33984     | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2213.0     | 606408    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                 | 13.0.2213.0     | 215232    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll             | 13.0.16107.4    | 30912     | 20-Mar-2017  | 23:54  | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2213.0     | 445128    | 06-Sep-2017  | 02:09  | x86      |
| Microsoft.sqlserver.replication.dll                          | 2015.130.2213.0 | 1638088   | 06-Sep-2017  | 02:09  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2213.0 | 150208    | 06-Sep-2017  | 02:08  | x64      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2213.0 | 158920    | 06-Sep-2017  | 02:08  | x64      |
| Oledbdest.dll                                                | 2015.130.2213.0 | 264392    | 06-Sep-2017  | 02:10  | x64      |
| Oledbsrc.dll                                                 | 2015.130.2213.0 | 291016    | 06-Sep-2017  | 02:10  | x64      |
| Rawdest.dll                                                  | 2015.130.2213.0 | 209600    | 06-Sep-2017  | 02:10  | x64      |
| Rawsource.dll                                                | 2015.130.2213.0 | 196808    | 06-Sep-2017  | 02:10  | x64      |
| Recordsetdest.dll                                            | 2015.130.2213.0 | 187080    | 06-Sep-2017  | 02:10  | x64      |
| Repldp.dll                                                   | 2015.130.2213.0 | 276168    | 06-Sep-2017  | 02:10  | x64      |
| Spresolv.dll                                                 | 2015.130.2213.0 | 244936    | 06-Sep-2017  | 02:10  | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2213.0 | 100544    | 06-Sep-2017  | 02:10  | x64      |
| Sqlmergx.dll                                                 | 2015.130.2213.0 | 346824    | 06-Sep-2017  | 02:06  | x64      |
| Sqlwep130.dll                                                | 2015.130.2213.0 | 105672    | 06-Sep-2017  | 02:06  | x64      |
| Ssradd.dll                                                   | 2015.130.2213.0 | 65216     | 06-Sep-2017  | 02:06  | x64      |
| Ssravg.dll                                                   | 2015.130.2213.0 | 65224     | 06-Sep-2017  | 02:06  | x64      |
| Ssrdown.dll                                                  | 2015.130.2213.0 | 50888     | 06-Sep-2017  | 02:06  | x64      |
| Ssrmax.dll                                                   | 2015.130.2213.0 | 63176     | 06-Sep-2017  | 02:06  | x64      |
| Ssrmin.dll                                                   | 2015.130.2213.0 | 63680     | 06-Sep-2017  | 02:06  | x64      |
| Ssrpub.dll                                                   | 2015.130.2213.0 | 51392     | 06-Sep-2017  | 02:06  | x64      |
| Ssrup.dll                                                    | 2015.130.2213.0 | 50880     | 06-Sep-2017  | 02:06  | x64      |
| Txagg.dll                                                    | 2015.130.2213.0 | 364744    | 06-Sep-2017  | 02:06  | x64      |
| Txbdd.dll                                                    | 2015.130.2213.0 | 172744    | 06-Sep-2017  | 02:06  | x64      |
| Txdatacollector.dll                                          | 2015.130.2213.0 | 367296    | 06-Sep-2017  | 02:06  | x64      |
| Txdataconvert.dll                                            | 2015.130.2213.0 | 296648    | 06-Sep-2017  | 02:06  | x64      |
| Txderived.dll                                                | 2015.130.2213.0 | 607944    | 06-Sep-2017  | 02:06  | x64      |
| Txlookup.dll                                                 | 2015.130.2213.0 | 532168    | 06-Sep-2017  | 02:06  | x64      |
| Txmergejoin.dll                                              | 2015.130.2213.0 | 278728    | 06-Sep-2017  | 02:06  | x64      |
| Txsort.dll                                                   | 2015.130.2213.0 | 259272    | 06-Sep-2017  | 02:06  | x64      |
| Txsplit.dll                                                  | 2015.130.2213.0 | 600768    | 06-Sep-2017  | 02:06  | x64      |
| Xe.dll                                                       | 2015.130.2213.0 | 626376    | 06-Sep-2017  | 02:08  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date     | Time | Platform |
|-------------------------------|-----------------|-----------|----------|------|----------|
| Launchpad.exe                 | 2015.130.2213.0 | 1011904   | 06-Sep-2017 | 02:10 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |
| Sqlsatellite.dll              | 2015.130.2213.0 | 836800    | 06-Sep-2017 | 02:08 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.2213.0 | 660168    | 06-Sep-2017  | 02:08  | x64      |
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 16-Jun-2016 | 14:21 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 16-Jun-2016 | 14:21 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 16-Jun-2016 | 14:21 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 16-Jun-2016 | 14:21 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2213.0 | 100544    | 06-Sep-2017  | 02:10  | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date     | Time | Platform |
|-------------------------|-----------------|-----------|----------|------|----------|
| Imrdll.dll              | 13.0.2213.0     | 23752     | 06-Sep-2017 | 02:09 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.89        | 77936     | 25-Aug-2017 | 03:09 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.89        | 77936     | 25-Aug-2017 | 03:09 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.89        | 37488     | 25-Aug-2017 | 03:09 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.89        | 37488     | 25-Aug-2017 | 03:09 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.89        | 78448     | 25-Aug-2017 | 03:09 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.89        | 78448     | 25-Aug-2017 | 03:09 | x86      |
| Commanddest.dll                                               | 2015.130.2213.0 | 202944    | 06-Sep-2017  | 02:08 | x86      |
| Commanddest.dll                                               | 2015.130.2213.0 | 249032    | 06-Sep-2017  | 02:10 | x64      |
| Dteparse.dll                                                  | 2015.130.2213.0 | 99016     | 06-Sep-2017  | 02:08 | x86      |
| Dteparse.dll                                                  | 2015.130.2213.0 | 109768    | 06-Sep-2017  | 02:10 | x64      |
| Dtepkg.dll                                                    | 2015.130.2213.0 | 115912    | 06-Sep-2017  | 02:08 | x86      |
| Dtepkg.dll                                                    | 2015.130.2213.0 | 137416    | 06-Sep-2017  | 02:10 | x64      |
| Dts.dll                                                       | 2015.130.2213.0 | 2631872   | 06-Sep-2017  | 02:08 | x86      |
| Dts.dll                                                       | 2015.130.2213.0 | 3145416   | 06-Sep-2017  | 02:10 | x64      |
| Dtsconn.dll                                                   | 2015.130.2213.0 | 391872    | 06-Sep-2017  | 02:08 | x86      |
| Dtsconn.dll                                                   | 2015.130.2213.0 | 492232    | 06-Sep-2017  | 02:10 | x64      |
| Dtslog.dll                                                    | 2015.130.2213.0 | 103112    | 06-Sep-2017  | 02:08 | x86      |
| Dtslog.dll                                                    | 2015.130.2213.0 | 120520    | 06-Sep-2017  | 02:10 | x64      |
| Dtspipeline.dll                                               | 2015.130.2213.0 | 1059520   | 06-Sep-2017  | 02:08 | x86      |
| Dtspipeline.dll                                               | 2015.130.2213.0 | 1278152   | 06-Sep-2017  | 02:10 | x64      |
| Dtswizard.exe                                                 | 13.0.2213.0     | 895688    | 06-Sep-2017  | 02:08 | x86      |
| Dtswizard.exe                                                 | 13.0.2213.0     | 895176    | 06-Sep-2017  | 02:09 | x64      |
| Dtuparse.dll                                                  | 2015.130.2213.0 | 80072     | 06-Sep-2017  | 02:08 | x86      |
| Dtuparse.dll                                                  | 2015.130.2213.0 | 87752     | 06-Sep-2017  | 02:10 | x64      |
| Exceldest.dll                                                 | 2015.130.2213.0 | 216264    | 06-Sep-2017  | 02:08 | x86      |
| Exceldest.dll                                                 | 2015.130.2213.0 | 263368    | 06-Sep-2017  | 02:10 | x64      |
| Excelsrc.dll                                                  | 2015.130.2213.0 | 232648    | 06-Sep-2017  | 02:08 | x86      |
| Excelsrc.dll                                                  | 2015.130.2213.0 | 285384    | 06-Sep-2017  | 02:10 | x64      |
| Execpackagetask.dll                                           | 2015.130.2213.0 | 135368    | 06-Sep-2017  | 02:08 | x86      |
| Execpackagetask.dll                                           | 2015.130.2213.0 | 166080    | 06-Sep-2017  | 02:10 | x64      |
| Flatfiledest.dll                                              | 2015.130.2213.0 | 334528    | 06-Sep-2017  | 02:08 | x86      |
| Flatfiledest.dll                                              | 2015.130.2213.0 | 389320    | 06-Sep-2017  | 02:10 | x64      |
| Flatfilesrc.dll                                               | 2015.130.2213.0 | 345288    | 06-Sep-2017  | 02:08 | x86      |
| Flatfilesrc.dll                                               | 2015.130.2213.0 | 401608    | 06-Sep-2017  | 02:10 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.2213.0     | 1308864   | 06-Sep-2017  | 02:08 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.2213.0     | 1308864   | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.analysisservices.applocal.dll                       | 13.0.2213.0     | 696520    | 06-Sep-2017  | 02:08 | x86      |
| Microsoft.analysisservices.applocal.dll                       | 13.0.2213.0     | 696520    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll               | 13.0.2213.0     | 763584    | 06-Sep-2017  | 02:08 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll               | 13.0.2213.0     | 763592    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2213.0     | 469704    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2213.0     | 469704    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2213.0     | 33984     | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2213.0     | 33984     | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2213.0     | 606408    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2213.0     | 606400    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2213.0     | 445128    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2213.0     | 445128    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.130.2213.0 | 150208    | 06-Sep-2017  | 02:08 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.130.2213.0 | 138952    | 06-Sep-2017  | 02:09 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2015.130.2213.0 | 158920    | 06-Sep-2017  | 02:08 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2015.130.2213.0 | 144576    | 06-Sep-2017  | 02:09 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2213.0     | 216768    | 06-Sep-2017  | 02:09 | x64      |
| Oledbdest.dll                                                 | 2015.130.2213.0 | 216776    | 06-Sep-2017  | 02:08 | x86      |
| Oledbdest.dll                                                 | 2015.130.2213.0 | 264392    | 06-Sep-2017  | 02:10 | x64      |
| Oledbsrc.dll                                                  | 2015.130.2213.0 | 235712    | 06-Sep-2017  | 02:08 | x86      |
| Oledbsrc.dll                                                  | 2015.130.2213.0 | 291016    | 06-Sep-2017  | 02:10 | x64      |
| Rawdest.dll                                                   | 2015.130.2213.0 | 168136    | 06-Sep-2017  | 02:08 | x86      |
| Rawdest.dll                                                   | 2015.130.2213.0 | 209600    | 06-Sep-2017  | 02:10 | x64      |
| Rawsource.dll                                                 | 2015.130.2213.0 | 155336    | 06-Sep-2017  | 02:08 | x86      |
| Rawsource.dll                                                 | 2015.130.2213.0 | 196808    | 06-Sep-2017  | 02:10 | x64      |
| Recordsetdest.dll                                             | 2015.130.2213.0 | 151744    | 06-Sep-2017  | 02:08 | x86      |
| Recordsetdest.dll                                             | 2015.130.2213.0 | 187080    | 06-Sep-2017  | 02:10 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2213.0 | 100544    | 06-Sep-2017  | 02:10 | x64      |
| Sqlceip.exe                                                   | 13.0.2213.0     | 249024    | 06-Sep-2017  | 02:09 | x86      |
| Sqldest.dll                                                   | 2015.130.2213.0 | 215232    | 06-Sep-2017  | 02:08 | x86      |
| Sqldest.dll                                                   | 2015.130.2213.0 | 263880    | 06-Sep-2017  | 02:10 | x64      |
| Txagg.dll                                                     | 2015.130.2213.0 | 364744    | 06-Sep-2017  | 02:06 | x64      |
| Txagg.dll                                                     | 2015.130.2213.0 | 304832    | 06-Sep-2017  | 02:10 | x86      |
| Txbdd.dll                                                     | 2015.130.2213.0 | 172744    | 06-Sep-2017  | 02:06 | x64      |
| Txbdd.dll                                                     | 2015.130.2213.0 | 137928    | 06-Sep-2017  | 02:10 | x86      |
| Txcache.dll                                                   | 2015.130.2213.0 | 182984    | 06-Sep-2017  | 02:06 | x64      |
| Txcache.dll                                                   | 2015.130.2213.0 | 148160    | 06-Sep-2017  | 02:10 | x86      |
| Txcharmap.dll                                                 | 2015.130.2213.0 | 289984    | 06-Sep-2017  | 02:06 | x64      |
| Txcharmap.dll                                                 | 2015.130.2213.0 | 250568    | 06-Sep-2017  | 02:10 | x86      |
| Txcopymap.dll                                                 | 2015.130.2213.0 | 182984    | 06-Sep-2017  | 02:06 | x64      |
| Txcopymap.dll                                                 | 2015.130.2213.0 | 147656    | 06-Sep-2017  | 02:10 | x86      |
| Txdataconvert.dll                                             | 2015.130.2213.0 | 296648    | 06-Sep-2017  | 02:06 | x64      |
| Txdataconvert.dll                                             | 2015.130.2213.0 | 255176    | 06-Sep-2017  | 02:10 | x86      |
| Txderived.dll                                                 | 2015.130.2213.0 | 607944    | 06-Sep-2017  | 02:06 | x64      |
| Txderived.dll                                                 | 2015.130.2213.0 | 518856    | 06-Sep-2017  | 02:10 | x86      |
| Txfileextractor.dll                                           | 2015.130.2213.0 | 201408    | 06-Sep-2017  | 02:06 | x64      |
| Txfileextractor.dll                                           | 2015.130.2213.0 | 163008    | 06-Sep-2017  | 02:10 | x86      |
| Txfileinserter.dll                                            | 2015.130.2213.0 | 199880    | 06-Sep-2017  | 02:06 | x64      |
| Txfileinserter.dll                                            | 2015.130.2213.0 | 160960    | 06-Sep-2017  | 02:10 | x86      |
| Txlookup.dll                                                  | 2015.130.2213.0 | 532168    | 06-Sep-2017  | 02:06 | x64      |
| Txlookup.dll                                                  | 2015.130.2213.0 | 449224    | 06-Sep-2017  | 02:10 | x86      |
| Txmergejoin.dll                                               | 2015.130.2213.0 | 278728    | 06-Sep-2017  | 02:06 | x64      |
| Txmergejoin.dll                                               | 2015.130.2213.0 | 223432    | 06-Sep-2017  | 02:10 | x86      |
| Txpivot.dll                                                   | 2015.130.2213.0 | 228040    | 06-Sep-2017  | 02:06 | x64      |
| Txpivot.dll                                                   | 2015.130.2213.0 | 181960    | 06-Sep-2017  | 02:10 | x86      |
| Txsort.dll                                                    | 2015.130.2213.0 | 259272    | 06-Sep-2017  | 02:06 | x64      |
| Txsort.dll                                                    | 2015.130.2213.0 | 211144    | 06-Sep-2017  | 02:10 | x86      |
| Txsplit.dll                                                   | 2015.130.2213.0 | 600768    | 06-Sep-2017  | 02:06 | x64      |
| Txsplit.dll                                                   | 2015.130.2213.0 | 512712    | 06-Sep-2017  | 02:10 | x86      |
| Txunpivot.dll                                                 | 2015.130.2213.0 | 201928    | 06-Sep-2017  | 02:06 | x64      |
| Txunpivot.dll                                                 | 2015.130.2213.0 | 162504    | 06-Sep-2017  | 02:10 | x86      |
| Xe.dll                                                        | 2015.130.2213.0 | 558784    | 06-Sep-2017  | 02:08 | x86      |
| Xe.dll                                                        | 2015.130.2213.0 | 626376    | 06-Sep-2017  | 02:08 | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.34     | 483520    | 24-Aug-2017 | 18:13 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.34 | 75456     | 24-Aug-2017 | 18:13 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.34     | 45760     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.34     | 74432     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.34     | 201920    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.34     | 2347200   | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.34     | 101568    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.34     | 378560    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.34     | 185536    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.34     | 127168    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.34     | 63168     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.34     | 52416     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.34     | 87232     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.34     | 721600    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.34     | 87232     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.34     | 78016     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.34     | 41664     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.34     | 36544     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.34     | 47808     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.34     | 27328     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.34     | 32960     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.34     | 118976    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.34     | 94400     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.34     | 108224    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.34     | 256704    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 102080    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 115904    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 118976    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 115904    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 125632    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 117952    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 113344    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 145600    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 100032    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 114880    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.34     | 69312     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.34     | 28352     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.34     | 43712     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.34     | 82112     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.34     | 136896    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.34     | 2155712   | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.34     | 3818688   | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 107712    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 120000    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 124608    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 121024    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 133312    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 121024    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 118464    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 152256    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 105152    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 119488    | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.34     | 66752     | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.34     | 2756288   | 24-Aug-2017 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.34     | 752320    | 24-Aug-2017 | 18:13 | x86      |
| Sharedmemory.dll                                                     | 2014.120.8224.34 | 47296     | 24-Aug-2017 | 18:13 | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 1436360   | 06-Sep-2017  | 02:10  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3742408   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3076288   | 06-Sep-2017  | 02:07  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3743944   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3647688   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 2002624   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 1948360   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3430600   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3442888   | 06-Sep-2017  | 02:08  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 1386176   | 06-Sep-2017  | 02:07  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2213.0  | 3617480   | 06-Sep-2017  | 02:07  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.34 | 4348096   | 24-Aug-2017 | 18:13 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date     | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|----------|------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.2213.0     | 79040     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2213.0     | 567496    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2213.0     | 166080    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2213.0     | 1619656   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 81608     | 06-Sep-2017 | 02:10 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 93896     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 93896     | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 93888     | 06-Sep-2017 | 02:34 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 102088    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 93896     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 93896     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 114376    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 81608     | 06-Sep-2017 | 02:12 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2213.0     | 93896     | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.2213.0     | 657608    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2213.0     | 329928    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2213.0     | 1069768   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532160    | 06-Sep-2017 | 02:10 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532168    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532168    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532160    | 06-Sep-2017 | 02:34 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532160    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532168    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532168    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532160    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532168    | 06-Sep-2017 | 02:12 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2213.0     | 532160    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2213.0     | 161992    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2213.0     | 76488     | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2213.0     | 76488     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2213.0     | 124104    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2213.0     | 104128    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2213.0     | 4910280   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545288   | 06-Sep-2017 | 02:10 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545800   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545800   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545792   | 06-Sep-2017 | 02:34 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3546312   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545792   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545792   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3546312   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545280   | 06-Sep-2017 | 02:12 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2213.0     | 3545800   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2213.0     | 9645768   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2213.0     | 92872     | 06-Sep-2017 | 02:09 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2213.0     | 5951168   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2213.0     | 245952    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.2213.0     | 298184    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2213.0     | 207560    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2213.0     | 500936    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2213.0 | 391880    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2213.0 | 396992    | 06-Sep-2017 | 02:09 | x86      |
| Msmdlocal.dll                                             | 2015.130.2213.0 | 37020360  | 06-Sep-2017 | 02:08 | x86      |
| Msmdlocal.dll                                             | 2015.130.2213.0 | 56109768  | 06-Sep-2017 | 02:10 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2213.0 | 7499976   | 06-Sep-2017 | 02:09 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2213.0 | 6501576   | 06-Sep-2017 | 02:11 | x86      |
| Msolap130.dll                                             | 2015.130.2213.0 | 6968000   | 06-Sep-2017 | 02:08 | x86      |
| Msolap130.dll                                             | 2015.130.2213.0 | 8590016   | 06-Sep-2017 | 02:10 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.2213.0     | 2516168   | 06-Sep-2017 | 02:09 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2213.0 | 108744    | 06-Sep-2017 | 02:09 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.2213.0 | 114368    | 06-Sep-2017 | 02:11 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.2213.0 | 99016     | 06-Sep-2017 | 02:09 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2213.0     | 2698440   | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 863936    | 06-Sep-2017 | 02:08 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 868040    | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 868032    | 06-Sep-2017 | 02:10 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 868040    | 06-Sep-2017 | 02:13 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 872136    | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 868040    | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 868032    | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 880320    | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 863944    | 06-Sep-2017 | 02:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2213.0     | 868032    | 06-Sep-2017 | 02:10 | x86      |
| Rsconfigtool.exe                                          | 13.0.2213.0     | 1405632   | 06-Sep-2017 | 02:08 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |
| Sqlrsos.dll                                               | 2015.130.2213.0 | 26312     | 06-Sep-2017 | 02:06 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2213.0 | 732864    | 06-Sep-2017 | 02:08 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2213.0 | 584384    | 06-Sep-2017 | 02:09 | x86      |
| Xmsrv.dll                                                 | 2015.130.2213.0 | 24015552  | 06-Sep-2017 | 02:06 | x64      |
| Xmsrv.dll                                                 | 2015.130.2213.0 | 32696008  | 06-Sep-2017 | 02:10 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date     | Time | Platform |
|------------------------------------|-----------------|-----------|----------|------|----------|
| Smrdll.dll                         | 13.0.2213.0     | 23752     | 06-Sep-2017 | 02:09 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date     | Time | Platform |
|--------------------------------------------------------------|-----------------|-----------|----------|------|----------|
| Autoadmin.dll                                                | 2015.130.2213.0 | 1311432   | 06-Sep-2017 | 02:08 | x86      |
| Dtaengine.exe                                                | 2015.130.2213.0 | 167112    | 06-Sep-2017 | 02:08 | x86      |
| Dteparse.dll                                                 | 2015.130.2213.0 | 99016     | 06-Sep-2017 | 02:08 | x86      |
| Dteparse.dll                                                 | 2015.130.2213.0 | 109768    | 06-Sep-2017 | 02:10 | x64      |
| Dtepkg.dll                                                   | 2015.130.2213.0 | 115912    | 06-Sep-2017 | 02:08 | x86      |
| Dtepkg.dll                                                   | 2015.130.2213.0 | 137416    | 06-Sep-2017 | 02:10 | x64      |
| Dts.dll                                                      | 2015.130.2213.0 | 2631872   | 06-Sep-2017 | 02:08 | x86      |
| Dts.dll                                                      | 2015.130.2213.0 | 3145416   | 06-Sep-2017 | 02:10 | x64      |
| Dtsconn.dll                                                  | 2015.130.2213.0 | 391872    | 06-Sep-2017 | 02:08 | x86      |
| Dtsconn.dll                                                  | 2015.130.2213.0 | 492232    | 06-Sep-2017 | 02:10 | x64      |
| Dtslog.dll                                                   | 2015.130.2213.0 | 103112    | 06-Sep-2017 | 02:08 | x86      |
| Dtslog.dll                                                   | 2015.130.2213.0 | 120520    | 06-Sep-2017 | 02:10 | x64      |
| Dtspipeline.dll                                              | 2015.130.2213.0 | 1059520   | 06-Sep-2017 | 02:08 | x86      |
| Dtspipeline.dll                                              | 2015.130.2213.0 | 1278152   | 06-Sep-2017 | 02:10 | x64      |
| Dtswizard.exe                                                | 13.0.2213.0     | 895688    | 06-Sep-2017 | 02:08 | x86      |
| Dtswizard.exe                                                | 13.0.2213.0     | 895176    | 06-Sep-2017 | 02:09 | x64      |
| Dtuparse.dll                                                 | 2015.130.2213.0 | 80072     | 06-Sep-2017 | 02:08 | x86      |
| Dtuparse.dll                                                 | 2015.130.2213.0 | 87752     | 06-Sep-2017 | 02:10 | x64      |
| Exceldest.dll                                                | 2015.130.2213.0 | 216264    | 06-Sep-2017 | 02:08 | x86      |
| Exceldest.dll                                                | 2015.130.2213.0 | 263368    | 06-Sep-2017 | 02:10 | x64      |
| Excelsrc.dll                                                 | 2015.130.2213.0 | 232648    | 06-Sep-2017 | 02:08 | x86      |
| Excelsrc.dll                                                 | 2015.130.2213.0 | 285384    | 06-Sep-2017 | 02:10 | x64      |
| Flatfiledest.dll                                             | 2015.130.2213.0 | 334528    | 06-Sep-2017 | 02:08 | x86      |
| Flatfiledest.dll                                             | 2015.130.2213.0 | 389320    | 06-Sep-2017 | 02:10 | x64      |
| Flatfilesrc.dll                                              | 2015.130.2213.0 | 345288    | 06-Sep-2017 | 02:08 | x86      |
| Flatfilesrc.dll                                              | 2015.130.2213.0 | 401608    | 06-Sep-2017 | 02:10 | x64      |
| Microsoft.analysisservices.applocal.core.dll                 | 13.0.2213.0     | 1308864   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.applocal.dll                      | 13.0.2213.0     | 696520    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll              | 13.0.2213.0     | 763584    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.analysisservices.project.dll                       | 2015.130.2213.0 | 2023112   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2213.0     | 432840    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2213.0     | 432840    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2213.0     | 2044096   | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2213.0     | 2044104   | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2213.0     | 33480     | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2213.0     | 33480     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2213.0     | 250048    | 06-Sep-2017 | 02:08 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2213.0     | 250048    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2213.0     | 33984     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2213.0     | 33984     | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2213.0     | 606408    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2213.0     | 606400    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2213.0     | 445128    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2213.0     | 445128    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2213.0 | 150208    | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2213.0 | 138952    | 06-Sep-2017 | 02:09 | x86      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2213.0 | 158920    | 06-Sep-2017 | 02:08 | x64      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2213.0 | 144576    | 06-Sep-2017 | 02:09 | x86      |
| Msmdlocal.dll                                                | 2015.130.2213.0 | 37020360  | 06-Sep-2017 | 02:08 | x86      |
| Msmdlocal.dll                                                | 2015.130.2213.0 | 56109768  | 06-Sep-2017 | 02:10 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2213.0 | 7499976   | 06-Sep-2017 | 02:09 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2213.0 | 6501576   | 06-Sep-2017 | 02:11 | x86      |
| Msolap130.dll                                                | 2015.130.2213.0 | 6968000   | 06-Sep-2017 | 02:08 | x86      |
| Msolap130.dll                                                | 2015.130.2213.0 | 8590016   | 06-Sep-2017 | 02:10 | x64      |
| Oledbdest.dll                                                | 2015.130.2213.0 | 216776    | 06-Sep-2017 | 02:08 | x86      |
| Oledbdest.dll                                                | 2015.130.2213.0 | 264392    | 06-Sep-2017 | 02:10 | x64      |
| Oledbsrc.dll                                                 | 2015.130.2213.0 | 235712    | 06-Sep-2017 | 02:08 | x86      |
| Oledbsrc.dll                                                 | 2015.130.2213.0 | 291016    | 06-Sep-2017 | 02:10 | x64      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2213.0 | 100544    | 06-Sep-2017 | 02:10 | x64      |
| Txdataconvert.dll                                            | 2015.130.2213.0 | 296648    | 06-Sep-2017 | 02:06 | x64      |
| Txdataconvert.dll                                            | 2015.130.2213.0 | 255176    | 06-Sep-2017 | 02:10 | x86      |
| Xe.dll                                                       | 2015.130.2213.0 | 558784    | 06-Sep-2017 | 02:08 | x86      |
| Xe.dll                                                       | 2015.130.2213.0 | 626376    | 06-Sep-2017 | 02:08 | x64      |
| Xmsrv.dll                                                    | 2015.130.2213.0 | 24015552  | 06-Sep-2017 | 02:06 | x64      |
| Xmsrv.dll                                                    | 2015.130.2213.0 | 32696008  | 06-Sep-2017 | 02:10 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
