---
title: Error 3801 when a database is suspended in single-user mode during a T-SQL snapshot backup
description: Describes the symptoms that error 3801 occurs when a database is suspended in single-user mode during a T-SQL snapshot backup.
ms.date: 02/15/2023
ms.custom: KB5023106
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2022 on Windows
---
# KB5023106 - FIX: Error 3801 when a database is suspended in single-user mode during a T-SQL snapshot backup

## Symptoms

In Microsoft SQL Server 2022, the Transact-SQL snapshot backup logic is broken when a database is suspended in single-user mode. You can see the following error message:

>Msg 3081, Level 16, State 9, Line <*LineNumber*></br>
Database '*DatabaseName*' was previously suspended for snapshot backup.</br>
Msg 5069, Level 16, State 1, Line <*LineNumber*></br>
ALTER DATABASE statement failed.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.