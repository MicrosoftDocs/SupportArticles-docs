---
title: Purchase Requisitions Can't Be Released
description: Works around an issue where PRs created before the current fiscal year can't be released in Dynamics 365 Finance and Dynamics 365 Supply Chain Management.
author: Shubhs93
ms.author: shubhamshr
ms.reviewer: shubhamshr
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 03/14/2025
---

# Purchase requisitions created before the current fiscal year can't be released

This article provides workarounds for an issue where purchase requisitions created before the current fiscal year can't be released in Dynamics 365 Finance and Dynamics 365 Supply Chain Management.

## Symptoms

When you try to convert a purchase requisition (PR) submitted at the end of one fiscal year and approved in a new fiscal year into a purchase order (PO) in Dynamics 365 Finance and Dynamics 365 Supply Chain Management, you might receive the following error message:

> Purchase requisition line was pre-encumbered in a fiscal year that is different from the accounting date of the purchase order. Hence, purchase order cannot be created.

## Cause 1: Pre-encumbrance issue

When a PR is [approved](/dynamics365/supply-chain/procurement/purchase-requisitions-overview#purchase-requisition-header-and-line-status-relationships), it creates [a pre-encumbrance to reserve budget funds](/dynamics365/supply-chain/procurement/purchase-requisitions-overview#consolidating-purchase-requisition-lines). If the requisition was submitted in the previous fiscal year, the pre-encumbrance is tied to that year's budget. The system detects a mismatch when converting the PR into a PO in the new fiscal year because the pre-encumbrance belongs to the old fiscal year, but the PO is created in the new fiscal year.

## Cause 2: No PR rollover functionality

Dynamics 365 doesn't support PR rollovers across fiscal years. If a PR remains open at year-end, it can't be carried over automatically into the new fiscal year. This restriction ensures that budgets and financial commitments remain aligned with fiscal year policies.

## Workaround

The best practice is to either cancel open PRs at year-end or convert them into POs before the fiscal year closes. This ensures smooth procurement processing without encountering fiscal year mismatches. Since Dynamics 365 doesn't support PR rollovers, organizations should proactively manage requisitions as part of their year-end closing procedures.

- Method 1: Cancel open PRs at year-end
   1. Identify all open PRs before the fiscal year-end closing.
   1. Cancel any unapproved or pending PRs that haven't been converted into POs.
   1. Create new PRs in the new fiscal year, ensuring they align with the correct budget year.

  This method avoids the issue by ensuring that new requisitions are processed within the correct fiscal period.

- Method 2: Convert PRs into POs before fiscal year-end and roll over POs
   1. Convert open PRs into POs before the fiscal year closes.
   1. If a PO needs to be received or invoiced in the new fiscal year, use the rollover functionality of POs.

   This method ensures that financial commitments are properly managed across fiscal years.

## More information

- [Select purchase orders and run the purchase order year-end process](/previous-versions/dynamicsax-2012/appuser-itpro/process-purchase-orders-at-year-end#select-purchase-orders-and-run-the-purchase-order-year-end-process)
- [Purchase order year-end close](/dynamics365/finance/budgeting/purchase-order-year-end-process)
