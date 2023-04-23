---
title: Update automatic tuning to avoid missing slower query execution plans
description: Updates automatic tuning to avoid missing slower query execution plans when checking for plan regressions.
ms.date: 05/11/2023
ms.custom: KB5026842
author: Elena068
ms.author: v-qianli2
ms.reviewer:
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# Improvement: Update automatic tuning to avoid missing slower query execution plans

## Summary

This improvement adds multiple consecutive checks and additional check time to automatic tuning to avoid missing slower query execution plans when checking for plan regressions. The following trace flags are introduced in this improvement:

- 12618 - This trace flag enables the new model that uses multiple checks.
- 12656 - This trace flag adds five more minutes to the check.

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 4 for SQL Server 2022](cumulativeupdate4.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
