---
title: Block the change tracking side table truncation when the base table is truncated
description: Describes the improvement that blocks the truncation of the change tracking side table when the base table is truncated.
ms.date: 2/15/2023
ms.custom: KB5022966
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2022 on Windows
---
# KB5022966 - Improvement: Block the change tracking side table truncation when the base table is truncated

## Summary

This improvement blocks the truncation of the change tracking side table when the corresponding base table is truncated in Microsoft SQL Server 2022. Therefore, you can share a database backup that has all data from the side table with Microsoft for troubleshooting issues related change tracking.

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
