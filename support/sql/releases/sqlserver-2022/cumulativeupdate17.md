---
title: Cumulative update 17 for SQL Server 2022 (KB5048038)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 17 (KB5048038).
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5048038
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5048038 - Cumulative Update 17 for SQL Server 2022

_Release Date:_ &nbsp; January 16, 2025  
_Version:_ &nbsp; 16.0.4175.1

## Summary

This article describes Cumulative Update package 17 (CU17) for Microsoft SQL Server 2022. This update contains 13 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 16 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4175.1**, file version: **2022.160.4175.1**
- Analysis Services - Product version: **16.0.43.239**, file version: **2022.160.43.239**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|----------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=3666640>[3666640](#3666640) </a> | Fixes an issue with the business rule item for the domain-based attribute (DBA) option when you use Master Data Services.| Master Data Services | Master Data Services| Windows|
| <a id=3560259>[3560259](#3560259) </a> | Fixes an issue in which some availability group (AG) databases are in a non-synchronized state after the Windows Server Failover Clustering (WSFC) quorum loss. After applying the fix, the databases should be able to switch to a resolving state when the persisted configuration data can't be read because of the WSFC quorum loss. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3615657>[3615657](#3615657) </a> | Adds trace flag 3478 in SQL Server 2022 to allow the maximum number of parallel redo threads to be increased based on the total number of CPUs. This change aims to restore the same functionality as SQL Server 2016 or later versions if the thread pool is disabled in SQL Server 2022. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3677296>[3677296](#3677296) </a> | Starting in SQL Server 2022 CU17, you can enable Always On availability groups by using a Pacemaker cluster when SQL Server runs as a restricted application with Security-Enhanced Linux (SELinux) enabled. | SQL Server Engine| High Availability and Disaster Recovery | Linux|
| <a id=3086691>[3086691](#3086691) </a> | Adds a server configuration option `external xtp dll gen util enabled`, which is configured by using `sp_configure` to enable the Hekaton dynamic-link library (DLL) Generator component for the Hekaton (In-Memory OLTP) feature. </br></br>SQL Server compiles and links a DLL for each native compiled table and stored procedure, which contains the native implementation of those objects in C code. Although the Hekaton DLLs are dynamically generated, the files themselves might present some challenges when there's a compliance requirement that enforces code integrity as a criterion. </br></br>With the introduction of the Hekaton DLL Generator component for the Hekaton (In-Memory OLTP) feature, regulatory compliance requirements such as [code integrity](/azure/security/fundamentals/code-integrity#code-integrity-as-an-authorization-gate) can be met with Hekaton-generated DLLs. In this case, code integrity ensures that the Hekaton-generated DLLs remain intact and unmodified from the time they're created until they're loaded and executed. | SQL Server Engine| In-Memory OLTP| Windows|
| <a id=3677980>[3677980](#3677980) </a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581)| SQL Server Engine| Programmability | All|
| <a id=3653362>[3653362](#3653362) </a> | Fixes a performance issue of the SUBSTRING function that you encounter when extensively using the function, such as building indexes on computed columns with expressions that involve calling SUBSTRING. | SQL Server Engine| Programmability | All|
| <a id=3572259>[3572259](#3572259) </a> | Fixes error "The XML data type is damaged" thrown by the Replication Log Reader Agent when you update an XML column with XML compression enabled.| SQL Server Engine| Replication | Windows|
| <a id=3445709>[3445709](#3445709) </a></br><a id=3538141>[3538141](#3538141) </a></br><a id=3686639>[3686639](#3686639) </a> | [Improvement: Microsoft Entra managed identity support for backup and restore database operations and for EKM with AKV in SQL Server on Azure VMs (KB5043526)](microsoft-entra-managed-identity-support-for-backup-restore-database-ekm-akv.md) | SQL Server Engine| Security Infrastructure | Windows |
| <a id=3514753>[3514753](#3514753) </a> | Fixes various assertion failures (for example, Location: sosmerge.cpp:2930; Expression: mrP->mrpgcnt > 0) that you might encounter when building an index in simple or bulk-logged recovery models with indirect checkpoints because of missing flushes of intermediate data pages.| SQL Server Engine| SQL OS| All|
| <a id=3616559>[3616559](#3616559) </a> | Fixes a performance issue that you might encounter only when `sp_lock` is called frequently from multiple connections, which might cause a memory leak. The memory isn't cleaned up until you restart the SQL Server service. </br></br>**Note**: You need to turn on trace flag 15915.| SQL Server Engine| Transaction Services| All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always offer the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU17 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5048038)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5048038-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5048038-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5048038-x64.exe| 1B3F57691F8A7B9950CB1F05EAF18E87B3275378FF6A0386E6A017E1543A7880   |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 13-Dec-2024 | 09:53 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.239 | 336944    | 13-Dec-2024 | 09:53 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.239     | 865216    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.239     | 2903640   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 13-Dec-2024 | 09:53 | x86      |
| Msmdctr.dll                                         | 2022.160.43.239 | 38984     | 13-Dec-2024 | 09:53 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.239 | 71818808  | 13-Dec-2024 | 09:53 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.239 | 53975640  | 13-Dec-2024 | 09:53 | x86      |
| Msmdpump.dll                                        | 2022.160.43.239 | 10333632  | 13-Dec-2024 | 09:53 | x64      |
| Msmdredir.dll                                       | 2022.160.43.239 | 8132032   | 13-Dec-2024 | 09:53 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.239 | 71365704  | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 956880    | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1884720   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1671728   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1881160   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1848272   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1147440   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1140272   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1769520   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1749064   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 932912    | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1837616   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 955464    | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1882576   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1668544   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1876552   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1844808   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1145416   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1138640   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1765456   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1745480   | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 933448    | 13-Dec-2024 | 09:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1833032   | 13-Dec-2024 | 09:53 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.239 | 10083400  | 13-Dec-2024 | 09:53 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.239 | 8265264   | 13-Dec-2024 | 09:53 | x86      |
| Msolap.dll                                          | 2022.160.43.239 | 10969648  | 13-Dec-2024 | 09:53 | x64      |
| Msolap.dll                                          | 2022.160.43.239 | 8744024   | 13-Dec-2024 | 09:53 | x86      |
| Msolui.dll                                          | 2022.160.43.239 | 308176    | 13-Dec-2024 | 09:53 | x64      |
| Msolui.dll                                          | 2022.160.43.239 | 289832    | 13-Dec-2024 | 09:53 | x86      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 13-Dec-2024 | 09:53 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 13-Dec-2024 | 09:53 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 13-Dec-2024 | 09:53 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 13-Dec-2024 | 09:53 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 13-Dec-2024 | 09:53 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 13-Dec-2024 | 09:53 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Sqlceip.exe                                         | 16.0.4175.1     | 301112    | 13-Dec-2024 | 09:53 | x86      |
| Sqldumper.exe                                       | 2022.160.4175.1 | 448552    | 13-Dec-2024 | 09:53 | x64      |
| Sqldumper.exe                                       | 2022.160.4175.1 | 378960    | 13-Dec-2024 | 09:53 | x86      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 13-Dec-2024 | 09:53 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 13-Dec-2024 | 09:53 | x86      |
| Tmapi.dll                                           | 2022.160.43.239 | 5884504   | 13-Dec-2024 | 09:53 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.239 | 5575224   | 13-Dec-2024 | 09:53 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.239 | 1481288   | 13-Dec-2024 | 09:53 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.239 | 7198296   | 13-Dec-2024 | 09:53 | x64      |
| Xmsrv.dll                                           | 2022.160.43.239 | 26593328  | 13-Dec-2024 | 09:53 | x64      |
| Xmsrv.dll                                           | 2022.160.43.239 | 35895760  | 13-Dec-2024 | 09:53 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4175.1 | 104504    | 13-Dec-2024 | 09:53 | x64      |
| Instapi150.dll                             | 2022.160.4175.1 | 79944     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.239     | 2633776   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.239     | 2633800   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.239     | 2933328   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.239     | 2323528   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4175.1 | 104528    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4175.1 | 92200     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4175.1     | 555048    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4175.1     | 555064    | 13-Dec-2024 | 09:53 | x86      |
| Msasxpress.dll                             | 2022.160.43.239 | 27720     | 13-Dec-2024 | 09:53 | x86      |
| Msasxpress.dll                             | 2022.160.43.239 | 32816     | 13-Dec-2024 | 09:53 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Sqldumper.exe                              | 2022.160.4175.1 | 378960    | 13-Dec-2024 | 09:53 | x86      |
| Sqldumper.exe                              | 2022.160.4175.1 | 448552    | 13-Dec-2024 | 09:53 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4175.1 | 395304    | 13-Dec-2024 | 09:53 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4175.1 | 456776    | 13-Dec-2024 | 09:53 | x64      |
| Sqlsvcsync.dll                             | 2022.160.4175.1 | 280648    | 13-Dec-2024 | 09:53 | x86      |
| Sqlsvcsync.dll                             | 2022.160.4175.1 | 362536    | 13-Dec-2024 | 09:53 | x64      |
| Svrenumapi150.dll                          | 2022.160.4175.1 | 1247296   | 13-Dec-2024 | 09:53 | x64      |
| Svrenumapi150.dll                          | 2022.160.4175.1 | 972856    | 13-Dec-2024 | 09:53 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4175.1     | 309328    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4175.1     | 2070592   | 13-Dec-2024 | 09:53 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |

SQL Server 2022 Data Quality

|           File name           | File version | File size |     Date    |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 16.0.4175.1  | 469072    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.cleansing.dll | 16.0.4175.1  | 469064    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.core.dll      | 16.0.4175.1  | 600104    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.core.dll      | 16.0.4175.1  | 600128    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.dll           | 16.0.4175.1  | 174120    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.dll           | 16.0.4175.1  | 174152    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.infra.dll     | 16.0.4175.1  | 1857592   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.infra.dll     | 16.0.4175.1  | 1857592   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.proxy.dll     | 16.0.4175.1  | 370768    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.ssdqs.proxy.dll     | 16.0.4175.1  | 370728    | 13-Dec-2024 | 09:53 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 13-Dec-2024 | 10:38 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 13-Dec-2024 | 10:38 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4175.1 | 5994576   | 13-Dec-2024 | 10:38 | x64      |
| Aetm-enclave.dll                             | 2022.160.4175.1 | 5959696   | 13-Dec-2024 | 10:38 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4175.1 | 6194800   | 13-Dec-2024 | 10:38 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4175.1 | 6160680   | 13-Dec-2024 | 10:38 | x64      |
| Dcexec.exe                                   | 2022.160.4175.1 | 96336     | 13-Dec-2024 | 10:38 | x64      |
| Fssres.dll                                   | 2022.160.4175.1 | 100416    | 13-Dec-2024 | 10:38 | x64      |
| Hadrres.dll                                  | 2022.160.4175.1 | 227336    | 13-Dec-2024 | 10:38 | x64      |
| Hkcompile.dll                                | 2022.160.4175.1 | 1427520   | 13-Dec-2024 | 10:38 | x64      |
| Hkdllgen.exe                                 | 2022.160.4175.1 | 1570856   | 13-Dec-2024 | 10:38 | x64      |
| Hkengine.dll                                 | 2022.160.4175.1 | 5769272   | 13-Dec-2024 | 10:38 | x64      |
| Hkruntime.dll                                | 2022.160.4175.1 | 190520    | 13-Dec-2024 | 10:38 | x64      |
| Hktempdb.dll                                 | 2022.160.4175.1 | 71736     | 13-Dec-2024 | 10:38 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.239     | 2322504   | 13-Dec-2024 | 10:38 | x86      |
| Microsoft.sqlserver.xe.core.dll              | 2022.160.4175.1 | 84032     | 13-Dec-2024 | 10:38 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4175.1 | 182312    | 13-Dec-2024 | 10:38 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2022.160.4175.1 | 198736    | 13-Dec-2024 | 10:38 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4175.1 | 333880    | 13-Dec-2024 | 10:38 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4175.1 | 96312     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 30760     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 38968     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 34856     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 38952     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 38952     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 30760     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 30776     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 34856     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 38968     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 30776     | 13-Dec-2024 | 10:38 | x64      |
| Odsole70.rll                                 | 16.0.4175.1     | 38952     | 13-Dec-2024 | 10:38 | x64      |
| Qds.dll                                      | 2022.160.4175.1 | 1808424   | 13-Dec-2024 | 10:38 | x64      |
| Rsfxft.dll                                   | 2022.160.4175.1 | 55368     | 13-Dec-2024 | 10:38 | x64      |
| Secforwarder.dll                             | 2022.160.4175.1 | 84024     | 13-Dec-2024 | 10:38 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 10:38 | x64      |
| Sqlaamss.dll                                 | 2022.160.4175.1 | 120904    | 13-Dec-2024 | 10:38 | x64      |
| Sqlaccess.dll                                | 2022.160.4175.1 | 444480    | 13-Dec-2024 | 10:38 | x64      |
| Sqlagent.exe                                 | 2022.160.4175.1 | 722984    | 13-Dec-2024 | 10:38 | x64      |
| Sqlceip.exe                                  | 16.0.4175.1     | 301112    | 13-Dec-2024 | 10:38 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4175.1 | 104488    | 13-Dec-2024 | 10:38 | x64      |
| Sqlctr160.dll                                | 2022.160.4175.1 | 157752    | 13-Dec-2024 | 10:38 | x64      |
| Sqlctr160.dll                                | 2022.160.4175.1 | 129064    | 13-Dec-2024 | 10:38 | x86      |
| Sqldk.dll                                    | 2022.160.4175.1 | 4020240   | 13-Dec-2024 | 10:38 | x64      |
| Sqldtsss.dll                                 | 2022.160.4175.1 | 120888    | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 1759312   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 3872808   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4089912   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4605992   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4737080   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 3774504   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 3962920   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4601896   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4429888   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4503592   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 2459728   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 2402344   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4286528   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 3921960   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4442168   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4233256   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4216872   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 3999816   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 3876904   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 1697832   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4327464   | 13-Dec-2024 | 10:38 | x64      |
| Sqlevn70.rll                                 | 2022.160.4175.1 | 4470824   | 13-Dec-2024 | 10:38 | x64      |
| Sqliosim.com                                 | 2022.160.4175.1 | 387128    | 13-Dec-2024 | 10:38 | x64      |
| Sqliosim.exe                                 | 2022.160.4175.1 | 3057704   | 13-Dec-2024 | 10:38 | x64      |
| Sqllang.dll                                  | 2022.160.4175.1 | 48953424  | 13-Dec-2024 | 10:38 | x64      |
| Sqlmin.dll                                   | 2022.160.4175.1 | 51288120  | 13-Dec-2024 | 10:38 | x64      |
| Sqlolapss.dll                                | 2022.160.4175.1 | 116776    | 13-Dec-2024 | 10:38 | x64      |
| Sqlos.dll                                    | 2022.160.4175.1 | 51256     | 13-Dec-2024 | 10:38 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4175.1 | 100392    | 13-Dec-2024 | 10:38 | x64      |
| Sqlrepss.dll                                 | 2022.160.4175.1 | 145464    | 13-Dec-2024 | 10:38 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4175.1 | 51256     | 13-Dec-2024 | 10:38 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4175.1 | 5834808   | 13-Dec-2024 | 10:38 | x64      |
| Sqlservr.exe                                 | 2022.160.4175.1 | 723000    | 13-Dec-2024 | 10:38 | x64      |
| Sqlsvc.dll                                   | 2022.160.4175.1 | 194624    | 13-Dec-2024 | 10:38 | x64      |
| Sqltses.dll                                  | 2022.160.4175.1 | 10668088  | 13-Dec-2024 | 10:38 | x64      |
| Sqsrvres.dll                                 | 2022.160.4175.1 | 305232    | 13-Dec-2024 | 10:38 | x64      |
| Svl.dll                                      | 2022.160.4175.1 | 247872    | 13-Dec-2024 | 10:38 | x64      |
| Xe.dll                                       | 2022.160.4175.1 | 718904    | 13-Dec-2024 | 10:38 | x64      |
| Xpqueue.dll                                  | 2022.160.4175.1 | 100432    | 13-Dec-2024 | 10:38 | x64      |
| Xpstar.dll                                   | 2022.160.4175.1 | 534584    | 13-Dec-2024 | 10:38 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 13-Dec-2024 | 09:53 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 13-Dec-2024 | 09:53 | x86      |
| Bcp.exe                                              | 2022.160.4175.1  | 141376    | 13-Dec-2024 | 09:53 | x64      |
| Commanddest.dll                                      | 2022.160.4175.1  | 272424    | 13-Dec-2024 | 09:53 | x64      |
| Datacollectortasks.dll                               | 2022.160.4175.1  | 227344    | 13-Dec-2024 | 09:53 | x64      |
| Distrib.exe                                          | 2022.160.4175.1  | 260136    | 13-Dec-2024 | 09:53 | x64      |
| Dteparse.dll                                         | 2022.160.4175.1  | 133160    | 13-Dec-2024 | 09:53 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4175.1  | 178216    | 13-Dec-2024 | 09:53 | x64      |
| Dtepkg.dll                                           | 2022.160.4175.1  | 153640    | 13-Dec-2024 | 09:53 | x64      |
| Dtexec.exe                                           | 2022.160.4175.1  | 76872     | 13-Dec-2024 | 09:53 | x64      |
| Dts.dll                                              | 2022.160.4175.1  | 3266624   | 13-Dec-2024 | 09:53 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4175.1  | 493624    | 13-Dec-2024 | 09:53 | x64      |
| Dtsconn.dll                                          | 2022.160.4175.1  | 550952    | 13-Dec-2024 | 09:53 | x64      |
| Dtshost.exe                                          | 2022.160.4175.1  | 120360    | 13-Dec-2024 | 09:53 | x64      |
| Dtslog.dll                                           | 2022.160.4175.1  | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Dtspipeline.dll                                      | 2022.160.4175.1  | 1337384   | 13-Dec-2024 | 09:53 | x64      |
| Dtuparse.dll                                         | 2022.160.4175.1  | 104488    | 13-Dec-2024 | 09:53 | x64      |
| Dtutil.exe                                           | 2022.160.4175.1  | 166480    | 13-Dec-2024 | 09:53 | x64      |
| Exceldest.dll                                        | 2022.160.4175.1  | 284728    | 13-Dec-2024 | 09:53 | x64      |
| Excelsrc.dll                                         | 2022.160.4175.1  | 305208    | 13-Dec-2024 | 09:53 | x64      |
| Execpackagetask.dll                                  | 2022.160.4175.1  | 182312    | 13-Dec-2024 | 09:53 | x64      |
| Flatfiledest.dll                                     | 2022.160.4175.1  | 423992    | 13-Dec-2024 | 09:53 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4175.1  | 440360    | 13-Dec-2024 | 09:53 | x64      |
| Logread.exe                                          | 2022.160.4175.1  | 792632    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.239      | 2933808   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4175.1      | 30776     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4175.1      | 391240    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4175.1  | 1718328   | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4175.1      | 555064    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll         | 2022.160.4175.1  | 182312    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.sqlserver.xevent.dll                       | 2022.160.4175.1  | 198736    | 13-Dec-2024 | 09:53 | x64      |
| Msdtssrvrutil.dll                                    | 2022.160.4175.1  | 124968    | 13-Dec-2024 | 09:53 | x64      |
| Msgprox.dll                                          | 2022.160.4175.1  | 313424    | 13-Dec-2024 | 09:53 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 2750472   | 13-Dec-2024 | 09:53 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 153608    | 13-Dec-2024 | 09:53 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 13-Dec-2024 | 09:53 | x86      |
| Oledbdest.dll                                        | 2022.160.4175.1  | 288808    | 13-Dec-2024 | 09:53 | x64      |
| Oledbsrc.dll                                         | 2022.160.4175.1  | 313384    | 13-Dec-2024 | 09:53 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4175.1  | 526376    | 13-Dec-2024 | 09:53 | x64      |
| Rawdest.dll                                          | 2022.160.4175.1  | 227384    | 13-Dec-2024 | 09:53 | x64      |
| Rawsource.dll                                        | 2022.160.4175.1  | 215080    | 13-Dec-2024 | 09:53 | x64      |
| Rdistcom.dll                                         | 2022.160.4175.1  | 944168    | 13-Dec-2024 | 09:53 | x64      |
| Recordsetdest.dll                                    | 2022.160.4175.1  | 206888    | 13-Dec-2024 | 09:53 | x64      |
| Repldp.dll                                           | 2022.160.4175.1  | 337976    | 13-Dec-2024 | 09:53 | x64      |
| Replerrx.dll                                         | 2022.160.4175.1  | 198736    | 13-Dec-2024 | 09:53 | x64      |
| Replisapi.dll                                        | 2022.160.4175.1  | 419880    | 13-Dec-2024 | 09:53 | x64      |
| Replmerg.exe                                         | 2022.160.4175.1  | 596024    | 13-Dec-2024 | 09:53 | x64      |
| Replprov.dll                                         | 2022.160.4175.1  | 890960    | 13-Dec-2024 | 09:53 | x64      |
| Replrec.dll                                          | 2022.160.4175.1  | 1058896   | 13-Dec-2024 | 09:53 | x64      |
| Replsub.dll                                          | 2022.160.4175.1  | 501800    | 13-Dec-2024 | 09:53 | x64      |
| Spresolv.dll                                         | 2022.160.4175.1  | 301096    | 13-Dec-2024 | 09:53 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4175.1  | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Sqlcmd.exe                                           | 2022.160.4175.1  | 276544    | 13-Dec-2024 | 09:53 | x64      |
| Sqldiag.exe                                          | 2022.160.4175.1  | 1140808   | 13-Dec-2024 | 09:53 | x64      |
| Sqldistx.dll                                         | 2022.160.4175.1  | 268320    | 13-Dec-2024 | 09:53 | x64      |
| Sqlmergx.dll                                         | 2022.160.4175.1  | 424000    | 13-Dec-2024 | 09:53 | x64      |
| Sqlnclirda11.dll                                     | 2011.110.5069.66 | 3478208   | 13-Dec-2024 | 09:53 | x64      |
| Sqlsvc.dll                                           | 2022.160.4175.1  | 153664    | 13-Dec-2024 | 09:53 | x86      |
| Sqlsvc.dll                                           | 2022.160.4175.1  | 194624    | 13-Dec-2024 | 09:53 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4175.1  | 210984    | 13-Dec-2024 | 09:53 | x64      |
| Ssradd.dll                                           | 2022.160.4175.1  | 100416    | 13-Dec-2024 | 09:53 | x64      |
| Ssravg.dll                                           | 2022.160.4175.1  | 100392    | 13-Dec-2024 | 09:53 | x64      |
| Ssrmax.dll                                           | 2022.160.4175.1  | 100392    | 13-Dec-2024 | 09:53 | x64      |
| Ssrmin.dll                                           | 2022.160.4175.1  | 100392    | 13-Dec-2024 | 09:53 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 13-Dec-2024 | 09:53 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 13-Dec-2024 | 09:53 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 13-Dec-2024 | 09:53 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 13-Dec-2024 | 09:53 | x86      |
| Txagg.dll                                            | 2022.160.4175.1  | 395320    | 13-Dec-2024 | 09:53 | x64      |
| Txbdd.dll                                            | 2022.160.4175.1  | 190504    | 13-Dec-2024 | 09:53 | x64      |
| Txdatacollector.dll                                  | 2022.160.4175.1  | 469032    | 13-Dec-2024 | 09:53 | x64      |
| Txdataconvert.dll                                    | 2022.160.4175.1  | 333896    | 13-Dec-2024 | 09:53 | x64      |
| Txderived.dll                                        | 2022.160.4175.1  | 632912    | 13-Dec-2024 | 09:53 | x64      |
| Txlookup.dll                                         | 2022.160.4175.1  | 608296    | 13-Dec-2024 | 09:53 | x64      |
| Txmerge.dll                                          | 2022.160.4175.1  | 243752    | 13-Dec-2024 | 09:53 | x64      |
| Txmergejoin.dll                                      | 2022.160.4175.1  | 301096    | 13-Dec-2024 | 09:53 | x64      |
| Txmulticast.dll                                      | 2022.160.4175.1  | 145448    | 13-Dec-2024 | 09:53 | x64      |
| Txrowcount.dll                                       | 2022.160.4175.1  | 145448    | 13-Dec-2024 | 09:53 | x64      |
| Txsort.dll                                           | 2022.160.4175.1  | 276520    | 13-Dec-2024 | 09:53 | x64      |
| Txsplit.dll                                          | 2022.160.4175.1  | 620624    | 13-Dec-2024 | 09:53 | x64      |
| Txunionall.dll                                       | 2022.160.4175.1  | 194576    | 13-Dec-2024 | 09:53 | x64      |
| Xe.dll                                               | 2022.160.4175.1  | 718904    | 13-Dec-2024 | 09:53 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4175.1 | 100360    | 13-Dec-2024 | 09:53 | x64      |
| Exthost.exe                   | 2022.160.4175.1 | 247848    | 13-Dec-2024 | 09:53 | x64      |
| Launchpad.exe                 | 2022.160.4175.1 | 1452096   | 13-Dec-2024 | 09:53 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Sqlsatellite.dll              | 2022.160.4175.1 | 1255488   | 13-Dec-2024 | 09:53 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4175.1 | 702504    | 13-Dec-2024 | 09:53 | x64      |
| Fdhost.exe               | 2022.160.4175.1 | 157736    | 13-Dec-2024 | 09:53 | x64      |
| Fdlauncher.exe           | 2022.160.4175.1 | 100392    | 13-Dec-2024 | 09:53 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 13-Dec-2024 | 09:53 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 13-Dec-2024 | 09:53 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 13-Dec-2024 | 09:53 | x86      |
| Commanddest.dll                                               | 2022.160.4175.1 | 231496    | 13-Dec-2024 | 09:53 | x86      |
| Commanddest.dll                                               | 2022.160.4175.1 | 272424    | 13-Dec-2024 | 09:53 | x64      |
| Dteparse.dll                                                  | 2022.160.4175.1 | 116808    | 13-Dec-2024 | 09:53 | x86      |
| Dteparse.dll                                                  | 2022.160.4175.1 | 133160    | 13-Dec-2024 | 09:53 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4175.1 | 165960    | 13-Dec-2024 | 09:53 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4175.1 | 178216    | 13-Dec-2024 | 09:53 | x64      |
| Dtepkg.dll                                                    | 2022.160.4175.1 | 129104    | 13-Dec-2024 | 09:53 | x86      |
| Dtepkg.dll                                                    | 2022.160.4175.1 | 153640    | 13-Dec-2024 | 09:53 | x64      |
| Dtexec.exe                                                    | 2022.160.4175.1 | 65096     | 13-Dec-2024 | 09:53 | x86      |
| Dtexec.exe                                                    | 2022.160.4175.1 | 76872     | 13-Dec-2024 | 09:53 | x64      |
| Dts.dll                                                       | 2022.160.4175.1 | 2861096   | 13-Dec-2024 | 09:53 | x86      |
| Dts.dll                                                       | 2022.160.4175.1 | 3266624   | 13-Dec-2024 | 09:53 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4175.1 | 444488    | 13-Dec-2024 | 09:53 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4175.1 | 493624    | 13-Dec-2024 | 09:53 | x64      |
| Dtsconn.dll                                                   | 2022.160.4175.1 | 464936    | 13-Dec-2024 | 09:53 | x86      |
| Dtsconn.dll                                                   | 2022.160.4175.1 | 550952    | 13-Dec-2024 | 09:53 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4175.1 | 114728    | 13-Dec-2024 | 09:53 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4175.1 | 94776     | 13-Dec-2024 | 09:53 | x86      |
| Dtshost.exe                                                   | 2022.160.4175.1 | 120360    | 13-Dec-2024 | 09:53 | x64      |
| Dtshost.exe                                                   | 2022.160.4175.1 | 98344     | 13-Dec-2024 | 09:53 | x86      |
| Dtslog.dll                                                    | 2022.160.4175.1 | 120904    | 13-Dec-2024 | 09:53 | x86      |
| Dtslog.dll                                                    | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Dtspipeline.dll                                               | 2022.160.4175.1 | 1144904   | 13-Dec-2024 | 09:53 | x86      |
| Dtspipeline.dll                                               | 2022.160.4175.1 | 1337384   | 13-Dec-2024 | 09:53 | x64      |
| Dtuparse.dll                                                  | 2022.160.4175.1 | 104488    | 13-Dec-2024 | 09:53 | x64      |
| Dtuparse.dll                                                  | 2022.160.4175.1 | 88128     | 13-Dec-2024 | 09:53 | x86      |
| Dtutil.exe                                                    | 2022.160.4175.1 | 142360    | 13-Dec-2024 | 09:53 | x86      |
| Dtutil.exe                                                    | 2022.160.4175.1 | 166480    | 13-Dec-2024 | 09:53 | x64      |
| Exceldest.dll                                                 | 2022.160.4175.1 | 247872    | 13-Dec-2024 | 09:53 | x86      |
| Exceldest.dll                                                 | 2022.160.4175.1 | 284728    | 13-Dec-2024 | 09:53 | x64      |
| Excelsrc.dll                                                  | 2022.160.4175.1 | 264256    | 13-Dec-2024 | 09:53 | x86      |
| Excelsrc.dll                                                  | 2022.160.4175.1 | 305208    | 13-Dec-2024 | 09:53 | x64      |
| Execpackagetask.dll                                           | 2022.160.4175.1 | 149568    | 13-Dec-2024 | 09:53 | x86      |
| Execpackagetask.dll                                           | 2022.160.4175.1 | 182312    | 13-Dec-2024 | 09:53 | x64      |
| Flatfiledest.dll                                              | 2022.160.4175.1 | 374824    | 13-Dec-2024 | 09:53 | x86      |
| Flatfiledest.dll                                              | 2022.160.4175.1 | 423992    | 13-Dec-2024 | 09:53 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4175.1 | 391192    | 13-Dec-2024 | 09:53 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4175.1 | 440360    | 13-Dec-2024 | 09:53 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4175.1     | 120888    | 13-Dec-2024 | 09:53 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4175.1     | 120872    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.239     | 2933808   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.239     | 2933832   | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4175.1     | 509992    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4175.1     | 510008    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4175.1     | 391240    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2022.160.4175.1 | 170040    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2022.160.4175.1 | 182312    | 13-Dec-2024 | 09:53 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2022.160.4175.1 | 178248    | 13-Dec-2024 | 09:53 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2022.160.4175.1 | 198736    | 13-Dec-2024 | 09:53 | x64      |
| Msdtssrvr.exe                                                 | 16.0.4175.1     | 219216    | 13-Dec-2024 | 09:53 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4175.1 | 100392    | 13-Dec-2024 | 09:53 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4175.1 | 124968    | 13-Dec-2024 | 09:53 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.239 | 10164264  | 13-Dec-2024 | 09:53 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 13-Dec-2024 | 09:53 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 13-Dec-2024 | 09:53 | x86      |
| Odbcdest.dll                                                  | 2022.160.4175.1 | 342096    | 13-Dec-2024 | 09:53 | x86      |
| Odbcdest.dll                                                  | 2022.160.4175.1 | 383016    | 13-Dec-2024 | 09:53 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4175.1 | 350272    | 13-Dec-2024 | 09:53 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4175.1 | 399416    | 13-Dec-2024 | 09:53 | x64      |
| Oledbdest.dll                                                 | 2022.160.4175.1 | 247880    | 13-Dec-2024 | 09:53 | x86      |
| Oledbdest.dll                                                 | 2022.160.4175.1 | 288808    | 13-Dec-2024 | 09:53 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4175.1 | 268368    | 13-Dec-2024 | 09:53 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4175.1 | 313384    | 13-Dec-2024 | 09:53 | x64      |
| Rawdest.dll                                                   | 2022.160.4175.1 | 227384    | 13-Dec-2024 | 09:53 | x64      |
| Rawdest.dll                                                   | 2022.160.4175.1 | 190488    | 13-Dec-2024 | 09:53 | x86      |
| Rawsource.dll                                                 | 2022.160.4175.1 | 215080    | 13-Dec-2024 | 09:53 | x64      |
| Rawsource.dll                                                 | 2022.160.4175.1 | 186424    | 13-Dec-2024 | 09:53 | x86      |
| Recordsetdest.dll                                             | 2022.160.4175.1 | 206888    | 13-Dec-2024 | 09:53 | x64      |
| Recordsetdest.dll                                             | 2022.160.4175.1 | 174152    | 13-Dec-2024 | 09:53 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4175.1 | 137256    | 13-Dec-2024 | 09:53 | x64      |
| Sqlceip.exe                                                   | 16.0.4175.1     | 301112    | 13-Dec-2024 | 09:53 | x86      |
| Sqldest.dll                                                   | 2022.160.4175.1 | 256080    | 13-Dec-2024 | 09:53 | x86      |
| Sqldest.dll                                                   | 2022.160.4175.1 | 288808    | 13-Dec-2024 | 09:53 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4175.1 | 210984    | 13-Dec-2024 | 09:53 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4175.1 | 174136    | 13-Dec-2024 | 09:53 | x86      |
| Txagg.dll                                                     | 2022.160.4175.1 | 346152    | 13-Dec-2024 | 09:53 | x86      |
| Txagg.dll                                                     | 2022.160.4175.1 | 395320    | 13-Dec-2024 | 09:53 | x64      |
| Txbdd.dll                                                     | 2022.160.4175.1 | 149560    | 13-Dec-2024 | 09:53 | x86      |
| Txbdd.dll                                                     | 2022.160.4175.1 | 190504    | 13-Dec-2024 | 09:53 | x64      |
| Txbestmatch.dll                                               | 2022.160.4175.1 | 567352    | 13-Dec-2024 | 09:53 | x86      |
| Txbestmatch.dll                                               | 2022.160.4175.1 | 661544    | 13-Dec-2024 | 09:53 | x64      |
| Txcache.dll                                                   | 2022.160.4175.1 | 170008    | 13-Dec-2024 | 09:53 | x86      |
| Txcache.dll                                                   | 2022.160.4175.1 | 202792    | 13-Dec-2024 | 09:53 | x64      |
| Txcharmap.dll                                                 | 2022.160.4175.1 | 280632    | 13-Dec-2024 | 09:53 | x86      |
| Txcharmap.dll                                                 | 2022.160.4175.1 | 325688    | 13-Dec-2024 | 09:53 | x64      |
| Txcopymap.dll                                                 | 2022.160.4175.1 | 165928    | 13-Dec-2024 | 09:53 | x86      |
| Txcopymap.dll                                                 | 2022.160.4175.1 | 202792    | 13-Dec-2024 | 09:53 | x64      |
| Txdataconvert.dll                                             | 2022.160.4175.1 | 288808    | 13-Dec-2024 | 09:53 | x86      |
| Txdataconvert.dll                                             | 2022.160.4175.1 | 333896    | 13-Dec-2024 | 09:53 | x64      |
| Txderived.dll                                                 | 2022.160.4175.1 | 559144    | 13-Dec-2024 | 09:53 | x86      |
| Txderived.dll                                                 | 2022.160.4175.1 | 632912    | 13-Dec-2024 | 09:53 | x64      |
| Txfileextractor.dll                                           | 2022.160.4175.1 | 186408    | 13-Dec-2024 | 09:53 | x86      |
| Txfileextractor.dll                                           | 2022.160.4175.1 | 219176    | 13-Dec-2024 | 09:53 | x64      |
| Txfileinserter.dll                                            | 2022.160.4175.1 | 186440    | 13-Dec-2024 | 09:53 | x86      |
| Txfileinserter.dll                                            | 2022.160.4175.1 | 219176    | 13-Dec-2024 | 09:53 | x64      |
| Txgroupdups.dll                                               | 2022.160.4175.1 | 354344    | 13-Dec-2024 | 09:53 | x86      |
| Txgroupdups.dll                                               | 2022.160.4175.1 | 403520    | 13-Dec-2024 | 09:53 | x64      |
| Txlineage.dll                                                 | 2022.160.4175.1 | 129088    | 13-Dec-2024 | 09:53 | x86      |
| Txlineage.dll                                                 | 2022.160.4175.1 | 157752    | 13-Dec-2024 | 09:53 | x64      |
| Txlookup.dll                                                  | 2022.160.4175.1 | 522280    | 13-Dec-2024 | 09:53 | x86      |
| Txlookup.dll                                                  | 2022.160.4175.1 | 608296    | 13-Dec-2024 | 09:53 | x64      |
| Txmerge.dll                                                   | 2022.160.4175.1 | 194640    | 13-Dec-2024 | 09:53 | x86      |
| Txmerge.dll                                                   | 2022.160.4175.1 | 243752    | 13-Dec-2024 | 09:53 | x64      |
| Txmergejoin.dll                                               | 2022.160.4175.1 | 256040    | 13-Dec-2024 | 09:53 | x86      |
| Txmergejoin.dll                                               | 2022.160.4175.1 | 301096    | 13-Dec-2024 | 09:53 | x64      |
| Txmulticast.dll                                               | 2022.160.4175.1 | 116816    | 13-Dec-2024 | 09:53 | x86      |
| Txmulticast.dll                                               | 2022.160.4175.1 | 145448    | 13-Dec-2024 | 09:53 | x64      |
| Txpivot.dll                                                   | 2022.160.4175.1 | 198696    | 13-Dec-2024 | 09:53 | x86      |
| Txpivot.dll                                                   | 2022.160.4175.1 | 239672    | 13-Dec-2024 | 09:53 | x64      |
| Txrowcount.dll                                                | 2022.160.4175.1 | 116776    | 13-Dec-2024 | 09:53 | x86      |
| Txrowcount.dll                                                | 2022.160.4175.1 | 145448    | 13-Dec-2024 | 09:53 | x64      |
| Txsampling.dll                                                | 2022.160.4175.1 | 153640    | 13-Dec-2024 | 09:53 | x86      |
| Txsampling.dll                                                | 2022.160.4175.1 | 186424    | 13-Dec-2024 | 09:53 | x64      |
| Txscd.dll                                                     | 2022.160.4175.1 | 198712    | 13-Dec-2024 | 09:53 | x86      |
| Txscd.dll                                                     | 2022.160.4175.1 | 235560    | 13-Dec-2024 | 09:53 | x64      |
| Txsort.dll                                                    | 2022.160.4175.1 | 231504    | 13-Dec-2024 | 09:53 | x86      |
| Txsort.dll                                                    | 2022.160.4175.1 | 276520    | 13-Dec-2024 | 09:53 | x64      |
| Txsplit.dll                                                   | 2022.160.4175.1 | 550992    | 13-Dec-2024 | 09:53 | x86      |
| Txsplit.dll                                                   | 2022.160.4175.1 | 620624    | 13-Dec-2024 | 09:53 | x64      |
| Txtermextraction.dll                                          | 2022.160.4175.1 | 8648744   | 13-Dec-2024 | 09:53 | x86      |
| Txtermextraction.dll                                          | 2022.160.4175.1 | 8702024   | 13-Dec-2024 | 09:53 | x64      |
| Txtermlookup.dll                                              | 2022.160.4175.1 | 4139064   | 13-Dec-2024 | 09:53 | x86      |
| Txtermlookup.dll                                              | 2022.160.4175.1 | 4184104   | 13-Dec-2024 | 09:53 | x64      |
| Txunionall.dll                                                | 2022.160.4175.1 | 153640    | 13-Dec-2024 | 09:53 | x86      |
| Txunionall.dll                                                | 2022.160.4175.1 | 194576    | 13-Dec-2024 | 09:53 | x64      |
| Txunpivot.dll                                                 | 2022.160.4175.1 | 178216    | 13-Dec-2024 | 09:53 | x86      |
| Txunpivot.dll                                                 | 2022.160.4175.1 | 215080    | 13-Dec-2024 | 09:53 | x64      |
| Xe.dll                                                        | 2022.160.4175.1 | 641064    | 13-Dec-2024 | 09:53 | x86      |
| Xe.dll                                                        | 2022.160.4175.1 | 718904    | 13-Dec-2024 | 09:53 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1046.0     | 559680    | 13-Dec-2024 | 10:14 | x86      |
| Dmsnative.dll                                                        | 2022.160.1046.0 | 152640    | 13-Dec-2024 | 10:14 | x64      |
| Dwengineservice.dll                                                  | 16.0.1046.0     | 45112     | 13-Dec-2024 | 10:14 | x86      |
| Instapi150.dll                                                       | 2022.160.4175.1 | 104504    | 13-Dec-2024 | 10:14 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1046.0     | 67640     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1046.0     | 293456    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1046.0     | 1958472   | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1046.0     | 169520    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1046.0     | 647224    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1046.0     | 246368    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1046.0     | 139344    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1046.0     | 79968     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1046.0     | 51248     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1046.0     | 88656     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1046.0     | 1129528   | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1046.0     | 80992     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1046.0     | 70736     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1046.0     | 35376     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1046.0     | 30784     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1046.0     | 46672     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1046.0     | 21552     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1046.0     | 26672     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1046.0     | 131664    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1046.0     | 86624     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1046.0     | 100960    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1046.0     | 293432    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 120376    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 138296    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 141384    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 137776    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 150592    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 139832    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 134712    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 176688    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 117816    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 136768    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1046.0     | 72784     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1046.0     | 22064     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1046.0     | 37432     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1046.0     | 129072    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1046.0     | 3064912   | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1046.0     | 3955784   | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 118336    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 133184    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 137776    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 133680    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 148528    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 134192    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 130624    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 171064    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 115256    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 132152    | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1046.0     | 67664     | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1046.0     | 2682936   | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1046.0     | 2436664   | 13-Dec-2024 | 10:14 | x86      |
| Microsoft.sqlserver.xe.core.dll                                      | 2022.160.4175.1 | 84032     | 13-Dec-2024 | 10:14 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                         | 2022.160.4175.1 | 182312    | 13-Dec-2024 | 10:14 | x64      |
| Microsoft.sqlserver.xevent.dll                                       | 2022.160.4175.1 | 198736    | 13-Dec-2024 | 10:14 | x64      |
| Mpdwinterop.dll                                                      | 2022.160.4175.1 | 297000    | 13-Dec-2024 | 10:14 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4175.1 | 9078864   | 13-Dec-2024 | 10:14 | x64      |
| Secforwarder.dll                                                     | 2022.160.4175.1 | 84024     | 13-Dec-2024 | 10:14 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1046.0 | 61504     | 13-Dec-2024 | 10:14 | x64      |
| Sqldk.dll                                                            | 2022.160.4175.1 | 4020240   | 13-Dec-2024 | 10:14 | x64      |
| Sqldumper.exe                                                        | 2022.160.4175.1 | 448552    | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 1759312   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 4605992   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 3774504   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 4601896   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 4503592   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 2459728   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 2402344   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 4233256   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 4216872   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 1697832   | 13-Dec-2024 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4175.1 | 4470824   | 13-Dec-2024 | 10:14 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 13-Dec-2024 | 10:14 | x64      |
| Sqlos.dll                                                            | 2022.160.4175.1 | 51256     | 13-Dec-2024 | 10:14 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1046.0 | 4841520   | 13-Dec-2024 | 10:14 | x64      |
| Sqltses.dll                                                          | 2022.160.4175.1 | 10668088  | 13-Dec-2024 | 10:14 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

This article also provides the following important information.

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Hybrid environment deployment</b></summary>

When you deploy an update to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the update:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply an update:
    >
    > - Install the update on the passive node.
    > - Install the update on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
