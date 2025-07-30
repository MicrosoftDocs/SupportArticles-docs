---
title: Error may occur when setting the SQL Server Agent job history log
description: Fixes an error that occurs when setting or changing the maximum number of job history log rows and job history rows per job.
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5024352
ms.reviewer: derekw, pcaronauger, v-qianli2
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2019 on Linux
---
# FIX: Error may occur when setting the SQL Server Agent job history log

## Symptoms

Assume that the Microsoft SQL Server Agent is enabled within a SQL Server instance on a Linux installation. When you try to set or change the maximum number of rows for the job history log and the maximum number of job history rows per job, the following error may occur:

> Msg 0, Level 11, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded.

## Resolution

Two new SQL Server Agent properties, `sqlagent.jobhistorymaxrows` and `sqlagent.jobhistorymaxrowsperjob`, have been added to the `mssql-conf` configuration utility. These settings allow you to set the maximum number of rows for the job history log and the maximum number of job history rows per job, respectively.

Example: </br>`sudo /opt/mssql/bin/mssql-conf set sqlagent.jobhistorymaxrows 1000` </br>`sudo /opt/mssql/bin/mssql-conf set sqlagent.jobhistorymaxrowsperjob 100`

> [!NOTE]
> The two properties can't be configured by using SQL Server Management Studio (SSMS).

This problem is fixed in the following cumulative updates for SQL Server:

- [Cumulative Update 2 for SQL Server 2022](cumulativeupdate2.md)
- [Cumulative Update 20 for SQL Server 2019](../sqlserver-2019/cumulativeupdate20.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

- [Latest cumulative update for SQL Server 2022](build-versions.md)
- [Latest cumulative update for SQL Server 2019](../sqlserver-2019/build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
