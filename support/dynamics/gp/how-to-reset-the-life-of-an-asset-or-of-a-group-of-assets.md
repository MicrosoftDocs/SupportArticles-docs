---
title: How to reset the life of an asset or of a group of assets
description: This article describes how to reset the life of a fixed asset in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# How to reset the life of an asset or of a group of assets in Fixed Asset Management in Microsoft Dynamics GP

This article describes how to reset the life of an asset or of a group of assets in Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861544

> [!NOTE]
>
> - When you reset the life of an asset, the depreciation is recalculated from the service date forward to the date when the asset was already depreciated.
> - If there are adjustments to the depreciation for any period, the adjustments are written to the Financial Detail file.
> - Depreciation for the prior year is posted into the current fiscal year General Ledger under the prior year depreciation account. Depreciation for the prior year is not posted into the prior year General Ledger.
> - When you reset the life of an asset, the performance of the system may be affected. Therefore, we do not recommend this action. For example, the following issues may result from this action:
>   - The size of the Financial Detail (FA00902) table may be increased. This creates more data to be processed for the Post to GL routine.
>   - If a user changes the LTD Depreciation field and the YTD Depreciation field manually, these amounts are recalculated.

## How to reset the life of a single asset

### Method 1

1. Make a full, restorable backup.
2. Select **Cards**, point to **Fixed Assets**, and then select **Book**.
3. Select the asset ID of the required asset, and then select the book ID.
4. Select the incorrect **Depreciation Method**.
5. Select the correct **Depreciation Method**, and then select **Save**.
6. In the following message, select **Yes**:

   > You have changed a depreciation sensitive field. This will result in depreciation values being recalculated. Do you wish to continue?

7. In the following message, select **Life**:

   > A depreciation sensitive field has changed. Please select one of the following "Reset" options - Life, Year, or Recalculate.
8. Select **Save**, and then close the window.

### Method 2

#### Microsoft Dynamics GP 10.0 and higher versions

1. Make a full, restorable backup.
2. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate One Asset**.
3. In the Depreciate Asset window, select the asset ID of the required asset.
4. Do not enter a depreciation target date.
5. Select a book for this asset, and then select **Reset Life**.

#### Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0

1. Select **Tools**, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate One Asset**.
2. In the Depreciate Asset window, select the asset ID of the required asset.
3. Do not enter a depreciation target date.
4. Select a book for this asset, and then select **Reset Life**.

## How to reset the life of a group of assets

Follow these steps:

1. Make a full, restorable backup.
2. Select **Transactions**, point to **Fixed Assets**, select **Select Assets**, and then select **New Group**.
3. Name the group, and then select **OK**.
4. Under **Current Groups**, select the newly created asset group, select to select the assets for which you want to reset the life, and then select **OK**.
5. Select **Transactions**, point to **Fixed Assets**, and then select **Mass Change**.
6. Select the newly created asset group ID, select the **Book** tab, select the book ID, select **Reset Life**, and then select **Apply Changes**.
7. In the following message, select **OK**:

   > Are you sure you want to apply changes to group (New_Group_Name)
8. Close the window.
