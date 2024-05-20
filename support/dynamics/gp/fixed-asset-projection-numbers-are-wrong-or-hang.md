---
title: Fixed Asset Projection numbers are incorrect or hang
description: Fixed Asset Project numbers are incorrect or hang. Provides a resolution.
ms.reviewer: theley, cwaswick, kenhub
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# Fixed Asset Projection numbers are incorrect or hang in Fixed Asset Management using Microsoft Dynamics GP

This article provides a resolution for the issue that the fixed asset projection numbers are wrong or hang in Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2432511

## Symptoms

Fixed Asset Projection numbers for the current month do not match the previous month. No retirements, transfers, or additions were done for the current month. All assets are straight-line depreciation. Pre-projection numbers especially seem to be overstated or understated. Fixed Asset projections may also error or time out.

## Cause

The Fixed Assets Projection master file may have become corrupt.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, follow these steps:

1. Have all users exit Microsoft Dynamics GP.

2. Open SQL Server Management Studio using the appropriate method below:
   - If you use Microsoft SQL Server 2008, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
   - If you use Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - If you use Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

3. If you know the specific asset causing the issue, run a select statement against the Asset General Information Master table (FA00100) in the Company database to find the asset index (ASSETINDEX):

    ```sql
    Select * from FA00100 where ASSETID = 'XX'
    ```

    (where XX = the Asset ID)

4. Run a delete statement to remove the asset from the Projections Report Master table (FA41900) in the company database.

    Remove the projection for the asset from the FA41900 table using the appropriate method below.

    **Method 1:**

    1. If you know the specific asset causing the issue, run a select statement against the Asset General Information Master table (FA00100) in the Company database to find the asset index (ASSETINDEX):

        ```sql
        Select * from FA00100 where ASSETID = 'XX'
        ```

        (where XX = the Asset ID)

    2. Execute the following delete statement yourself in SQL Server Management Studio to remove the specific asset projection from the FA41900 table:

        ```sql
        Delete FA41900 where ASSETINDEX = 'XXX'
        ```

        (where XXX = the asset index number found in Step 2)

    **Method 2:**

    There is an Automated Solution available to clear the projections for all assets from the FA41900 table to stop projections from erring or timing out.

5. Rerun the Fixed Asset projections using the appropriate method below:

    - For a single asset, select Microsoft Dynamics GP, point to **Tools**, point to **Routines**, point to **Fixed Assets** and select **Depreciate One Asset**. (Make sure to mark the Project Only checkbox.)
    - For all assets or an asset group, select Microsoft Dynamics GP, point to **Tools**, point to **Routines**, point to **Fixed Assets** and select **Projection**.

> [!NOTE]
> In running the projection, you will want to take into consideration the Depreciated To Date of your assets. The system will only project the amounts on the periods where the assets have not been depreciated yet. For example, if the assets have been depreciated on the first 3 months and you run projections up to the 12th month, the projection amounts will only be populated from the 4th month to the 12th month. You will not see any projections for the first 3 months since they have already been depreciated.
