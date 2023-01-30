---
title: The hybrid buffer pool with direct write feature is enabled by default
description: Describes the improvement to enable the hybrid buffer pool with direct write feature by default.
ms.date: 02/15/2023
ms.custom: KB5022972
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# KB5022972 - Improvement: The hybrid buffer pool with direct write feature is enabled by default

## Summary

This improvement removes the trace flag requirement for the hybrid buffer pool with direct write feature and enables this feature by default in SQL Server 2022. Additionally, we add a trace flag to disable the `Direct Write` behavior for troubleshooting or debugging purposes.

> [!NOTE]
> The PMM page protection is only enabled under the existing trace flag.

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
