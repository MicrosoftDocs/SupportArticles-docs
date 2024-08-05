---
title: How to integrate Project Accounting with Fixed Asset Management in Microsoft Dynamics GP
description: Describes how to integrate Project Accounting with Fixed Asset Management. This operation lets items that are associated with a Project Accounting purchase order available as assets in Fixed Asset Management in Microsoft Dynamics GP 9.0.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# How to integrate Project Accounting with Fixed Asset Management in Microsoft Dynamics GP

This article describes how to integrate Project Accounting in Microsoft Dynamics GP 9.0 with Fixed Asset Management in Microsoft Dynamics GP 9.0. After you do these steps, items that are associated with a Project Accounting purchase order are available as assets in Fixed Asset Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936276

## Steps to integrate Project Accounting

To integrate Project Accounting with Fixed Asset Management, follow these steps.

> [!NOTE]
> To complete these steps, Project Accounting and Fixed Asset Management must be installed. Additionally, they must be registered.

1. On the **Tools** menu, point to **Setup** > **Fixed Assets**, and then click **Company**.
2. In the Fixed Assets Company Setup window, click to select the **Post POP through to FA** check box, and then click one of the following options:
    - **By Account**  
    - **By Receipt Line**
3. In the **Asset Account Options** area, click the blue arrow next to **Default Accounts**.
4. In the Default Accounts window, click the lookup button next to the **Clearing** field, double-click a clearing account, and then click **OK**.
5. Click **OK**, and then click **Close**.
6. On the **Transaction** menu, point to **Purchasing**, and then click **Purchase Order Entry**.
7. Create a purchase order that contains the project information and the cost category information.
8. Click **Save**.
9. On the **Transaction** menu, point to **Purchasing**, and then click **Receivings Transaction Entry**.
10. Create a receivings transaction entry that links to the purchase order that you created in step 7.
11. In the **Item** area, click the blue arrow next to the **Item** field.
12. In the Receivings Item Detail Entry window, follow the appropriate step depending on the option that you enabled in step 2:

    - If you enabled the **By Account** option, enter the clearing account that you selected in step 4 to transfer the item to Fixed Asset Management. You use this clearing account as the inventory account.
        > [!NOTE]
        > If you are receiving a non-inventory item, you cannot change the purchasing account. Therefore, the item is not transferred to Fixed Asset Management.
    - If you enabled the **By Receipt Line** option, click to select the **Capital Item** check box to transfer the item to Fixed Asset Management.
13. Click **Save**.
14. On the **Cards** menu, point to **Fixed Assets**, and then click **General**.
15. Click **Purchase**.

    After you complete this step, you can select the item. Then, you can create an asset.
