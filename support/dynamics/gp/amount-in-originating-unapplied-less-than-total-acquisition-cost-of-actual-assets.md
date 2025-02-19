---
title: Amount in Originating Unapplied less than total acquisition cost
description: The amount that appears in the Originating Unapplied box is less than the total acquisition cost of the actual assets that were saved by using this purchasing transaction. Provides a workaround.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# The amount in Originating Unapplied is less than the total acquisition cost of the actual assets in Fixed Assets Purchasing Transactions

This article provides a workaround for the issue that the amount in the **Originating Unapplied** box is less than the total acquisition cost of the actual assets in the Fixed Assets Purchasing Transactions window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 895442

## Symptoms

In the Fixed Assets Purchasing Transactions window of the Fixed Assets module, the amount that appears in the **Originating Unapplied** box is less than the total acquisition cost of the actual assets that were saved by using this purchasing transaction. This problem occurs only for assets that have the same asset ID but that have a different suffix.

## Cause

This problem occurs because Microsoft Business Solutions - Great Plains does not update the amount in the **Originating Unapplied** box in the Fixed Assets Purchasing Transactions window after you create an asset and then clear that asset. If you continue to create the asset after you clear the asset, the asset has an incorrect acquisition cost.

## Workaround

To work around this problem, follow these steps:

1. Back up your company database.
2. Select **Start**, select **All Programs**, select **Microsoft SQL Server**, and then select **Query Analyzer**.
3. Select the server to which you want to connect. (This server is a server that is running Microsoft SQL Server.) Enter the login name and the password.

4. Run a `SELECT` statement on the FA01100 (FA-AP Post Master) table and on the FA01400 (Asset Purchase Master) table for this purchasing transaction (FA_AP_Post_Index).

   Type the following in the query pane. Then, press F5, or select the green arrow.

   ```sql
   select VENDORID, DOCNUMBR, * from FA01100 where VENDORID = 'VendorID' and DOCNUMBR = 'Invoice Document Number'
   select VENDORID, DOCNUMBR, FA_AP_Post_Index, * from FA01400 where VENDORID = 'VendorID' and DOCNUMBR = 'Invoice Document Number'
   ```

   > [!NOTE]
   > In the statement, replace *VendorID* with the appropriate vendor ID. Replace *Invoice Document Number* with the appropriate invoice document number.

5. The sum of the Acquisition_Cost values in the FA01400 table is not equal to the APPLDAMT value and to the ORAPPAMT value in the FA01100 table. To correctly sum the information, use the following script.

   Type the following in the query pane. Then, press F5, or select the green arrow.

   ```sql
   select sum (Acquisition_Cost from FA01400 where VENDORID = 'Vendor ID' and DOCNUMBR = 'Invoice Document Number.
   ```

6. Update the APPLDAMT value and the ORAPPAMT value in the FA01100 table for this specific FA_AP_Post_Index record.

   Type the following in the query pane. Then, press F5, or select the green arrow.

   ```sql
   update FA01100 set APPLDAMT = X, ORAPPAMT= X where DEX_ROW_ID= Z
   ```

   > [!NOTE]
   > In the statement, replace *X* with the sum of the Acquisition_Cost values in the FA01400 table. Replace *Z* with the specific DEX_ROW_ID value of that record in FA01100.

## Steps to reproduce the problem

1. Create an invoice transaction from the Payables Management module. To do this, follow these steps:

    1. Select **Transactions**, select **Purchasing**, and then select **Transaction Entry**.
    2. Select **Distributions**.
    3. In the **PURCH Type** box, select the Fixed Assets clearing account. You must select the Fixed Assets clearing account so that the Fixed Asset user interface will start when you post this invoice.
    4. In the **Document Number** box, type *000514*.
    5. In the **Amount** box, type *1,000*.

2. In the Fixed Assets Company Setup window, clear the **Delete Purchasing Transactions Immediately** check box, and then select **Save**.
3. In the Asset General Information window, select **Cards**, select **Fixed Assets**, and then select **General**. In the **Asset ID** box, type *Car*. In the **Suffix** box, type *1*.

4. Select **Purchase** to open the Fixed Assets Purchasing Transactions window.
5. Select the payables invoice that you created in step 1, and then select **Select**.

6. In the Asset General Information window, use the TAB key to move to the **Acquisition Cost** box. Then, select the **expansion** button to open the Asset Purchase window. In the **Acquisition Cost** box, type *100*, and then select **OK**.

7. In the Asset General Information window, verify that the amount in the **Acquisition Cost** box is 100 dollars. Enter a description, a class ID, a type, a property type, and a quantity for this asset ID. Select **Save**, and then select **Clear**.
8. Repeat step 3 through step 7 for the following new asset IDs and acquisition costs:

    - In the **Asset ID** box, type *Car*. In the **Suffix** box, type *2*. Use an acquisition cost of 200 dollars.
    - In the **Asset ID** box, type *Car*. In the **Suffix** box, type *3*. Use an acquisition cost of 300 dollars.

9. In the Asset General Information window, select **Cards**, select **Fixed Assets**, and then select **General**. In the **Asset ID** box, type *Car*. In the **Suffix** box, type *4*. Select **Purchases**. Select the same purchasing transaction in the Fixed Assets Purchasing Transactions window. Then, select **OK**.

    > [!NOTE]
    > The value that appears in the **Originating Unapplied** box for voucher 000514 is 400 dollars.

10. In the Asset General Information window, select **Clear** so that this asset ID is not saved.
11. In the Asset General Information window, use the lookup button for the **Asset ID** box to select the **Car** asset ID that has a suffix of **2**. Then, select **Save**. Next, select the **Car** asset ID that has a suffix of **3**, and then select **Save**.

12. Reenter the **Car** asset ID that has a suffix of **4**, and then select **Purchases**. Select the same purchasing transaction invoice in the Fixed Assets Purchasing Transactions window that you entered earlier.

### Expected results

In the Fixed Assets Purchasing Transactions window, you expect the amount that appears in the **Originating Unapplied** box for voucher 000514 to be 400 dollars.

### Actual results

In the Fixed Assets Purchasing Transactions window, the amount that appears in the **Originating Unapplied** box for voucher 000514 is -100 dollars. Microsoft Great Plains incorrectly calculates this amount by using the following formula:

`$400 (the originating unapplied amount) - $200 (the acquisition cost of the Car-2 item) - $300 (the acquisition cost of the Car-3 item) = $-100`

> [!NOTE]
> You can prevent this problem by closing the Asset General Information window after you select **Clear** in step 8.
