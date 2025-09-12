---
title: Cumulative update 9 for SQL Server 2016 (KB4037357)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 9 (KB4037357).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4037357
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
---

# KB4037357 - Cumulative Update 9 for SQL Server 2016

_Release Date:_ &nbsp; November 20, 2017  
_Version:_ &nbsp; 13.0.2216.0

This article describes cumulative update package 9 (build number: 13.0.2216.0) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

> [!NOTE]
> The following table lists the status of individual Microsoft Knowledge Base articles. A separate Microsoft Knowledge Base article might not be created for each bug.

| Bug reference | Description| Fix area|
|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=10868755>[10868755](#10868755) </a> | [FIX: Error when exporting a Reporting Services report to PDF in SQL Server 2016 or 2017 (KB4040512)](https://support.microsoft.com/help/4040512)| Reporting Services|
| <a id=10868765>[10868765](#10868765) </a> | [FIX: Access violation occurs when you use sp_xml_preparedocument to open XML documents in SQL Server (KB4039510)](https://support.microsoft.com/help/4039510) | XML |
| <a id=11078703>[11078703](#11078703) </a> | [FIX: Cannot change the password for a SQL Server 2014 or 2016 service account when additional LSA protection is enabled (KB4039592)](https://support.microsoft.com/help/4039592)| Management Tools|
| <a id=11078710>[11078710](#11078710) </a> | [FIX: Access violation when you cancel a pending query if the missing indexes feature is enabled in SQL Server 2014 and 2016 (KB4042232)](https://support.microsoft.com/help/4042232)| SQL performance |
| <a id=11078717>[11078717](#11078717) </a> | [FIX: Bookmarks functionality does not work completely when you open a report in MHTML format through Outlook in SSRS 2014 and 2016 (KB4043947)](https://support.microsoft.com/help/4043947) | Reporting Services|
| <a id=10868752>[10868752](#10868752) </a> | [FIX: A memory leak may occur when you perform Process Update operations in SSAS (KB4033789)](https://support.microsoft.com/help/4033789)| Analysis Services |
| <a id=11077635>[11077635](#11077635) </a> | [FIX: Memory use with many databases greater in SQL Server 2016 than earlier versions (KB4035062)](https://support.microsoft.com/help/4035062) | SQL Engine|
| <a id=10868720>[10868720](#10868720) </a> | [FIX: SQL Server Managed Backup does not delete old backups that are beyond the retention period in SQL Server (KB4038882)](https://support.microsoft.com/help/4038882)| SQL Engine|
| <a id=10868737>[10868737](#10868737) </a> | [FIX: SSAS crashes when you process an SSAS database or cube in SQL Server (KB4039509)](https://support.microsoft.com/help/4039509)| Analysis Services |
| <a id=10868724>[10868724](#10868724) </a> | [FIX: Managed Backup fails intermittently because of SQLVDI error in SQL Server (KB4039511)](https://support.microsoft.com/help/4039511) | SQL Engine|
| <a id=10868769>[10868769](#10868769) </a> | [FIX: "Non-yielding Scheduler" condition occurs for query with many expressions in SQL Server 2014 and 2016 (KB4039735)](https://support.microsoft.com/help/4039735) | SQL performance |
| <a id=11078700>[11078700](#11078700) </a> | [FIX: Backup of availability database via VSS-based application may fail in SQL Server (KB4040108)](https://support.microsoft.com/help/4040108)| SQL Engine|
| <a id=10868731>[10868731](#10868731) </a> | [FIX: Managed Backup to Microsoft Azure stops after large database backup in SQL Server (KB4040376)](https://support.microsoft.com/help/4040376) | SQL Engine|
| <a id=11061122>[11061122](#11061122) </a> | [FIX: Assertion occurs when you access memory-optimized table through MARS in SQL Server 2016 (KB4046056)](https://support.microsoft.com/help/4046056) | SQL Engine|
| <a id=11057320>[11057320](#11057320) </a> | [FIX: Errors 33111 and 3013 when you back up a TDE encrypted database in SQL Server (KB4052134)](https://support.microsoft.com/help/4052134) | SQL Engine|
| <a id=11124143>[11124143](#11124143) </a> | [FIX: The Alert Engine reads the complete Application event log and sends alerts on old events after Windows is updated (KB4052127)](https://support.microsoft.com/help/4052127) | Management Tools|
| <a id=10881287>[10881287](#10881287) </a> | [FIX: DMV sys.dm_os_windows_info returns wrong values for Windows 10 and Windows Server 2016 (KB4052131)](https://support.microsoft.com/help/4052131)| SQL Engine|
| <a id=11127656>[11127656](#11127656) </a> | [FIX: Queries that retrieve data by using non-clustered index seek take longer in SQL Server (KB4052625)](https://support.microsoft.com/help/4052625)| SQL Engine|
| <a id=10870632>[10870632](#10870632) </a> | [FIX: Data-driven subscription fails after you upgrade from SSRS 2008 to SSRS 2016 (KB4042948)](https://support.microsoft.com/help/4042948)| Reporting Services|
| <a id=10868734>[10868734](#10868734) </a> | [FIX: Error when you export a DQS knowledge base that contains domains in the DQS client in SQL Server (KB4022483)](https://support.microsoft.com/help/4022483)| Data Quality Services (DQS) |
| <a id=10868746>[10868746](#10868746) </a> | [FIX: Access violation for spatial datatypes query via linked server in SQL Server (KB4040401)](https://support.microsoft.com/help/4040401)| SQL Engine|
| <a id=11078721>[11078721](#11078721) </a> | [FIX: Inconsistent behavior for returning trailing blanks at the end of CHAR and BINARY data in SQL Server (KB4055758)](https://support.microsoft.com/help/4055758)| SQL Engine|

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

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

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

| File   name            | File version    | File size | Date      | Time | Platform |
|------------------------|-----------------|-----------|-----------|------|----------|
| Msmdsrv.rll            | 2015.130.2216.0 | 1295024   | 10-Nov-2017 | 00:05 | x86      |
| Msmdsrvi.rll           | 2015.130.2216.0 | 1291952   | 10-Nov-2017 | 00:05 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.2216.0 | 88752     | 10-Nov-2017 | 00:05 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time | Platform |
|--------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2216.0     | 1023144   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2216.0     | 1344168   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2216.0     | 702632    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2216.0     | 765616    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2216.0     | 707240    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2216.0     | 37032     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2216.0     | 46256     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2216.0 | 72880     | 10-Nov-2017 | 00:04 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2216.0 | 60072     | 10-Nov-2017 | 00:05 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2216.0 | 88752     | 10-Nov-2017 | 00:05 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2216.0 | 364208    | 10-Nov-2017 | 00:05 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2216.0 | 267432    | 10-Nov-2017 | 00:05 | x86      |
| Sqltdiagn.dll                              | 2015.130.2216.0 | 60584     | 10-Nov-2017 | 00:05 | x86      |
| Svrenumapi130.dll                          | 2015.130.2216.0 | 854192    | 10-Nov-2017 | 00:05 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time | Platform |
|-------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2216.0  | 473264    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2216.0  | 1876656   | 10-Nov-2017 | 00:06 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                                | 2015.130.2216.0 | 1311408   | 10-Nov-2017 | 00:04 | x86      |
| Dtaengine.exe                                                | 2015.130.2216.0 | 167088    | 10-Nov-2017 | 00:04 | x86      |
| Dteparse.dll                                                 | 2015.130.2216.0 | 98984     | 10-Nov-2017 | 00:04 | x86      |
| Dtepkg.dll                                                   | 2015.130.2216.0 | 115880    | 10-Nov-2017 | 00:04 | x86      |
| Dts.dll                                                      | 2015.130.2216.0 | 2631856   | 10-Nov-2017 | 00:04 | x86      |
| Dtsconn.dll                                                  | 2015.130.2216.0 | 391856    | 10-Nov-2017 | 00:04 | x86      |
| Dtslog.dll                                                   | 2015.130.2216.0 | 103088    | 10-Nov-2017 | 00:04 | x86      |
| Dtspipeline.dll                                              | 2015.130.2216.0 | 1059496   | 10-Nov-2017 | 00:04 | x86      |
| Dtswizard.exe                                                | 13.0.2216.0     | 895664    | 10-Nov-2017 | 00:04 | x86      |
| Dtuparse.dll                                                 | 2015.130.2216.0 | 80048     | 10-Nov-2017 | 00:04 | x86      |
| Exceldest.dll                                                | 2015.130.2216.0 | 216240    | 10-Nov-2017 | 00:04 | x86      |
| Excelsrc.dll                                                 | 2015.130.2216.0 | 232616    | 10-Nov-2017 | 00:04 | x86      |
| Flatfiledest.dll                                             | 2015.130.2216.0 | 334512    | 10-Nov-2017 | 00:04 | x86      |
| Flatfilesrc.dll                                              | 2015.130.2216.0 | 345264    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.applocal.core.dll                 | 13.0.2216.0     | 1308840   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.applocal.dll                      | 13.0.2216.0     | 696488    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll              | 13.0.2216.0     | 763568    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.project.dll                       | 2015.130.2216.0 | 2023088   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2216.0     | 432808    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2216.0     | 2044080   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2216.0     | 33456     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2216.0     | 250032    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2216.0     | 33960     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2216.0     | 606384    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2216.0     | 445096    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2216.0 | 138928    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2216.0 | 144552    | 10-Nov-2017 | 00:05 | x86      |
| Msmdlocal.dll                                                | 2015.130.2216.0 | 37020336  | 10-Nov-2017 | 00:05 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2216.0 | 6501544   | 10-Nov-2017 | 00:06 | x86      |
| Msolap130.dll                                                | 2015.130.2216.0 | 6967984   | 10-Nov-2017 | 00:05 | x86      |
| Oledbdest.dll                                                | 2015.130.2216.0 | 216752    | 10-Nov-2017 | 00:05 | x86      |
| Oledbsrc.dll                                                 | 2015.130.2216.0 | 235696    | 10-Nov-2017 | 00:05 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2216.0 | 88752     | 10-Nov-2017 | 00:05 | x86      |
| Txdataconvert.dll                                            | 2015.130.2216.0 | 255152    | 10-Nov-2017 | 00:05 | x86      |
| Xe.dll                                                       | 2015.130.2216.0 | 558768    | 10-Nov-2017 | 00:04 | x86      |
| Xmsrv.dll                                                    | 2015.130.2216.0 | 32695984  | 10-Nov-2017 | 00:05 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name  | File version    | File size | Date      | Time | Platform |
|--------------|-----------------|-----------|-----------|------|----------|
| Keyfile.dll  | 2015.130.2216.0 | 88752     | 10-Nov-2017 | 00:05 | x86      |
| Msmdsrv.rll  | 2015.130.2216.0 | 1295024   | 10-Nov-2017 | 00:05 | x86      |
| Msmdsrvi.rll | 2015.130.2216.0 | 1291952   | 10-Nov-2017 | 00:05 | x86      |

SQL Server 2016 Business Intelligence Development Studio

| File   name        | File version    | File size | Date      | Time | Platform |
|--------------------|-----------------|-----------|-----------|------|----------|
| Sqlsqm_keyfile.dll | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Sqlboot.dll           | 2015.130.2216.0 | 186544    | 10-Nov-2017 | 00:05 | x64      |
| Sqlvdi.dll            | 2015.130.2216.0 | 197288    | 10-Nov-2017 | 00:04 | x64      |
| Sqlvdi.dll            | 2015.130.2216.0 | 168616    | 10-Nov-2017 | 00:05 | x86      |
| Sqlwriter_keyfile.dll | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |
| Sqlwvss.dll           | 2015.130.2216.0 | 336048    | 10-Nov-2017 | 00:03 | x64      |

SQL Server 2016 Analysis Services

 | File   name                                   | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll    | 13.0.2216.0     | 1343664   | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2216.0     | 765616    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 04-Jun-2016  | 16:07 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 23-Jun-2016 | 15:46 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 16:07 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 23-Jun-2016 | 15:46 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 16:07 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 23-Jun-2016 | 15:46 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 23-Jun-2016 | 15:46 | x86      |
| Microsoft.powerbi.adomdclient.dll             | 13.0.2216.0     | 985264    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.powerbi.adomdclient.dll             | 13.0.2216.0     | 985256    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 23-Jun-2016 | 15:46 | x86      |
| Msmdlocal.dll                                 | 2015.130.2216.0 | 56110768  | 10-Nov-2017 | 00:05  | x64      |
| Msmdlocal.dll                                 | 2015.130.2216.0 | 37020336  | 10-Nov-2017 | 00:05  | x86      |
| Msmdsrv.exe                                   | 2015.130.2216.0 | 56656560  | 10-Nov-2017 | 00:04  | x64      |
| Msmgdsrv.dll                                  | 2015.130.2216.0 | 7499944   | 10-Nov-2017 | 00:05  | x64      |
| Msmgdsrv.dll                                  | 2015.130.2216.0 | 6501544   | 10-Nov-2017 | 00:06  | x86      |
| Msolap130.dll                                 | 2015.130.2216.0 | 8590000   | 10-Nov-2017 | 00:05  | x64      |
| Msolap130.dll                                 | 2015.130.2216.0 | 6967984   | 10-Nov-2017 | 00:05  | x86      |
| Sql_as_keyfile.dll                            | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05  | x64      |
| Sqlboot.dll                                   | 2015.130.2216.0 | 186544    | 10-Nov-2017 | 00:05  | x64      |
| Sqlceip.exe                                   | 13.0.2216.0     | 250536    | 10-Nov-2017 | 00:04  | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 04-Jun-2016  | 16:07 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 23-Jun-2016 | 15:46 | x86      |
| Tmapi.dll                                     | 2015.130.2216.0 | 4344496   | 10-Nov-2017 | 00:03  | x64      |
| Tmcachemgr.dll                                | 2015.130.2216.0 | 2825392   | 10-Nov-2017 | 00:03  | x64      |
| Tmpersistence.dll                             | 2015.130.2216.0 | 1069744   | 10-Nov-2017 | 00:03  | x64      |
| Tmtransactions.dll                            | 2015.130.2216.0 | 1349800   | 10-Nov-2017 | 00:03  | x64      |
| Xe.dll                                        | 2015.130.2216.0 | 626344    | 10-Nov-2017 | 00:04  | x64      |
| Xmsrv.dll                                     | 2015.130.2216.0 | 24015536  | 10-Nov-2017 | 00:03  | x64      |
| Xmsrv.dll                                     | 2015.130.2216.0 | 32695984  | 10-Nov-2017 | 00:05  | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time | Platform |
|--------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2216.0     | 1023144   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2216.0     | 1023152   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2216.0     | 1344168   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2216.0     | 702632    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2216.0     | 765616    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2216.0     | 707240    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2216.0     | 707248    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2216.0     | 37032     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2216.0     | 46256     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2216.0 | 75440     | 10-Nov-2017 | 00:03 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2216.0 | 72880     | 10-Nov-2017 | 00:04 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2216.0 | 72880     | 10-Nov-2017 | 00:05 | x64      |
| Pbsvcacctsync.dll                          | 2015.130.2216.0 | 60072     | 10-Nov-2017 | 00:05 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2216.0 | 404144    | 10-Nov-2017 | 00:03 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2216.0 | 364208    | 10-Nov-2017 | 00:05 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2216.0 | 348848    | 10-Nov-2017 | 00:03 | x64      |
| Sqlsvcsync.dll                             | 2015.130.2216.0 | 267432    | 10-Nov-2017 | 00:05 | x86      |
| Sqltdiagn.dll                              | 2015.130.2216.0 | 67752     | 10-Nov-2017 | 00:03 | x64      |
| Sqltdiagn.dll                              | 2015.130.2216.0 | 60584     | 10-Nov-2017 | 00:05 | x86      |
| Svrenumapi130.dll                          | 2015.130.2216.0 | 1115816   | 10-Nov-2017 | 00:03 | x64      |
| Svrenumapi130.dll                          | 2015.130.2216.0 | 854192    | 10-Nov-2017 | 00:05 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time | Platform |
|-------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2216.0  | 473264    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2216.0  | 473264    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2216.0  | 1876656   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2216.0  | 1876656   | 10-Nov-2017 | 00:06 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.2216.0     | 41136     | 10-Nov-2017 | 00:04  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 9-Dec-16  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.2216.0 | 224944    | 10-Nov-2017 | 00:05  | x64      |
| Dcexec.exe                                   | 2015.130.2216.0 | 74408     | 10-Nov-2017 | 00:04  | x64      |
| Fssres.dll                                   | 2015.130.2216.0 | 81584     | 10-Nov-2017 | 00:05  | x64      |
| Hadrres.dll                                  | 2015.130.2216.0 | 177840    | 10-Nov-2017 | 00:04  | x64      |
| Hkcompile.dll                                | 2015.130.2216.0 | 1297064   | 10-Nov-2017 | 00:04  | x64      |
| Hkengine.dll                                 | 2015.130.2216.0 | 5600424   | 10-Nov-2017 | 00:06  | x64      |
| Hkruntime.dll                                | 2015.130.2216.0 | 158896    | 10-Nov-2017 | 00:06  | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.2216.0     | 234672    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.2216.0     | 79536     | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.2216.0 | 391848    | 10-Nov-2017 | 00:03  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.2216.0 | 71336     | 10-Nov-2017 | 00:05  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.2216.0 | 65192     | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.2216.0 | 150192    | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.2216.0 | 158896    | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.2216.0 | 272048    | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.2216.0 | 74920     | 10-Nov-2017 | 00:03  | x64      |
| Msvcp120.dll                                 | 12.0.40649.5    | 660128    | 06-Mar-2017  | 18:24 | x64      |
| Msvcr120.dll                                 | 12.0.40649.5    | 963744    | 06-Mar-2017  | 18:24 | x64      |
| Qds.dll                                      | 2015.130.2216.0 | 844464    | 10-Nov-2017 | 00:05  | x64      |
| Rsfxft.dll                                   | 2015.130.2216.0 | 34480     | 10-Nov-2017 | 00:04  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05  | x64      |
| Sqlaccess.dll                                | 2015.130.2216.0 | 462504    | 10-Nov-2017 | 00:03  | x64      |
| Sqlagent.exe                                 | 2015.130.2216.0 | 565936    | 10-Nov-2017 | 00:04  | x64      |
| Sqlboot.dll                                  | 2015.130.2216.0 | 186544    | 10-Nov-2017 | 00:05  | x64      |
| Sqlceip.exe                                  | 13.0.2216.0     | 250536    | 10-Nov-2017 | 00:04  | x86      |
| Sqldk.dll                                    | 2015.130.2216.0 | 2586280   | 10-Nov-2017 | 00:05  | x64      |
| Sqllang.dll                                  | 2015.130.2216.0 | 39346352  | 10-Nov-2017 | 00:05  | x64      |
| Sqlmin.dll                                   | 2015.130.2216.0 | 37372592  | 10-Nov-2017 | 00:03  | x64      |
| Sqlos.dll                                    | 2015.130.2216.0 | 26288     | 10-Nov-2017 | 00:04  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.2216.0 | 27824     | 10-Nov-2017 | 00:03  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.2216.0 | 5797552   | 10-Nov-2017 | 00:04  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.2216.0 | 732848    | 10-Nov-2017 | 00:04  | x64      |
| Sqlservr.exe                                 | 2015.130.2216.0 | 392872    | 10-Nov-2017 | 00:04  | x64      |
| Sqltses.dll                                  | 2015.130.2216.0 | 8896680   | 10-Nov-2017 | 00:03  | x64      |
| Sqsrvres.dll                                 | 2015.130.2216.0 | 251056    | 10-Nov-2017 | 00:03  | x64      |
| Stretchcodegen.exe                           | 13.0.2216.0     | 55472     | 10-Nov-2017 | 00:06  | x86      |
| Xe.dll                                       | 2015.130.2216.0 | 626344    | 10-Nov-2017 | 00:04  | x64      |
| Xpstar.dll                                   | 2015.130.2216.0 | 422064    | 10-Nov-2017 | 00:04  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Bcp.exe                                                      | 2015.130.2216.0 | 119984    | 10-Nov-2017 | 00:05  | x64      |
| Commanddest.dll                                              | 2015.130.2216.0 | 249008    | 10-Nov-2017 | 00:05  | x64      |
| Datacollectortasks.dll                                       | 2015.130.2216.0 | 188080    | 10-Nov-2017 | 00:05  | x64      |
| Dteparse.dll                                                 | 2015.130.2216.0 | 109744    | 10-Nov-2017 | 00:05  | x64      |
| Dtepkg.dll                                                   | 2015.130.2216.0 | 137392    | 10-Nov-2017 | 00:05  | x64      |
| Dts.dll                                                      | 2015.130.2216.0 | 3145392   | 10-Nov-2017 | 00:05  | x64      |
| Dtsconn.dll                                                  | 2015.130.2216.0 | 492208    | 10-Nov-2017 | 00:05  | x64      |
| Dtslog.dll                                                   | 2015.130.2216.0 | 120488    | 10-Nov-2017 | 00:05  | x64      |
| Dtspipeline.dll                                              | 2015.130.2216.0 | 1278128   | 10-Nov-2017 | 00:05  | x64      |
| Dtswizard.exe                                                | 13.0.2216.0     | 895144    | 10-Nov-2017 | 00:04  | x64      |
| Dtuparse.dll                                                 | 2015.130.2216.0 | 87728     | 10-Nov-2017 | 00:05  | x64      |
| Exceldest.dll                                                | 2015.130.2216.0 | 263344    | 10-Nov-2017 | 00:05  | x64      |
| Excelsrc.dll                                                 | 2015.130.2216.0 | 285360    | 10-Nov-2017 | 00:05  | x64      |
| Execpackagetask.dll                                          | 2015.130.2216.0 | 166064    | 10-Nov-2017 | 00:05  | x64      |
| Flatfiledest.dll                                             | 2015.130.2216.0 | 389296    | 10-Nov-2017 | 00:05  | x64      |
| Flatfilesrc.dll                                              | 2015.130.2216.0 | 401584    | 10-Nov-2017 | 00:05  | x64      |
| Logread.exe                                                  | 2015.130.2216.0 | 616624    | 10-Nov-2017 | 00:04  | x64      |
| Microsoft.analysisservices.applocal.core.dll                 | 13.0.2216.0     | 1308848   | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.analysisservices.applocal.dll                      | 13.0.2216.0     | 696496    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll              | 13.0.2216.0     | 763568    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2216.0     | 33968     | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2216.0     | 606384    | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                 | 13.0.2216.0     | 215208    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll             | 13.0.16107.4    | 30912     | 20-Mar-17 | 22:54 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2216.0     | 445096    | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.replication.dll                          | 2015.130.2216.0 | 1638056   | 10-Nov-2017 | 00:05  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2216.0 | 150192    | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2216.0 | 158896    | 10-Nov-2017 | 00:03  | x64      |
| Msxmlsql.dll                                                 | 2015.130.2216.0 | 1497256   | 10-Nov-2017 | 00:04  | x64      |
| Oledbdest.dll                                                | 2015.130.2216.0 | 264360    | 10-Nov-2017 | 00:05  | x64      |
| Oledbsrc.dll                                                 | 2015.130.2216.0 | 290984    | 10-Nov-2017 | 00:05  | x64      |
| Rawdest.dll                                                  | 2015.130.2216.0 | 209584    | 10-Nov-2017 | 00:05  | x64      |
| Rawsource.dll                                                | 2015.130.2216.0 | 196784    | 10-Nov-2017 | 00:05  | x64      |
| Recordsetdest.dll                                            | 2015.130.2216.0 | 187048    | 10-Nov-2017 | 00:05  | x64      |
| Repldp.dll                                                   | 2015.130.2216.0 | 276136    | 10-Nov-2017 | 00:05  | x64      |
| Spresolv.dll                                                 | 2015.130.2216.0 | 244912    | 10-Nov-2017 | 00:05  | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05  | x64      |
| Sqlmergx.dll                                                 | 2015.130.2216.0 | 346800    | 10-Nov-2017 | 00:03  | x64      |
| Sqlwep130.dll                                                | 2015.130.2216.0 | 105640    | 10-Nov-2017 | 00:03  | x64      |
| Ssradd.dll                                                   | 2015.130.2216.0 | 65200     | 10-Nov-2017 | 00:03  | x64      |
| Ssravg.dll                                                   | 2015.130.2216.0 | 65192     | 10-Nov-2017 | 00:03  | x64      |
| Ssrdown.dll                                                  | 2015.130.2216.0 | 50856     | 10-Nov-2017 | 00:03  | x64      |
| Ssrmax.dll                                                   | 2015.130.2216.0 | 63144     | 10-Nov-2017 | 00:03  | x64      |
| Ssrmin.dll                                                   | 2015.130.2216.0 | 63664     | 10-Nov-2017 | 00:03  | x64      |
| Ssrpub.dll                                                   | 2015.130.2216.0 | 51376     | 10-Nov-2017 | 00:03  | x64      |
| Ssrup.dll                                                    | 2015.130.2216.0 | 50856     | 10-Nov-2017 | 00:03  | x64      |
| Txagg.dll                                                    | 2015.130.2216.0 | 364720    | 10-Nov-2017 | 00:03  | x64      |
| Txbdd.dll                                                    | 2015.130.2216.0 | 172712    | 10-Nov-2017 | 00:03  | x64      |
| Txdatacollector.dll                                          | 2015.130.2216.0 | 367280    | 10-Nov-2017 | 00:03  | x64      |
| Txdataconvert.dll                                            | 2015.130.2216.0 | 296616    | 10-Nov-2017 | 00:03  | x64      |
| Txderived.dll                                                | 2015.130.2216.0 | 607920    | 10-Nov-2017 | 00:03  | x64      |
| Txlookup.dll                                                 | 2015.130.2216.0 | 532144    | 10-Nov-2017 | 00:03  | x64      |
| Txmergejoin.dll                                              | 2015.130.2216.0 | 278704    | 10-Nov-2017 | 00:03  | x64      |
| Txsort.dll                                                   | 2015.130.2216.0 | 259248    | 10-Nov-2017 | 00:03  | x64      |
| Txsplit.dll                                                  | 2015.130.2216.0 | 600744    | 10-Nov-2017 | 00:03  | x64      |
| Xe.dll                                                       | 2015.130.2216.0 | 626344    | 10-Nov-2017 | 00:04  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.2216.0 | 1012400   | 10-Nov-2017 | 00:05 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |
| Sqlsatellite.dll              | 2015.130.2216.0 | 836784    | 10-Nov-2017 | 00:04 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.2216.0 | 660144    | 10-Nov-2017 | 00:04  | x64      |
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 03-Sep-2014  | 14:52 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 03-Sep-2014  | 14:53 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 03-Sep-2014  | 14:53 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 03-Sep-2014  | 14:53 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05  | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.2216.0     | 23728     | 10-Nov-2017 | 00:06 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.89        | 77936     | 25-Aug-2017 | 02:09  | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.89        | 77936     | 08-Nov-2017  | 14:42 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.89        | 37488     | 25-Aug-2017 | 02:09  | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.89        | 37488     | 08-Nov-2017  | 14:42 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.89        | 78448     | 25-Aug-2017 | 02:09  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.89        | 78448     | 08-Nov-2017  | 14:42 | x86      |
| Commanddest.dll                                               | 2015.130.2216.0 | 202928    | 10-Nov-2017 | 00:04  | x86      |
| Commanddest.dll                                               | 2015.130.2216.0 | 249008    | 10-Nov-2017 | 00:05  | x64      |
| Dteparse.dll                                                  | 2015.130.2216.0 | 98984     | 10-Nov-2017 | 00:04  | x86      |
| Dteparse.dll                                                  | 2015.130.2216.0 | 109744    | 10-Nov-2017 | 00:05  | x64      |
| Dtepkg.dll                                                    | 2015.130.2216.0 | 115880    | 10-Nov-2017 | 00:04  | x86      |
| Dtepkg.dll                                                    | 2015.130.2216.0 | 137392    | 10-Nov-2017 | 00:05  | x64      |
| Dts.dll                                                       | 2015.130.2216.0 | 2631856   | 10-Nov-2017 | 00:04  | x86      |
| Dts.dll                                                       | 2015.130.2216.0 | 3145392   | 10-Nov-2017 | 00:05  | x64      |
| Dtsconn.dll                                                   | 2015.130.2216.0 | 391856    | 10-Nov-2017 | 00:04  | x86      |
| Dtsconn.dll                                                   | 2015.130.2216.0 | 492208    | 10-Nov-2017 | 00:05  | x64      |
| Dtslog.dll                                                    | 2015.130.2216.0 | 103088    | 10-Nov-2017 | 00:04  | x86      |
| Dtslog.dll                                                    | 2015.130.2216.0 | 120488    | 10-Nov-2017 | 00:05  | x64      |
| Dtspipeline.dll                                               | 2015.130.2216.0 | 1059496   | 10-Nov-2017 | 00:04  | x86      |
| Dtspipeline.dll                                               | 2015.130.2216.0 | 1278128   | 10-Nov-2017 | 00:05  | x64      |
| Dtswizard.exe                                                 | 13.0.2216.0     | 895664    | 10-Nov-2017 | 00:04  | x86      |
| Dtswizard.exe                                                 | 13.0.2216.0     | 895144    | 10-Nov-2017 | 00:04  | x64      |
| Dtuparse.dll                                                  | 2015.130.2216.0 | 80048     | 10-Nov-2017 | 00:04  | x86      |
| Dtuparse.dll                                                  | 2015.130.2216.0 | 87728     | 10-Nov-2017 | 00:05  | x64      |
| Exceldest.dll                                                 | 2015.130.2216.0 | 216240    | 10-Nov-2017 | 00:04  | x86      |
| Exceldest.dll                                                 | 2015.130.2216.0 | 263344    | 10-Nov-2017 | 00:05  | x64      |
| Excelsrc.dll                                                  | 2015.130.2216.0 | 232616    | 10-Nov-2017 | 00:04  | x86      |
| Excelsrc.dll                                                  | 2015.130.2216.0 | 285360    | 10-Nov-2017 | 00:05  | x64      |
| Execpackagetask.dll                                           | 2015.130.2216.0 | 135336    | 10-Nov-2017 | 00:04  | x86      |
| Execpackagetask.dll                                           | 2015.130.2216.0 | 166064    | 10-Nov-2017 | 00:05  | x64      |
| Flatfiledest.dll                                              | 2015.130.2216.0 | 334512    | 10-Nov-2017 | 00:04  | x86      |
| Flatfiledest.dll                                              | 2015.130.2216.0 | 389296    | 10-Nov-2017 | 00:05  | x64      |
| Flatfilesrc.dll                                               | 2015.130.2216.0 | 345264    | 10-Nov-2017 | 00:04  | x86      |
| Flatfilesrc.dll                                               | 2015.130.2216.0 | 401584    | 10-Nov-2017 | 00:05  | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.2216.0     | 1308840   | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.2216.0     | 1308848   | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.analysisservices.applocal.dll                       | 13.0.2216.0     | 696488    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.analysisservices.applocal.dll                       | 13.0.2216.0     | 696496    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll               | 13.0.2216.0     | 763568    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll               | 13.0.2216.0     | 763568    | 10-Nov-2017 | 00:06  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2216.0     | 469672    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2216.0     | 469680    | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2216.0     | 33960     | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2216.0     | 33968     | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2216.0     | 606384    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2216.0     | 606384    | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2216.0     | 445096    | 10-Nov-2017 | 00:04  | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2216.0     | 445096    | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.130.2216.0 | 150192    | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.130.2216.0 | 138928    | 10-Nov-2017 | 00:05  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2015.130.2216.0 | 158896    | 10-Nov-2017 | 00:03  | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2015.130.2216.0 | 144552    | 10-Nov-2017 | 00:05  | x86      |
| Msdtssrvr.exe                                                 | 13.0.2216.0     | 216744    | 10-Nov-2017 | 00:04  | x64      |
| Oledbdest.dll                                                 | 2015.130.2216.0 | 264360    | 10-Nov-2017 | 00:05  | x64      |
| Oledbdest.dll                                                 | 2015.130.2216.0 | 216752    | 10-Nov-2017 | 00:05  | x86      |
| Oledbsrc.dll                                                  | 2015.130.2216.0 | 290984    | 10-Nov-2017 | 00:05  | x64      |
| Oledbsrc.dll                                                  | 2015.130.2216.0 | 235696    | 10-Nov-2017 | 00:05  | x86      |
| Rawdest.dll                                                   | 2015.130.2216.0 | 209584    | 10-Nov-2017 | 00:05  | x64      |
| Rawdest.dll                                                   | 2015.130.2216.0 | 168112    | 10-Nov-2017 | 00:05  | x86      |
| Rawsource.dll                                                 | 2015.130.2216.0 | 196784    | 10-Nov-2017 | 00:05  | x64      |
| Rawsource.dll                                                 | 2015.130.2216.0 | 155312    | 10-Nov-2017 | 00:05  | x86      |
| Recordsetdest.dll                                             | 2015.130.2216.0 | 187048    | 10-Nov-2017 | 00:05  | x64      |
| Recordsetdest.dll                                             | 2015.130.2216.0 | 151728    | 10-Nov-2017 | 00:05  | x86      |
| Sql_is_keyfile.dll                                            | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05  | x64      |
| Sqlceip.exe                                                   | 13.0.2216.0     | 250536    | 10-Nov-2017 | 00:04  | x86      |
| Sqldest.dll                                                   | 2015.130.2216.0 | 263848    | 10-Nov-2017 | 00:05  | x64      |
| Sqldest.dll                                                   | 2015.130.2216.0 | 215216    | 10-Nov-2017 | 00:05  | x86      |
| Txagg.dll                                                     | 2015.130.2216.0 | 364720    | 10-Nov-2017 | 00:03  | x64      |
| Txagg.dll                                                     | 2015.130.2216.0 | 304816    | 10-Nov-2017 | 00:05  | x86      |
| Txbdd.dll                                                     | 2015.130.2216.0 | 172712    | 10-Nov-2017 | 00:03  | x64      |
| Txbdd.dll                                                     | 2015.130.2216.0 | 137904    | 10-Nov-2017 | 00:05  | x86      |
| Txcache.dll                                                   | 2015.130.2216.0 | 182952    | 10-Nov-2017 | 00:03  | x64      |
| Txcache.dll                                                   | 2015.130.2216.0 | 148144    | 10-Nov-2017 | 00:05  | x86      |
| Txcharmap.dll                                                 | 2015.130.2216.0 | 289960    | 10-Nov-2017 | 00:03  | x64      |
| Txcharmap.dll                                                 | 2015.130.2216.0 | 250544    | 10-Nov-2017 | 00:05  | x86      |
| Txcopymap.dll                                                 | 2015.130.2216.0 | 182952    | 10-Nov-2017 | 00:03  | x64      |
| Txcopymap.dll                                                 | 2015.130.2216.0 | 147632    | 10-Nov-2017 | 00:05  | x86      |
| Txdataconvert.dll                                             | 2015.130.2216.0 | 296616    | 10-Nov-2017 | 00:03  | x64      |
| Txdataconvert.dll                                             | 2015.130.2216.0 | 255152    | 10-Nov-2017 | 00:05  | x86      |
| Txderived.dll                                                 | 2015.130.2216.0 | 607920    | 10-Nov-2017 | 00:03  | x64      |
| Txderived.dll                                                 | 2015.130.2216.0 | 518832    | 10-Nov-2017 | 00:05  | x86      |
| Txfileextractor.dll                                           | 2015.130.2216.0 | 201392    | 10-Nov-2017 | 00:03  | x64      |
| Txfileextractor.dll                                           | 2015.130.2216.0 | 162992    | 10-Nov-2017 | 00:05  | x86      |
| Txfileinserter.dll                                            | 2015.130.2216.0 | 199848    | 10-Nov-2017 | 00:03  | x64      |
| Txfileinserter.dll                                            | 2015.130.2216.0 | 160944    | 10-Nov-2017 | 00:05  | x86      |
| Txlookup.dll                                                  | 2015.130.2216.0 | 532144    | 10-Nov-2017 | 00:03  | x64      |
| Txlookup.dll                                                  | 2015.130.2216.0 | 449200    | 10-Nov-2017 | 00:05  | x86      |
| Txmergejoin.dll                                               | 2015.130.2216.0 | 278704    | 10-Nov-2017 | 00:03  | x64      |
| Txmergejoin.dll                                               | 2015.130.2216.0 | 223408    | 10-Nov-2017 | 00:05  | x86      |
| Txpivot.dll                                                   | 2015.130.2216.0 | 228016    | 10-Nov-2017 | 00:03  | x64      |
| Txpivot.dll                                                   | 2015.130.2216.0 | 181936    | 10-Nov-2017 | 00:05  | x86      |
| Txsort.dll                                                    | 2015.130.2216.0 | 259248    | 10-Nov-2017 | 00:03  | x64      |
| Txsort.dll                                                    | 2015.130.2216.0 | 211120    | 10-Nov-2017 | 00:05  | x86      |
| Txsplit.dll                                                   | 2015.130.2216.0 | 600744    | 10-Nov-2017 | 00:03  | x64      |
| Txsplit.dll                                                   | 2015.130.2216.0 | 512688    | 10-Nov-2017 | 00:05  | x86      |
| Txunpivot.dll                                                 | 2015.130.2216.0 | 201904    | 10-Nov-2017 | 00:03  | x64      |
| Txunpivot.dll                                                 | 2015.130.2216.0 | 162480    | 10-Nov-2017 | 00:05  | x86      |
| Xe.dll                                                        | 2015.130.2216.0 | 558768    | 10-Nov-2017 | 00:04  | x86      |
| Xe.dll                                                        | 2015.130.2216.0 | 626344    | 10-Nov-2017 | 00:04  | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.34     | 483520    | 24-Aug-2017 | 17:13 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.34 | 75456     | 24-Aug-2017 | 17:13 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.34     | 45760     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.34     | 74432     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.34     | 201920    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.34     | 2347200   | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.34     | 101568    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.34     | 378560    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.34     | 185536    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.34     | 127168    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.34     | 63168     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.34     | 52416     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.34     | 87232     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.34     | 721600    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.34     | 87232     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.34     | 78016     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.34     | 41664     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.34     | 36544     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.34     | 47808     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.34     | 27328     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.34     | 32960     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.34     | 118976    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.34     | 94400     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.34     | 108224    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.34     | 256704    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 102080    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 115904    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 118976    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 115904    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 125632    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 117952    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 113344    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 145600    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 100032    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 114880    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.34     | 69312     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.34     | 28352     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.34     | 43712     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.34     | 82112     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.34     | 136896    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.34     | 2155712   | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.34     | 3818688   | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 107712    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 120000    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 124608    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 121024    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 133312    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 121024    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 118464    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 152256    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 105152    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 119488    | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.34     | 66752     | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.34     | 2756288   | 24-Aug-2017 | 17:13 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.34     | 752320    | 24-Aug-2017 | 17:13 | x86      |
| Sharedmemory.dll                                                     | 2014.120.8224.34 | 47296     | 24-Aug-2017 | 17:13 | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 1436328   | 10-Nov-2017 | 00:06  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3742384   | 10-Nov-2017 | 00:03  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3076264   | 10-Nov-2017 | 00:04  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3743912   | 10-Nov-2017 | 00:03  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3647656   | 10-Nov-2017 | 00:04  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 2002600   | 10-Nov-2017 | 00:04  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 1948336   | 10-Nov-2017 | 00:04  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3430576   | 10-Nov-2017 | 00:05  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3442856   | 10-Nov-2017 | 00:05  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 1386160   | 10-Nov-2017 | 00:04  | x64      |
| Sqlevn70.rll                                                         | 2015.130.2216.0  | 3617456   | 10-Nov-2017 | 00:04  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.34 | 4348096   | 24-Aug-2017 | 17:13 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.2216.0     | 79024     | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2216.0     | 567472    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2216.0     | 166064    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2216.0     | 1619632   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 81584     | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 93872     | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 93864     | 10-Nov-2017 | 00:44 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 93872     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 102064    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 93872     | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 93872     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 114352    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 81576     | 10-Nov-2017 | 00:03 | x86      |
| Microsoft.reportingservices.diagnostics.resources.dll     | 13.0.2216.0     | 93872     | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.2216.0     | 657584    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2216.0     | 329904    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2216.0     | 1069744   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532144    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532136    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532144    | 10-Nov-2017 | 00:44 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532144    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532144    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532136    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532136    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532144    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532136    | 10-Nov-2017 | 00:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.2216.0     | 532144    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2216.0     | 161968    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2216.0     | 76464     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2216.0     | 76456     | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2216.0     | 124080    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2216.0     | 104112    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2216.0     | 4910256   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545256   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545768   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545768   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545776   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3546280   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545768   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545776   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3546280   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545264   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.2216.0     | 3545768   | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2216.0     | 9645744   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2216.0     | 92848     | 10-Nov-2017 | 00:04 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2216.0     | 5951152   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2216.0     | 245936    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.2216.0     | 298152    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2216.0     | 207528    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2216.0     | 500912    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2216.0 | 391848    | 10-Nov-2017 | 00:03 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2216.0 | 396976    | 10-Nov-2017 | 00:05 | x86      |
| Msmdlocal.dll                                             | 2015.130.2216.0 | 56110768  | 10-Nov-2017 | 00:05 | x64      |
| Msmdlocal.dll                                             | 2015.130.2216.0 | 37020336  | 10-Nov-2017 | 00:05 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2216.0 | 7499944   | 10-Nov-2017 | 00:05 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2216.0 | 6501544   | 10-Nov-2017 | 00:06 | x86      |
| Msolap130.dll                                             | 2015.130.2216.0 | 8590000   | 10-Nov-2017 | 00:05 | x64      |
| Msolap130.dll                                             | 2015.130.2216.0 | 6967984   | 10-Nov-2017 | 00:05 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.2216.0     | 2516136   | 10-Nov-2017 | 00:05 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2216.0 | 108712    | 10-Nov-2017 | 00:05 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.2216.0 | 114352    | 10-Nov-2017 | 00:06 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.2216.0 | 98992     | 10-Nov-2017 | 00:05 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2216.0     | 2698416   | 10-Nov-2017 | 00:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 863920    | 10-Nov-2017 | 00:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 868016    | 10-Nov-2017 | 00:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 868016    | 10-Nov-2017 | 00:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 868016    | 10-Nov-2017 | 00:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 872104    | 10-Nov-2017 | 00:06 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 868016    | 10-Nov-2017 | 00:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 868016    | 10-Nov-2017 | 00:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 880296    | 10-Nov-2017 | 00:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 863920    | 10-Nov-2017 | 00:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.2216.0     | 868016    | 10-Nov-2017 | 00:04 | x86      |
| Rsconfigtool.exe                                          | 13.0.2216.0     | 1405616   | 10-Nov-2017 | 00:04 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |
| Sqlrsos.dll                                               | 2015.130.2216.0 | 26288     | 10-Nov-2017 | 00:03 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2216.0 | 732848    | 10-Nov-2017 | 00:04 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2216.0 | 584368    | 10-Nov-2017 | 00:05 | x86      |
| Xmsrv.dll                                                 | 2015.130.2216.0 | 24015536  | 10-Nov-2017 | 00:03 | x64      |
| Xmsrv.dll                                                 | 2015.130.2216.0 | 32695984  | 10-Nov-2017 | 00:05 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.2216.0     | 23728     | 10-Nov-2017 | 00:05 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                                | 2015.130.2216.0 | 1311408   | 10-Nov-2017 | 00:04 | x86      |
| Dtaengine.exe                                                | 2015.130.2216.0 | 167088    | 10-Nov-2017 | 00:04 | x86      |
| Dteparse.dll                                                 | 2015.130.2216.0 | 98984     | 10-Nov-2017 | 00:04 | x86      |
| Dteparse.dll                                                 | 2015.130.2216.0 | 109744    | 10-Nov-2017 | 00:05 | x64      |
| Dtepkg.dll                                                   | 2015.130.2216.0 | 115880    | 10-Nov-2017 | 00:04 | x86      |
| Dtepkg.dll                                                   | 2015.130.2216.0 | 137392    | 10-Nov-2017 | 00:05 | x64      |
| Dts.dll                                                      | 2015.130.2216.0 | 2631856   | 10-Nov-2017 | 00:04 | x86      |
| Dts.dll                                                      | 2015.130.2216.0 | 3145392   | 10-Nov-2017 | 00:05 | x64      |
| Dtsconn.dll                                                  | 2015.130.2216.0 | 391856    | 10-Nov-2017 | 00:04 | x86      |
| Dtsconn.dll                                                  | 2015.130.2216.0 | 492208    | 10-Nov-2017 | 00:05 | x64      |
| Dtslog.dll                                                   | 2015.130.2216.0 | 103088    | 10-Nov-2017 | 00:04 | x86      |
| Dtslog.dll                                                   | 2015.130.2216.0 | 120488    | 10-Nov-2017 | 00:05 | x64      |
| Dtspipeline.dll                                              | 2015.130.2216.0 | 1059496   | 10-Nov-2017 | 00:04 | x86      |
| Dtspipeline.dll                                              | 2015.130.2216.0 | 1278128   | 10-Nov-2017 | 00:05 | x64      |
| Dtswizard.exe                                                | 13.0.2216.0     | 895664    | 10-Nov-2017 | 00:04 | x86      |
| Dtswizard.exe                                                | 13.0.2216.0     | 895144    | 10-Nov-2017 | 00:04 | x64      |
| Dtuparse.dll                                                 | 2015.130.2216.0 | 80048     | 10-Nov-2017 | 00:04 | x86      |
| Dtuparse.dll                                                 | 2015.130.2216.0 | 87728     | 10-Nov-2017 | 00:05 | x64      |
| Exceldest.dll                                                | 2015.130.2216.0 | 216240    | 10-Nov-2017 | 00:04 | x86      |
| Exceldest.dll                                                | 2015.130.2216.0 | 263344    | 10-Nov-2017 | 00:05 | x64      |
| Excelsrc.dll                                                 | 2015.130.2216.0 | 232616    | 10-Nov-2017 | 00:04 | x86      |
| Excelsrc.dll                                                 | 2015.130.2216.0 | 285360    | 10-Nov-2017 | 00:05 | x64      |
| Flatfiledest.dll                                             | 2015.130.2216.0 | 334512    | 10-Nov-2017 | 00:04 | x86      |
| Flatfiledest.dll                                             | 2015.130.2216.0 | 389296    | 10-Nov-2017 | 00:05 | x64      |
| Flatfilesrc.dll                                              | 2015.130.2216.0 | 345264    | 10-Nov-2017 | 00:04 | x86      |
| Flatfilesrc.dll                                              | 2015.130.2216.0 | 401584    | 10-Nov-2017 | 00:05 | x64      |
| Microsoft.analysisservices.applocal.core.dll                 | 13.0.2216.0     | 1308840   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.applocal.dll                      | 13.0.2216.0     | 696488    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll              | 13.0.2216.0     | 763568    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.analysisservices.project.dll                       | 2015.130.2216.0 | 2023088   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2216.0     | 432808    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2216.0     | 432816    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2216.0     | 2044080   | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2216.0     | 2044080   | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2216.0     | 33456     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2216.0     | 33448     | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2216.0     | 250032    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2216.0     | 250032    | 10-Nov-2017 | 00:06 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2216.0     | 33960     | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2216.0     | 33968     | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2216.0     | 606384    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2216.0     | 606384    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2216.0     | 445096    | 10-Nov-2017 | 00:04 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2216.0     | 445096    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2216.0 | 150192    | 10-Nov-2017 | 00:03 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2015.130.2216.0 | 138928    | 10-Nov-2017 | 00:05 | x86      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2216.0 | 158896    | 10-Nov-2017 | 00:03 | x64      |
| Microsoft.sqlserver.xevent.dll                               | 2015.130.2216.0 | 144552    | 10-Nov-2017 | 00:05 | x86      |
| Msmdlocal.dll                                                | 2015.130.2216.0 | 56110768  | 10-Nov-2017 | 00:05 | x64      |
| Msmdlocal.dll                                                | 2015.130.2216.0 | 37020336  | 10-Nov-2017 | 00:05 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2216.0 | 7499944   | 10-Nov-2017 | 00:05 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2216.0 | 6501544   | 10-Nov-2017 | 00:06 | x86      |
| Msolap130.dll                                                | 2015.130.2216.0 | 8590000   | 10-Nov-2017 | 00:05 | x64      |
| Msolap130.dll                                                | 2015.130.2216.0 | 6967984   | 10-Nov-2017 | 00:05 | x86      |
| Oledbdest.dll                                                | 2015.130.2216.0 | 264360    | 10-Nov-2017 | 00:05 | x64      |
| Oledbdest.dll                                                | 2015.130.2216.0 | 216752    | 10-Nov-2017 | 00:05 | x86      |
| Oledbsrc.dll                                                 | 2015.130.2216.0 | 290984    | 10-Nov-2017 | 00:05 | x64      |
| Oledbsrc.dll                                                 | 2015.130.2216.0 | 235696    | 10-Nov-2017 | 00:05 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2216.0 | 100528    | 10-Nov-2017 | 00:05 | x64      |
| Txdataconvert.dll                                            | 2015.130.2216.0 | 296616    | 10-Nov-2017 | 00:03 | x64      |
| Txdataconvert.dll                                            | 2015.130.2216.0 | 255152    | 10-Nov-2017 | 00:05 | x86      |
| Xe.dll                                                       | 2015.130.2216.0 | 558768    | 10-Nov-2017 | 00:04 | x86      |
| Xe.dll                                                       | 2015.130.2216.0 | 626344    | 10-Nov-2017 | 00:04 | x64      |
| Xmsrv.dll                                                    | 2015.130.2216.0 | 24015536  | 10-Nov-2017 | 00:03 | x64      |
| Xmsrv.dll                                                    | 2015.130.2216.0 | 32695984  | 10-Nov-2017 | 00:05 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
