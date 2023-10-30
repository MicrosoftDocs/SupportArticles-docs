---
title: Cumulative update 3 for SQL Server 2016 (KB3205413)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 3 (KB3205413).
ms.date: 10/26/2023
ms.custom: KB3205413
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB3205413 - Cumulative Update 3 for SQL Server 2016

_Release Date:_ &nbsp; November 16, 2016  
_Version:_ &nbsp; 13.0.2186.6

Cumulative Update 3 (CU3) for SQL Server 2016 was also released as a SQL Server Security Bulletin on 11/8/2016, [KB3194717](https://support.microsoft.com/help/3194717). Please see [MS16-136](/security-updates/SecurityBulletins/2016/ms16-136) for details. As a result of this, you may already have CU3 installed as part of that security bulletin release and installation of this CU is unnecessary. If you do attempt to install CU3 after MS16-136, you may receive the following message:

> There are no SQL Server instances or shared features that can be updated on this computer

> [!NOTE]
> This message indicates that CU3 is already installed and no further action is required.

> [!NOTE]
> The package name for CU3 (*SQLServer2016-KB3194717-x64.exe*) contains the security update MS16-136 KB number (3194717), not the CU3 KB number (3205413). This can be ignored as a single package services both release channels.

This article describes cumulative update package 3 (build number: **13.0.2186.6**) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=8198035>[8198035](#8198035)</a> | [FIX: Canceling a query takes a long time in a Tabular instance of SQL Server 2014 or 2016 Analysis Services (KB3180263)](https://support.microsoft.com/help/3180263) | Analysis Services |
| <a id=8198038>[8198038](#8198038)</a> | [SQL Server Analysis Services crashes when you have multiple roles and run a CREATE SESSION CUBE statement in SQL Server (KB3181260)](https://support.microsoft.com/help/3181260) | Analysis Services |
| <a id=8490536>[8490536](#8490536)</a> | [FIX: Exception occurs during parallel processing of partitions if a column is re-encoded in SQL Server 2016 (KB3196100)](https://support.microsoft.com/help/3196100) | Analysis Services |
| <a id=8492066>[8492066](#8492066)</a> | [FIX: Performance issues caused by continuous growth of memory in SQL Server 2016 Analysis Services (KB3196102)](https://support.microsoft.com/help/3196102) | Analysis Services |
| <a id=8532319>[8532319](#8532319)</a> | [FIX: Time-out error when you process multiple partitions in parallel in SQL Server 2016 Analysis Services (Tabular model) (KB3197758)](https://support.microsoft.com/help/3197758) | Analysis Services |
| <a id=8462663>[8462663](#8462663)</a> | FIX: Error when you process a calculated column in a table with multiple partitions (KB3197817) | Analysis Services |
| <a id=8306655>[8306655](#8306655)</a> | Improvements to Master Data Services (MDS) API to validate user input and return values. | Data Quality Services (DQS) |
| <a id=8463728>[8463728](#8463728)</a> | [FIX: An assertion occurs when you use parallel redo in a secondary replica of a SQL Server AlwaysOn Availability Group (KB3200975)](https://support.microsoft.com/help/3200975) | High Availability |
| <a id=8463843>[8463843](#8463843)</a> | [FIX: Rolling upgrade for an AlwaysOn replica or a database mirroring instance fails after Cumulative Update 1 for SQL Server 2016 is installed (KB3197893)](https://support.microsoft.com/help/3197893) | High Availability |
| <a id=8635182>[8635182](#8635182)</a> | [FIX: Error 19432 and time-out errors when you use SQL Server 2016 AlwaysOn Availability Groups (KB3198760)](https://support.microsoft.com/help/3198760) | High Availability |
| <a id=8635198>[8635198](#8635198)</a> | [FIX: Error 19432 is logged after you upgrade Availability replicas in an Always On Availability Group to Cumulative Update 1 for SQL Server 2016 (KB3198766)](https://support.microsoft.com/help/3198766) | High Availability |
| <a id=8528554>[8528554](#8528554)</a> | [FIX: SQL Server 2016 hangs when you restore databases that contain memory-optimized tables (KB3197605)](https://support.microsoft.com/help/3197605) | In-Memory OLTP |
| <a id=7709909>[7709909](#7709909)</a> | FIX: SQL Server crashes when you commit a Hekaton transaction after a native procedure is dropped (KB3172956) | In-Memory OLTP |
| <a id=7831313>[7831313](#7831313)</a> | Fixes an access violation when using nested procedure calls in natively compiled modules (In-memory OLTP) that use LOB output parameters. | In-Memory OLTP |
| <a id=7855166>[7855166](#7855166)</a> | [FIX: SQL Server Managed Backup to Windows Azure tries to back up database snapshots in SQL Server (KB3168708)](https://support.microsoft.com/help/3168708) | Management Tools |
| <a id=8254314>[8254314](#8254314)</a> | [Version copy fails when entity contains collections but not consolidated members in SQL Server 2016 MDS (KB3188150)](https://support.microsoft.com/help/3188150) | Master Data Services (MDS) |
| <a id=8254369>[8254369](#8254369)</a> | [FIX: It takes a very long time to purge lots of members from an entity in SQL Server 2016 Master Data Services (KB3188153)](https://support.microsoft.com/help/3188153) | MDS |
| <a id=8254378>[8254378](#8254378)</a> | [Functional area permissions are lost after you upgrade to SQL Server 2016 Master Data Services (KB3188157)](https://support.microsoft.com/help/3188157) | MDS |
| <a id=8254390>[8254390](#8254390)</a> | [FIX: Filter and Change Tracking settings are removed after you change a domain-based attribute in SQL Server 2016 Master Data Services (KB3188158)](https://support.microsoft.com/help/3188158) | MDS |
| <a id=8254410>[8254410](#8254410)</a> | [Can't filter attributes when you use the SQL Server 2016 Master Data Services Add-in on a non-English version of Excel (KB3188154)](https://support.microsoft.com/help/3188154) | MDS |
| <a id=8254419>[8254419](#8254419)</a> | [FIX: Can't add new explicit hierarchies after you delete all the existing explicit hierarchies from an entity in SQL Server 2016 Master Data Services (KB3188160)](https://support.microsoft.com/help/3188160) | MDS |
| <a id=8198006>[8198006](#8198006)</a> | [Reporting Services counter is missing from Windows Performance Monitor after you install SQL Server 2014 SP1 CU6 (KB3171681)](https://support.microsoft.com/help/3171681) | Reporting Services |
| <a id=8518928>[8518928](#8518928)</a> | [FIX: SQL Server 2016 Reporting Services keeps cycling on trying to unload application domains when Report Server is configured on a Network Load Balancing Cluster (KB3197403)](https://support.microsoft.com/help/3197403) | Reporting Services |
| <a id=8208301>[8208301](#8208301)</a> | FIX: The user interface of SSRS 2016 mobile report contains multiple minimal display issues (KB3190222) | Reporting Services |
| <a id=8259797>[8259797](#8259797)</a> | [FIX: SQL Server 2016 Query Optimizer incorrectly adds a SORT operator if a partitioned table only contains a single partition (KB3198775)](https://support.microsoft.com/help/3198775) | SQL performance |
| <a id=8296902>[8296902](#8296902)</a> | [FIX: Intermittent non-yielding conditions, performance problems and intermittent connectivity failures in SQL Server 2016 (KB3189855)](https://support.microsoft.com/help/3189855) | SQL performance |
| <a id=8464882>[8464882](#8464882)</a> | [FIX: Performance regression in the expression service during numeric arithmetic operations in SQL Server 2016 (KB3197952)](https://support.microsoft.com/help/3197952) | SQL performance |
| <a id=8667863>[8667863](#8667863)</a> | FIX: Poor performance occurs during a table scan when a query is used that filters non-Primary Key columns on in-memory history tables (KB3198846) | SQL performance |
| <a id=8346967>[8346967](#8346967)</a> | [FIX: Queries that use CHANGETABLE use much more CPU in SQL Server 2014 SP1 or in SQL Server 2016 (KB3180060)](https://support.microsoft.com/help/3180060) | SQL service |
| <a id=8442115>[8442115](#8442115)</a> | [FIX: Error 976 occurs when you run the DBCC CHECKDB command on an unreadable secondary replica of SQL Server 2016 Availability Group (KB3194923)](https://support.microsoft.com/help/3194923) | SQL service |
| <a id=8494882>[8494882](#8494882)</a> | [FIX: SQL Server 2016 crashes when a Tuple Mover task is ended unexpectedly (KB3195901)](https://support.microsoft.com/help/3195901) | SQL service |
| <a id=8527150>[8527150](#8527150)</a> | [FIX: Heap scan may cause high PAGEIOLATCH_SH waits in SQL Server 2016 (KB3197589)](https://support.microsoft.com/help/3197589) | SQL service |
| <a id=8575761>[8575761](#8575761)</a> | [Poor performance when you run INSERT.. SELECT operations in SQL Server 2016 (KB3180087)](https://support.microsoft.com/help/3180087) | SQL service |

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
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

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

x64-based versions

SQL Server 2016 Business Intelligence Development Studio

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlsqm_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlboot.dll           | 2015.130.2186.6 | 186560    | 01-Nov-16 | 02:19 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 Analysis Services

|                   File name                   |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll    | 13.0.2186.6     | 1343680   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2186.6     | 765640    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 15-Jun-16 | 20:47 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 15-Jun-16 | 20:47 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 15-Jun-16 | 12:27 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 15-Jun-16 | 20:47 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 15-Jun-16 | 20:47 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 15-Jun-16 | 12:27 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 15-Jun-16 | 20:47 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 12:27 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 20:47 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 12:27 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 20:47 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 15-Jun-16 | 20:47 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 15-Jun-16 | 12:27 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 15-Jun-16 | 20:47 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 15-Jun-16 | 20:47 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 15-Jun-16 | 12:27 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 15-Jun-16 | 20:47 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 15-Jun-16 | 12:27 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 15-Jun-16 | 20:47 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 15-Jun-16 | 20:47 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 15-Jun-16 | 12:27 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 15-Jun-16 | 20:47 | x86      |
| Msmdlocal.dll                                 | 2015.130.2186.6 | 37014216  | 01-Nov-16 | 02:17 | x86      |
| Msmdlocal.dll                                 | 2015.130.2186.6 | 56081096  | 01-Nov-16 | 02:19 | x64      |
| Msmdsrv.exe                                   | 2015.130.2186.6 | 56626376  | 01-Nov-16 | 02:17 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2186.6 | 7500480   | 01-Nov-16 | 02:18 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2186.6 | 6501576   | 01-Nov-16 | 02:18 | x86      |
| Msolap130.dll                                 | 2015.130.2186.6 | 6968000   | 01-Nov-16 | 02:17 | x86      |
| Msolap130.dll                                 | 2015.130.2186.6 | 8590016   | 01-Nov-16 | 02:19 | x64      |
| Sql_as_keyfile.dll                            | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |
| Sqlboot.dll                                   | 2015.130.2186.6 | 186560    | 01-Nov-16 | 02:19 | x64      |
| Sqlceip.exe                                   | 13.0.2186.6     | 242880    | 01-Nov-16 | 02:18 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 15-Jun-16 | 12:27 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 15-Jun-16 | 20:47 | x86      |
| Tmapi.dll                                     | 2015.130.2186.6 | 4344520   | 01-Nov-16 | 02:18 | x64      |
| Tmcachemgr.dll                                | 2015.130.2186.6 | 2825408   | 01-Nov-16 | 02:18 | x64      |
| Tmpersistence.dll                             | 2015.130.2186.6 | 1069760   | 01-Nov-16 | 02:18 | x64      |
| Tmtransactions.dll                            | 2015.130.2186.6 | 1349832   | 01-Nov-16 | 02:18 | x64      |
| Xmsrv.dll                                     | 2015.130.2186.6 | 32693952  | 01-Nov-16 | 02:18 | x86      |
| Xmsrv.dll                                     | 2015.130.2186.6 | 24013000  | 01-Nov-16 | 02:18 | x64      |

SQL Server 2016 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2186.6     | 1023168   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2186.6     | 1023176   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2186.6     | 1344200   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2186.6     | 702664    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2186.6     | 765632    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2186.6     | 707272    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2186.6     | 707272    | 01-Nov-16 | 02:18 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2186.6  | 473280    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2186.6  | 473280    | 01-Nov-16 | 02:18 | x86      |

SQL Server 2016 Database Services Core Instance

|             File name            |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Hadrres.dll                      | 2015.130.2186.6 | 177864    | 01-Nov-16 | 02:18 | x64      |
| Hkcompile.dll                    | 2015.130.2186.6 | 1297600   | 01-Nov-16 | 02:18 | x64      |
| Hkengine.dll                     | 2015.130.2186.6 | 5597896   | 01-Nov-16 | 02:17 | x64      |
| Hkruntime.dll                    | 2015.130.2186.6 | 158912    | 01-Nov-16 | 02:17 | x64      |
| Qds.dll                          | 2015.130.2186.6 | 844480    | 01-Nov-16 | 02:19 | x64      |
| Rsfxft.dll                       | 2015.130.2186.6 | 34504     | 01-Nov-16 | 02:18 | x64      |
| Sql_engine_core_inst_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |
| Sqlaccess.dll                    | 2015.130.2186.6 | 461512    | 01-Nov-16 | 02:18 | x64      |
| Sqlagent.exe                     | 2015.130.2186.6 | 565960    | 01-Nov-16 | 02:17 | x64      |
| Sqlboot.dll                      | 2015.130.2186.6 | 186560    | 01-Nov-16 | 02:19 | x64      |
| Sqlceip.exe                      | 13.0.2186.6     | 242880    | 01-Nov-16 | 02:18 | x86      |
| Sqldk.dll                        | 2015.130.2186.6 | 2583232   | 01-Nov-16 | 02:19 | x64      |
| Sqllang.dll                      | 2015.130.2186.6 | 39304384  | 01-Nov-16 | 02:19 | x64      |
| Sqlmin.dll                       | 2015.130.2186.6 | 37330632  | 01-Nov-16 | 02:18 | x64      |
| Sqlos.dll                        | 2015.130.2186.6 | 26312     | 01-Nov-16 | 02:18 | x64      |
| Sqlscriptdowngrade.dll           | 2015.130.2186.6 | 27840     | 01-Nov-16 | 02:18 | x64      |
| Sqlscriptupgrade.dll             | 2015.130.2186.6 | 5797056   | 01-Nov-16 | 02:19 | x64      |
| Sqlserverspatial130.dll          | 2015.130.2186.6 | 732872    | 01-Nov-16 | 02:18 | x64      |
| Sqlservr.exe                     | 2015.130.2186.6 | 392904    | 01-Nov-16 | 02:17 | x64      |
| Sqltses.dll                      | 2015.130.2186.6 | 8896704   | 01-Nov-16 | 02:18 | x64      |

SQL Server 2016 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2186.6 | 3145416   | 01-Nov-16 | 02:19 | x64      |
| Dtspipeline.dll                                              | 2015.130.2186.6 | 1278144   | 01-Nov-16 | 02:19 | x64      |
| Dtswizard.exe                                                | 13.0.2186.6     | 895176    | 01-Nov-16 | 02:18 | x64      |
| Logread.exe                                                  | 2015.130.2186.6 | 616640    | 01-Nov-16 | 02:17 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2186.6     | 33992     | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2186.6     | 606408    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2186.6     | 445128    | 01-Nov-16 | 02:17 | x86      |
| Repldp.dll                                                   | 2015.130.2186.6 | 276168    | 01-Nov-16 | 02:19 | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.2186.6 | 1012936   | 01-Nov-16 | 02:19 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |
| Sqlsatellite.dll              | 2015.130.2186.6 | 836808    | 01-Nov-16 | 02:18 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 23-Apr-15 | 02:50 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 23-Apr-15 | 02:50 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 23-Apr-15 | 02:50 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 23-Apr-15 | 02:50 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.2186.6     | 23752     | 01-Nov-16 | 02:18 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                       | 2015.130.2186.6 | 2631872   | 01-Nov-16 | 02:19 | x86      |
| Dts.dll                                                       | 2015.130.2186.6 | 3145416   | 01-Nov-16 | 02:19 | x64      |
| Dtspipeline.dll                                               | 2015.130.2186.6 | 1059520   | 01-Nov-16 | 02:19 | x86      |
| Dtspipeline.dll                                               | 2015.130.2186.6 | 1278144   | 01-Nov-16 | 02:19 | x64      |
| Dtswizard.exe                                                 | 13.0.2186.6     | 895680    | 01-Nov-16 | 02:18 | x86      |
| Dtswizard.exe                                                 | 13.0.2186.6     | 895176    | 01-Nov-16 | 02:18 | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2186.6     | 469704    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2186.6     | 469704    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2186.6     | 33984     | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2186.6     | 33992     | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2186.6     | 606400    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2186.6     | 606408    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2186.6     | 445120    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2186.6     | 445128    | 01-Nov-16 | 02:17 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2186.6     | 216776    | 01-Nov-16 | 02:18 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |
| Sqlceip.exe                                                   | 13.0.2186.6     | 242880    | 01-Nov-16 | 02:18 | x86      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.authorization.dll             | 13.0.2186.6     | 79040     | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2186.6     | 567488    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2186.6     | 166080    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2186.6     | 1620672   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2186.6     | 329416    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2186.6     | 1069248   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2186.6     | 161984    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2186.6     | 76480     | 01-Nov-16 | 02:17 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2186.6     | 76480     | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2186.6     | 122568    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2186.6     | 104136    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2186.6     | 4904136   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2186.6     | 9644224   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2186.6     | 92864     | 01-Nov-16 | 02:18 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2186.6     | 5951176   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2186.6     | 245952    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2186.6     | 207552    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2186.6     | 500936    | 01-Nov-16 | 02:18 | x86      |
| Msmdlocal.dll                                             | 2015.130.2186.6 | 37014216  | 01-Nov-16 | 02:17 | x86      |
| Msmdlocal.dll                                             | 2015.130.2186.6 | 56081096  | 01-Nov-16 | 02:19 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2186.6 | 7500480   | 01-Nov-16 | 02:18 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2186.6 | 6501576   | 01-Nov-16 | 02:18 | x86      |
| Msolap130.dll                                             | 2015.130.2186.6 | 6968000   | 01-Nov-16 | 02:17 | x86      |
| Msolap130.dll                                             | 2015.130.2186.6 | 8590016   | 01-Nov-16 | 02:19 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.2186.6     | 2518208   | 01-Nov-16 | 02:18 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2186.6 | 108736    | 01-Nov-16 | 02:18 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.2186.6 | 114376    | 01-Nov-16 | 02:18 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.2186.6 | 99016     | 01-Nov-16 | 02:18 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2186.6     | 2697928   | 01-Nov-16 | 02:18 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2186.6 | 584384    | 01-Nov-16 | 02:17 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.2186.6 | 732872    | 01-Nov-16 | 02:18 | x64      |
| Xmsrv.dll                                                 | 2015.130.2186.6 | 32693952  | 01-Nov-16 | 02:18 | x86      |
| Xmsrv.dll                                                 | 2015.130.2186.6 | 24013000  | 01-Nov-16 | 02:18 | x64      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.2186.6     | 23752     | 01-Nov-16 | 02:18 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |

SQL Server 2016 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2186.6 | 2631872   | 01-Nov-16 | 02:19 | x86      |
| Dts.dll                                                      | 2015.130.2186.6 | 3145416   | 01-Nov-16 | 02:19 | x64      |
| Dtspipeline.dll                                              | 2015.130.2186.6 | 1059520   | 01-Nov-16 | 02:19 | x86      |
| Dtspipeline.dll                                              | 2015.130.2186.6 | 1278144   | 01-Nov-16 | 02:19 | x64      |
| Dtswizard.exe                                                | 13.0.2186.6     | 895680    | 01-Nov-16 | 02:18 | x86      |
| Dtswizard.exe                                                | 13.0.2186.6     | 895176    | 01-Nov-16 | 02:18 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2186.6     | 432832    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2186.6     | 432832    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2186.6     | 2043592   | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2186.6     | 2043592   | 01-Nov-16 | 02:18 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2186.6     | 250048    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2186.6     | 250048    | 01-Nov-16 | 02:18 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2186.6     | 33984     | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2186.6     | 33992     | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2186.6     | 606400    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2186.6     | 606408    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2186.6     | 445120    | 01-Nov-16 | 02:17 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2186.6     | 445128    | 01-Nov-16 | 02:17 | x86      |
| Msmdlocal.dll                                                | 2015.130.2186.6 | 37014216  | 01-Nov-16 | 02:17 | x86      |
| Msmdlocal.dll                                                | 2015.130.2186.6 | 56081096  | 01-Nov-16 | 02:19 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2186.6 | 7500480   | 01-Nov-16 | 02:18 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2186.6 | 6501576   | 01-Nov-16 | 02:18 | x86      |
| Msolap130.dll                                                | 2015.130.2186.6 | 6968000   | 01-Nov-16 | 02:17 | x86      |
| Msolap130.dll                                                | 2015.130.2186.6 | 8590016   | 01-Nov-16 | 02:19 | x64      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2186.6 | 100544    | 01-Nov-16 | 02:19 | x64      |
| Xmsrv.dll                                                    | 2015.130.2186.6 | 32693952  | 01-Nov-16 | 02:18 | x86      |
| Xmsrv.dll                                                    | 2015.130.2186.6 | 24013000  | 01-Nov-16 | 02:18 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
