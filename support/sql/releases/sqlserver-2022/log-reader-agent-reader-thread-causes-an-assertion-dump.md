---
title: Log Reader Agent reader thread causes an assertion dump on a publisher
description: Describes the symptoms that the Log Reader Agent reader thread causes an assertion dump on a publisher.
ms.date: 02/15/2023
ms.custom: KB5022970
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2022 on Windows
---
# KB5022970 - FIX: Log Reader Agent reader thread causes an assertion dump on a publisher

## Symptoms

The Log Reader Agent reader thread causes an assertion dump on a publisher when a data manipulation language (DML) transaction log record appears between `sp_changearticle` transaction log records. Here is the failed assertion expression:

(LSN)m_curLSN < (LSN)(pSchemas->schema_lsn_begin) 

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.