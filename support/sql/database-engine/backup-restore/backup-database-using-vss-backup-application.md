---
title: Back up a database using a VSS backup application
description: This article provides a resolution for the problem that occurs when you use Volume Shadow Copy Services (VSS) based applications to back up your SQL Server databases.
ms.date: 09/19/2022
ms.custom: sap:Database Engine
---
# Backing up a SQL Server database using a VSS backup application may fail for some databases

This article helps you resolve the problem that occurs when you use Volume Shadow Copy Services (VSS) based applications to back up your SQL Server databases.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2014054

## Symptoms

When you use Volume Shadow Copy Services (VSS) based applications to back up your SQL Server databases, the backup operation may fail if the database name contains either leading or trailing spaces or non-printable characters.  

The same problem may also occur when you try to back up a volume that contains one of these databases.

## Cause

VSS based backup applications use `SQLServerWriter` (SQLWriter) to query Writer Metadata Component information to determine which database files need to be backed up. The Writer Metadata Component is created by SQLWriter using VSS API and contains three sets of data:

- Writer identification and classification information
- Writer-level specifications
- Component data

When a database name contains leading or trailing spaces or non-printable characters, this document may not be created successfully. As a result, VSS-based applications will not be able to back up these databases or any volumes that contain these databases.

## Resolution

Rename all databases that contain either leading or trailing spaces or unprintable characters in their names. You can use the following query to locate the presence of such characters in front or at end of the names:  

```sql
SELECT database_id AS DatabaseID, '##'+name+'##' AS DatabaseName FROM sys.databases  
```

Example output:

```output
DatabaseID         DatabaseName
8                  ##AdventureWorks##          -- DB name is fine
15                 ## DBWithLeadingSpace##     -- DB name contains leading spaces
17                 ##DBWithTrailingSpace ##    -- DB name contains trailing spaces  
```

> [!NOTE]
> In the preceding query, if the database name contains unprintable characters they may either be printed out as spaces or some junk.

## More information

Writers (like SQL Writer) add components using [IVssCreateWriterMetadata::AddComponent](/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addcomponent), specifying the following component information:

- Type
- Name
- Logical path (if any)
- Supported feature
- [Selectability](/windows/win32/vss/vssgloss-s)
- Metadata to be used by the writer during restore
- Display information
- Notification information

[C (Volume Shadow Copy Service)](/windows/win32/vss/vssgloss-c) are collections of files that form a logical unit for purposes of backup and restore. All files in a component (except those explicitly excluded) must be backed up and restored as a unit.

For more information, see [VSS Metadata](/windows/win32/vss/vss-metadata).

You can use one or more of the following methods to identify if you are running into this issue:

- Various backup applications may raise custom messages about `SqlServerWriter` (or SQLWriter) not being found.
- When you execute from a command prompt on the target SQL Server machine, you will not see `SqlServerWriter` in the output.  

    vssadmin list writers
