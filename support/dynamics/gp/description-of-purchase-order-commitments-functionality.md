---
title: Purchase Order Commitments functionality
description: Description of the Purchase Order Commitments functionality in Microsoft Dynamics GP 9.0.
ms.reviewer:
ms.date: 03/13/2024
---
# Description of the Purchase Order Commitments functionality in Microsoft Dynamics GP 9.0

This article describes the Purchase Order Commitments functionality in Microsoft Dynamics GP 9.0.

> [!NOTE]
> To use the Purchase Order Commitments functionality, you have to enable this functionality. For more information, see the "Setting up purchase order commitments" section of the Purchase Order Enhancements Help file.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921226

Commitments are amounts that are not invoiced in purchase orders. These amounts are committed to be paid in the future. The Purchase Order Commitments functionality can validate commitments against a budget. Then, the functionality can generate financial statements that include the commitment.

If you add line items to a purchase order, the Purchase Order Commitments functionality will perform a calculation to determine whether the purchase order will exceed the budget. For example, if you have an annual budget of $10,000 and a purchase order is created for $2,000, the available budget is $8,000. A new purchase order for $8,500 will exceed the budget.

The Purchase Order Commitments functionality performs this calculation against the budgeted amounts for each line item. When you enter a line item in the Purchase Order Entry window, the Purchase Order Commitments functionality checks the inventory account, the required date, and the extended cost of the line item. Then, the Purchase Order Commitments functionality uses these factors to perform the calculation against the budgeted amount in the Budget Maintenance window.

> [!NOTE]
> You can set the inventory account, the required date, and the extended cost of the line item in the Purchasing Item Detail Entry window.

If the commitment on a line item does not exceed the budget, the process for this line item continues. However, if the commitment exceeds the budget, you receive the following message:

> This item has exceeded the budget for account number *AccountNo* by *$NumberA*. The budget amount for this account is *$NumberB*. Do you want to authorize this amount?

> [!NOTE]
> The AccountNo placeholder represents an actual account number. The NumberA placeholder and the NumberB placeholder represent actual numbers.

If you authorize the amount, the purchase order can be saved. However, you cannot print the purchase order.

> [!NOTE]
> A purchase order cannot be saved if it contains any unauthorized commitments.

When you receive a shipment of goods or an invoice, the commitment on each line item will be reduced according to the invoiced amount for the line item. If the invoiced amount is more than the commitment, the commitment is reduced to zero.

Additionally, when you close or cancel a purchase order in the **Edit Purchase Order Status** window, the remaining commitment is reduced to zero.

> [!NOTE]
>
> - You can authorize commitments on only one line item at a time.
> - You can reduce, reverse, or change an existing commitment. To do this, use one of the following methods:
>
>    1. Change the cost on the line item on the purchase order.
>    2. Change the required date on the line item on the purchase order. This moves the rest of the commitment to a different fiscal period or to a different fiscal year
>    3. Delete the line item on the purchase order.
>
> - If a purchase order that contains a commitment is not invoiced at the end of the fiscal year, the remaining amount of the commitment will not carry forward to the next fiscal year.
> - When you create a new budget, you can enter receipts against a prior fiscal year.
> - When you close the fiscal year in the general ledger, the Purchase Order Commitments functionality is not affected.
> - A purchase order can have commitments for multiple fiscal years. The Purchase Order Commitments functionality checks the required date in the Purchasing Item Detail Entry window to determine the fiscal period or the fiscal year of the commitment. Therefore, each line item of the purchase order can be committed for a different fiscal period or for a different fiscal year.
