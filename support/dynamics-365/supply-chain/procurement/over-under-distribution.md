---
title: Resolve Accounting Distribution Errors on Purchase Orders
description: Learn how to resolve purchase order distribution errors, including over- or under-distribution, fully distributed line errors, and confirmation exceptions.
ms.date: 11/09/2026
ms.search.form: PurchTable, PurchTablePart
audience: Application User
ms.reviewer: kamaybac, henrikan
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---
# Purchase order accounting distribution errors

## Summary

In Microsoft Dynamics 365 Supply Chain Management, inconsistent purchase order distributions can prevent you from confirming a purchase order or completing another purchase order action. This article describes three symptoms and the shared purchase order distribution reset procedure.

[Accounting distributions](/dynamics365/finance/accounts-payable/accounting-distributions) allocate amounts on a source document, such as a purchase order, to specific ledger accounts.

## Symptoms

You experience one of the following symptoms.

- You receive the following error.

  > One or more accounting distributions is either over-distributed or under-distributed

- When you confirm a purchase order, you receive the following exception.

  > Object reference not set

- You can't complete a purchase order action because a line isn't fully distributed, and you receive the following error.

  > This action can only be completed after the line number %1 is fully distributed.

## Cause

These symptoms can occur because of inconsistent purchase order distributions. Distribution inconsistency is a possible cause, not a diagnosis for every **Object reference not set** exception.

## Resolution

For an intercompany purchase order, first compare your configuration with [Accounting distributions are over- or under-distributed when you confirm intercompany purchase orders](intercompany-purchase-order-confirmation-over-under-distribution.md). That article describes a specific budget-control and price-synchronization scenario with a separate line-level reset procedure.

For other scenarios, you can reset the purchase order to unblock the process. Test the reset in a user acceptance testing (UAT) environment before you use it in production. Review the applicability and limitations in [Resolve PO distribution errors in Dynamics 365 Supply Chain Management](https://www.microsoft.com/en-us/dynamics-365/blog/it-professional/2020/08/12/resolve-po-distribution-errors-in-dynamics-365-supply-chain-management/) before running the tool.

1. Go to **Procurement and sourcing** > **Periodic tasks** > **Clean up** > **Purchase order distribution reset**.
2. Select the affected purchase order, and then select **OK**.

The tool validates the purchase order's state before resetting the corresponding source document and accounting distributions. If change management is enabled, the purchase order is reset to **Draft**.

After the reset, check the order's status and retry the blocked action through your normal purchase order process. If change management returned the order to **Draft**, complete the normal approval process before you confirm it. See [Approve and confirm purchase orders](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation). Check whether the original error recurs.
