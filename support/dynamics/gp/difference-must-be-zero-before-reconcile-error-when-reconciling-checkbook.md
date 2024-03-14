---
title: The difference must be zero before you can reconcile this checkbook error
description: Fixes a problem that occurs when you reconcile the checkbook in Select Bank Transactions in Microsoft Dynamics GP, and you receive an error message that states the difference must be zero before you can reconcile this checkbook. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Bank Reconciliation
---
# "The difference must be zero before you can reconcile this checkbook" error when reconciling the checkbook in Select Bank Transactions

This article provides a resolution for the issue that the difference is shown as zero when you reconcile the checkbook in **Select Bank Transactions** in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 851301

## Symptoms

When you reconcile the checkbook in **Select Bank Transactions** in Microsoft Dynamics GP, the difference is displayed as zero, but you receive the following error message:

> The difference must be zero before you can reconcile this checkbook.

## Cause

This is caused by a fractional difference. The **Select Bank Transactions** window will only display as many decimal places as are set up for the currency ID assigned to the respective checkbook. So, for example, if your checkbook is assigned a currency ID with two decimal places, then only two decimal places show in the **Select Bank Transactions** window. However, the records in the SQL Table store up to five decimal places for an amount field, so this issue may happen if you have amounts in the remaining decimal places for any record in the SQL tables, and may result in a fractional difference. This typically happens if the records were imported into Microsoft Dynamics GP with amounts that have more decimal places than the currency ID is set up for.

> [!IMPORTANT]
> Importing data in this manner isn't supported. This article serves as a guide to help you fix the data, as we can't provide data fixing for unsupported conditions within a support case.

## Resolution

Use the steps below to check for records with fractional decimal places and use the scripts below to resolve it:

1. Start Microsoft SQL Server Management Studio, and select the **New Query** button to open a query window.
2. Execute the following script against the company database to determine whether there are records that have amounts with a non-zero third, fourth, or fifth decimal place value:

    > [!NOTE]
    > If your currency for the checkbook has 2 decimals, the '3' in the script below on each line will check the 3rd position for a fraction. So if your currency has 3 decimal places, adjust the script to '4', and so on.

    ```sql
    select 'CM20200' AS 'TABLE',DEX_ROW_ID,ClrdAmt,TRXAMNT,ORIGAMT,Checkbook_Amount,* from CM20200 where right(ClrdAmt,3)<>0
    or right(TRXAMNT,3)<>0
    or right(ORIGAMT,3)<>0
    or right(Checkbook_Amount,3)<>0
    select 'CM20400' AS 'TABLE',DEX_ROW_ID,DEBITAMT,CRDTAMNT,* from CM20400 where right(DEBITAMT,3)<>0
    or right(CRDTAMNT,3)<>0
    select 'CM20500' AS 'TABLE',DEX_ROW_ID,StmntBal,CUTOFFBAL,ClrePayAmt,ClrdDepAmt,Cleared_Difference,OUTPAYTOT,OUTDEPTOT,IINADJTOT,DECADJTOT,ASOFBAL, * from CM20500 where right(StmntBal,3)<>0
    or right(CUTOFFBAL,3)<>0
    or right(ClrePayAmt,3)<>0
    or right(ClrdDepAmt,3)<>0
    or right(Cleared_Difference,3)<>0
    or right(OUTPAYTOT,3)<>0
    or right(OUTDEPTOT,3)<>0
    or right(IINADJTOT,3)<>0
    or right(DECADJTOT,3)<>0
    or right(ASOFBAL,3)<>0
    select 'CM20501' AS 'TABLE', DEX_ROW_ID,TRXAMNT,* from CM20501 where right(TRXAMNT,3)<>0
    select 'CM20201' AS 'TABLE', DEX_ROW_ID, Orig_Credit_Card_Total,Originating_Cash_Total,Originating_Deposit_Amou,Originating_Checkbook_Am,* from CM20201 where right(ORCHKTTL,3)<>0
    or right(Orig_Credit_Card_Total,3)<>0
    or right(Originating_Cash_Total,3)<>0
    or right(Originating_Deposit_Amou,3)<>0
    or right(Originating_Checkbook_Am,3)<>0
    ```

    > [!IMPORTANT]
    > Be sure to scroll across on any records returned to take note all the 'amount' columns for any records returned.

3. In addition, execute this script to review the amounts in the Checkbook Master table as well:

    ```sql
    select CURRBLNC,* from CM00100 where CHEKBKID = 'xxx'
    --modify the xxx placeholder with your checkbook ID.
    ```

4. Make a current restorable backup of the company database before you continue, or do this in a test environment first.

    > [!IMPORTANT]
    > Do not skip this step.
5. Depending on what tables/fields you found the fraction in, read both methods below and use the appropriate method to resolve the issue:

    **Method 1: Update each field one at a time directly in SQL to remove the fractional decimal.**

    You can simply update the amounts found by the scripts above directly in the SQL Table(s) using a script similar to the example below. After updating the amounts to remove the unwanted fraction, then refresh the Select Bank Transactions window to see if the issue is resolved.

    Here is an example script to update one field at a time:

    ```console
    UPDATE CMXXXXX SET YYYYY = '$.$$000' where DEX_ROW_ID = x
    
    --Before executing this script, update the placedholders as needed:
     -Modify the CMXXXXX placeholder with the correct table name; 
     -Modify the YYYYY placedholder with the correct field name in that table; 
     -Modify the $.$$000 with the correct amount with 2 decimal places,
     -Modify the x with the specific Dex Row ID for the record that you need to modify. 
    
    Repeat as many times as needed to update each field/table returned by the script in step 2
    and/or step 3 that has more than 2 decimal places.
    ```

    > [!NOTE]
    > Be consistent. If you update any amount(s) in a table found by the script in step 2 for a Checkbook_Amt field, then you may need to also update the current checkbook balance value in the CM00100 Checkbook Master table in the same direction. Also, be sure to have all users out of Microsoft Dynamics GP before running an update script against the Checkbook Master table. You don't want anyone to post and change the amount of the current balance for the checkbook at the exact same time that you are doing this maintenance.

    **Method 2: Sum field totals to see if any totals have a fractional decimal.**

    Execute the below script to verify the field totals by type. Review to see if any have more decimals than the currency ID you are using. In addition, if the records were imported in or from a third-party software, then you may have imported in amounts with more decimals than allowed in GP. In this case, you will need to calculate the 'net difference' and update a single record for this difference so that you balance to $0.00000 exactly. You may need to open a support incident if you need further assistance to do this. If you do this yourself, be sure to do this in a test company first.

Here is an example script to sum each of the amount fields for the CM20200 table by type:

```sql
select Distinct(CMTRXTYPE)as 'Type',SUM(TRXAMNT)as 'TRXAMNT', SUM (ORIGAMT)as 'ORIGAMT', SUM(Checkbook_Amount)as 'Checkbook_Amount' from CM20200 where CHEKBKID='XXX' group by CMTRXTYPE
--update the XXX placeholder with the appropriate checkbook ID.
```

Transaction Type:

1 = Deposit  
2 = Receipt  
3 = Check  
4 = Withdrawal  
5 = Increase Adjustment  
6 = Decrease Adjustment  
7 = Transfer  
101 = Interest Income  
102 = Other Income  
103 = Other Expense  
104 = Service Charge

> [!NOTE]
> Make note of any amounts you change, as you may also need to update the CM00100 checkbook balance in the same direction for the same difference.

## More information

As a last resort, check the SQL collation and SQL Server Sort order to see if you are on a supported environment. (SQL Collation of Latin1-General and SQL Server Sort Order of 50 or 52 are supported. The Reconcile may not run on an unsupported version even if the difference is $0.00000.) If an unsupported SQL Collation or SQL Server Sort Order is being used, you will need to open a support incident with the SQL Server team for additional assistance on how to change the SQL Collation/SQL Sort Order before you can continue. Run this script to determine the SQL Collation and SQL Server Sort Order:

```console
sp_helpsort
```
