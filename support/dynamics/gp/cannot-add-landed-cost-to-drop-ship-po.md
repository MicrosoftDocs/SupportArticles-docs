---
title: Cannot add a Landed Cost to a Drop-Ship PO
description: Provides an answer to the question that whether you can add a Landed Cost to a Drop-Ship PO in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# Cannot add a Landed Cost to a Drop-Ship PO

This article provides more information about the question that you can't add a Landed Cost to a Drop-Ship PO in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4049365

You can only add Landed costs to receivings, and drop-ship PO's Landed costs aren't received in and don't affect inventory since the quantities are shipped directly to the Customer's site. Because drop-ship PO's Landed costs aren't received, there will be no shipment receipt to enter the Landed Cost on and no shipment receipt to match the Landed Cost with. Landed costs are only added to receivings, and there's none in this case.

## Workaround

If you want to charge the customer an additional amount equivalent to the Landed Cost amount, you could add it as a Freight Amount (and edit the GL account as wished).
