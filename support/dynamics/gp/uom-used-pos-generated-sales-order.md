---
title: UOM used on POs generated from Sales Order
description: Information about the unit of measure used on purchase orders generated from Sales Order Processing in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# Information about the unit of measure used on purchase orders generated from Sales Order Processing in Microsoft Dynamics GP

This article describes how the options in the Sales Order Processing Setup Options window, the Item Purchasing Options Maintenance window, and the Item Vendors Maintenance window affect the Unit of Measure that is used when a purchase order is generated from a sales order in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951789

## Introduction

When the purchase order preview is generated in the Purchase Orders Preview window from the Sales Transaction Entry window, the unit of measure assigned will depend on the options set in the Item Vendors Maintenance window for the Vendor/Item combination. To view the Item Vendors Maintenance window options, follow these steps.

## More information

1. On the **Cards** menu, point to **Inventory**, and then select **Vendors**.
2. In the **Item Number** list, select the item number.
3. In the **Vendor ID** list, select the vendor ID.
4. > [!NOTE]
   > The value in the **Default Purchasing U of M** section.

    1. If **From Item Vendor** is selected, the unit of measure selected here will default on the Purchase Order Preview window.
    1. If **From Item** is selected, the system will view at the Sales Order Processing Setup Options window.

To view the Sales Order Processing Setup Options window, follow these steps:

1. Follow the appropriate step:

    - On Microsoft Dynamics GP 9.0 and earlier versions, On the **Tools** menu, point to **Setup**, point to **Sales** and then select **Sales Order Processing**.
    - On Microsoft Dynamics GP 10.0, On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Sales**, and then select **Sales Order Processing**.
2. Select **Options**.
3. > [!NOTE]
   > The value in the **U of M** field in the **Defaults for Purchase Order** section.

    - If **Sales Line Item's U of M** is selected, the unit of measure that is located on the Sales Line Item will default in the Purchase Order Preview window.
    - If **Item's Default Purchasing U of M** is selected, the unit of measure that is assigned to the Item in the Item Purchasing Options Maintenance window will be used.

To view the Item Purchasing Options Maintenance window, follow these steps:

1. On the **Cards** menu, point to **Inventory**, and then select **Item Purchasing Options**.
2. In the **Item Number** list, select the item number.
3. > [!NOTE]
   > The value in the **Default Purchasing U of M** field. The unit of measure selected here will be the unit of measure that defaults in the Purchase Orders Preview window if the Item/Vendor combination is **From Item** in the Item Vendors Maintenance window and if the **Defaults for Purchase Order** field in the Sales Order Processing Setup Options window is set to **Item's Default Purchasing U of M** on the **U of M** list.

This article explains what unit of measure will default in the Purchase Order Previews window. However, you may change the default. To do it, select the **Item** tab, and then change the unit of measure. The unit of measure that appears in the **U of M** field is the value that will appear on the purchase order when you select **Generate**.

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
