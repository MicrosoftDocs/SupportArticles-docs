---
title: The key name for the JSON_OBJECT function isn't quoted
description: Describes an issue where the key name for the JSON_OBJECT function isn't quoted.
ms.date: 02/15/2023
ms.custom: KB5022978
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# KB5022978 - FIX: The key name for the JSON_OBJECT function isn't quoted

## Symptoms

When the data type is a **numeric**, **Boolean**, or internal JSON data type, the key name for the `JSON_OBJECT` function isn't quoted in SQL Server 2022.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
