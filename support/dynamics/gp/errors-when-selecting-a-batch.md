---
title: Errors when selecting a batch
description: Provides a solution to errors that occur when you select a batch in the Build Payroll Checks window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/16/2024
---
# Error messages when you select a batch in the Build Payroll Checks window in Microsoft Dynamics GP

This article provides a solution to errors that occur when you select a batch in the Build Payroll Checks window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851664

## Symptoms

When you select a batch in the Build Payroll Checks window in Microsoft Dynamics GP, you may receive one of the following error messages:

Error message 1
> Error - "Open operation on UPR_Temp_Post2 has incorrect record length"

Error message 2
> Error - "Remove Range Operation on Table ddDeposits has caused known error 2"

Error message 3
> Error - "Batches with zero transactions cannot be marked"

Error message 4
> Error - "Another user is performing a check run"

Error message 5
> Error - "UPR_Work_Post failed accessing SQL data"

Error message 6
> Error - "The employee record cannot be inactivated or deleted Pay run is in progress for this employee"

Error message 7
> Error - "Checks cannot be calculated. Errors were found."

Error message 8
> Error - "You cannot void a check. A computer check run is in process."

Error message 9
> Error - "You cannot edit a batch marked for posting"

Error message 10
> Error - "Batch is marked for posting and cannot be edited."

Additionally, an Open Operation error, a Get/Change error, or a Save Operation error may occur on one of the following files to indicate that the Payroll batch is stuck:

- UPR_WORK_MSTR

- UPR_WORK_MSTR_Detail

- UPR_WORK_HDR

- UPR_WORK_Pay_Type

- UPR_WORK_Deduction

- UPR_WORK_Benefit

- UPR_WORK_State_Tax

- UPR_WORK_Local Tax

- UPR_WORK_Check

- UPR_WORK_Post

- UPR_Flat_Tax_Records

- UPR_Account_Cache

## Cause

This problem may occur if the payroll work tables haven't been cleared. The payroll work tables must be cleared to release the batch.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs

To resolve this problem, follow these steps:

### Step 1: Delete records in Payroll work tables


1. Open Microsoft SQL Server using the appropriate method below:
   - Start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

2. Run delete statements against the company database.

    > [!NOTE]
    > The first two lines in the script delete the contents of the activity files in the Dynamics database. The other lines delete the contents of the work files and the activity files in the Company database.

    ```sql
    Delete DYNAMICS..UPR10300
    Delete DYNAMICS..UPR10304
    Delete UPR10200
    Delete UPR10201
    Delete UPR10202
    Delete UPR10203
    Delete UPR10204
    Delete UPR10205
    Delete UPR10206
    Delete UPR10207
    Delete UPR10208
    Delete UPR10209
    Delete UPR10213
    Delete UPR19900
    Delete UPR19901
    ```

3. If you use Direct Deposit, run this delete statement for Direct Deposit Work table:

    ```sql
    Delete DD10100 --(Direct Deposit Employee Deposit Work)
    ```

### Step 2: Delete temporary files

To delete temporary files, open Windows Explorer, and then select the **Temporary** directory. The Temporary directory has the following path:

`C:\Windows\Temporary`

In the directory, delete the files that begin with TNT. Then, delete the files that have a .tmp file name extension.

### Step 3: Do Check Links

Check Links will check the linking of the data between the tables to ensure data integrity. To do it, follow these steps:

1. Open the check Links window. In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, select **Maintenance**, and then select **Check Links.**  
2. In the **Series** list, select **Payroll**.
3. In the **Logical Tables** list, select **Payroll Transactions**, select **Insert**, and then select **OK**.
4. In the **Report Destination** dialog box, select the appropriate check box, and then select **OK**.

> [!NOTE]
> You can safely ignore the error messages that occur in the error log. The Check Links process is reattaching the batch ID to the existing transactions.  
>
> If your batch should have been a recurring batches, and was rebuilt by the Check Links process, the batch frequency was set to **single use** by default. Select **Transactions**, select **Payroll**, and then select **Batches**, and select the **Batch ID** that was recreated, and review the Batch settings. If this should be a recurring batch, change the frequency to a **Frequency** other than **Single Use**.

### Step 4: Build the check file

Build the check file again. All the batches are still in the check file.

**COMMON QUESTIONS:**  
Q1:  I don't want to delete the whole payroll batch and start over, should I still follow the steps above?

A1:  Yes, the Transactions in the payroll batch are stored in the **UPR10302** Payroll Transactions table, and you aren't deleting that table in the scripts above, so the transactions aren’t getting removed. The scripts only remove the **batch** **header** record (**UPR10301**) and when you run **checklinks**, the system will recreate that batch header record again (because it sees it on the transactions still, so it will recreate it.),

Q2: I posted the new batch and it disappeared. It should have been a recurring batch.

A2:  When you ran check links to rebuild the batch, it built it with a **single use** frequency by default. You should have edited the batch frequency before posting it, if it should have been a recurring batch. If you posted the batch, it's too late now. You'll need to manually key the batch/transactions back in again (starting on the next posting date needed), and change the frequency on the new batch to be used going forward.
