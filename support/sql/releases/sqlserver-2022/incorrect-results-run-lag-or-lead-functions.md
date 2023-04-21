---
title: Incorrect results when running LAG or LEAD window functions
description: Fixes an error that occurs when running LAG or LEAD window functions with the IGNORE NULLS option.
ms.date: 05/11/2023
ms.custom: KB5026655
author: Elena068
ms.author: v-qianli2
ms.reviewer:
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# FIX: Incorrect results when running LAG or LEAD window functions

## Symptoms

Incorrect results are returned when you run `LAG` or `LEAD` window functions that use the `IGNORE NULLS` option.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 4 for SQL Server 2022](cumulativeupdate4.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
