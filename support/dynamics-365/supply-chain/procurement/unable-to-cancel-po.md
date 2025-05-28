---
title: Can't Cancel a Budget-Enabled Purchase Order Within a Closed Period
description: Provides a workaround to cancel or request a change to a purchase order governed by budget within a closed period in Microsoft Dynamics 365 Supply Chain Management.
ms.reviewer: shubhamshr
ms.date: 05/28/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---
# Can't cancel a purchase order governed by budget within a closed period

This article explains how to resolve issues when attempting to cancel or modify a purchase order (PO) [governed by budget](/dynamics365/supply-chain/procurement/tasks/create-purchase-order-governed-by-budget#perform-budget-checking) in Microsoft Dynamics 365 Supply Chain Management, specifically when the associated accounting period is closed or on hold.

## Symptoms

When you try to cancel or change a PO, you might receive one of the following error messages:

- > Budget control is enabled. This purchase order cannot be cancelled as the accounting date period is either on-hold or closed. You can use the purchase order year-end close process to move the purchase order to the next fiscal year or open the ledger calendar associated with the accounting date.
- > A change cannot be made to this purchase order as the accounting period is on hold or closed. You can use the purchase order year-end close process to update the order to the next fiscal year.

## Cause

This behavior is by design. The ability to cancel or modify a PO depends on the budget check status and the accounting period's status.

For example, consider a fiscal year that runs from April 2023 to March 2024.
  
### Scenarios where you can cancel an open PO

- A budget check isn't performed or failed.

  If the PO hasn't undergone a budget check, or if the budget check has failed, you can cancel the PO.

- A budget check is passed, and the closed period isn't the last period of the fiscal year.

  If the PO has passed the budget check and the accounting date falls within a closed period that isn't the last period of the fiscal year, the system will use the next open or available period within the same fiscal year.

  Example: If the accounting date of the PO is in December 2023, and the December 2023 period is closed while January, February, and March 2024 are open, you can still cancel the PO without reopening the December 2023 period.

### Scenarios where you can't cancel an open PO

- A budget check is passed and the accounting date falls in the last period of the fiscal year.

  If the PO has passed the budget check and the accounting date is in the last period of the fiscal year (for example, March 2024) and that period is closed, you can't cancel the PO unless you reopen the closed period.

## Workaround

To cancel a PO in a closed period, you must reopen the closed or on-hold period. For example, if the blocking error message indicates that the March 2024 period is closed, follow these steps to reopen that period and then cancel the PO:

1. Navigate to **General ledger** > **Ledger setup** > **Ledger calendars**.
1. Find the ledger calendar for the fiscal year and accounting period of the PO.
1. Change the status of the closed or on-hold period (for example, March 2024) to **Open**.
1. Cancel the PO.
1. After cancellation, return to the ledger calendar and set the period back to its original status (for example, closed or on hold).

> [!NOTE]
> We recommend that you perform this operation outside business hours to minimize the risk of other users creating records during the reopening period.

## More information

[Fiscal calendars, fiscal years, and periods](/dynamics365/finance/budgeting/fiscal-calendars-fiscal-years-periods)
