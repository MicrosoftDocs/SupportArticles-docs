---
title: How inventory on Stock Status report is calculated
description: Discusses how the inventory value is calculated on the Stock Status report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# How the inventory value on the Stock Status report is calculated in Microsoft Dynamics GP

This article discusses how the Stock Status report calculates the inventory value for each item in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850168

The inventory value on the Stock Status report is calculated based on the following item valuation methods.

- FIFO or LIFO Perpetual valuation methods

  The on-hand quantity is multiplied by the cost at which the item was received.

- Average Perpetual valuation methods

  The on-hand quantity is multiplied by the current cost of the item.

- FIFO or LIFO Periodic valuation methods

  The on-hand quantity is multiplied by the standard cost of the item.
