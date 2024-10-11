---
title: Inventory reconcile process when Manufacturing series is installed
description: Explains how the inventory reconcile process functions when the Manufacturing series is installed in Microsoft Dynamics GP 9.0 and in Microsoft Great Plains 8.0.
ms.reviewer: theley, ttorgers
ms.date: 03/20/2024
ms.custom: sap:Manufacturing Series
---
# Information about the inventory reconcile process when the Manufacturing series is installed in Microsoft Dynamics GP 9.0 and in Microsoft Great Plains 8.0

This article describes how the inventory reconcile process functions when the Manufacturing series is installed in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 913344

When you have the Manufacturing series installed, the inventory reconcile process functions differently than when the Manufacturing series was not installed. If you have the Manufacturing series installed and you select **Process** in the **Inventory Reconcile Quantities** dialog box, you experience the following behavior:

- Allocated quantities for the items are set to 0 in the Inventory series.
- The on-hand quantity and the allocated quantity for the item are determined by using data from the Inventory, Sales Order Processing, Invoicing, Bill of Materials, and Purchase Order Processing series. The on-hand quantity and the allocated quantity are set to the amounts that are determined by the system. This change is printed on the Inventory Reconcile Report.
- Pick documents from the Manufacturing series are also used to adjust the allocated quantities for the item. This change is printed on the Picklist Reconcile Inventory Allocation Report.
- The Manufacturing tables that store the pick documents are compared. A change to the quantity that is issued for a particular manufacturing order may result. This change is printed on the Picklist Reconcile Report for the Manufacturing series.
