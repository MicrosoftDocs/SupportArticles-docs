---
title: Clear data for the Fixed Asset files
description: Describes how to clear data for the Fixed Asset files to rerun an import in Fixed Assets in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# How to clear data for the Fixed Asset files to rerun an import in Fixed Assets in Microsoft Dynamics GP

This article describes how to clear data for the Fixed Asset files to rerun an import in Fixed Assets in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850361

## Remove both the asset general information and the asset book information

If you want to remove both the asset general information and the asset book information, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. In Microsoft Dynamics GP, point to **Tools**  on the **Microsoft Dynamics GP**  menu, point to **Utilities**, point to **Fixed Assets**, and then select **Clear Data.**  
2. In the **Series** list, select **Financial**. (The **Display** option in the menubar should default to Logical.)
3. To insert the following logical tables, select the tables, and then select **Insert**.
   - Fixed Assets Master
   - Fixed Assets Index Master
   - Fixed Assets Financial Master
4. Select **Process**.

    > [!NOTE]
    > If you receive any error messages for the Fixed Assets Financial Master Note tables, you must re-create the FA00902.* files. To do it, follow these steps:

    1. Exit Microsoft Dynamics GP.

    2. Open SQL Query Analyzer, and then select the company database.

    3. Enter the following query.

        ```sql
        Delete FA00902
        Delete FA00905
        ```

    4. To run the query, select the green arrow, or press F5.

    5. Start Microsoft Dynamics GP.

5. Run the import again.

## Remove only the book information

If you want to remove only the book information, follow these steps:

1. Make a full backup copy to protect the data.
2. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Fixed Assets**, and then select **Clear Data**.
3. In the **Series** list, select **Financial**.
4. In the top menubar, select **Display** and then select **Physical**.
5. To insert the following physical tables, select the table name, and then select **Insert**.

    - Asset Book Master (FA00200)
    - Asset Financial Detail Master (FA00902)
    - Asset Book ITC/Cost Adjustment Master (FA00300)
    - Fixed Assets General Ledger Interface WORK (FA00905)
6. Select **Process**.
7. Run the book import again.
