---
title: The Get-SCDWJob cmdlet is slow or times out
description: Fixes an issue in which the Get-SCDWJob cmdlet is slow or times out when the fn_OrchestrationJobHistoryView function runs for a long time.
ms.date: 04/08/2024
ms.reviewer: austinm, meerak, khusmeno
---
# The Get-SCDWJob cmdlet times out when the fn_OrchestrationJobHistoryView function runs for a long time

This article helps you fix an issue in which the `Get-SCDWJob` cmdlet is slow or times out when the `fn_OrchestrationJobHistoryView` function runs for a long time.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 4089660

## Symptoms

When there is too much process activity by Microsoft SQL Server that involves the `fn_OrchestrationJobHistoryView` function, the `Get-SCDWJob` cmdlet takes more than several seconds to run. In a worst-case scenario, the `Get-SCDWJob` cmdlet times out after 30 minutes and generates a message that resembles the following:

> get-scdwjob :  The requested operation timed out.

## Cause

This issue occurs when the following conditions are true:

- The `fn_OrchestrationJobHistoryView` function from the `DWStagingAndConfig` data source is called.
- The function has a string that contains thousands of process IDs.

In this situation, the function must be optimized to significantly improve performance so that the loop processes only the process IDs that are of interest before the loop is entered instead of doing this after the loop is entered.

## Resolution

To resolve this issue, follow these steps:

1. Start SQL Server Management Studio.
2. Expand the **DWStagingAndConfig** database, expand **Programmability**, expand **Functions**, and then expand **Table-valued Functions**.
3. Locate the `dbo.fn_OrchestrationJobHistoryView` function.
4. Right-click the function, and then click **Modify**.
5. Locate the following line in the code:

   `INSERT INTO @tempProcessTable(value) SELECT value from dbo.fn_ParseIntListInOrder(@ProcessIdList)`

6. Add two hyphens to the beginning of this line, as follows:

    `-- INSERT INTO @tempProcessTable(value) SELECT value from dbo.fn_ParseIntListInOrder(@ProcessIdList)`

7. Add the following line:

    `INSERT INTO @tempProcessTable(value) SELECT id FROM [Infra].[OrchestrationProcessView] WHERE id IN (SELECT value from dbo.fn_ParseIntListInOrder(@ProcessIdList)) AND (CategoryName not in ('Deployment','Execution'))`

8. To apply the changes, click **Execute**. If you accidentally change more than intended, close the query window without clicking **Execute**. If the function is currently being used, execution will be delayed. Execution of change takes 1 second or less unless the function is currently being used.

## More information

The `Get-SCDWJob` cmdlet is not the only entity that calls the `fn_OrchestrationJobHistoryView` function. In the most severe case, the running time decreased from more than 30 minutes to less than 2 seconds.
