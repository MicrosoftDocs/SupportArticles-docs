---
title: Transfer order line data discrepancies or corruption
description: Introduces the Correct inventory transfer order lines manually feature to fix the data discrepancies or data corruption issues of transfer orders in Dynamics 365 Supply Chain Management. 
author: sherry-zheng 
ms.author: chuzheng 
ms.custom: sap:Inventory management
ms.date: 05/21/2024
---
# Transfer order line data discrepancies or corruption

This article introduces how to use the **Correct inventory transfer order lines manually** feature to fix the data discrepancies or data corruption issues of transfer orders in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

When you inspect the lines of a transfer order, you notice one or more of the following issues:

- There is a data discrepancy or corruption in the **Shipped quantity** field.
- There is a data discrepancy or corruption in the **Ship remain** field.
- There is a data discrepancy or corruption in the **Receive remain** field.
- After a transfer order line is received, there are still orphan inventory transactions which aren’t financially updated. For now, it only covers the receipt side.
- When a picking list is generated for a transfer order, an [output order](/dynamics365/supply-chain/inventory/outbound-process#output-orders) is generated. Inventory transactions hold a child reference of a completed output order.
- [Transfer order header status](/dynamics365/intelligent-order-management/integrate-transfer-orders#process-transfer-order-and-status-updates) is inconsistent.
- Transfer order lines and inventory transactions still exist, but the header is missing.

## Cause

These issues are usually caused by data corruption or a discrepancy due to customizations and integration.

## Resolution

As an administrator, you can use the **Correct inventory transfer order lines manually** feature to fix inconsistent data and correct the unexpected quantities that are related to the transfer orders.

On the **Transfer order manual correction** page, select one of the following options to fix the data discrepancies or data corruption issues:

- **Recalculate transfer-related quantities**
- **Recalculate inventory transactions**
- **Recalculate header status**
- **Recover header**

You can manually correct inventory transfer order lines as described in the following procedure:

1. Go to **Inventory management** > **Periodic tasks** > **Clean up** > **Correct transfer order lines manually**.
2. In the **Transfer order** field, find and select the transfer order that is giving you trouble.
3. In the **Item number** field, select the related item number.
4. In the **Line number** field, select a line where you find a discrepancy.
5. Under the **Parameters** section, select a resolution for different issues.

| Issue | Option |
| --- | --- |
| There is a data discrepancy or corruption in the **Shipped quantity** field.| Recalculate transfer-related quantities. |
| There is a data discrepancy or corruption in the **Ship remain** field.| Recalculate transfer-related quantities. |
| There is a data discrepancy or corruption in the **Receive remain** field.| Recalculate transfer-related quantities. |
| After a transfer order line is received, there are still orphan inventory transactions which aren’t financially updated. For now, it only covers the receipt side. | Recalculate inventory transactions. |
| When a picking list is generated for a transfer order, an output order is generated. Inventory transactions hold a child reference of a completed output order. | Recalculate inventory transactions. |
| Transfer order header status is inconsistent. | Recalculate header status. |
| Transfer order lines and inventory transactions still exist, but the header is missing. | Recover header. |

## More information

[Correct inventory transfer order lines manually D365 SCM [Data fix self-service tool]](https://www.youtube.com/watch?v=vu_x9M1Ygps)
