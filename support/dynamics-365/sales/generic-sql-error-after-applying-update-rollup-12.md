---
title: Can't access web pages after applying Update Rollup 12
description: Fixes an issue in which you can't access any web page after applying Update Rollup 12 to Microsoft Dynamics CRM 2011 Server Update Rollup 11.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# An error occurs after applying Update Rollup 12 to Microsoft Dynamics CRM 2011 Server Update Rollup 11: Generic SQL Error

This article helps you fix an issue in which you can't access any web page after applying Update Rollup 12 to Microsoft Dynamics CRM 2011 Server Update Rollup 11.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2906374

## Symptoms

When trying to access any Microsoft Dynamics CRM 2011 web page after applying Update Rollup 12 on top of an Update Rollup 11 Dynamics CRM Server, an error occurs:

> \>Crm Exception: Message: Generic SQL error., ErrorCode: -2147204784, InnerException: System.Data.SqlClient.SqlException (0x80131904): Invalid column name 'ObjectTypeCodeName'.
>
> Invalid column name 'ObjectTypeCodeName'.

## Cause

This issue only occurs in one of the two following sequences has been met:

1. Update Rollup 12 is applied on top of a CRM Server version below Update Rollup 10.
2. The CRM Server is then rolled back to Update Rollup 11.
3. Update Rollup 12 is later applied on top of Update Rollup 11.

or

1. Update Rollup 12 is applied on top of Update Rollup 7.
2. The CRM Server is rolled back to Update Rollup 7.
3. An attempt to apply Update Rollup 11 is made; however, the file versions didn't change to the correct version number.
4. Update Rollup 15 is applied.

## Resolution

In order to resolve this issue, database updates must be made. Before doing this, you must first ensure you have a full backup of your CRM databases in SQL Server.

[Create a Full Database Backup](/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server)

Once that has been done, run the following two statements SQL Server Management Studio:

```sql
delete from MetadataSchema.Attribute where AttributeId in ('4456bbb5-0bad-4360-afca-74d099056116', 'c3dce60b-fd95-43b4-8d20-ea4bbcd5c436');

delete from AttributeIds where AttributeId in ('4456bbb5-0bad-4360-afca-74d099056116', 'c3dce60b-fd95-43b4-8d20-ea4bbcd5c436');
```

After removing these fields, you must complete an IISReset.
