---
title: Cannot enter a negative quantity or do a return for a project
description: You receive an error when you attempt to enter a negative quantity or do a return transaction on a cost transaction in Project Accounting. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# You receive an error when you try to enter a negative quantity or do a return for a project in Microsoft Dynamics GP

This article provides a resolution for the errors that may occur when you try to enter a negative quantity or do a return for a project in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2549380

## Symptom

You experience one of the following errors when you enter a negative quantity on a cost transaction or enter a return in an attempt to reduce the cost on your project.

> You are not allowed to have negative Actual Quantity.

> You are not allowed to have negative Actual Costs.

> You are not allowed to have negative Actual Accrued Revenues.

> You are not allowed to have negative Total Revenue for the Cost Category within the Budget.

> You are not allowed return accrued revenues greater than the actual posted amount.

> You are not allowed to return a quantity greater than the actual posted quantity.

> You are not allowed to return costs greater than the actual posted amount.

These errors may be seen in the following cost transaction entry windows:

- Timesheet Entry
- Employee Expense Entry
- Equipment Log Entry
- Inventory Transfer Entry
- Returns from Project Entry
- Returns Transaction Entry

## Cause

When you enter a negative cost transaction or a return transaction in Project Accounting, the system will look back to what has previously been posted against that project and cost category to determine if the transaction you are entering now will bring the posted amount below zero. It does this in three areas: Quantity, Cost, and Revenues and will only let you complete entry of the transaction if all three values will result in 0 or more on the project.

It is the PA01301 (Project Budget Master) table that is examined to make this determination. These are the fields that are reviewed for each of the areas.

- Quantity -- PAPostedQty and PAUnpostedQty
- Cost -- PAPostedTotalCostN and PAUnpostedTotalCostN
- Revenues -- PAPosted_Accr_RevN and PAUnpostAccrRevN

The system will add up the values in both fields and then compare that to what you are currently entering. For example, you posted a timesheet with a quantity of 8 hours (PAPostedQty = 8). You then entered a new timesheet for -2 hours to reverse part of the original and saved it in a batch (PAUnpostedQty = -2). You would be able to enter another transaction for -6 (8 + -2 + -6 = 0) but not for -7 since then with the three transactions you would have a -1 quantity on the project.

The same calculation applies to the Cost and Revenue fields.

> [!NOTE]
> Miscellaneous Log cost category types are the only ones that are allowed to go negative for actual posted Quantity, Cost, and Revenues.

## Resolution

To review the values considered, access the project and cost category in the Budget Detail Entry window. To access the Budget Detail Entry window on the **Cards** menu, point to **Project**, and then select **Project**. Enter your Project Number and select **Budget**. Highlight the cost category and select the expansion arrow on Cost Category ID field. Review what is displayed for Qty and Total Cost in the Actual row. To review the detail behind those summary values, select **Actual** to drill back to the associated cost transaction inquiry window.

You can also review the values in the table by running the following script.

```sql
SELECT PAUnpostedQty, PAPostedQty, PAUnpostedTotalCostN, PAPostedTotalCostN, PAUnpostAccrRevN, PAPosted_Accr_RevN, * FROM PA01301 WHERE PAPROJNUMBER = 'XXX' and PACOSTCATID = 'YYY'
```

> [!NOTE]
> XXX would be replaced by the Project Number.  
> YYY would be replaced by the Cost Category ID.

If your detail transactions do not support your summary values, run PA Reconcile on Cost Transactions for the customer on this project. To run PA Reconcile on the Microsoft Dynamics GP menu, point to **Tools**, point to **Utilities**, point to **Project**, and then select **PA Reconcile**.

If PA Reconcile does not correct the error, then verify there are no orphan, unposted transactions in the corresponding Work transaction table.

Timesheets: PA10001  
Employee Expenses: PA10501  
Equipment Logs: PA10101  
Purchase Materials: PA10901 and PA10702  
Inventory: PA10901

If stranded records are found, remove them, and then run PA Reconcile again.

## More information

If the PA01301 is not reflecting the actual posted quantity, cost or revenue when you compare to the detail and PA Reconcile is not correcting it, then there is likely something incorrect or damaged with the posted cost transaction(s). Review the cost transaction for abnormalities and consider removing history and reentering the transaction.

Posted cost transactions are stored in the following tables:

Timesheets: PA30101  
Employee Expenses: PA30501  
Equipment Logs: PA30201  
Purchase Materials: PA30901 and PA31102  
Inventory: PA30901

> [!NOTE]
> If you are working with a purchase materials transaction, verify in the PA31102 that the ORD field is set correctly. If the receipt was from a purchase order (PApurordnum field is populated), then the ORD field should be populated with something other than 0. If no PO was involved, then the ORD field should be 0. If it is incorrect, update it, and then re-run PA Reconcile on Cost Transactions.
