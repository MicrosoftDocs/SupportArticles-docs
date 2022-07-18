---
title: Unsupported and supported SharePoint database changes
description: Describes some unsupported and supported SharePoint database changes, and what actions you need to perform when you experience an unsupported database changes.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 164350
  - CSSTroubleshoot
ms.reviewer: xiaojhua
appliesto: 
  - SharePoint Foundation 2013
  - SharePoint Server 2013
  - SharePoint Server 2016 
search.appverid: MET150
ms.date: 7/18/2022
---

# Unsupported and supported SharePoint Server database changes

_Original KB number:_ &nbsp; 841057

Microsoft SharePoint Server stores data in Microsoft SQL Server databases, and it uses various stored procedures for the regular processing. Therefore, SQL Server databases are important to the successful operation of SharePoint Server. SharePoint Server is tested by using a database structure that's designed by the Microsoft SharePoint Server development team. Then, it's approved for release based on that structure. If you change the database, Microsoft can't reliably predict the effect to the operation of SharePoint Server. This article describes some unsupported and supported database changes, and what actions you need to perform.

> [!WARNING]
> Microsoft strictly prohibits all third-party changes to SharePoint Server databases. If you install or use any third-party tool to change data in SharePoint Server databases, the entire SharePoint Server farm becomes unsupported.

## Unsupported database changes

Unsupported database changes include, but are not limited to the following examples:

- Adding database triggers.
- Adding new indexes or changing existing indexes within tables. 
- Adding, changing, or deleting any primary or foreign key relationships.
- Changing or deleting existing stored procedures.
- Calling existing stored procedures directly, except the stored procedures that are described in the following articles:

  - [[MS-WSSFOB]: Windows SharePoint Services (WSS): File Operations Database Communications Base Protocol](/openspecs/sharepoint_protocols/ms-wssfob/252d2086-6571-430f-863d-bcaf9d267e62)  
  - [[MS-WSSFO3]: Windows SharePoint Services (WSS): File Operations Database Communications Version 3 Protocol](/openspecs/sharepoint_protocols/ms-wssfo3/46249efd-d184-42cc-baad-a605875ef783)

- Adding new stored procedures.
- Adding, changing, or deleting any data in any table of SharePoint Server databases.
- Adding, changing, or deleting any columns in any table of SharePoint Server databases. 
- Changing the database schema.
- Adding tables to SharePoint Server databases.
- Changing the database collation.
- Running the `DBCC_CHECKDB WITH REPAIR_ALLOW_DATA_LOSS` command.

  **Note** Running the `DBCC_CHECKDB WITH REPAIR_FAST` and `REPAIR_REBUILD` commands is supported, as these commands only update the indexes of the associated database.

- Executing ad hoc queries against SharePoint Server databases.
- Enabling SQL Server change data capture (CDC)
- Enabling SQL Server transactional replication.
- Enabling SQL Server merge replication.

If an unsupported database change is discovered during a support call, you must perform at least one of the following procedures:

- Perform a database restoration from the last known good backup that doesn't include the unsupported database change.  
- Roll back all the database changes.

If you can't perform either of the procedures, you must recover the data manually. The database must be restored to an unmodified state before Microsoft SharePoint Server Support can provide any data migration assistance.

If a database change is necessary, you should contact [Microsoft Support](https://support.microsoft.com/contactus) to determine whether a product issue exists and should be addressed.

## Supported database changes

For some specific usage scenarios, the prohibition against the database changes has the following exceptions:

- Operations that are initiated from the SharePoint Server administrative user interface.
- SharePoint Server specific tools and utilities (such as Ststadm.exe) that are provided directly by Microsoft.
- Changes that are made programmatically through the SharePoint Server object model and that are in compliance with the SharePoint Server SDK documentation.
- Activities that are in compliance with the [SharePoint Server protocols documentation](/openspecs/sharepoint_protocols/ms-spprotlp/8a50af28-2b50-43d8-9c5a-3e520255ef7e?redirectedfrom=MSDN).

Microsoft SharePoint Server support agents may provide scripts that change SharePoint Server databases during a support incident. In this case, all changes are reviewed by the SharePoint Server development team. This makes sure that the operations being performed won't result in an unstable or unsupported database state. During a support incident, database changes that are made with the guidance of a Microsoft SharePoint Server support agent won't result in an unsupported database state. You shouldn't reapply the scripts or changes that are provided by Microsoft SharePoint Server Support outside of a support incident.

## Unsupported read operations

Programmatically or manually reading from SharePoint Server databases may cause unexpected locking in SQL Server, which may affect the performance. Any read operations against SharePoint Server databases are considered unsupported if:

- The read operations use queries, scripts, .dll files (and so on) that are not provided by the Microsoft SharePoint Server development team or by the Microsoft SharePoint Server Support.  
- The read operations are identified as a barrier to the resolution for Microsoft Support.

In this scenario, the database is considered to be in an unsupported state. To return the database to a supported state, all unsupported read operations must be stopped.
