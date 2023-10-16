---
title: MDX query with calculated measure runs slowly
description: This article provides a resolution for the problem when a Multidimensional Expressions (MDX) query is executed with a calculated measure in SSAS 2016, 2017 and 2019 tabular instance.
ms.date: 01/14/2021
ms.reviewer: yinnw
ms.topic: troubleshooting
---
# MDX queries with calculated measure using the "/" operator run slowly in SSAS

This article helps you resolve the problem when a Multidimensional Expressions (MDX) query is executed with a calculated measure in SSAS 2016, 2017 and 2019 tabular instance.

_Applies to:_ &nbsp; Analysis Services, SQL Server 2016, SQL Server 2019, SQL Server 2017 on Windows, Analysis Cubes  
_Original KB number:_ &nbsp; 4560494

## Symptoms

When a Multidimensional Expressions (MDX) query is executed with a calculated measure in SSAS 2016, 2017 and 2019 tabular instance, the calculated measure runs slow and consumes lots of memories if it uses the `/` operator.

## Cause

An improved DIVIDE function allowing faster performance is available in both MDX and DAX. ​

## Resolution

Use the DIVIDE function instead of the `/` operator in the calculation.

## References

[terminDescription of the standard terminology that is used to describe Microsoft software updatesology](../../windows-client/deployment/standard-terminology-software-updates.md)
