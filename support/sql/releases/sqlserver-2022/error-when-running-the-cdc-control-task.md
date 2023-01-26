---
title: Error when running the CDC Control task
description: Describes the symptoms that running the CDC Control task fails in Microsoft SQL Server 2022.
ms.date: 02/15/2023
ms.custom: KB5023021
appliesto:
- SQL Server 2022 on Windows
---
# KB5023021 - FIX: Error when running the CDC Control task

## Symptoms

Running the change data capture (CDC) Control task fails in Microsoft SQL Server 2022 because the 16.0 version of `Attunity.SqlServer.CDCControlTask.dll` refers to the 16.100 version of `Microsoft.SqlServer.DtsMsg.dll`.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.