---
title: Database compatibility level causes low performance
description: Provides a workaround for an issue in which query performance is decreased or CPU usage is increased because of supported SQL Server database compatibility level for SharePoint Server 2016 installations.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: sharepoint-server-itpro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: sudeepg, troymoen, shaunbe, pelopes, sureshka, josack, alexek, rainera, abloesch, jopilov
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2016
- SharePoint Server 2016
search.appverid: MET150
---
# Supported SQL Server database compatibility level for SharePoint Server 2016 installations

_Original KB number:_ &nbsp; 4469993

## Symptom

When you use SharePoint Server 2016 together with Microsoft SQL Server version 2016 or 2017, you may notice decreased query performance or increased CPU usage on the database server.

## Cause

This issue happens because content databases that are created by SharePoint Server 2016 use the default database compatibility level for the version of SQL Server that the database is installed on. For example, if the SharePoint databases are deployed in an instance of SQL Server 2016, the databases are set to the 130 database compatibility level. Similarly, in an instance of SQL Server 2017, the databases are set to the 140 database compatibility level.

## Workaround

SharePoint Server 2016 content databases that are deployed on SQL Server versions 2016 and 2017 are tested and validated to work best with compatibility level 110. Therefore, we strongly recommend that you set the database compatibility level to 110 for SharePoint Server 2016 content databases. To change the compatibility level, run the following TSQL command:

```sql
ALTER DATABASE database_nameSET COMPATIBILITY_LEVEL = 110
```

You can view the compatibility level of all the databases in an instance of SQL Server by using the following TSQL query:

```sql
SELECT name, compatibility_level FROM sys.databases
```

## More information

The following table shows the supported database compatibility levels to use for different versions of SharePoint Server.

|Server version|Supported database compatibility level|
|---|---|
| SharePoint Server 2016| 110 |
| SharePoint Server 2019| 130 |
|||

For more information about database compatibility during version upgrades and a list of default and supported database compatibility levels for each version of SQL Server, see [ALTER DATABASE (Transact-SQL) compatibility level](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level) on the Microsoft Docs website.

## References

- [View or change the compatibility level of a database](/sql/relational-databases/databases/view-or-change-the-compatibility-level-of-a-database)
- [Recommended updates and configuration options for SQL Server 2017 and 2016 with high-performance workloads](https://support.microsoft.com/help/4465518)
