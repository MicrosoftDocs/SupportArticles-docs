---
title: Restore operation fails on Linux servers
description: This article provides a workaround for the problem where a SQL database restore operation fails on Linux servers.
ms.date: 01/15/2021
ms.custom: sap:SQL Server on Linux
ms.reviewer: houdu, pradm, mikehab, ramakoni
ms.topic: article 
---
# SQL database restore operation fails on Linux servers

This article helps you work around the problem where a SQL database restore operation fails on Linux servers.

_Applies to:_ &nbsp; SQL Server 2017 on Linux, SQL Server 2017 Developer Linux, SQL Server 2017 Enterprise Core Linux, SQL Server 2017 Enterprise Linux, SQL Server 2017 Standard Linux  
_Original KB number:_ &nbsp; 4519691

## Symptoms

When you try to restore a SQL database on a Microsoft SQL Server 2017 Linux server, the operation fails during the restore process and returns an error message that resembles the following:

> MODIFY FILE encountered operating system error 31(A device attached to the system is not functioning.) while attempting to expand the physical file

## Cause

This problem may occur because the hard disk has run out of space. On Linux servers, SQL Server does not check the available space before the operation starts.

## Workaround

To work around this problem, restore the database on a volume that has enough space.

## References

Learn about the [Description of the standard terminology that is used to describe Microsoft software updates](../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
