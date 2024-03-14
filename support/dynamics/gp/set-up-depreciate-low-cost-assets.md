---
title: Set up and depreciate low-cost assets
description: Describes how to set up and then depreciate low-cost assets according to German law in Microsoft Dynamics GP.
ms.reviewer: theley, dbader
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set up and then depreciate low-cost assets according to German law in Microsoft Dynamics GP

This article describes how to set up and then depreciate low-cost assets according to German law in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946267

## Introduction

The German law that goes into effect in January 2008 requires companies in Germany to pool low-cost movable assets into a group. Currently, low-cost movable assets are defined as movable assets that have acquisition costs or manufacturing costs that are greater than 150 euros and less than 1,000 euros. The value of this pool must be depreciated over a linear period of five years. You can do it by setting the depreciation period of this group to five years.

> [!NOTE]
> The group value will remain the same even if the assets are sold during the depreciation period.

## More information

To set up and then depreciate a group of low-cost assets in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, follow these steps.

### Step 1: Create a group of low-cost assets

1. Create a class ID in the Class Setup window. To do it, use the appropriate method:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then select **Class**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Fixed Assets**, and then select **Class**.

2. Create a book ID in the Book Setup window. To do it, follow these steps:

    1. Open the Book Setup window. To do it, use the appropriate method:

        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then select **Book**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Fixed Assets**, and then select **Book**.
    1. In the **Book ID** field, type a book ID.
    1. In the **Description** field, type a description.
    1. In the **Depreciation Period** list, select **Periodic**, and then select **Save**.

3. Associate the book ID with the class ID in the Book Class Setup window. To do it, follow these steps:

    1. Open the Book Class Setup window. To do it, use the appropriate method:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then select **Book Class**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Fixed Assets**, and then select **Book Class**.
    1. In the **Book ID** list, select a book ID.
    1. In the **Class ID** list, select a class ID.
    1. In the **Depreciation Method** list, select **Straight-Line Orig Life**.
    1. In the **Averaging Convention** list, select the appropriate averaging convention.
    1. In the **Orig LifeYears, Days** field, type **5**.
    1. Select **Save**.

4. In the Asset General Information window, create an asset ID for each low-cost asset. To do it, follow these steps:

    1. On the **Cards** menu, point to **Fixed Assets**, and then select **General**.
    1. In the **Asset ID** list, select an asset. Or, type a new asset ID.
    1. In the **Class ID** list, select the class ID that you created in step 1.
    1. Select **Save**.

5. Create a book record for the asset. To do it, follow these steps:

    1. On the **Cards** menu, point to **Fixed Assets**, and then select **Book**.
    1. In the **Asset ID** list, select an asset ID.
    1. In the **Book ID** list, select the book ID that you created in step 2.
    1. Select **Save**.

### Step 2: Depreciate the group of low-cost assets

1. Create an asset group ID in the Select Assets window. To do it, follow these steps:

    1. On the **Transactions** menu, point to **Fixed Assets**, and then select **Select Assets**.
    1. Select **New Group**. In the **Group Name** field, type a name for the group. Name the group to reflect the purpose. For example, name the group **LOWCOSTASSETS**.
    1. Select **OK**.
    1. Select the **Asset ID** check box to add assets to the group.
    1. Select **OK**.

2. Depreciate the assets in the group. To do it, follow these steps:

    1. Open the Depreciation Process Information window. To do it, use the appropriate method:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Fixed Assets**, and then select **Depreciate**.
    1. In the **Asset Group ID** list, select the asset group ID that you created in step 1.
    1. In the **Depreciation Target Date** field, type a date.
    1. In the **Books on file** list, select a book ID, and then select **Insert**.
    1. Select **Depreciate**. When you're prompted to continue the depreciation process, select **OK**.

## Depreciation

Depreciation is calculated for each selected asset and for each period. After the depreciation process is complete, the depreciation expense account is debited. And, the depreciation reserve account is credited in the general ledger.

You can view the depreciation details for the assets that you depreciated in the group in the Financial Detail Inquiry window. To open the Financial Detail Inquiry window, point to **Fixed Assets** on the **Inquiry** menu, and then select **Financial Detail**.

> [!IMPORTANT]
> Don't depreciate the low-cost assets individually by using the Depreciate Asset window.

## Sell or retire an asset

To sell or to retire an asset that is part of the group of low-cost assets, create a new group. Then, move the asset from the depreciation group to the new group. It will help identify the asset that is marked for sale or for retirement. When you retire an asset, you must post a revenue transaction in General Ledger in Microsoft Dynamics GP.

> [!IMPORTANT]
> Don't retire low-cost assets individually by using the Retirement Maintenance window. And, don't retire a group that contains the assets that you want to sell or retire by using the Fixed Assets Mass Retirement window.

## References

For more information, see the Fixed Assets Management documentation that is included with the Microsoft Dynamics GP installation or with the Microsoft Business Solutions - Great Plains 8.0 installation.
