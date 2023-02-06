---
title: Log Reader Agent reader thread may generate an assertion dump on a publisher
description: Fixes an issue in which the Log Reader Agent reader thread generates an assertion dump on a publisher.
ms.date: 02/15/2023
ms.custom: KB5022970
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2022 on Windows
---
# KB5022970 - FIX: Log Reader Agent reader thread may generate an assertion dump on a publisher

## Symptoms

Consider the following scenario:

- You have a transactional replication setup.
- You execute the `sp_changearticle` stored procedure to change the property of an article on the publisher, and data manipulation language (DML) changes occur on the published table.

In this scenario, the Log Reader Agent reader thread may generate the following assertion dump when processing the log records:

>\* Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;replrowset.cpp:2226</br>
\* Expression:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(LSN)m_curLSN < (LSN)(pSchemas->schema_lsn_begin)</br>
\* SPID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<SPID></br>
\* Process ID:&nbsp;&nbsp;&nbsp;&nbsp;\<ProcessID>

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
