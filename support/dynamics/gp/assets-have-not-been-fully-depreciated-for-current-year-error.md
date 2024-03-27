---
title: Assets have not been fully depreciated for the current year error in Fixed Assets
description: Describes an issue that prompts you with an Assets have not been fully depreciated for the current year message when you try to close the year in Fixed Assets in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# "Assets have not been fully depreciated for the current year" error in Fixed Assets in Microsoft Dynamics GP

This article provides a resolution for the **Assets have not been fully depreciated for the current year** error that may occur when closing year-end for Fixed Assets in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2929773

## Symptoms

When you try to close year-end for Fixed Assets in Microsoft Dynamics GP, you are prompted with the following message:

> Assets have not been fully depreciated for the current year. Do you wish to continue?

## Cause

This message means that the system recognizes an asset that is not fully depreciated to the last day of the fiscal year. If all assets are not depreciated to the last day of the year, depreciation may be overstated in the following year.

> [!NOTE]
> This behavior may also occur if an asset has a depreciation method of No Depreciation. If that is the case, you can click through the message. This issue was logged as Quality Issue #63786 and was resolved in Service Pack 4 (SP4) for Microsoft Dynamics GP 2010 and in SP1 for Microsoft Dynamics GP 2013.

Partial open assets may also trigger this error. That scenario is currently being investigated.

## Resolution

To make sure that all assets are depreciated to the last day of the year, follow these steps:

1. On the Microsoft Dynamics GP menu, select **Tools**, point to **Utilities**, point to **Fixed Assets**, and then select **Build Calendar**. Select the **Inquire** button, and then confirm the last day of the year.

2. On the Microsoft Dynamics GP menu, select **Tools**, point to **Utilities**, point to **Fixed Assets**, and then select **Depreciate**. Run the depreciation process to the last day of the year.

3. Run the following script in SQL Server Management Studio against the company database to determine whether there are other assets that have not been depreciated to the last day of the year.

    ```sql
    select Distinct a.ASSETID, b.DEPRTODATE from FA00100 a, FA00200 b, FA40200 c where a.ASSETINDEX=b.ASSETINDEX and c.BOOKINDX=b.BOOKINDX and a.ASSETSTATUS not in (3,4) and b.FULLYDEPRFLAG='N' and b.DEPRTODATE < (select top 1 PERIODENDDATE from FA42100 where FISCALYEAR='YYYY' order by PERIODID desc) and b.DEPRECIATIONMETHOD <> 15
    ```

    If any results are returned, view the assets that are specified there. If no results are returned, you should be able to close the year. In that case, the problem is probably one of the following:

   - The No Depreciation method that was described in the Cause section
   - Partial open assets

   > [!NOTE]
   > Replace the *YYYY* placeholder in this script with the last day of the fiscal year (as determined in step 1).

4. For versions that are earlier than SP4 for Microsoft Dynamics GP 2010 (before version 11.00.2248) and earlier than SP1 for Microsoft Dynamics GP 2013 (before version 12.00.1333), run the following script in SQL Server Management Studio against the company database:

    ```sql
    SELECT * FROM FA00200 WHERE DEPRECIATIONMETHOD = 15
    ```

   This determines whether there are any assets that have a depreciation method of No Depreciation  If there are, you can select through this message.
