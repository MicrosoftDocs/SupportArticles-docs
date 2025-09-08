---
title: Set up and use lot expiration dates
description: Describes how to set up and use lot expiration dates in Microsoft Dynamics GP 10.0.
ms.reviewer: theley, ppeterso
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# How to set up and use lot expiration dates in Microsoft Dynamics GP 10.0

This article describes how to set up and use lot expiration dates in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954630

## Introduction

This article includes the following parts:

- The new setup options in the Inventory Control Setup window and how they are used to control the use of expired lot numbers.

- The steps to configuring the options for the use, and the assignment of lots including expiration dates.

- The warning messages from the Inventory Control Setup window.

## More information

In Microsoft Dynamics GP 10.0, you can use expired lots when you enter transactions in the following modules:

- Bill of Materials
- Purchase Order Processing
- Sales Order Processing
- Invoicing
- Manufacturing
- Inventory

You can require a password to limit the users who can enter expired lots.

## Configure Inventory

1. Start Microsoft Dynamics GP 10.0 as the sa user.

2. On the **Microsoft Dynamics GP** menu, point to Tools, point to **Setup**, point to **Inventory**, and then select **Inventory Control**.

3. Select the appropriate check boxes in the **Use Expired Lots in** section:

    - **Inventory Adjustments and Transfers**  
    - **Other Transactions**  

        > [!NOTE]
        > A password can be entered for each of these options.

4. Select **OK**.

## Configure the warning messages for lot numbers that are near the expiration dates

- Lot tracked item classes

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Inventory**, and then select **Item Class**.
    2. In the **Class ID** list, select an item class ID.
    3. If it's necessary, select the **Warn** check box, and then enter a value in the **days before lot expires** field.
    4. Select **OK**.

- Lot tracked items

    1. On the **Cards** menu, point to **Inventory**, and then select **Item**.
    2. In the **Item Number** list, select an item number.
    3. Select **Options**.
    4. If it's necessary, select the **Warn** check box, and then enter a value in the **days before lot expires** field.
    5. Select **OK**.

## Example

This example uses Fabrikam, Inc., the sample company for Microsoft Dynamics GP 10.0.

### Inventory Control Setup window

1. On the **Microsoft Dynamics GP** menu, point to Tools, point to **Setup**, point to **Inventory**, and then select **Inventory Control**.
2. Select the **Use Existing Serial/Lot Numbers Only on Decrease or Transfer Transactions** check box.
3. Select the **Inventory Adjustments and Transfers** check box in the **Use Expired Lots in** section.
4. In the **Password** field, type **TEST**.
5. Select **OK**.

### Item Maintenance window

1. On the **Cards** menu, point to **Inventory**, and then select **Item**.
2. Create a new item with the following attributes:

    - **Item Type:** Sales Inventory
    - **Valuation Method**: FIFO Perpetual
    - **Class ID**: SERVERS-2
    - **Sales Tax Option**: Nontaxable
    - **Purchase Tax Option**: Nontaxable
    - **Current Cost**: $10.00

3. Select **Options**, and then select **Lot Numbers** in the **Track** field.
4. Select the **Warn** check box, type 5 in the **days before lot expires** field, and then select **OK**.
5. Select **Save**, and then close the Item Maintenance window.

### Increase adjustment in the Item Transaction Entry window

1. On the **Transactions** menu, point to **Inventory**, and then select **Transaction Entry**.
2. In the **Document Type** list, select **Adjustment**.
3. In the **Date** field, type **04172018**.
4. In the **Item Number** list, select the item number you created in the Item Maintenance window.
5. In the **Quantity** field, type 10 .
6. In the **Site ID** field, type **WAREHOUSE**. When you're prompted to add the site, select **Add**.
7. In the Item Lot Number Entry window, type A in the **Lot Number** field, and then select the blue right arrow.
8. In the Lot Attribute Entry window, enter the following information, and then select **OK**:

    - **Manufactured Date**: 04122018
    - **Expiration Date**: 05122018

9. In the **Quantity Selected** field, type **10**, select **Insert**, and then select **OK**.

10. Select **Post**, and then close the Item Transaction Entry window. When you're prompted to print posting journals, select the appropriate destination.

### First decrease adjustment in the Item Transaction Entry window

1. On the **Transactions** menu, point to **Inventory**, and then select **Transaction Entry**.
2. In the **Document Type** list, select **Adjustment**.
3. In the **Date** field, type **05102018**.
4. In the **Item Number** list, select the item number you created in the Item Maintenance window.
5. In the **Quantity** field, type **-5**.
6. In the **Site ID** list, select **WAREHOUSE**.
7. In the Lot Number Entry window, select **A** in the **Lot Number** list, and then type 5 in the **Quantity Selected** field.
8. Select **Insert**. Select **Yes** when you receive the following message:  
    > This lot is approaching its expiration date. Do you want to use this lot?
9. Select **Post**. Close the Item Transaction Entry window. When you're prompted to print posting journals, select the appropriate destination.

### Second decrease adjustment in the Item Transaction Entry window

1. On the **Microsoft Dynamics GP** menu, select **User Date**.
2. Type **12202018**, and then select **OK**.
3. On the **Transactions** menu, point to **Inventory**, and then select **Transaction Entry**.
4. In the **Document Type** list, select **Adjustment**.
5. In the **Item Number** list, select the item number you created in the Item Maintenance window.
6. In the **Quantity** field, type **-5**.
7. In the **Site ID** list, select **WAREHOUSE**.
8. In the Lot Number Entry window, select **A** in the **Lot Number** list, and then type 5 in the **Quantity Selected** field.
9. Select **Insert**.
10. When you receive the following message, type **TEST**, and then select **OK**:  
    Enter a password to use an expired lot.

    > [!NOTE]
    > A yellow triangle with an exclamation point is displayed next to the expiration date as a notification that the lot number has expired.

    > [!NOTE]
    > If the **Inventory Adjustments and Transfers** check box in the **Use Expired Lots in** section isn't marked, you will receive the following message instead:

    > You can't select this lot number because its expiration date has passed.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
