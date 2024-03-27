---
title: SQL CUs must be installed on secondary sites
description: Describes that SQL Server cumulative updates must be manually installed on secondary sites that use SQL Server Express.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo
ms.custom: sap:Configuration Manager Database\SQL Settings and Configuration
---
# SQL Server cumulative updates must be manually installed on secondary sites that use SQL Server Express

This article describes that SQL Server cumulative updates must be manually installed on secondary System Center 2012 Configuration Manager sites that use SQL Server Express.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2688247

## System Center 2012 Configuration Manager

The original RTM version of System Center 2012 Configuration Manager installs SQL Server Express 2008 R2 Service Pack 1 (SP1) when you deploy a new secondary site. The minimum supported SQL Server version is Cumulative Update 4 for SQL Server 2008 R2 SP1. You must manually install Cumulative Update 4 for SQL Server 2008 R2 SP1 on the new secondary site after the site is installed.

  For more information about Cumulative Update 4 for SQL Server 2008 R2 SP1, see ([Cumulative update package 4 for SQL Server 2008 R2 Service Pack 1](https://support.microsoft.com/help/2633146)).

## System Center 2012 Configuration Manager SP1

While the RTM version of System Center 2012 Configuration Manager requires Cumulative Update 4 for SQL Server 2008 R2 SP1, System Center 2012 Configuration Manager SP1 requires Cumulative Update 6 for SQL Server 2008 R2 SP1 (or SQL Server 2008 R2 SP2).

  If you attempt to upgrade a secondary site to SP1 from the primary console and the SQL version on the secondary site is not at the proper level, the UI will indicate that prerequisite checks failed and suggest checking the ConfigMgrPrereq.log on the primary site. The log will show something similar to the following:

  > <01-04-2013 16:25:14> INFO: Check Sql version on secondary site.  
  > <01-04-2013 16:25:28> INFO: RemoteCheckSqlVersion result:9  
  > <01-04-2013 16:25:28> *secondary.contoso.com*; SQL Server version; Error; Configuration Manager sites require a supported SQL Server version with required hotfixes for site database operations to succeed. Before Setup can continue, you must install a supported version of SQL Server on the specified site database server. For more information, see [http://go.microsoft.com/fwlink/p/?LinkID=232936](https://go.microsoft.com/fwlink/p/?LinkID=232936).

  If you wish to upgrade to System Center 2012 Configuration Manager SP1 on these secondary sites, you must first manually upgrade SQL on your secondary sites to Cumulative Update package 6 for SQL Server 2008 R2 SP1 (or SQL Server 2008 R2 SP2) before beginning the Configuration Manager SP1 upgrade process.

  For more information about Cumulative Update 6 for SQL Server 2008 R2 SP1, see [Cumulative update package 6 for SQL Server 2008 R2 Service Pack 1](https://support.microsoft.com/help/2679367).

  For more information about SQL Server 2008 R2 SP2, see [SQL Server 2008 R2 Service Pack 2](https://www.microsoft.com/download/details.aspx?id=30437).
