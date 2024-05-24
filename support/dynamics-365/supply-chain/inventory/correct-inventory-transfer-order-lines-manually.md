---
title: Transfer order line data discrepancy or corruption
description: Introduces the Correct inventory transfer order lines manually feature to fix the data discrepancy or data corruption issues for transfer orders in Dynamics 365 Supply Chain Management. 
author: sherry-zheng 
ms.author: chuzheng 
ms.custom: sap:Inventory management\Issues with inventory orders
ms.date: 05/21/2024
---
# Transfer order line data discrepancy or corruption

This article introduces how to use the **Correct inventory transfer order lines manually** feature to fix the data discrepancy or data corruption issues for transfer orders in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

When you inspect the lines of a transfer order, you notice one or more of the following issues:

- A data discrepancy or corruption exists in the **Shipped quantity**, **Ship remain**, or  **Receive remain** field.
- After receiving a transfer order line, there are still orphan inventory transactions that haven't been financially updated. For now, it only covers the receipt side.
- When generating a picking list for a transfer order, an [output order](/dynamics365/supply-chain/inventory/outbound-process#output-orders) is generated. Inventory transactions hold a child reference of a completed output order.
- [Transfer order header status](/dynamics365/intelligent-order-management/integrate-transfer-orders#process-transfer-order-and-status-updates) is inconsistent.
- Transfer order lines and inventory transactions still exist, but the header is missing.

## Cause

These issues usually occur due to data corruption or discrepancies caused by customizations and integration.

## Resolution

As an administrator, you can use the **Correct inventory transfer order lines manually** feature to fix inconsistent data and correct the unexpected quantities that are related to the transfer orders.

Follow these steps to manually correct inventory transfer order lines:

1. Navigate to the **Transfer order manual correction** page by selecting **Inventory management** > **Periodic tasks** > **Clean up** > **Correct transfer order lines manually**.
2. In the **Transfer number** field, find and select the transfer order in question.
3. In the **Item number** field, select the related item number.
4. In the **Line number** field, select the line where you find a discrepancy.
5. Under the **Parameters** section, select the correction option based on different issues.

   | Issue | Option |
   | --- | --- |
   | A data discrepancy or corruption exists in the **Shipped quantity**, **Ship remain**, or **Receive remain** field.| **Recalculate transfer-related quantities** |
   | After receiving a transfer order line, there are still orphan inventory transactions that haven't been financially updated. For now, it only covers the receipt side. | **Recalculate inventory transactions** |
   | When generating a picking list for a transfer order, an output order is generated. Inventory transactions hold a child reference of a completed output order. | **Recalculate inventory transactions** |
   | Transfer order header status is inconsistent. | **Recalculate header status** |
   | Transfer order lines and inventory transactions still exist, but the header is missing. | **Recover header** |
