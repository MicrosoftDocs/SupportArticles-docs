---
title: Enable the Projection button in Depreciation Projection
description: Describes how to make the Projection button available in the Depreciation Projection window for Fixed Assets.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Fixed Assets
---
# How to enable the Projection button in the Depreciation Projection window for Fixed Assets in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains

This article describes how to enable the Projection button in the Depreciation Projection window for Fixed Assets in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856544

To make the Projection button available in the Depreciation Projection window for Fixed Assets, follow these steps.

> [!NOTE]
> The following steps require you to run delete scripts by using the Microsoft SQL Query Analyzer tool. We recommend that you create a backup of your data before you follow these steps.

1. Make sure that all users exit Microsoft Dynamics GP.
2. Use one of the following methods to start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio depending on the program that you use:

   - Method 1: SQL Server Desktop Engine (MSDE2000)

     Select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.
   - Method 2: SQL Server 2000

     Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - Method 3: SQL Server 2005

     Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - Method 4: SQL Server 2008

     Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
   - Method 5: SQL Server 2008 R2

     Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008 R2**, and then select **SQL Server Management Studio**.
   - Method 6: SQL Server 2012

     Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2012**, and then select **SQL Server Management Studio**.
3. Run the following commands against the Company database:

    ```sql
    DELETE FA40203
    DELETE FA41900
    ```

    > [!NOTE]
    >
    > - FA40203 is the Fixed Assets Depreciation Book Setup table (used for tracking projections and depreciation).
    > - FA41900 is the Projection Report Master table.

4. Start Microsoft Dynamics GP.
5. Verify that the Projection button is available. To do this, follow one of these steps, depending on the program that you are running:
   - For Microsoft Dynamics GP 10.0 and later versions:

     On the Microsoft Dynamics GP menu, point to **Tools**, point to **Routines**, point to **Fixed Assets**, select **Projection**, and then verify that the **Projection** button is available.
   - For Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0:

      On the **Tools** menu, point to **Routines**, point to **Fixed Assets**, select **Projection**, and then verify that the **Projection** button is available.
