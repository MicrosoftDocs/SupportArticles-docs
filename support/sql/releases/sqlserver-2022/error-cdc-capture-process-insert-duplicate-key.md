---
title: Error when CDC capture process inserts duplicate key in cdc.lsn_time_mapping
description: Describes an issue where error occurs when Change Data Capture (CDC) capture process tries to insert duplicate key in the cdc.lsn_time_mapping table in SQL Server 2022 or 2019.
ms.date: 01/19/2023
ms.custom: KB5022979
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---
# KB5022979 - FIX: Error occurs when CDC capture process tries to insert duplicate key in table "cdc.lsn_time_mapping" in SQL Server

## Symptoms

Assume that Change Data Capture (CDC) is enabled in Microsoft SQL Server 2022 or 2019. Because of a timing issue, CDC capture process may try to insert duplicate `start_lsn` in the table `cdc.lsn_time_mapping`, and you may receive an error message that resembles the following:

> Violation of PRIMARY KEY constraint 'lsn_time_mapping_clustered_idx'. Cannot insert duplicate key in object 'cdc.lsn_time_mapping'. The duplicate key value is (Value).

## Resolution

This problem is fixed in the following cumulative updates for SQL Server:

- :::image type="icon" source="../media/download-icon.png" border="false":::  [Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)
- :::image type="icon" source="../media/download-icon.png" border="false":::  [Cumulative Update 19 for SQL Server 2019](https://support.microsoft.com/topic/b63d7163-e2e7-46f7-b50a-c3d1f2913219)

> [!NOTE]
> This fix covers all the cases. For the same issue that occurs in SQL Server 2019 that has a previous cumulative update installed, SQL Server 2017, and SQL Server 2016, see the previous fix [KB 4521739](https://support.microsoft.com/topic/dd6ee9c4-f5fd-1509-96a3-3f3562391fa3). However, the previous fix didn't cover all the cases.

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

- Latest cumulative update for SQL Server 2022
- [Latest cumulative update for SQL Server 2019](https://support.microsoft.com/topic/782ed548-1cd8-b5c3-a566-8b4f9e20293a)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
