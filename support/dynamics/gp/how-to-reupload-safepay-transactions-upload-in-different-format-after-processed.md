---
title: Reupload SafePay Transactions Upload in different format
description: Provides the steps to reupload a SafePay Transactions file in a different format after it has already been processed in Microsoft Dynamics GP.
ms.reviewer: theley, dbader
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to reupload a SafePay Transactions Upload file in a different format after it was processed in Microsoft Dynamics GP

This article describes how to reupload a SafePay Transactions Upload file in a different format after it was already processed in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 854519

To reupload a SafePay Transactions Upload file, follow these steps:

1. Have all users exit Microsoft Dynamics GP.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    Method 1: For SQL Server Desktop Engine

    If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    Method 2: For SQL Server 2000

    If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    Method 3: For SQL Server 2005

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

3. Run the following scripts against the company database.

    ```sql
    SELECT * from ME123503
    ```

    ```sql
    SELECT * from ME123504
    ```

    In these scripts, note the value of the **MEUPLDID** field for the last upload process.

4. Run the following scripts against the company database.

    ```sql
    DELETE ME123503 where MeUpldID = 'XXX'
    ```

    > [!NOTE]
    > Replace the placeholder *XXX* by using the value of the **MEUPLDID** field that you noted.

    ```sql
    DELETE ME123504 where MeUpldID = 'XXX'
    ```

    > [!NOTE]
    > Replace the placeholder *XXX* by using the value of the **MEUPLDID** field that you noted.

5. Start Microsoft Dynamics GP.
6. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Financials**, point to **SafePay**, and then select **Transactions Upload**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Financials**, point to **SafePay**, and then select **Transactions Upload**.

7. Verify that you can re-upload the SafePay Transaction file.
