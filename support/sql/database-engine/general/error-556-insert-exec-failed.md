---
title: Error 556 insert exec failed
description: This article helps you work around the periodic failure of a stored procedure in a database that is using the Query Data Store feature.
ms.date: 09/02/2020
ms.custom: sap:Database Design and Development
ms.reviewer: nathansc, dajiro
---
# "INSERT EXEC fails because the stored procedure altered the schema of the target table" error in SQL Server 2016

This article helps you work around a problem that occurs because a stored procedure in a database that's using the Query Data Store feature periodically fails.

_Original product version:_ &nbsp; SQL Server 2016  
_Original KB number:_ &nbsp; 4465511

## Symptoms

Consider the following scenario:

- You have a Microsoft SQL Server 2016 database that's using the Query Data Store feature.

- You have a stored procedure that makes a call to another stored procedure by using the `INSERT...EXEC` syntax.

- The Query Data Store feature periodically runs auto-cleanup as it increases to its maximum configured size. Additionally, the Query Data Store state changes from `READ_WRITE` to `READ_ONLY`.

In this scenario, parent stored procedure execution periodically fails, and you receive an error message that resembles the following:

> Msg 556, Level 16, State 2, Line *LineNumber*  
INSERT EXEC failed because the stored procedure altered the schema of the target table.

## Cause

The auto-cleanup process flushes the plan out of Query Data Store. The query encounters a recompile operation because the plan is missing from Query Data Store. However, the plan is still present in the procedure cache. By design, when the recompile operation occurs, SQL Server throws error 556 to prevent duplicate execution of the child procedure. Such a duplicate operation would cause incorrect results to be returned.

## Resolution

### Service Pack information for SQL Server 2016

This issue is fixed in the following service pack for SQL Server:  

[Service Pack 3 for SQL Server 2016](https://support.microsoft.com/help/5003279)

**About service packs for SQL Server:**  

Service packs are cumulative. Each new service pack contains all the fixes that are in previous service packs, together with any new fixes. We recommend that you apply the latest service pack and the latest cumulative update for that service pack. You don't have to install a previous service pack before you install the latest service pack. Refer to Table 1 in the following article for more information about the latest service pack and latest cumulative update:

[How to determine the version, edition and update level of SQL Server and its components](../../releases/download-and-install-latest-updates.md)

## Workaround

To work around this issue, follow these steps:

1. Increase the size of the Query Data Store. This will reduce the frequency or likelihood of the Query Data Store clearing out the plan and entering the `READ_ONLY` operating mode.

2. Add error handling to your code to catch error 556, and then resubmit the `INSERT EXEC` query.

3. Clear the procedure cache when Query Data Store returns to `READ_WRITE` state from `READ_ONLY`.

## Additional information

Because of the changes that were made to Query Data Store in Microsoft SQL Server 2017, this problem doesn't occur in SQL Server 2017. This problem won't be fixed in SQL Server 2016.
