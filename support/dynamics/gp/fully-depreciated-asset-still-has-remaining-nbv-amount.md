---
title: Fully depreciated asset still has remaining NBV amount
description: Explains why an asset may be retired or fully depreciated, but yet there is a remaining amount for the Net Book Value amount in Fixed Assets using Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Fixed Assets
---
# Fully depreciated asset still has remaining Net Book Value (NBV) amount in Fixed Assets for Microsoft Dynamics GP

This article explains why an asset may be retired or is flagged as fully depreciated, but yet there is a remaining amount in the **Net Book Value** (NBV) field in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2652477

## Cause

This issue happens because no **Switchover** method was used.

When as asset has a depreciation method other than **Straight-Line** method (such as a Declining Balance method), and there is no **Switchover** method defined, it is normal for an asset to be fully depreciated, even though there is a remaining **Net Book Value** amount. Because there is no **Switchover** method, the depreciation calculation will never reach $0. The fully depreciated flag is set to **Y** because the **Remaining Year, Days** has reached zero.

A **Switchover** method is needed for other types of depreciation (other than **Straight-Line**) to ensure the **NBV** will reach $0.00 at the end of the asset's life. The purpose of the **Switchover** method is to take effect when the system determines that the **Straight-Line** method will take more depreciation than the selected depreciation method, to ensure the **NBV** amount will reach $0.00 at the end of its original life.

## Resolution

Use these steps to recalculate the depreciation and get the NBV to reach zero:

1. Make a backup of the company database and copy it to a test company. It's recommended to test these steps in a test company first before doing this on your live database.
2. Go to the Asset Book window for the asset. To do this, select **Cards**, point to Fixed Assets, and then select **Book**. Enter the appropriate Asset ID and Book ID.
3. In the **Switchover** field, select **Straight-Line**.
4. Select **Save**. You're prompted with following message:

    > You have changed a depreciation sensitive field. This will result in depreciation values being recalculated. Do you wish to continue?
    Click Yes.

5. You're prompted with the following message:

   > A depreciation sensitive field has changed. Select one of the following "Reset" options.

   Usually you will reset the **Life**. This will back out all the depreciation for the life of the asset and recalculate it, which could change the depreciation numbers. (Most often you have to reset Life. In some cases, you may get by with only resetting the Year, but if the switchover method needs to take over before the current year, then reset Year may not be sufficient.)

    > [!NOTE]
    > Reset Life will recalculate the depreciation on the asset life to date. Reset Year will only recalculate the depreciation for the current year. And Recalculate will only be used going forward. For more information about these options and depreciation sensitive fields, see [Information about changing a depreciation-sensitive field in the Asset Book window in Fixed Asset Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/information-about-changing-a-depreciation-sensitive-field-in-the-asset-book-window-in-fixed-asset-management-in-microsoft-dynamics-gp-02ba9e2a-23b3-b71a-c44b-92fb7d313701).

6. After you've verified the results of the recalculculated depreciation in the test company, follow the same steps in the live company.

## More information

If you retire an asset that has an **NBV** amount, it will remain. Retiring an asset will not set the **NBV** amount to zero.
