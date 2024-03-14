---
title: Unable to add entity because it already exists error when you transfer a requisition to a purchase order in Microsoft Dynamics GP
description: Describes a problem where you receive the error message - Unable to add entity because it already exists.
ms.reviewer: theley, steves, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# Error message when you transfer a requisition to a purchase order in Microsoft Dynamics GP: "Unable to add entity because it already exists"

This article describes an issue where you can't transfer a requisition to a purchase order in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952224

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## Symptoms

When you transfer a requisition to a purchase order in Microsoft Dynamics GP, you receive the following error message:
> Unable to add entity because it already exists

## Cause 1

The value in the **Next Purchase Order Number** field in the Purchase Order Processing Setup window has already been used on a purchasing document. See [Resolution 1](#resolution-1).

## Cause 2

Invalid records exist in the MulitUserManager table that reference the next purchase order number. See [Resolution 2](#resolution-2).

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Resolution 1

1. Check the POP10100 table and the POP30300 table for the last purchase order number used in the system by following these steps:

    1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

        **Method 1: For SQL Server Desktop Engine**

        If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, click **Start**, point to **All Programs** > **Microsoft Administrator Console**, and then click **Support Administrator Console**.

       **Method 2: For SQL Server 2000**

        If you're using SQL Server 2000, start SQL Query Analyzer. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.

        **Method 3: For SQL Server 2005**

        If you're using SQL Server 2005, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.  

    2. Run the following scripts against the company database:

        ```SQL
        select MAX (PONUMBER) from POP10100
        ```

        ```SQL
        select MAX (PONUMBER) from POP30100
        ```

    3. Use the results from step b to find the largest purchase order number.

2. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Purchasing**, and the click **Purchase Order Processing**.
   - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Setup** > **Purchasing**, and then click **Purchase Order Processing**.
3. Use the results from step 1 to determine if the value in the **Next Purchase Order Number** field has already been used. If the value has already been used, then change the value in the **Next Purchase Order Number** field.

## Resolution 2

1. Have all users exit Business Portal.
2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1: For SQL Server Desktop Engine**

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, click **Start**, point to **All Programs** > **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    **Method 2: For SQL Server 2000**

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.

    **Method 3: For SQL Server 2005**

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.  

3. Run the following script against the DYNAMICS database

    ```SQL
    Delete MultiUserManager
    ```

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
