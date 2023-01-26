---
title: Add permission check and change procedure in sys.sp_xtp_force_gc
description: Describes the improvement to add the permission check in sys.sp_xtp_force_gc and change the procedure to a single call for allocated and used bytes.
ms.date: 02/15/2023
ms.custom: KB5022975
appliesto:
- SQL Server 2022 on Windows
---
# KB5022975 - Improvement: Add the permission check in sys.sp_xtp_force_gc and change the procedure to a single call for allocated and used bytes

## Summary

This improvement adds the permission check in the procedure `sys.sp_xtp_force_gc`, and you need at least the control server-level permission to run this procedure. Additionally, it changes the implementation of the procedure to a single call for allocated and used bytes that are not freed after use.

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
