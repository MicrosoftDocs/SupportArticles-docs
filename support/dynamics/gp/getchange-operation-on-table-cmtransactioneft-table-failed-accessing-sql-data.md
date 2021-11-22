---
title: Payables batch shows error after an upgrade to Dynamics GP 2010
description: Provides a solution to an error that occurs when a payables batch goes to batch recovery.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# Error "A get/change operation on table cmTransactionEFT failed accessing SQL Data; Invalid column name 'BCHSOURC'" in Payables Management in Microsoft Dynamics GP 2010

This article provides a solution to an error that occurs when a payables batch goes to batch recovery.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2453132

## Symptoms

A payables batch goes to batch recovery and displays the following error message after an upgrade to Microsoft Dynamics GP 2010:

> A get/change operation on table cmTransactionEFT failed accessing SQL Data
>
> Invalid column name 'BCHSOURC'

## Cause

The cmTransctionEFT table may have failed during the upgrade and was not fixed properly. A new column BCHSOURC was added to the cmTransactionEFT (CM20202) table in Microsoft Dynamics GP 2010.

## Resolution

Recreate the CM20202 table using the Professional Services Tools Library to get the new field added to the table to resolve the issue. To do this, follow these steps:

1. Make a current backup of the company and Dynamics databases.

2. Install Professional Services Tools Library (PSTL) from Add/Remove Programs.

3. Create a shortcut to access PSTL. To do this, right-click **Shortcuts**, click **Add**, click **Add Window**, expand **Technical Service Tools**, expand **Project**, click to select **Professional Services Tools Library**, click **Add**, and then click **Done**.

4. Click the shortcut you created to open PSTL.

5. If prompted for registration keys, click **Cancel**. (The toolkit is free so you don't need any registration keys.)

6. Mark the Toolkit, and then click **Next**.

7. Click to select **Recreate SQL Objects**, and then click **Next**.

8. Select the Financial series.

9. Select the dbo.CM20202 table.

10. Click to mark Recreate Selected Table.

11. Be sure to mark the Recreate data for selected tables(s) checkbox. If this box is not marked, you will lose any data currently in the table, so it is important to make sure this box is also marked.

12. Click **Perform Selected Maintenance**.

Now test again and the error message should no longer occur.

## More information

This is an issue only with an upgrade to Microsoft Dynamics GP 2010. The issue does not happen in prior versions.
