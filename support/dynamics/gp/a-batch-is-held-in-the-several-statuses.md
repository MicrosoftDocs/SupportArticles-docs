---
title: A batch is held in the several statuses
description: Provides a solution to an error that occurs when you try to post a batch and open it in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.
ms.reviewer: kyouells, melissa
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to post a batch and open it in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850289

## Symptoms

After you try to post a batch in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, the batch is assigned one of the following statuses:

- Posting
- Receiving
- Busy
- Marked
- Locked
- Edited

You can't post or unmark the batch. When you try to open the batch, you may receive the following error message:
> "Batch is marked for posting by another user."

This problem occurs when you use Microsoft Dynamics GP together with Microsoft SQL Server.

## Cause

This issue may occur because a power fluctuation or some other problem caused the posting process to stop.

## Resolution

To fix the problem, use one of the options below. To have us fix this problem for you, go to the [Here's an easy fix](#heres-an-easy-fix) section. If you prefer to fix this problem manually, go to the [Let me fix it myself](#let-me-fix-it-myself) section.

### Here's an easy fix

To clear the SY00800 Batch Activity table and update the batch status in the SY00500 batch table automatically, select the **Download** button. In the **File Download** dialog box, select **Run** or **Open**, and then follow the steps in the easy fix wizard.

- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.

### Let me fix it myself

*Easy fix 50435*  
Follow these steps to fix this problem yourself:

> [!NOTE]
> All scripts that are in the "Resolution" section must be run in a query tool. To open the appropriate query tool, follow these guidelines:
>
> - If you're using Microsoft SQL Server 2000, run the statement in Query Analyzer. To open Management Studio, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2000** and then select **Query Analyzer**. To run a script, select **New Query**.
> - If you're using Microsoft SQL Server 2005, run the statement in Microsoft SQL Server Management Studio. To open Management Studio, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** and then select **SQL Server Management Studio**. To run a script, select **New Query**.
> - If you're using Microsoft SQL Server 2005 Express, run the statement in Microsoft SQL Server Management Studio Express. To open Management Studio Express, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** and then select **SQL Server Management Studio Express**. To run a script, select **New Query**.
> - If you're using Microsoft SQL Server 2008 (and later versions of SQL), run the statement in Microsoft SQL Server Management Studio. To open Management Studio, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2008 (or the version you have)** and then select **SQL Server Management Studio**.

To run a script, select **New Query** To run the script, follow these steps:

1. Make sure that you have a current backup of the company database, and ask all users to exit Microsoft Dynamics GP. To create the backup in Microsoft Dynamics GP, follow the appropriate steps after all users sign out from Microsoft Dynamics GP:
    1. On the **File** menu, select **Backup**.
    2. In the **Company Name** list, select the company that you want to back up.
    3. In the **Select the backup file** box, select the yellow folder to open the location in which you want to put the backup file.

    Or

    1. In the Object Explorer, Expand your databases so you see the database you want to back up.
    2. Right-click the Database Name, go to Tasks, and select Backup.
    3. Select the **add** button and select the location and file name you wish to save your backup to.
    4. Select **Ok** to start the backup.

2. View the contents of the following tables to verify that all users are signed out: DYNAMICS..ACTIVITY, DYNAMICS..SY00800, DYNAMICS..SY00801, TEMPDB..DEX_LOCK, and TEMPDB..DEX_SESSION. To do it, run the following script.

    ```sql
    SELECT * FROM DYNAMICS..ACTIVITY SELECT * FROM DYNAMICS..SY00800 SELECT * FROM DYNAMICS..SY00801 SELECT * FROM TEMPDB..DEX_LOCK SELECT * FROM TEMPDB..DEX_SESSION
    ```

    > [!NOTE]
    > When all users are signed out from Microsoft Dynamics GP, these tables won't have any records in them.
3. If no results are returned, go to Step 4. Otherwise, clear the stuck records by using any of the following appropriate scripts.

    ```sql
    DELETE DYNAMICS..ACTIVITY DELETE DYNAMICS..SY00800 DELETE DYNAMICS..SY00801 DELETE TEMPDB..DEX_LOCK DELETE TEMPDB..DEX_SESSION
    ```

4. Run the following script against the company database. Replace **XXX** with the batch number or the name of the batch that you're trying to post or select in Microsoft Dynamics GP.

    ```sql
    UPDATE SY00500 SET MKDTOPST=0, BCHSTTUS=0 where BACHNUMB='XXX'
    ```

    > [!NOTE]
    > The value of BACHNUMB is the same as the value of the Batch ID window in Microsoft Dynamics GP.

5. Verify the accuracy of the transactions.
6. Verify that you can edit and post the batches.

> [!NOTE]
> For more information about Payroll check interruptions, see [KB - Error message when you select a batch in the Build Payroll Checks window in Microsoft Dynamics GP](https://support.microsoft.com/help/851664).
