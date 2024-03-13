---
title: The variance or counted quantity for this serial number does not equal the variance or counted quantity for this item error when doing stock count on serialized item 
description: When you do a stock count on a serialized item in Microsoft Dynamics GP, you receive an error that states the variance or counted quantity for this serial number does not equal the variance or counted quantity for this item. Provides a resolution.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "The variance or counted quantity for this serial number does not equal the variance or counted quantity for this item" error when doing a stock count on a serialized item

This article provides a resolution for the issue that you can't do a stock count on a serialized item due to the error that's described in the Symptoms section.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929210

> [!IMPORTANT]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you perform a stock count on a serialized item in Microsoft Dynamics GP, you receive the following error message:

> The variance or counted quantity for this serial number does not equal the variance or counted quantity for this item

This problem occurs when you perform the stock count and then select **OK** in the Stock Count Serial Number Entry window. This problem occurs even after you confirm the following:

- You confirm that the value in the **Counted Qty** field in the Stock Count Entry window is equal to the values in the **Serial Numbers Counted** field and in the **Item Counted Qty** field in the Stock Count Serial Number Entry window.
- You confirm that the physical counted quantity is correct.

## Cause

This problem occurs if either of the following conditions is true:

- The stock count was already started when you performed the stock count, and the items in that stock count were sold. In this scenario, the values that appear in the Stock Count Serial Number Entry window reflect the stock count that existed before the items were sold.
- An interruption occurred that caused the variance quantities to be incorrectly updated.

## Resolution

To resolve this problem, use the appropriate method:

### The stock count was already started  

#### Method 1 - Restart the stock count if you can

1. Select **Transactions**, point to **Inventory**, and then select **Stock Count Schedule**.
2. Select the lookup button next to the **Stock Count ID** field.
3. Select the stock count, and then select **Select**.
4. Select **Cancel Count**.
5. Select **Start Count**.

#### Method 2 - Override the quantities

1. Select **Transactions**, point to **Inventory**, and then select **Stock Count Entry**.
2. Select the lookup button next to the **Stock Count ID** field.
3. Select the stock count, and then select **Select**.
4. Select the serialized item.
5. Select **Serial/Lot**.
6. Verify that the value in the **Serial Number Variance** field is equal to the number of serial numbers that are set to **Not Found** in the **Count Status** column.
7. If the value in the **Serial Number Variance** field matches the number of serial numbers, select **OK**. You receive the error message that is mentioned in the Symptoms section.
8. Select **Override**.

### An interruption occurred  

Update the Serial Number Variance field. To do this, follow these steps:

1. Start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
2. Sign in as the sa user.
3. Select the company database in the database list.
4. Type the following statement.

   ```sql
   SELECT * FROM IV10301 where STCKCNTID = '<XXX>' and LOCNCODE = '<YYY>'
   ```

   > [!NOTE]
   > In the statement, replace the *\<XXX>* placeholder with the stock count ID. Replace the *\<YYY>* placeholder with the site ID.

   If the multiple-bins feature is enabled, add the `BINNMBR` field to the statement.

   ```sql
   SELECT * FROM IV10301 where STCKCNTID = '<XXX>' and LOCNCODE = '<YYY>' and BINNMBR = '<ZZZ>'
   ```

   > [!NOTE]
   > In the statement, replace the *\<ZZZ>* placeholder with the bin number.

5. Note the `DEX_ROW_ID` value of the retrieved record. The `DEX_ROW_ID` value is in the last column of the table.
6. Update the record by using the `DEX_ROW_ID` value. To do this, type the following statement.

   ```sql
   UPDATE IV10301 SET STCKSRLLTVRNC = <##.#####> where DEX_ROW_ID = <BBB>
   ```

> [!NOTE]
> Make sure that you include five decimal places. If no values follow the first two digits, use zeros. For example, if the value in the **Serial Number Variance** field is supposed to be **12**, type *12.00000*.
>
> In the statement, replace the *<##.#####>* placeholder with the serial-number variance value. Replace the *\<BBB>* placeholder with the `DEX_ROW_ID` value.
