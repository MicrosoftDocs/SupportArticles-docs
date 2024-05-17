---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      sherry-zheng # GitHub alias
ms.author:   chuzheng # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     05/17/2024
---

**In this article**

1. Symptoms
2. Causes
3. Resolutions

**Symptoms**

When you inspect the lines of a transfer order, you notice one or more of the following issues:

- There is a data discrepancy or corruption in transfer order line in ‘Shipped quantity’
- There is a data discrepancy or corruption in transfer order line in ‘Ship remain’
- There is a discrepancy or corruption in transfer order line in ‘Receive remain’.
- After transfer order line is received, there are still orphan inventory transactions which aren’t financially updated. For now, it only covers the receipt side.
- When a picking list is generated for a transfer order, an output order is generated. Inventory transactions hold a child reference of completed output order.
- Transfer order header status inconsistency.
- Transfer order lines and inventory transactions still exist, but the header is missing.

**Cause**

These issues are usually caused by data corruption or a discrepancy due to customizations and integration.

**Resolution**

The correct inventory transfer order lines manually form allows the administrator users to fix inconsistent data and correct the unexpected quantities that are related to the transfer orders.

You can fix by:

- Recalculate transfer-related quantities
- Recalculate inventory transactions
- Recalculate header status
- Recover header

You can correct inventory transfer order lines as described in the following procedure:

1. Go to **Inventory management > Periodic tasks > Clean up> Correct transfer order lines manually**
2. In the **Transfer order** field, find and select the transfer order that is giving you trouble.
3. In the **Item number** field, select the related item number.
4. In the Lines **number** section, select a line where you find a discrepancy.
5. In the **Parameters**, select the correction options based on different symptoms.

| **Symptoms** | **Correction** |
| --- | --- |
| There is a data discrepancy or corruption in transfer order line in ‘Shipped quantity’ | **Recalculate transfer-related quantities** |
| There is a data discrepancy or corruption in transfer order line in ‘Ship remain’ | **Recalculate transfer-related quantities** |
| There is a discrepancy or corruption in transfer order line in ‘Receive remain’ | **Recalculate transfer-related quantities** |
| After transfer order line is received, there are still orphan inventory transactions which aren’t financially updated. For now, it only covers the receipt side. | **Recalculate inventory transactions** |
| When a picking list is generated for a transfer order, an output order is generated. Inventory transactions hold a child reference of completed output order. | **Recalculate inventory transactions** |
| Transfer order header status inconsistency | **Recalculate header status** |
| Transfer order lines and inventory transactions still exist, but header is missing. | **Recover header** |
```

