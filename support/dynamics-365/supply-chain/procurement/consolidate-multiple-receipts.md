---
title: Can't consolidate multiple purchase orders into a single receipt
description: Provides more information about the issue that the consolidation of multiple product orders into a single receipt is no longer allowed.
author: Henrikan
ms.date: 05/08/2024
ms.search.form: PurchTable, PurchTablePart
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
---
# You can't consolidate multiple purchase orders into a single receipt

The consolidation of multiple purchase orders into a single receipt is no longer allowed if the different product receipt lines have different accounting dates.

## More information

In earlier versions of Dynamics 365 Supply Chain Management, consolidation was allowed in this situation. However, the practice is prone to error. The accounting date on the purchase order lines that are created should not differ from the accounting date on the product receipt lines that those purchase order lines were created from. (The accounting date on the purchase order lines matches the accounting date on the purchase order header.) Therefore, the consolidation of multiple product orders into a single receipt is no longer allowed.

The accounting date is used, for example, for budget reservations and encumbrance. Therefore, it should be kept during the transition from product receipt to purchase order.
