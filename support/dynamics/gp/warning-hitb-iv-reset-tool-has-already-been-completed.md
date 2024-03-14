---
title: Warning message when you click HITB IV Reset Tool in Microsoft Dynamics GP 10.0
description: Describes a problem that occurs when you click HITB IV Reset Tool in Microsoft Dynamics GP 10.0. Provides a resolution.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# "The HITB Reset Tool has already been completed in this company. Are you sure you want to continue?" warning when you click HITB IV Reset Tool in Microsoft Dynamics GP 10.0

This article describes a warning message that occurs when you click HITB IV Reset Tool in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968456

## Symptoms

When you click **HITB IV Reset Tool** in Microsoft Dynamics GP 10.0, you receive the following warning message:

> [!WARNING]
> The HITB Reset Tool has already been completed in this company. Are you sure you want to continue?

## Cause

This problem occurs because the value is 5597 in the **coDefaultType** field of a record that is in the SY01401 table in the company database.

> [!NOTE]
> This value indicates that the Historical Inventory Trial Balance (HITB) feature is enabled in this company. If the HITB Reset tool was run, the warning message is correct. However, if the HITB Reset tool was not run, the warning message is incorrect. This problem indicates that the record was added to the table incorrectly when you upgraded to Microsoft Dynamics 10.0.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs. 

To resolve this problem, make sure that the reset process is completed by following these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.
  
    ### Method 1: For SQL Server Desktop Engine
  
    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, click **Start**, point to **All Programs** > **Microsoft Administrator Console**, and then click **Support Administrator Console**.
  
    ### Method 2: For SQL Server 2000
  
    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.
  
    ### Method 3: For SQL Server 2005
  
    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
  
    ### Method 4: For SQL Server 2008
  
    If you're using SQL Server 2008, start SQL Management Studio. to do it, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.  
  
2. Run the following statement against the company database:

    ```SQL
    SELECT * FROM SEE99997
    ```

3. If the value in the **Step** field of at least one of the returned records is 60, the reset process is complete. Therefore, to print the HITB report, point to **Inventory** on the **Reports** menu, and then click **Activity**.
    > [!NOTE]
    > If you want to rerun the HITB Reset tool, you must first delete the contents in the following tables:
    >
    >  - SEE99997
    >  - SEE99998
    >  - SEE99999
    >  - SEE30303

4. If the SEE99997 table doesn't contain records, the reset process isn't completed. To print the HITB report, follow these steps:

    1. Run the following statement against the company database:
  
        ```SQL
        DELETE SY01401 WHERE coDefaultType = 5597
        DELETE SEE30303
        ```

    1. On the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Inventory**, and then click **HITB IV Reset Tool**.
    1. Click **Yes** if you receive the warning message that's mentioned in the "Symptoms" section.
    1. Complete the reset process.
