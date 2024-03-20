---
title: Undo depreciation for fixed assets
description: Describes how to undo depreciation for fixed assets after you process depreciation in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# How to undo depreciation for fixed assets in Microsoft Dynamics GP

This article provides a solution to an issue after you process depreciation in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866024

## Symptoms

After you process depreciation in Microsoft Dynamics GP, you realize that there's an issue and you must undo depreciation.

You can undo depreciation for one asset by using the Depreciate One Asset routine in Microsoft Dynamics GP. However, you can't undo depreciation for all assets or for or a group of assets. It's by design.

## Resolution

To undo depreciation for one asset, follow these steps:

1. Open the Depreciate Asset window by using the appropriate method:
   - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate One Asset**.
   - In Microsoft Dynamics GP 9.0 or an earlier version of the program, select **Tools**, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate One Asset**.
2. In the **Asset ID** field, select the asset ID for which you want to undo the depreciation calculations.
3. Set the value in the **Depreciation Target Date** field back to the "Depreciated to Date" that this asset used previously.
4. Under **Select a Book for this Asset**, select a book on which to calculate depreciation.
5. Select **Depreciate**.

    You'll receive the following warning message:

    > The Target Date you have entered is before the Depreciation to Date for this Asset. Should you continue, depreciation will be backed out. Do you want to continue?

    If you select **Yes**, depreciation will be backed out to the target date that was entered. Reversing entries that back out the depreciation will be created in the Financial Detail file for the asset. When the General Ledger Interface is run for these transactions, the reversing entries will be put in a batch in General Ledger to post.

## More information

If you've lots of assets to undo depreciation and you don't want to use the Depreciation One Asset routine, a billable service may be available to you to undo depreciation for all assets or for a group of assets. Use one of the following options, depending on whether you're a customer or a partner:

Customers:
For more information about data manipulation consulting services, contact your partner of record. If you don't have a partner of record, visit the following web site to identify a partner: [Microsoft Pinpoint](https://www.microsoft.com/solution-providers/home).

Partners:
For more information about data manipulation consulting services, contact Microsoft Advisory Services at 800-MPN-SOLVE.
