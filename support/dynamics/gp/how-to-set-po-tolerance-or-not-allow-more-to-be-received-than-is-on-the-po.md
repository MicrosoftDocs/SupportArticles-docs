---
title: How to set PO tolerance or not allow more to be received
description: How to set a PO tolerance or not allow more to be received than is on the PO in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to set a PO tolerance or not allow more to be received than is on the PO in Microsoft Dynamics GP

This article introduces how to set the PO tolerance, or not allow more to be received in that is on the PO in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4020724

Use the appropriate method below, depending on if your item is inventoried or not, so users are not able to receive more quantity in than is on the Purchase order:

## Non-inventoried items

1. Go to **Microsoft Dynamics GP** > **Tools** > **Purchasing** > **Purchase Order Processing**.

2. In the Quantity Tolerance section, mark the **OVERAGE** checkbox and leave the default percentage as **0.000%**. (If this checkbox is marked, then it doesn't allow you to go over the percentage designated, so if you don't have any tolerance leave this as 0.000%. If you want an overage tolerance, set the percentage as desired. If the **Overage** checkbox is not marked, the system will allow the user to receive in any quantity.)

3. Select **OK**.

Now when you go over, you will get this message:

> You can't enter a quantity greater than the combined total of the Remaining to Receive quantity and the overage tolerance set up for the item.

## inventoried items

1. Go to **Cards** > **Inventory** > **Item** and select the item.
1. In the top menubar, select **GO TO** > **PURCHASING**.
1. Mark the checkbox for **OVERAGE**, and leave the default percentage as **0.000%**.
1. Select **Save**.

> [!NOTE]
> This feature is only available for items with an Item Type of **Sales Inventory** or **Discontinued**.  
> These tolerance fields are also available on the Item Class Setup, and can be rolled down to the items assigned to the class.

## More information

You can also use the **SHORTAGE** checkbox in the same manner.
