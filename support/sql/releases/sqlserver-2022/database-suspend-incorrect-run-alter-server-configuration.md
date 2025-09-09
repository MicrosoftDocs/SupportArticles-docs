---
title: Database is suspended incorrectly when you run ALTER SERVER CONFIGURATION
description: Fixes an issue where database is in an incorrect suspended state after errors occur when you run ALTER SERVER CONFIGURATION to suspend the server for a snapshot backup.
ms.date: 11/14/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5048510
ms.reviewer: rvuppula, nicolasbruno, v-cuichen
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# FIX: Database is suspended incorrectly when you run ALTER SERVER CONFIGURATION

## Symptoms

When you run `ALTER SERVER CONFIGURATION` to suspend the server for a snapshot backup, you might occasionally notice that the database is in an incorrect suspended state after an error occurs. The error that occurs when suspending the server for a snapshot backup is similar to the following error:

> Msg 9018, Level 16, State 1, Line \<LineNumber>  
> The log for database \<DatabaseName> does not allow user writes.
>
> Msg 5901, Level 16, State 1, Line \<LineNumber>  
> One or more recovery units belonging to database \<DatabaseName> failed to generate a checkpoint. This is typically caused by lack of system resources such as disk or memory, or in some cases due to database corruption. Examine previous entries in the error log for more detailed information on this failure.

After this error occurs, the suspended database count on the server shows 0, but not all the databases are unsuspended correctly.

This situation causes the following error when you run the `ALTER SERVER CONFIGURATION` command to suspend the server for a subsequent snapshot backup:

> Msg 3081, Level 16, State 4, Line \<LineNumber>  
> Database \<DatabaseName> was previously suspended for snapshot backup.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 16 for SQL Server 2022](cumulativeupdate16.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
