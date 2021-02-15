---
title: Error 556 insert exec failed
description: This article helps you work around the problem where a stored procedure in a database that is using Query Data Store feature periodically fails.
ms.date: 09/02/2020
ms.prod-support-area-path: Database Design and Development
ms.reviewer: nathansc, dajiro
ms.prod: sql
---
# INSERT EXEC failed because the stored procedure altered the schema of the target table error in SQL Server 2016

This article helps you work around the problem where a stored procedure in a database that is using Query Data Store feature periodically fails.

_Original product version:_ &nbsp; SQL Server 2016  
_Original KB number:_ &nbsp; 4465511

## Symptoms

Consider the following scenario:

- You have a Microsoft SQL Server 2016 database that's using the Query Data Store feature.
- You have a stored procedure that makes a call to another stored procedure by using *INSERT...EXEC* syntax.
- The Query Data Store periodically runs auto-cleanup as the size increases to its maximum configured size, and the Query Data Store changes status `fromREAD_WRITEtoREAD_ONLY`.

In this scenario, parent stored procedure execution periodically fails, and you receive an error message that resembles the following:

> Msg 556, Level 16, State 2, Line 5  
INSERT EXEC failed because the stored procedure altered the schema of the target table.

## Cause

When the Query Data Store runs auto-cleanup, this flush plans out of Query Data Store. The query encounters a recompile operation because the plan is missing from Query Data Store, but the plan is still present in the procedure cache. By design, when the recompile operation occurs, SQL Server throws error 556 to prevent duplicate execution of the child procedure, which would result in incorrect results being returned.

## Workaround

To work around this issue, follow these steps:

1. Increase the size of the Query Data Store. This will reduce the frequency or likelihood of the Query Data Store clearing out the plan and entering `READ_ONLY` operating mode.
2. Add error handling to your code to catch error 556, and then resubmit the `INSERT EXEC` query.
3. Clear the procedure cache when Query Data Store comes back to `READ_WRITE` state from `READ_ONLY`.

## Additional information

Because of the changes that were made to Query Data Store in Microsoft SQL Server 2017, this issue does not occur in SQL Server 2017. This issue won't be fixed in SQL Server 2016.
