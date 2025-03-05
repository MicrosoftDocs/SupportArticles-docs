---
title: Purchase requisitions cannot be released
description: Purchase requisitions created before the current fiscal year cannot be released.
author: Shubham
ms.reviewer: shubhamshr
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 02/25/2025
---
# Purchase requisitions created before the current fiscal year cannot be released

## Symptoms

In Dynamics 365 Finance & Supply Chain Management (D365 F&SCM), Purchase Requisitions (PRs) that are submitted at the end of one fiscal year and approved in the new fiscal year encounter an issue when converting them into Purchase Orders (POs). The system throws the following error:

# Error Message:
"Purchase requisition line was pre-encumbered in a fiscal year that is different from the accounting date of the purchase order. Hence, purchase order cannot be created."

This issue arises because D365 does not support automatic purchase requisition rollovers across fiscal years.

### Casue

# Pre-Encumbrance Issue:
When a purchase requisition is approved, it creates a pre-encumbrance in the system to reserve budget funds.

If the requisition was submitted in the previous fiscal year, the pre-encumbrance is tied to that year’s budget.
However, when attempting to convert the PR into a PO in the new fiscal year, the system detects a mismatch because the pre-encumbrance belongs to the old fiscal year, but the purchase order is being created in the new fiscal year.

# No PR Rollover Functionality:
D365 does not support purchase requisition rollovers across fiscal years.

If a PR remains open at year-end, it cannot be carried over automatically into the new fiscal year.
This restriction ensures that budgets and financial commitments remain aligned with fiscal year policies.

## Resolution

# Cancel Open Requisitions at Year-End
Process:

Before the fiscal year-end closing, identify all open purchase requisitions.
Cancel any unapproved or pending PRs that have not yet been converted into purchase orders.
Create new purchase requisitions in the new fiscal year, ensuring they align with the correct budget year.
This avoids the issue altogether by ensuring that new requisitions are processed within the correct fiscal period.

# Convert PRs to POs Before Fiscal Year-End & Roll Over POs

Process:

Instead of leaving PRs open, convert them into purchase orders before the fiscal year closes.
If the PO needs to be received or invoiced in the new fiscal year, leverage the rollover functionality for purchase orders.
This ensures that financial commitments are properly managed across fiscal years.

The best practice is to either cancel open PRs at year-end or convert them into POs before the fiscal year closes. This ensures smooth procurement processing without encountering fiscal year mismatches. Since D365 does not support PR rollovers, organizations should proactively manage requisitions as part of their year-end closing procedures.
