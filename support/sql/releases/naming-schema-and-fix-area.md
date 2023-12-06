---
title: Naming schema and Fix area
description: This article describes naming schema and fix area for SQL Server software update packages.
ms.date: 09/03/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: Arvindk
ms.topic: article
---
# Naming schema and Fix area descriptions for SQL Server software update packages

This article describes naming schema and fix area for SQL Server software update packages.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 822499

## Package information and release types

Microsoft has adopted a standardized naming schema for all the software update packages for SQL Server that are created and distributed.

A software update package is an executable (_.exe_ or _.msi_) file that contains one or more files that may be applied to SQL Server installations to correct a specific problem. Software update packages are distributed by Customer Support Services (CSS) to customers whose computers are affected by a specific problem.

Microsoft has adopted a naming schema for software update packages for the following reasons:

- Creates consistency across software update packages.
- Easier to search for software updated packages and Knowledge Base articles.
- Clear identification of the language and SQL Server version for which the software update package is applicable.

Each software update package that is selected at download time is contained within a self-extracting executable that facilitates easy installation and deployment of the software update package.

SQL Server software update packages typically fall into two major release types:

- GDR (General Distribution Release): GDR releases are reserved for those key fixes identified by SQL Server support to potentially affect a broad customer base.

- Hotfix: Hotfix releases are typically for fixes to isolated issues not affecting a large customer base; while the product is in mainstream support. Hotfix is released in two major types:

  - COD (Critical On Demand) or OD (On Demand): COD or OD releases are reserved for critical customer requests where key business functionality is impaired from the issue encountered. As the nature of the request, these releases do not follow a regular cadence.

  - CU (Cumulative Update): CU releases are non-critical requests that provide fixes for isolated issues not affecting key business functionality. The CU releases on a two-month cadence while the product and service pack are in mainstream support.

To learn more about the ISM and the different release types, which SQL Server servicing follows, see [An Incremental Servicing Model is available from the SQL Server team to deliver hotfixes for reported problems](https://support.microsoft.com/help/935897).

## Naming schema for SQL Server software update packages

SQL Server software update packages can be easily identified using the following naming schema.

- **Software update package name schema**

    To distinguish between the various software update packages available online, the following schema is employed:  
    `<product name or product program name>_<SP number or RTM>_<servicing release>_<KB article number>_<build number optional>_<architecture identifier>`

- **Extracted SQL Server file name schema**

    Once the primary SQL Server software update package has been downloaded and extracted, the file name will resemble the following:  
    `<product name or component>-<KB article number>-<build number optional>-<version optional>-<architecture Identifier>-<language code optional>.exe`

- **Extracted feature pack name schema**

  Once a software update package for a feature pack has been downloaded and extracted, the file name will resemble the following:

  _[feature pack file name].msi_

  - **ProductName** This is the full product name, which includes the product version information. For SQL Server, this attribute could be one of the following:

    - SQLServer2005
    - SQLServer2008
    - SQLServer2008R2
    - SQLServer2012

  - **SP number or RTM** The service pack level of the product or component that it can be applied on top of. RTM indicates the product without any service packs installed.
  - **KB article number** The Microsoft Knowledge Base article number that is associated with the software update.
  - **Servicing Release** The release type for the software update. For details, visit the [Package information and release types](#package-information-and-release-types) section.

    - COD: Critical On Demand
    - OD: On Demand
    - CU: Cumulative Update followed by the cumulative update release number

  - **Architecture identifier** This field is used to indicate on which processor architecture the particular hotfix package runs. The current options are the following:

    - x86: This package runs on x86 platforms.
    - ia64: This package runs on Itanium IA-64 platforms for 64-bit.
    - x64: This package only runs on AMD x64 and compatible systems.

  - **Version** An optional field that indicates the version of the software release.
  - **Build number** An optional field that is used to indicate the SQL Server build number included in the software update.

  For example, in _SQL2000-KB840223-8.00.1007-ia64-ENU.exe_, the build version of SQL Server is 8.00.1007. This will correspond to the file version of _Sqlservr.exe_ and to the returned value from `@@version run` against this server instance.

## Software update package and extracted file name mapping

The following tables illustrate the mapping between the Download File Name on the hotfix download page and the actual name of the package once downloaded and extracted.

## SQL Server software Update Package

| Package| Software Update Package Name| Extracted SQL Server File Name |
|---|---|---|
|CU Package for SQL Server 2005|SQLServer2005_SPx_CUxx_kbxxxxxx_9_00_xxxx_Arch<br/>|_SQLServer2005-KBxxxxxxx-Arch-Lang.exe_|
|CU Package for SQL Server 2008|SQLServer2008_RTM_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>SQLServer2008_SPx_CUxx_kbxxxxxx_10_00_xxxx_Arch|_SQLServer2008- KBxxxxxxx-Arch.exe_|
|CU Package for SQL Server 2008 R2|SQLServer2008R2_RTM_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>SQLServer2008R2_SPx_CUxx_kbxxxxxx_10_50_xxxx_Arch|_SQLServer2008R2-KBxxxxxxx-Arch.exe_|
|CU Package for SQL Server 2012|SQLServer2012_RTM_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>SQLServer2012_SPx_CUxx_kbxxxxxx_11_00_xxxx_Arch|_SQLServer2012-KBxxxxxxx-Arch.exe_|
  
## SQL Server Feature Pack

| Package| Software Update Package Name| Extracted SQL Server File Name |
|---|---|---|
|SQL Native Client|2005_SPx_SNAC_CUxx_kbxxxxxx_9_00_xxxx_Arch<br/>2008_RTM_SNAC_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008_SPx_SNAC_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008R2_RTM_SNAC_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>2008R2_SPx_SNAC_CUxx_kbxxxxxx_10_50_xxxx_Arch|_sqlncli.msi_|
|SQL Writer|2005_SPx_SQLWriter_CUxx_kbxxxxxx_9_00_xxxx_Arch|_SQLWriter.msi_|
|AS OLE DB for SQL Server 2005|2005_SPx_ASOLEDB_CUxx_kbxxxxxx_9_00_xxxx_Arch|_SQLServer2005_ASOLEDB9.msi_|
|AS OLE DB for SQL Server 2008|2008_RTM_ASOLEDB_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008_SPx_ASOLEDB_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008R2_RTM_ASOLEDB_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>2008R2_SPx_ASOLEDB_CUxx_kbxxxxxx_10_50_xxxx_Arch|_SQLServer2008_ASOLEDB10.msi_|
|AS OLE DB for SQL Server 2012|2012_RTM_ASOLEDB_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>2012_SPx_ASOLEDB_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>|_SQL_AS_OLEDB.msi_|
|ADMOMD.net|2005_SPx_ADMOMD_CUxx_kbxxxxxx_9_00_xxxx_Arch|_SQLServer2005_ADOMD.msi_|
|XMO/SMO (Shared Management Objects) for SQL Server 2005|2005_SPx_XMO_CUxx_kbxxxxxx_9_00_xxxx_Arch|_SQLServer2005_XMO.msi_|
|XMO/SMO (Shared Management Objects) for SQL Server 2008, SQL Server 2008 R2, and SQL Server 2012|2008_RTM_SMO_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008_SPx_SMO_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008R2_RTM_SMO_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>2008R2_SPx_SMO_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>2012_RTM_SMO_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>2012_SPx_SMO_CUxx_kbxxxxxx_11_00_xxxx_Arch|_SharedManagementObjects.msi_|
|Reporting Services for SharePoint for SQL Server 2005|2005_SPx_RSShrPnt_CUxx_KBxxxxx_9_00_xxxx_arch|_SharePointRS.msi_|
|Reporting Services for SharePoint for SQL Server 2008, SQL Server 2008 R2, and SQL Server 2012|2008_RTM_RSShrPnt_CUxx_KBxxxxx_10_00_xxxx_arch<br/>2008_SPx_RSShrPnt_CUxx_KBxxxxx_10_00_xxxx_arch<br/>2008R2_RTM_RSShrPnt_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_RSShrPnt_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2012_RTM_RSShrPnt_CUxx_KBxxxxx_11_00_xxxx_arch<br/>2012_SPx_RSShrPnt_CUxx_KBxxxxx_11_00_xxxx_arch<br/>|_rsSharePoint.msi_ (x86 and x64 only)|
|Reporting Services for SharePoint for SQL Server 2008 R2|2008R2_RTM_RSShrPnt_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_RSShrPnt_CUxx_KBxxxxx_10_50_xxxx_arch|_rsSharePoint.msi_ (x64 only)|
|Report Builder Click Once|2008_RTM_RBClckOnc_CUxx_kbxxxxx_10_00_xxxx_Arch<br/>2008_SPx_RBClckOnc_CUxx_kbxxxxx_10_00_xxxx_Arch|_RB2ClickOnce.msi_ (x86 and x64 only)|
|Report Builder for SQL Server 2008|2008_RTM_RprtBlder_CUxx_KBxxxx_10_00_xxxx_Arch<br/>2008_SPx_RprtBlder_CUxx_KBxxxx_10_00_xxxx_Arch|_ReportBuilder.msi_ (x86 only)|
|Report Builder for SQL Server 2008 R2|2008R2_RTM_RprtBlder_CUxx_KBxxxx_10_50_xxxx_Arch<br/>2008R2_SPx_RprtBlder_CUxx_KBxxxx_10_50_xxxx_Arch|_ReportBuilder3.msi_|
|Sap BI|2008_RTM_SapBI_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008_SPx_SapBI_CUxx_kbxxxxxx_10_00_xxxx_Arch<br/>2008R2_RTM_SapBI_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>2008R2_SPx_SapBI_CUxx_kbxxxxxx_10_50_xxxx_Arch<br/>2012_RTM_SapBI_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>2012_SPx_SapBI_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>|_SapBI.msi_|
|Stream Insight|2008R2_RTM_StrmNsght_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_StrmNsght_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2012_RTM_StrmNsght_CUxx_KBxxxxx_11_00_xxxx_arch<br/>2012_SPx_StrmNsght_CUxx_KBxxxxx_11_00_xxxx_arch<br/>|_StreamInsightClient.msi_|
|Synchronization|2008R2_RTM_Synch_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_Synch_CUxx_KBxxxxx_10_50_xxxx_arch|_Synchronization.msi_|
|PowerPivot for Excel Client|2008R2_RTM_PPExcel_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_PPExcel_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2012_RTM_PPExcel_CUxx_KBxxxxx_11_00_xxxx_arch<br/>2012_SPx_PPExcel_CUxx_KBxxxxx_11_00_xxxx_arch<br/>|_PowerPivot_for_Excel_x86.msi_|
|Stream Insight and Server|2008R2_RTM_PPServer_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_PPServer_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2012_RTM_PPServer_CUxx_KBxxxxx_11_00_xxxx_arch<br/><br/>2012_SPx_PPServer_CUxx_KBxxxxx_11_00_xxxx_arch<br/>|_StreamInsight.msi_|
|Master Data Services|2008R2_RTM_MDS_CUxx_KBxxxxx_10_50_xxxx_arch<br/>2008R2_SPx_MDS_CUxx_KBxxxxx_10_50_xxxx_arch|_MasterDataServices.msi_ (x64 only)|
|Data-Tier Application Framework|2012_RTM_DAC_CUxx_KBxxxxx_11_00_xxxx_arch<br/>2012_SPx_DAC_CUxx_KBxxxxx_11_00_xxxx_arch<br/>|_DACFramework.msi_|
|ADOMD.NET|2012_RTM_ADMOMD_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/>2012_SPx_ADMOMD_CUxx_kbxxxxxx_11_00_xxxx_Arch<br/><br/>|_SQL_AS_ADOMD.msi_|
|LocalDB|2012_RTM_LocalDB_CUxx_KBxxxxx_11_00_xxxx_arch<br/>2012_SPx_LocalDB_CUxx_KBxxxxx_11_00_xxxx_arch<br/><br/><br/>|_SqlLocalDB.msi_|
|Transact-SQL Language Service|2012_RTM_TSQLLAN_CUxx_KBxxxxx_11_00_xxxx_arch<br/>2012_SPx_TSQLLAN_CUxx_KBxxxxx_11_00_xxxx_arch<br/>|_TSqlLanguageService.msi_|
  
Best practices As a best practice, consider providing a name that you can use to easily identify packages during downloads.

## Package descriptions

This section describes each of the packages that are listed and their purposes. Installing a newer MSI package over an older MSI package removes the older version in favor of the newer version. Uninstalling a feature pack update by using an MSI package will completely remove the component. However, for the main CU package, uninstalling the _.exe_ file causes a rollback to the previously installed version.

- **SQL Server software update package**

  File name

  - _SQLServer2005-KBxxxxxxx-Arch-Lang.exe_ (For SQL Server 2005)

  - _SQLServer2008-KBxxxxxxx-Arch.exe_ (For SQL Server 2008)

  - _SQLServer2008R2-kbxxxxxx-Arch_ (For SQL Server 2008 R2)

  - _SQLServer2012-kbxxxxxx-Arch_ (For SQL Server 2012)

  Purpose

  The SQL Server software update package will update the SQL Server instance by using a collection of all SQL Server hotfixes that have been created since the product was released. The package will apply updates to all installed components if an update has been made. This package will update SQL Server DB & Engine, Analysis Service, Integration Services, Reporting Services, Replication Engine, and Manageability.

- **SQL Server Native Client**

  File name

  _sqlncli.msi_ (For SQL Server 2005, 2008, 2008 R2, 2012)

  Purpose

  SQL Server Native Client is a single dynamic-link library (DLL) containing both the SQL OLE DB provider and SQL ODBC driver. It contains run-time support for applications using native-code APIs (ODBC, OLE DB and ADO) to connect to SQL Server. SQL Server Native Client should be used to create new applications or enhance existing applications that need to take advantage of new SQL Server features. This installer for SQL Server Native Client installs the client components needed during run time to take advantage of new SQL Server features, and optionally installs the header files needed to develop an application that uses the SQL Server Native Client API.

- **Report builder**

  File name

  - _ReportBuilder.msi_ (For SQL Server 2008)

  - _ReportBuilder3.msi_ (For SQL Server 2008 R2)

  Purpose

  Report Builder provides an intuitive report authoring environment for business and power users with an Office look and feel. Report Builder supports the full capabilities of Report Definition Language (RDL) including flexible data layout, data visualizations, and richly formatted text features of SQL Server Reporting Services. The download provides a stand-alone installer for Report Builder.

- **Report Builder Click Once**

  File name

  _RB2ClickOnce.msi_ (For SQL Server 2008, SQL Server 2008 R2)

  Purpose

  The Click Once version of Report Builder designed to be started from Report Manager or a SharePoint library.

- **Reporting Services for SharePoint**

  File name

  - _SharePointRS.msi_ (For SQL Server 2005)
  - _rsSharePoint.msi_ (For SQL Server 2008, SQL Server 2008 R2, and SQL Server 2012)

  Purpose

  SQL Server Reporting Services Add-in for SharePoint Technologies allows you to take advantage of SQL Server 2005 and 2008 report processing and management capabilities in SharePoint. The download provides a Report Viewer web part, web application pages, and support for using standard Windows SharePoint Services.

- **SQL Writer**

  File name

  _SQLWriter.msi_ (For SQL Server 2005)

  Purpose

  The SQL Writer Service provides added functionality for backup and restore of SQL Server through the Volume Shadow Copy Service framework. When running, Database Engine locks and has exclusive access to the data files. When the SQL Writer Service is not running, backup programs running in Windows do not have access to the data files, and backups must be performed using SQL Server backup. Use the SQL Writer Service to permit Windows backup programs to copy SQL Server data files while SQL Server is running.

- **AS OLE DB**

  File name

  - _SQLServer2005_ASOLEDB9.msi_ (For SQL Server 2005)
  - _SQLServer2008_ASOLEDB10.msi_ (For SQL Server 2008 and SQL Server 2008 R2)
  - _SQL_AS_OLEDB.msi_ (For SQL Server 2012)

  Purpose

  The Analysis Services OLE DB Provider is a COM component that software developers can use to create client-side applications that browse metadata and query data stored in SQL Server Analysis Services. This provider implements both the OLE DB specification and the specification's extensions for online analytical processing (OLAP) and data mining.

    > [!NOTE]
    > SQL Server Analysis Services OLE DB Provider requires Core XML Services (MSXML) 6.0.

- **XMO/SMO (Shared Management Objects)**

  File name

  - _SQLServer2005_XMO.msi_ (For SQL Server 2005)
  - _SharedManagementObjects.msi_ (For SQL Server 2008, SQL Server 2008 R2, and SQL Server 2012)

  Purpose

  The Management Objects Collection package includes several key elements of the SQL Server 2005 management API, including Analysis Management Objects (AMO), Replication Management Objects (RMO), and SQL Server Management Objects (SMO). Developers and DBAs can use these components to programmatically manage SQL Server 2005.

    > [!NOTE]
    > SQL Server Management Objects Collection requires Core XML Services (MSXML) 6.0 and SQL Server Native Client.

- **ADMOMD.net**

  File name

  _SQLServer2005_ADOMD.msi_ (For SQL Server 2005)

  Purpose

  ADOMD.NET is a .NET Framework object model that enables software developers to create client-side applications that browse metadata and query data stored in SQL Server 2005 Analysis Services. ADOMD.NET is a ADO.NET provider with enhancements for online analytical processing (OLAP) and data mining.

- **SapBI**

  File name

  _SapBI.msi_ (For SQL Server 2008, SQL Server 2008 R2, and SQL Server 2012)

  Purpose

  The Connector for SAP BI is a set of managed components for transferring data to or from an SAP NetWeaver BI version 7.0 System. The component is designed to be used with the Enterprise and Developer editions of SQL Server 2008 or 2008 R2 Integration Services. To install the component, run the platform-specific installer for x86, x64, or Itanium computers respectively. For more information, see the Readme and the installation topic in the Help file.

- **Stream Insight (client)**

  File name

  _StreamInsightClient.msi_ (For SQL 2008 R2 and SQL Server 2012)

  Purpose

  For current users of StreamInsight, a run time data aggregator. StreamInsight allows software developers to create innovative solutions in the domain of Complex Event Processing that satisfy these needs. It allows to monitor, mine, and develop insights from continuous unbounded data streams and correlate constantly changing events with rich payloads in near real time. Industry-specific solution developers (ISVs) and developers of custom applications have the opportunity to innovate on and utilize proven, flexible, and familiar technology and rely on existing development skills when using the StreamInsight platform.

- **Stream Insight (Server)**  

  File name

  _StreamInsight.msi_ (For SQL Server 2008 R2 and SQL Server 2012)

  Purpose

  StreamInsight allows software developers to create innovative solutions in the domain of Complex Event Processing that satisfy these needs. It allows to monitor, mine, and develop insights from continuous unbounded data streams and correlate constantly changing events with rich payloads in near real time. Industry-specific solution developers (ISVs) and developers of custom applications have the opportunity to innovate on and utilize proven, flexible, and familiar Microsoft technology and rely on existing development skills when using the StreamInsight platform.

- **Synchronization**  

  File name

  _Synchronization.msi_ (For SQL 2008 R2)

  Purpose

  Microsoft Sync Framework is a comprehensive synchronization platform that enables collaboration and offline access for applications, services, and devices. Using Microsoft Sync Framework (MSF) runtime, developers can build sync ecosystems that integrate any application, with any data from any store using any protocol over any network. Sync Services for ADO.NET is a part of the MSF. Sync Services for ADO.NET enables synchronization between ADO.NET enabled databases. Because Sync Services for ADO.NET is part of the MSF, any database that uses Sync Services for ADO.NET can then also exchange information with other data sources that are supported by MSF, such as web services, file systems or custom data stores. For more information about the MSF, please go to [Microsoft Sync Framework Developer Center](https://go.microsoft.com/fwlink/?linkid=123130).

- **PowerPivot Excel Client**  

  File name

  _PowerPivot_for_Excel_x86.msi_ (For SQL Server 2008 R2 and SQL Server 2012)

  Purpose

  Microsoft&reg; PowerPivot for Microsoft&reg; Excel 2010 is a data analysis tool that delivers unmatched computational power directly within the software users already know and love - Microsoft&reg; Excel. You can transform mass quantities of data with incredible speed into meaningful information to get the answers you need in seconds. You can effortlessly share your findings with others.

- **Master Data Services**  

  File name

  _MasterDataServices.msi_ (For SQL 2008 R2)
  
  Purpose Master Data Services helps enterprises standardize the data people rely on to make critical business decisions. With Master Data Services, IT organizations can centrally manage critical data assets company wide and across diverse systems, enable more people to securely manage master data directly, and ensure the integrity of information over time.

- **Data-Tier Application Framework**  

  File name

  _DACFramework.msi_ (For SQL Server 2008 R2 and SQL Server 2012)

  Purpose

  The SQL Server Data-tier Application (DAC) framework is a component that is based on the .NET Framework and that provides application lifecycle services for database development and management. Application lifecycle services include extract, build, deploy, upgrade, import, and export for data-tier applications in SQL Azure, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008, and SQL Server 2005 through SQL Server Data Tools and SQL Server Management Studio.

- **OLEDB Provider for DB2**  

  File name

  - _DB2OLEDB.msi_ (For SQL Server 2008 R2)

  - _DB2OLEDBV4.msi_ (For SQL Server 2012)

  Purpose

  The OLE DB Provider for DB2 v4.0 offers a set of technologies and tools for integrating vital data that is stored in IBM DB2 databases with new solutions. SQL Server developers and administrators can use the data provider with Integration Services, Analysis Services, Replication, Reporting Services, and Distributed Query Processor.

- **LocalDB**  

  File name

  _SqlLocalDB.msi_ (For SQL Server 2012)

  Purpose

  New to the SQL Server Express family, LocalDB is a lightweight version of Express that has the same programmability features, but it runs in user mode and has a fast, zero-configuration installation and a short list of prerequisites. Use this if you need a simple way to create and work with databases from code. Express can be bundled with Visual Studio, other Database Development tools or embedded with an application that needs local databases.

- **Transact-SQL Language Service**  

  File name

  _TSqlLanguageService.msi_ (For SQL Server 2012)

  Purpose

  The SQL Server Transact-SQL Language Service is a component that is based on the .NET Framework. This component provides parsing validation and IntelliSense services for Transact-SQL for SQL Server 2012, for SQL Server 2008 R2, and for SQL Server 2008.

## Explanation of Fix areas column in the Fix list KB articles for cumulative updates and service packs

| Fix area| A fix in this area can address issues related to (but not limited to) |
|---|---|
|Analysis Services (SSAS)|Issues or errors that are related to any operations or components of Analysis Services (for example, processing a cube, exceptions when you use analysis services components, and so on).|
|Connectivity|Issues or errors that may occur when a program connects to SQL Server that are caused by a bug or a problem with Client provider (such as System.Data, SQL OLE DB, and so on).|
|Data Quality Services (DQS)|Issues or errors when you use DQS or its components.|
|High Availability|Always On, Clustering, Log shipping, Database mirroring, and so on|
|Integration services (SSIS)|Issues or errors together with components that are related to SSIS (such as BI studio, SSIS service, and so on).|
|Management Tools|Issues or errors when you use various SQL Server tools (such as SQL Server management studio, Profiler, Database Engine Tuning Advisor and other SQL client tools).|
|Master Data Services (MDS)|Issues or errors when you use MDS and its components.|
|Reporting services (SSRS)|Issues or errors when you use Reporting services components (such as Report server, Report manager, Report designer, and so on).|
|Setup and Install|Issues or errors for installing SQL Server or any of its components.|
|SQL performance|Query or server-wide performance issues.|
|SQL security|Issues or errors for authentication, authorization, Transparent Data Encryption (TDE), Auditing, FIPS compliance, Server hardening and so on.|
|SQL Service|Issues when you use AVS, exceptions, non-yielding schedulers, Server stops responding, DBCC checks, backup or restore operations, Database mirroring, Database recovery, memory leaks, corruption, distributed or linked server queries, Replication and so on.|
|XML|Any issues that are related to MSXML, System.XML, XML Lite and so on.|
  
## Frequently asked questions

1. **I have SQL Server 2008. Do I need to apply both the SQL Server software update package and the SQL Server Native Client package on the server to get all SNAC fixes (for example, consider linked server scenario where server is also a client)?**  

    If client and server are on the same machine, individually installing the SQL Server Native Client package is not required. If client and server are separate, apply the SQL Native Client package to the client, and apply the SQL Server Software Update Package to the server to get all updates.

2. **I have SQL Server 2005. Do I need to apply both the SQL Server software update package and the SQL Server Native Client package on the server to get all SNAC fixes?**

    Yes, both the SQL Server software update package and SQL Native Client Package are required to update the server and must be downloaded separately.

3. **Do I need to install the Feature Pack and the SQL Server Software Update Package?**  

    Each KB article will clearly identify the packages that need to be applied to the computer to obtain the described fix. SNAC and other MSI's (SQLWriter, XMO, RS Sharepoint, RB Clickonce etc.) are version bumped every CU even if there are no new fixes.

4. **How will we adjust the KB's once we reach 999999?**  

    Our KB's are currently six digits but will be going to 7 soon. The schema shown above in this doc is using the Letter's KB plus five X's for a total of seven characters to show our expected schema once we cross the 1,000,000 mark. Until such time, do continue to use the given six-digit KB.

5. **How do I apply the _SQLWriter.msi_ feature pack?**

    At this time, you will need to run the _SQLWriter.msi_ after the CU or COD package that you have downloaded for you fix.

## Applies to

- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2005 Standard Edition
- SQL Server 2005 Standard X64 Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Evaluation Edition
- SQL Server 2005 Enterprise X64 Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Developer Edition
- SQL Server 2005 Workgroup Edition
