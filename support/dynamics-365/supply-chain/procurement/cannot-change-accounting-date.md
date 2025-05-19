---
title: Issue with Changing Accounting Date Due to Reversing Distributions and Closed Fiscal Period
description: Provides a resolution for the issue that you can't change the accounting date on a purchase order.
ms.reviewer: shubhamshr
ms.date: 05/19/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orderss
---
# Cannot Change Accounting Date or Perform Budget Check Due to Unjournalized Reversing Distributions and Closed Fiscal Period

## Symptoms

When attempting to change the accounting date on a purchase order, getting the error of Cannot Change Accounting Date or Perform Budget Check Due to Unjournalized Reversing Distributions and Closed Fiscal Period.
Additionally, the budget check cannot be performed because the fiscal period associated with the accounting date is not within an open fiscal calendar period.

## Cause
The accounting date on the purchase order falls within a closed fiscal period. As a result, the accounting distribution cannot be reset.

## Workaround
Follow the steps below to cancel the purchase order and create a new one if necessary:
Cancel the purchase order.
Navigate to General ledger > Calendars > Ledger calendars and open the relevant fiscal period (e.g., 2023 Period 9).
Confirm the purchase order.
Set the status of the fiscal period (opened in Step 2) back to On hold once the confirmation is complete.

Changing the ledger calendar period is a viable workaround for resolving the issue when the accounting date falls in a closed fiscal period. For further guidance on modifying ledger calendar assignments, refer to the official documentation:
https://learn.microsoft.com/en-us/dynamics365/finance/general-ledger/change-mdfy-clndr-to-ledger
