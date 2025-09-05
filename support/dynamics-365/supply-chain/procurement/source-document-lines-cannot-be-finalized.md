---
title: The Source Document Lines Cannot Be Finalized Until the Status is Confirmed
description: Provides a resolution for the Source document lines cannot be finalized error in Microsoft Dynamics 365.
author: Sumit
ms.date: 09/05/2025
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: sugaur
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase order confirmation and packing slips
---
# "Source document lines cannot be finalized" error when confirming purchase order

This article provides guidance to resolve an error that might occur when confirming a purchase order in Microsoft Dynamics 365.

## Symptoms

When you try to [confirm a purchase order](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#confirming-purchase-orders), you might receive the following error message:

> The source document lines cannot be finalized until the status is Confirmed.

## Cause

The issue occurs when the document accounting status in the related [purchase requisition](/dynamics365/supply-chain/procurement/purchase-requisitions-overview) isn't confirmed.

## Resolution

To resolve this issue, reset the purchase order accounting distributions by following these steps:

1. Navigate to **Procurement and sourcing** > **Periodic tasks** > **Clean up** > **Purchase Order Distribution Reset**.
2. Enter the **Purchase Order (PO) number** in the designated field.
3. Select **OK** to proceed.
4. The status of the purchase order will update to **Draft**.
5. Submit the workflow and confirm the purchase order again.

Triggering the purchase order distribution reset initiates a data check to ensure that the selected purchase order is in the correct state for the tool to run. After the reset, you should be able to finalize the source document lines.

If you continue to experience issues after following these steps, verify that all required fields and configurations for the purchase order are complete. Additionally, ensure that any related workflows are properly configured and functioning as expected.
