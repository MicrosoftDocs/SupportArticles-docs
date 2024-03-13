---
title: You cannot inactivate a customer record
description: Provides a solution to an error that occurs when you try to inactivate a customer in SOP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you try to inactivate a customer in SOP

This article provides a solution to an error that occurs when you try to inactivate a customer in SOP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2743701

## Symptoms

When you try to set a customer to inactive in the Customer Maintenance window, you receive the following error:

> "You cannot inactivate a customer record with unposted or posted transactions."

## Cause

This problem/behavior occurs when there are open Sales Order Processing or Receivables Management (not yet in history) transactions still in GP for the customer you're trying to inactivate.

The system will only allow you to successfully mark **Inactivate** for a Customer ID in the Customer Maintenance window if you don't have any unposted transactions and if the posted transactions are in History.

## Resolution

You need to see if there are any OPEN Receivables Management transactions or unposted Sales Order Processing transactions for the customer. To resolve this problem, follow these steps:

1. Navigate to the **Receivables Transaction Inquiry - Customer** window. To get to this window, go to the **Inquiry** menu, point to **Sales**, and then select **Transaction by Customer**.

1. Enter the customer ID and mark the **Open** checkbox only. Then select **Redisplay**.

1. If there are any RM transactions with an Origin of OPEN, then you won't be able to inactivate this customer until the transactions are moved to history.

1. To move them to history, you'll need to run the Paid Transaction Removal routine on this customer. Before running the Paid Transaction Removal routine, you'll want to make sure you're maintaining history on the customer by looking at the **Customer Maintenance Options** window. To get to this window, go to the **Cards** menu, point to **Sales**, select **Customer**, select your customer, and then select **Options**.

1. Make sure the checkboxes in the Maintain History section are marked. If they're unmarked and you run the Paid Transaction Removal routine, the transactions for this customer will be removed from the system instead of being moved to history.

1. Run Paid Transaction Removal by navigating to the Microsoft Dynamics GP menu, point to **Tools**, point to **Routines**, point to **Sales**, and then select **Paid Transaction Removal**.

1. In the Paid Transaction Removal routine window, enter the customer ID in the **From** and **To** fields, and select **Process**.

Next we'll check to see if there are any unposted SOP transactions for this customer, using these steps:

1. Navigate to the **Sales Order Processing Document Inquiry** window. To get to this window, go to the **Inquiry** menu, point to **Sales**, and then select **Sales Documents**.  

1. Change the Documents drop down to **by Customer ID** and enter the customer you're trying to inactivate in the **From** and **To** fields.

1. Mark the **Unposted** option and select **Redisplay**.

1. If there are any transactions showing, they'll need to be moved to history or removed from the system before you can inactivate the customer.

1. To move SOP transactions to history, you can use the Reconcile - Remove Sales Documents utility. To get to this window, go to the Microsoft Dynamics GP menu, point to **Tools**, point to **Utilities**, point to **Sales**, and then select **Reconcile-Remove Sales Documents**.

1. Mark the **Remove Completed Documents** option and enter the transaction in the **From** and **To** fields. Select **Process**.

> [!NOTE]
> If you don't have the **Maintain History** checkboxes marked for this customer in the **Customer Maintenance Options** window, this utility will remove the transaction from the system instead of moving it to history.

After taking care of any unposted transactions and any posted transactions that aren't in history, you should be able to inactivate the customer without error.
