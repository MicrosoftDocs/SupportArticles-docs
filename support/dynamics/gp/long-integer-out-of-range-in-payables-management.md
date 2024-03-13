---
title: Long integer out of range
description: Provides a solution to an error that occurs when you print an edit list or post in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Long integer out of range" Error when you print an edit list or post in Payables Management in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print an edit list or post in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2652493

## Symptoms

You receive the following error message when you print an edit list or post a batch in Payables Management in Microsoft Dynamics GP 2010:

> Unhandled script exception:  
Long integer out of range. Results Invalid.  
EXCEPTION_CLASS_SCRIPT_OUT_OF_RANGE  
SCRIPT_CMD_SET

## Cause

The account index value for the GL account in the PM Tax Work table (PM10500) is greater than the small integer value of 32767, which is the largest value a small integer field will allow.

It's a known quality issue #63243 and was fixed in the 2011 US Payroll Year-End Update (version 11.00.1860).

## Resolution

A fix for this issue is currently available. Install the 2011 US Payroll Year-end update patch (11.00.1860) to resolve this issue.

## Workaround

To get around the issue until you're able to update to the 2011 year-end update patch, you can use a different general ledger account that has an account index (in the GL00100 and GL00105) smaller than the value of 32767. To do it, follow these steps:

1. Create a new general ledger account to use in the meantime. To do it, select **Cards**, point to **Financial**, and then select **Account**. Create a new account.

2. Start SQL Server Management Studio using the appropriate method below:

    **Method 1**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    **Method 2**: For SQL Server 2008

    If you're using SQL Server 2008, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

    **Method 3**: For SQL Server 2008 R2

    If you're using SQL Server 2008 R2, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008 R2**, and then select **SQL Server Management Studio**.

3. Select the **New Query** button at the top to open a query window. Copy in the below statement and execute against the Company database to look in the GL00100 and GL00105 tables to see what account index is assigned to the new account you just made. Also review the account indexes to look for skipped numbers that you can use.

    ```sql
    select * from GL00100
    ```

4. Run the following statement to update the account index value on the new account you made with an unused account index value lower than 32767.

    ```sql
    update GL00100 set ACTINDX = 'xxx' where ACTINDX = 'yyy'
    update GL00105 set ACTINDX = 'xxx' where ACTINDX = 'yyy'
    ```

    > [!NOTE]
    > Insert the new account index in for the *xxx* placeholder, and the currently assigned higher ACTINDX that you will be overwriting for the *yyy* placeholder in the script above. Run the script against the company database.

    > [!NOTE]
    > If you have any sub-modules that have their own account master tables, you may need to update those tables as well. For example, if you have Analytical Accounting, you will also need to update the AAG00200 Account Master table, etc.

5. Run the following statement to look at the batch in the PM Tax Work table and see if any of the account indexes in the problem batch are higher than 32767.

    ```sql
    select ACTINDX, * from PM10500 where BACHNUM = 'xx'
    ```

    insert the batch number for the *xx* placeholder above.

6. Then update the PM10500 Tax Work table to hit the new Account index you created.

    ```sql
    update PM10500 set ACTINDX = 'xxx' where Dex_Row_ID = 'z'
    ```

    > [!NOTE]
    > insert the new account index value for the *xxx* placeholder, and the **dex row id** value for the *z* placeholder so that you only update one line at a time as needed.

7. Print the edit list or post the batch.

8. Enter a journal entry in General Ledger to reclass the balance in the new dummy account to the correct general ledger account. To do it, select **Transactions**, point to **Financial** and then select **General**.

9. After you install the fix for this problem, you can inactivate the dummy account you made since it will no longer be used.

    > [!NOTE]
    > Update to the 2011 US Payroll Year-end Update patch as soon as you can to get this issue resolved. With the work-around method above, you will lose the drill-back capability between from the reclassed General Ledger entry for the correct account and the original Payables Management transaction that hit the dummy account.
