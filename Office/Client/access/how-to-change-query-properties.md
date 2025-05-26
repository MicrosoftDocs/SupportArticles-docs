---
title: How to modify query properties in Microsoft Access
description: Describes how to modify query properties in Microsoft Access, such as change the display of fields, create top value queries, add an alias for a table, change field captions and formatting.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
ms.reviewer: ROBCOO, SROULEAU
ms.date: 05/26/2025
---
# How to modify query properties in Microsoft Access

_Original KB number:_ &nbsp; 304356

This article applies only to a Microsoft Access database (.accdb and .mdb).

## Summary

This article shows you how to modify query properties in Microsoft Access. This information is useful if you want to perform such tasks as:

- Change the display of fields.
- Create top value queries.
- Add an alias for a table.
- Change field captions and formatting.

## More information

### Query Properties

To view all the query properties, in Design view of any query, right-click in an empty space in the query design window, and then click Properties  on the shortcut menu. In some versions of Access, the property sheet will open and default to the "Field List Properties". To display the Query Properties, left-click in an empty space in the query design window.

The following table lists all the query properties and explains what each one is used for.

|Property Name|Description|
|---|---|
|Description|You can use the Description property to provide information about objects contained in the Database window, as well as about individual table or query fields.|
|Default View|You can use the DefaultView property to specify the opening view of a query.|
|Output All Fields|You can use the OutputAllFields property to show all fields in the query's underlying data source and in the field list of a form or report. Setting this property is an easy way to show all fields without having to click the Show box in the query design grid for each field in the query.|
|Top Values|You can use the TopValues property to return a specified number of records or a percentage of records that meet the criteria that you specify. For example, you might want to return the top 10 values or the top 25 percent of all values in a field.|
|Unique Values|You can use the UniqueValues property when you want to omit records that contain duplicate data in the fields displayed in Datasheet view. For example, if a query's output includes more than one field, the combination of values from all fields must be unique for a particular record to be included in the results.|
|Unique Records|You can use the UniqueRecords property to specify whether to return only unique records based on all fields in the underlying data source, not just those fields present in the query itself.|
|Run Permissions|You can use the RunPermissions property in a multiuser environment with a secure workgroup to override the existing user permissions. This allows you to view a query or run an append, delete, make-table, or update query that you otherwise wouldn't have permission to run. For example, as a user, you may have read-only permission for queries, while the owner of the queries has read/write permission. If the owner sets the RunPermissions property to specify the owner's permissions, you can run an append query to add records to a table.|
|Source Database|The SourceDatabase property specifies the external database in which the source tables or queries for a query reside.|
|Source Connect Str|The SourceConnectStr property specifies the name of the application used to create an external database.|
|Record Locks|You can use the RecordLocks property to determine how records are locked and what happens when two users try to edit the same record at the same time.|
|Recordset Type|You can use the RecordsetType property to specify what kind of recordset is available.|
|ODBC Timeout|You can use the ODBCTimeout property to specify the number of seconds Microsoft Access waits before a time-out error occurs when a query is run on an Open Database Connectivity (ODBC) database. By setting this property to zero (0), no time-out will occur.|
|Filter|You can use the Filter property to specify a subset of records to be displayed when a filter is applied to a form, report, query, or table.|
|Order By|You can use the OrderBy property to specify how you want to sort records in a form, query, report, or table.|
|Max Records|Specifies the maximum number of records that will be returned by an ODBC database to a Microsoft Access database (.mdb).|
|Orientation|You can use the Orientation property to specify or determine the view orientation.|
|Subdatasheet Name|You can use the SubdatasheetName property to specify or determine the table or query that is bound to the subdatasheet.|
|Link Child Fields|You can use the LinkChildFields and LinkMasterFields properties together to specify how Microsoft Access links records in a form or report to records in a subform, subreport, or embedded object, such as a chart. If these properties are set, Microsoft Access automatically updates the related record in the subform when you change to a new record in a main form.|
|Link Master Fields|You can use the LinkChildFields and LinkMasterFields properties together to specify how Microsoft Access links records in a form or report to records in a subform, subreport, or embedded object, such as a chart. If these properties are set, Microsoft Access automatically updates the related record in the subform when you change to a new record in a main form.|
|Subdatasheet Height|You can use the SubdatasheetHeight property to specify or determine the display height of a subdatasheet when expanded.|
|Subdatasheet Expanded|You can use the SubdatasheetExpanded property to specify or determine the saved state of all subdatasheets within a table or query.|

#### Field List Properties

To view the field list properties, in Design view of any query, right-click in any cell in the query design grid, and then click Properties on the shortcut menu.

|Property Name|Description|
|---|---|
|Alias|You can use the Alias property to specify a custom name for a source table or query when you use the same table or query more than once in the same query.|
|Source|You can use the Source property to specify the source connection string and source database for a query's source table or query.|

> [!NOTE]
> The following two properties are not available in Access 2000:
>
> - Default
> - View Orientation
>
> The following two new properties were added in Access 2007 for queries:
>
> - Filter On Load
> - Order By On Load
