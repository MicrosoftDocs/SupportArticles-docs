---
title: Decrease the number of decimal places in Currency Setup
description: Describes an issue in which you receive an error message and you cannot decrease the number of decimal places for a currency.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# How to decrease the number of decimal places in Currency Setup

This article provides a solution to an issue where the number of decimal places for a currency cannot be decreased after the currency has been saved.

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
> Use this method if you have to change the decimal places back to two (or to another number) and if you have not entered any transactions by using the additional decimal places.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. If you are using Microsoft SQL Server 2000, click **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    If you are using Microsoft SQL Server 2005, click **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, click **SQL Server Management Studio**, and then click **New Query**.
2. Select the DYNAMICS database.

3. Run the following statement to reset the decimal places to two.

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

> [!NOTE]
> If you are using SQL Server Desktop Engine (also known as MSDE 2000), use the Support Administrator Console. For more information about how to do this, contact Microsoft Business Solutions Technical Support at 1-888-477-7877.
