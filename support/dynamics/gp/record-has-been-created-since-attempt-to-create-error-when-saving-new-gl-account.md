---
title: This record has been created since your attempt to create it error when saving a new General Ledger account
description: Describes a problem that occurs when you try to save a new General Ledger account in Microsoft Dynamics GP. Provides two resolutions for this problem.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "This record has been created since your attempt to create it" error when saving a new General Ledger account

This article provides resolutions for the issue that you can't save a new General Ledger account in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857649

## Symptoms

When you try to save a new General Ledger account in the Account Maintenance window in Microsoft Dynamics GP 2013, you receive the following error message:

> This record has been created since your attempt to create it. Changes won't be saved.

## Cause

This issue may occur because of any of the following reasons.

### Cause 1

This message frequently occurs if the Account Index Master table in General Ledger (GL00105) does not have the same number of records as the Account Master table in General Ledger (GL00100). See resolution 1.

### Cause 2

An account master table in a different sub-module does not have the same number of records as the GL00100 Account Master table. For example, if you are using Analytical Accounting, the Account Master table in Analytical Accounting (AAG00200) must have the same number of records as the GL00100 Account Master table. See resolution 2.

### Cause 3

This problem may occur because certain triggers were created when you updated the GL00100 Account Master table to Microsoft Dynamics GP 8.0 or to a later version of Microsoft Dynamics GP. The Microsoft FRx triggers are now combined with the default triggers for the GL00100 Account Master table. These additional triggers are no longer needed. See resolution 3.

### Cause 4

This problem may occur if the account already exists in the frl_acct_code table. See resolution 4.

### Cause 5

This problem may occur if the DEX_ROW_ID column in the GL00100 Account Master table is not marked as an Identity field. This problem typically occurs if the following conditions are true:

- Data Transformation Services (DTS) is used to transfer the chart of accounts from one database to another.
- The **Enable Identity Insert** option is not selected in the DTS wizard.

See Resolution 5.

## Resolution

Use the resolution that is appropriate for your situation, and then test to see whether your issue is resolved. If you have to open Microsoft SQL Server Management Studio, use one of the following methods, as appropriate:

- If you are using SQL Server 2005, select **Start**, point to **All Programs**, point to Microsoft SQL Server 2005, and then select **SQL Server Management Studio**.
- If you are using SQL Server 2008, select **Start**, point to **All Programs**, point to Microsoft SQL Server 2008, and then select **SQL Server Management Studio**.
- If you are using SQL Server 2008 R2, select **Start**, point to **All Programs**, point to Microsoft SQL Server 2008 R2, and then select **SQL Server Management Studio**.
- If you are using SQL Server 2012, select **Start**, point to **All Programs**, point to Microsoft SQL Server 2012, and then select **SQL Server Management Studio**.

### Resolution 1

Verify that the GL00100 and GL00105 tables have the same number of records. To do this, follow these steps:

1. Open SQL Server Management Studio.

2. Run the following scripts against the company database to verify how many records exist in the GL00100 Account Master table and the GL00105 Account Index Master table.

    ```sql
    Select count (*) from GL00100
    ```

    ```sql
    Select count (*) from GL00105
    ```

3. Use one of the following scenarios, based on your findings from the count scripts.

Scenario 1

The Account Master table (GL00100) has more records than the Index Master table (GL00105). To resolve this issue, run check links to create the corresponding index record. To do this, follow these steps:

1. In Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 2010, and Microsoft Dynamics GP 2013, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**. In Microsoft Dynamics GP 9.0 and earlier versions, select **File**, point to **Maintenance**, and then select **Check Links**.
2. In the **Series** list, select **Financial**.
3. In the **Logical Tables** list, select **Account Master**, and then select **Insert**.
4. Select **OK** to run the Check Links process. You can print the error log to the screen to check whether the account index was updated.
5. Close the report.
6. Run the count scripts from step 2 again to verify that the tables have the same number of records, and then test again.

Scenario 2

The Index Master table (GL00105) has more records than the Account Master table (GL00100) table. To resolve the issue, delete the additional index records in the GL00105 table that do not correspond to a valid General Ledger account. To do this, follow these steps:

1. Open SQL Server Management Studio.
2. Copy the script, and then execute it against the company database to view the additional index records in the GL00105 table that do not exist in the GL00100 table. If you find any additional records, delete them by using the following script:

    ```sql
    Select * from GL00105 where ACTINDX not in (select ACTINDX from GL00100) 
    Delete GL00105 where ACTINDX not in (select ACTINDX from GL00100)
    ```

3. Run the count scripts from step 2 again to verify that the tables have the same number of records, and then test again.

Scenario 3

If the GL00100 and GL00105 tables have the same number of records, investigate the other causes that are described here.

### Resolution 2

For any other modules that have an Account Master table, such as Analytical Accounting, make sure that the Account Master table in the sub-module has the same number of records as the GL00100 Account Master table. The following example shows how to troubleshoot Analytical Accounting.

> [!NOTE]
> Review the triggers on the GL00100 table to see the other modules that may be updated. For information about how to view the triggers, see Resolution 3.

To troubleshoot the Account Master table in Analytical Accounting (AAG00200), follow these steps:

1. Run the following scripts in SQL Server Management Studio against the company database to verify how many records are in each table.

    ```sql
    Select count (*) from GL00100
    ```

    ```sql
    Select count (*) from GL00105
    ```

    ```sql
    Select count (*) from AAG00200
    ```

2. If the GL00105 Account Index Master table has more or fewer records than the GL00100 Account Master table, see Resolution 1.
3. For the AAG00200 Account Master table, use one of the following scenarios, as appropriate.

    Scenario 1

    If the AAG00200 table has more records than the GL00100 table, run the following script to delete any account indexes that do not exist in the GL00100 Account Master table:

    ```sql
    Delete AAG00200 where ACTINDX not in (Select ACTINDX from GL00100)
    ```

    Scenario 2

    If the AAG00200 table has fewer records than the GL00100 table, you must delete the AAG00200 table and then re-create it.

    > [!NOTE]
    > When you take this action, the link between the General Ledger account and Account Class is removed in Analytical Accounting. Therefore, before you begin, you may want note the accounts that are linked to each class ID in Analytical Accounting.

    1. In SQL Server Management Studio, run the following script against the company database to delete the AAG00200 table:

        ```sql
        Delete AAG00200
        ```

    2. Run the following script to re-create the AAG00200 table:

        ```sql
        Insert into AAG00200 (ACTINDX,aaAcctClassID,aaChangeDate,aaChangeTime) select ACTINDX,0,convert(char(10),getdate(),111),convert(char(12),getdate(),114) from GL00100 where ACTINDX not in (select ACTINDX from AAG00200)
        ```

    3. Select **Cards**, point to **Financial**, point to **Analytical Accounting**, and then select **Accounting Class Link**.

    4. Enter the class ID, mark the appropriate accounts to link, and then exit the window.

4. Run the count scripts again in step 1 to verify that all three tables have the same number of records, and then test again.

### Resolution 3

To resolve the problem of having additional triggers, run the following script in SQL Server Management Studio against the company database to view all the triggers on the GL00100 table:

```sql
sp_helptrigger GL00100
```

Review the triggers that are listed in this table to see whether the following FRx triggers are listed. (Do this in Microsoft Dynamics GP 9.0 and earlier versions. These triggers are included in the General Ledger Account Master triggers in later versions.)

- FRx_Chart_Delete
- FRx_Chart_Insert
- FRx_Chart_Update

If this is the case, you can remove these triggers by following these steps:

1. Back up the company database.
2. Run the following scripts in the Support Administrator Console or in SQL Server Management Studio against the company database:

    ```sql
    Drop trigger FRx_Chart_Delete 
    ```

    ```sql
    Drop trigger FRx_Chart_Insert 
    ```

    ```sql
    Drop trigger FRx_Chart_Update
    ```

3. Test again.

### Resolution 4

To resolve this problem, run a script to view the accounts that exist in the frl_acct_code table but not in the General Ledger Account Master table. To do this, follow these steps:

1. Back up the company database.
2. Run the following script in the Support Administrator Console or in SQL Server Management Studio:

    ```sql
    Select * from frl_acct_code where acct_id not in (select ACTINDX from GL00100)
    ```

3. In the results that are returned, determine whether the account number that you want to add or save is already listed.
4. Run the following script to remove additional accounts from the frl_acct_code table:

    ```sql
    Delete frl_acct_code where acct_id not in (select ACTINDX from GL00100)
    ```

5. Verify that all three tables now have the same number of records:

    ```sql
    Select count (*) from GL00100
    Select count (*) from GL00105
    select COUNT (*) from frl_acct_code
    ```

6. Sign in to Microsoft Dynamics GP, and try to add the account again.

### Resolution 5

To check the identity column, follow these steps:

1. Select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **SQL Server Management Studio**.
2. Expand the company database.
3. Expand **Tables**.
4. Right-click **GL00100**, and then select **Design** if you are using SQL Server 2008. (If you are using SQL Server 2005, select **Modify**.)
5. Under **Column Name**, select **DEX_ROW_ID**.
6. In the Column Properties window at the bottom, scroll down, and then expand **Identity Specification**.
7. Make sure that **Yes** is selected in the **Identity Specification** field. Also, make sure that **1** is selected in the **Identity Seed** field and in the **Identity Increment** field.
