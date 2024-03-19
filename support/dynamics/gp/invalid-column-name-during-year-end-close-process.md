---
title: Invalid column name error during Year-End Close process
description: You may receive the Invalid column name error during Year-End Close process with Analytical Accounting installed in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Invalid column name 'X'" during Year-End Close process with Analytical Accounting installed

This article provides a resolution for the issue that error occurs when closing the GL Year with Analytical Accounting installed in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3052955

## Symptoms

When closing the GL Year with Analytical Accounting installed, this error message happens:

> [Microsoft][SQL Server Native Client 10.0][SQL Server]Invalid column name '1'.  
[Microsoft][SQL Server Native Client 10.0][SQL Server]Invalid column name '2'.  
[Microsoft][SQL Server Native Client 10.0][SQL Server]Invalid column name '3'.  
[Microsoft][SQL Server Native Client 10.0][SQL Server]Invalid column name '4'.  
The stored procedure aagYearEndCloseMain returned the following results: DBMS: 207, Microsoft Dynamics GP:.

## Cause

The **Consolidate balances during Year End Close** checkboxes are marked on the individual dimensions(s), however the **Include dimensions in the year end close** isn't marked at the main AA setup Options level. This checkbox is grayed out on the individual dimensions and doesn't show as marked, however, if you look in the AAG00400 dimension table, the aaIncYEC column is in fact marked.

This may happen if you had the main setup Options level marked at one time and then marked the individual dimensions. However, you then went back and unmarked the main setup Options level. This leaves the dimensions still marked to be included in the year-end close process in the SQL table and causes the issue because of the mismatched settings.

## Resolution

Basically, if the dimensions are marked, then the main setup Options level for AA should also be marked, or if the main setup level isn't marked, then the dimensions shouldn't be marked either. Have either all marked or all unmarked. When one level is marked and the other isn't marked, the error message will happen. Use the appropriate method below, depending on whether you want the AA dimensions included in the year-end close process or not:

Option 1 - If you don't want AA dimensions included in the year-end:

1. Go to Microsoft Dynamics GP, select **Tools**, select **Setup**, point to **Company**, point to **Analytical Accounting**, and select **Options** and mark **Include dimensions in the year end close**.
2. Then go to each dimension code and unmark **Consolidate balances during Year End Close** on each and save.
3. Then go back to the main level again and unmark the **Include dimensions in the year end close** again.

Option 2 - If you do want AA dimensions included in the year-end:

1. Go to Microsoft Dynamics GP, select **Tools**, select **Setup**, point to **Company**, point to **Analytical Accounting**, and select **Options** and mark **Include dimensions in the year end close**.
2. Verify the **Consolidate balances during Year End Close** checkbox is marked on each dimension that you want consolidated.

## More information

Usually once users mark the dimensions to be included in the year-end process, they don't go back and unmark it. So, because of the easy work-around for this issue and not many users go back to unmark it to cause the mismatch, this would have a low-priority rating, so this issue wasn't logged as a quality issue at this time.
