---
title: Can't Change Accounting Date or Do a Budget Check
description: Works around an issue where you can't change the accounting date on a purchase order in Microsoft Dynamics 365 Supply Chain Management.
ms.reviewer: shubhamshr, ashuaggarwal
ms.date: 06/24/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---
# Can't change the accounting date or perform a budget check on a purchase order

This article provides workarounds for an issue where you can't change the accounting date on a purchase order (PO) due to unjournalized reversing distributions and a closed fiscal period in Dynamics 365 Supply Chain Management.

## Symptoms

When you try to change the accounting date on a PO, you receive the following error message:

> You cannot change the date because reversing distributions that have not yet been journalized still exist. Confirm the current changes before you change the accounting date.

Additionally, the budget check can't be performed because the fiscal period associated with the accounting date isn't within an open fiscal calendar period.

## Cause

This issue occurs because the accounting date on the PO falls within a closed fiscal period. As a result, the accounting distribution can't be reset.

## Workaround

To resolve this issue, use one of the following workarounds:

### Option 1: Cancel and re-create the purchase order

1. [Cancel the PO](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#canceling-purchase-orders).
2. Create a new purchase order with the correct accounting date.

### Option 2: Temporarily open the fiscal period

1. Navigate to **General ledger** > **Calendars** > **Ledger calendars**.

2. Open the relevant fiscal period (for example, 2023 Period 9).

3. Make the necessary changes to the purchase order, such as changing the accounting date or performing a budget check.

4. [Confirm the PO](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#confirming-purchase-orders).

5. Set the status of the fiscal period back to **On hold** once the changes are complete.

> [!NOTE]
> Changing the ledger calendar period is a viable workaround when the accounting date falls in a closed fiscal period. For more information on modifying ledger calendar assignments, see [Change or reassign a ledger calendar](/dynamics365/finance/general-ledger/change-mdfy-clndr-to-ledger).
