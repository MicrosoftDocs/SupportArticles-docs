---
title: Information about kits
description: Discusses kits and how they're used in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley, jchrist
ms.date: 03/13/2024
---
# Information about kits in Microsoft Dynamics GP

This article discusses kits and how they're used in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865156

## Introduction

Kit quantities aren't tracked in Inventory in Microsoft Dynamics GP. Quantities are tracked for the components of a kit. When you enter a kit on an order or on an invoice, each component is checked for shortages. A kit can't be a component of another kit.

Kits can be sold only in Sales Order Processing. Kits can't be sold in Invoicing. A kit can't be purchased through Purchase Order Processing or by entering an increase adjustment for the kit. The components must be purchased because the components are tracked in Inventory. The kits aren't tracked in Inventory.

You can't partially transfer kits. For example, for a kit item on an order, the Quantity to Order is 5. You can't transfer 2 to an invoice and 3 to a backorder. You must either invoice or backorder all 5. It's true for all other transfers on backorders, on invoices, and on returns.

The distribution accounts will come from both the kit and from the kit component, depending on the account type. Posting accounts that are used for kits are as follows:

- The Accounts Receivable account type uses the Customer Account Maintenance posting account.
- The Sales account type uses the Customer Account Maintenance posting account or the Item Account Maintenance for Kit Item posting account.
- The Commission Expense account type uses the Posting Account Setup for Sales Series posting account.
- The Commission Payable account type uses the Posting Account Setup for Sales Series posting account.
- The Inventory account type uses the Item Account Maintenance for Component Item posting account.
- The Cost of Good Sold account type uses the Customer Account Maintenance posting account, the Item Account Maintenance for Kit Item posting account, or the Component Item posting account.

> [!NOTE]
>
> - If the **Posting Account From** field in Sales Order Processing Setup is set to **Customer**, the Sales account and the Cost of Goods Sold account will come from the Customer Account Maintenance window.
> - If the **Posting Account From** field in Sales Order Processing Setup is set to **Item**, the Sales account will come from the Item Account Maintenance window for the kit item.
> - If the **Posting Account** field in Sales Order Processing is set to **Item**, the Cost of Goods Sold account will come from the Item Account Maintenance window for either the kit item or the component item, depending on the settings in the Item Kit Maintenance window. If the **Cost of Goods Sold** field is set to **From Component Item**, the Cost of Goods Sold account will come from the Item Account Maintenance window for the component item. If the **Cost of Goods Sold** field is set to **From Kit Item**, the Cost of Goods Sold account will come from the Item Account Maintenance window for the kit item.
> - Service, Flat Fee, and Miscellaneous item types won't post to a Cost of Goods Sold account.

## More information

Microsoft Dynamics GP lets you create a kit without assigning components to it. However, when the kit is entered on an order or on an invoice, no unit cost will default in, and no adjustment will be made to the Cost of Goods Sold account or to the Inventory account. It's true even if a current cost and a standard cost are entered for the kit in the Item Kit Maintenance window. You must have a component assigned to the kit to trigger a journal entry to the Cost of Goods Sold account and to the Inventory account. The amount for the entry will be the actual cost or the standard cost of the component, depending on the valuation method that is used for the component.

You'll be unable to return to multiple return quantity types on a kit. It's true because you can change or add components to a kit when you enter the transaction and because kits don't track quantities. In the Sales Item Detail Entry window, you can select **Kits**, select a component item, and then select the expansion button next to the **Extended Kit Quantity** field. By using this window, you can return individual components to multiple return quantity types. Remember that the only quantity field that is updated for the kit is the quantity sold. The return quantity type that you enter for the kit is a default for the components. This return quantity type can be changed for each component.
