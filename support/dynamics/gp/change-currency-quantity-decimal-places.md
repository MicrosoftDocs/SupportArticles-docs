---
title: Change currency/quantity decimal places
description: Describes how to change the currency decimal places or the quantity decimal places in Microsoft Dynamics GP.
ms.reviewer: theley, aeckman, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# How to change the currency decimal places or quantity decimal places in Manufacturing in Microsoft Dynamics GP

This article describes how to change the currency decimal places or the quantity decimal places in Manufacturing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 930346

## Introduction

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## More information

To change the currency decimal places or the quantity decimal places, you must complete two tasks:

1. You must change the decimal places in the core tables of Microsoft Dynamics GP.
2. You must update fields in Manufacturing in Microsoft Dynamics GP to reflect the change.

## Task 1: Change the decimal places in the core tables

1. On the **Tools** menu, select **Utilities**, point to **Inventory**, and then select **Change Decimal Places**.
2. In the Change Decimal Places window, select **Change Currency Decimal Places** or **Change Quantity Decimal Places**.

    > [!NOTE]
    >
    > - If you select **Change Currency Decimal Places**, you receive a warning message because changing the currency decimal places rounds the amounts in the price list. For more information, press **F1** to view the "Effects of changing decimal places for currencies for items" topic in Microsoft Dynamics GP Help.
    > - If you select **Change Quantity Decimal Places**, you receive a warning message because changing the number of quantity decimal places clears the unit of measure schedule, the price list, and the purchasing options for the item. For more information, press **F1** to view the "Handling effects of changing quantity decimals" topic in Microsoft Dynamics GP Help.

3. Select the new decimal place or the currency ID. Or, select both items if both items are applicable.
4. Select the item number that you want to change, and then select **Process**.
5. If you receive the following warning message, select **OK**:  
    > Manufacturing isn't updated when you change currency decimals.

    > [!NOTE]
    > If Microsoft Dynamics GP cannot change the decimal places of the item, the reason is included in the Decimal Places Change Audit report.

## Task 2: Update fields in Manufacturing to reflect the change

The changes that you make by using the Change Decimal Places utility don't affect the Manufacturing tables. So you must update the decimal places in the CT00102 table. The column that you update depends on the change that you made:

- If you changed the currency decimal places, you must update the **DECPLCUR** column.
- If you changed the quantity decimal places, you must update the **DECPLQTY** column.

To update the **DECPLCUR** column or the **DECPLQTY** column, you must run an SQL statement in SQL Query Analyzer. The values in the table will be corrected as follows.

|Value that is stored in the table|Corresponding decimal place quantity|
|---|---|
|1|0|
|2|1|
|3|2|
|4|3|
|5|4|
|6|5|
  
To update the **DECPLQTY** column or the **DECPLCUR** column by running an SQL statement, follow these steps:

1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
2. Enter your connection information, and then select **OK**.
3. In the database list, select the Microsoft Dynamics GP company database.
4. Run the following SQL statement in SQL Query Analyzer.

    ```sql
    update CT00102 set DECPLQTY = 3 where ITEMNMBR = '<Item_number>'
    ```

    > [!NOTE]
    > In the statement, the **<Item_number>** placeholder is a placeholder for the actual item number that you want to update.

5. On the **Query** menu, select **Execute**.
