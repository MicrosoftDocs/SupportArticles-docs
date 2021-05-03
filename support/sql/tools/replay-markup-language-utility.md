---
title: Replay Markup Language Utilities
description: This article describes a group of utilities that support professionals use to troubleshoot SQL Server.
ms.date: 09/03/2020
ms.prod-support-area-path: Tools
ms.reviewer: sureshka, jopilov, toddhay, troymoen
ms.topic: article
ms.prod: sql
---
# Description of the Replay Markup Language Utilities for SQL Server

This article describes a group of utilities that support professionals use to troubleshoot SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 944837

## Introduction

The SQL Server support team uses several internally written utilities to ease the work that is related to a typical customer support case. This article describes one utility suite that is called the Replay Markup Language (RML) Utilities for SQL Server. Database developers and system administrators can use the RML Utilities for SQL Server.

## More information

You can use the RML Utilities for SQL Server to perform the following tasks:

- You can determine the application, the database, the SQL Server login, or the query that is using the most resources.
- You can determine whether the execution plan for a batch is changed when you capture the trace for the batch. Additionally, you can use the RML Utilities for SQL Server to determine how SQL Server performs each of these execution plans.
- You can determine the queries that are running slower than before.

After you capture a trace for an instance of SQL Server, you can use the RML Utilities for SQL Server to replay the trace file against another instance of SQL Server. If you also capture the trace during the replay, you can use the RML Utilities for SQL Server to compare the new trace file to the original trace file. You can use this technique to test how SQL Server behaves after you apply changes. For example, you can use this technique to test how SQL Server behaves after you do the following:

- You install a SQL Server service pack.
- You install a SQL Server hotfix.
- You update a stored procedure or a function.
- You update an index or create an index.

## Version history

|Version number|Description|
|---|---|
|9.04.0098|The current release packaged with Database Experimentation Assistant utility that supports all released versions of SQL Server|
|9.04.0097|The current release available from the SQL Nexus site that supports all released versions of SQL Server|
|9.04.0051|The previous Web release available from www.microsoft.com/download that supports SQL Server 2000, SQL Server 2005, SQL Server 2008 SQL Server 2008 R2, SQL Server 2012 and SQL Server 2014|
|9.04.0004|The previous Web release that supports SQL Server 2000, SQL Server 2005, SQL Server 2008 SQL Server 2008 R2, SQL Server 2012 and SQL Server 2014|
|9.01.0109|The previous Web release that supports SQL Server 2000, SQL Server 2005, SQL Server 2008 and SQL Server 2008 R2.|
|9.00.0023|The previous Web release that supports SQL Server 2000 and SQL Server 2005|
|8.10.0010|The initial Web release that supports SQL Server 7.0 and SQL Server 2000|
|||

This current version of the RML Utilities for SQL Server supersedes any earlier versions. You must uninstall any earlier version of the RML Utilities for SQL Server before you install the current version. The current version of the RML Utilities for SQL Server provides support for SQL Server 2000, SQL Server 2005, SQL Server 2008, SQL Server 2008 R2, SQL Server 2008 R2, SQL Server 2012, SQL Server 2014, SQL Server 2016, SQL Server 2017, SQL Server 2019. Additionally, the current version of the RML Utilities for SQL Server contains important software updates, improved features (process .trc and .xel files) and reports, and performance and scalability improvements.

## Obtain the RML Utilities for SQL Server

When you install the [Database Experimentation Assistant](https://www.microsoft.com/download/details.aspx?id=54090) you can get the RML utilities (ReadTrace and ostress) from the folder: C:\Program Files (x86)\Microsoft Corporation\Database Experimentation Assistant\Dependencies\X64\

If you are using RML utilities along with [SQL Nexus](https://github.com/microsoft/SqlNexus/wiki) utility, you can obtain ReadTrace and ostress from the location: https://github.com/microsoft/SqlNexus/releases/tag/09.04.0097

The RML Utilities for SQL Server is available for download from the [Download Center](https://www.microsoft.com/download/details.aspx?id=4511)

> [!NOTE]
> Microsoft provides the RML Utilities for SQL Server as-is. Microsoft Customer Support Services (CSS) does not provide support or updates for the RML Utilities for SQL Server. If you have a suggestion or if you want to report a bug, you can use the e-mail address in the Problems and Assistance topic in the Help file (*RML Help.pdf*). The Help file is included with the RML Utilities for SQL Server.

## Benefits of the RML Utilities for SQL Server

The RML Utilities for SQL Server are useful if you want to simulate application testing when it is impractical or impossible to test by using the real application. For example, in a test environment, it may be difficult to generate the same user load that exists in the production environment. You can use the RML Utilities for SQL Server to replay a production workload in a test environment and assess the performance impact of changes, such as an upgrade to SQL Server 2008 or the application of a SQL Server service pack. Additionally you can use the RML Utilities for SQL Server to analyze and compare various replay workloads. This kind of regression analysis would otherwise be a difficult process that you would have to perform manually.

The Help file contains a Quick Start topic. This topic includes a brief exercise that will familiarize you with each RML utility. To open the Help file, click **Start**, point to **All Programs**, point to **RML Utilities for SQL Server**, point to **Help**, and then click **RML Help**.

## Utilities in the RML Utilities for SQL Server

The RML Utilities for SQL Server contain the following utilities:

- ReadTrace
- Reporter
- OStress
- OStress Replay Control Agent (ORCA)

For a complete description of each utility and sample usage, see the RML Help that is included with the RML Utilities for SQL Server.
