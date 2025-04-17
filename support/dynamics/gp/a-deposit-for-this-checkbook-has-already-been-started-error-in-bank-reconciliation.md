---
title: A deposit for this checkbook has already been started error in Bank Reconciliation
description: Error message - A deposit for this checkbook has already been started that occurs in Bank Reconciliation in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, dbader
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Bank Reconciliation
---
# "A deposit for this checkbook has already been started" error in Bank Reconciliation in Microsoft Dynamics GP

This article provides a resolution for the error **A deposit for this checkbook has already been started** that occurs in Bank Reconciliation in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 864117

## Symptoms

In Bank Reconciliation in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> A deposit for this checkbook has already been started.

Additionally, the following symptoms occur:

- You cannot open the Bank Deposit Entry window.
- The deposit does not post.

## Cause

This problem occurs when a posting interruption previously occurred.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, follow one of the methods below:

Make sure to have a current backup of the company database before doing either Method.

### Method 1 - Delete deposit and deposit work tables, run check links

1. Clear out the deposit:

   1. Open the Bank Deposit Entry window under **Transactions** > **Financials** > **Bank Deposits**.
   2. Select your checkbook ID. If you get prompted with the error message, select **OK** on it.
   3. Don't do anything else in the window. Simply select the **DELETE** button at the top. Pressing **Delete** will reset the deposit and clear out the deposit work tables and usually does wonders to help clear everything out.

2. Then in SQL Server Management Studio, use the below scripts to verify that the Deposit work tables do not have any stuck records for this deposits in it. Update the below scripts to replace the XXX with the for the checkbook ID you are having the problem with.

    ```sql
    Delete CM10100 where CHEKBKID = 'XXX'
    Delete CM10101 where CHEKBKID = 'XXX'
    ```

3. Run checklinks:
   1. Go to **Microsoft Dynamics GP** > **Maintenance** > **Check links**.
   2. Financial series.
   3. Insert over **Checkbook Master, CM Setup,** and **CM Transactions**, select **OK** to process.

4. Then execute the script below to make sure the **deposit in progress** field on the checkbook is an empty string: This often causes the **Error message 3571 does not exist** message if this field is not empty. Update the XXX placeholder for the checkbook ID having the problem.

    ```sql
    Update CM00100 set Deposit_In_Progress = '' where CHEKBKID = 'XXX'
    ```

5. Now test again to confirm the issue has been resolved.

### Method 2 - Clear activity tables, run check links and update checkbook/chequebook

1. Have all the users exit Microsoft Dynamics GP.
2. Start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**. Open a **New query** window.
3. Run the following statements against the DYNAMICS database. No users should be in Dynamics GP at all when executing these scripts:

   ```sql
   DELETE ACTIVITYDELETE SY00800DELETE SY00801
   ```

4. Run the following statement against the company database.

   Update the checkbook ID.

   ```sql
   DELETE CM10100 where CHEKBKID = 'XXX'  
   DELETE CM10101 where CHEKBKID = 'XXX'
   ```

5. Perform the Check Links routine on the CM Transaction file and on the Checkbook Master file. To do this, follow these steps:

    1. Point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
    2. In the **Series** list, select **Financial**.
    3. Insert the following files:
        - CM Transaction
        - Checkbook Master
    4. Select **OK**.

6. To determine whether a deposit number is in the **Deposit_In_Progress** field, run the following statement against the CM00100 table.

   ```sql
   SELECT * FROM CM00100
   ```

7. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
8. In the **Checkbook ID** list, select a checkbook.
9. Note the value in the **Next Deposit Number** field.
10. If the value in the **Deposit_In_Progress** field in step 6 is equal to or less than the value that you noted in step 9, set the value of the **Deposit_In_Progress** field to ' ' (blank). To do this, run the following script against the company database.

    ```sql
    UPDATE CM00100 SET Deposit_In_Progress = '' where CHEKBKID = '<XXX>'
    ```

    **Note** \<XXX> is a placeholder for the value in the Checkbook ID list.
