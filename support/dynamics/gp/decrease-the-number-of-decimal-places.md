---
title: Decrease the number of decimal places in Currency Setup
description: Describes an issue in which you receive an error message and you can't decrease the number of decimal places for a currency.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Can't decrease the number of decimal places in Currency Setup

This article provides a solution to an issue where the number of decimal places for a currency can't be decreased after the currency has been saved.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865702

## Symptoms

In Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you increase the number of decimal places in the **Currency Setup** window from the original setting. Then, you try to reset the number to the original setting.

When you do this, you receive an error message that states that the number of decimal places for a currency cannot be decreased after the currency has been saved.

## Cause

This issue occurs because you can only increase the number of decimal places in the **Currency Setup** window. If you try to decrease the number, you receive the error message that is mentioned in the [Symptoms](#symptoms) section because of an issue in which reports may be incorrect because of rounding. The error message is to prevent problems on your trial balance.

## Resolution

To resolve this issue, follow these steps.

> [!IMPORTANT]
> Use this method if you have to change the decimal places back to **2** (or another number) and if you haven't entered any transactions by using the additional decimal places.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. If you're using Microsoft SQL Server 2000, select **Start**, point to **Programs** > **Microsoft SQL Server**, and then select **Query Analyzer**.

   If you're using Microsoft SQL Server 2005, select **Start**, point to **Programs** > **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio** > **New Query**.

2. Select the DYNAMICS database.

3. Run the following statement to reset the decimal places to **2**.

    ```sql
    UPDATE MC40200 SET DECPLCUR=3 where CURNCYID='Z-US$'
    ```

    > [!NOTE]
    > In this statement, "Z-US$" is the currency that you selected and then changed in the **Currency Setup** window.

    Set the "DECPLCUR" value according to the following table.

    |Number of decimal places that you want|DECPLCUR value|
    |---|---|
    |0|1|
    |1|2|
    |2|3|
    |3|4|
    |4|5|
    |5|6|

4. In Microsoft Dynamics GP, go to **Administration** > **Setup** > **System** > **Currency** to open the **Currency Setup** window.
   
   1. Select the currency ID that you fixed.
   2. Make a change to the description and select **Save** to roll down the change with the code.

   This will update any other company's setups if you're fixing a functional currency.
