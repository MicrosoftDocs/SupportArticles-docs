---
title: Payment Amount Is 0.00 in Online Store Transactions
description: Payment amount 0.00 in Online store transactions is expected in Dynamics 365 Commerce. Learn why credit card orders show 0.00 until fulfillment captures the payment.
ms.reviewer: brstor, stalasila
ms.date: 07/13/2026
ms.custom: sap:Payments\Issues with payment transactions
ai-usage: ai-assisted
---
# Payment amount is 0.00 in Online store transactions

## Summary

This article explains why the **Payment amount** field shows **0.00** for an e-commerce credit card order on the **Online store transactions** page in Microsoft Dynamics 365 Commerce, and confirms that this is expected behavior.

## Symptoms

After you place an e-commerce order that's paid by credit card and then synchronize the order to Commerce headquarters, the **Payment amount** field shows **0.00** on the **Online store transactions** page and on the **Payments** tab of the sales order. At the same time, the **Sales** and **Payment** difference shows the full order amount, and the order status is **Authorized**.

## Cause

This behavior is by design.

An online credit card order is *authorized* at checkout and *captured* at fulfillment:

- **Authorize** – When the order is placed, the payment amount is *held* on the card. The card isn't charged yet.
- **Capture** – When the order is invoiced or shipped, the payment amount is actually *charged*.

The **Payment amount** field reflects the *captured* amount only. Until the order is fulfilled, nothing is captured yet, so the **Payment amount** is **0.00**. The system tracks the held funds separately as the authorized amount, and the order shows a status of **Authorized**. No payment is lost.

This authorize-now/capture-at-fulfillment model is the standard behavior for card-not-present payments in Dynamics 365 Commerce. Because the repro stops at order synchronization (that is, before fulfillment), a **Payment amount** of **0.00** is the expected *authorized-but-not-yet-captured* state.

## Resolution

No action is required. This behavior is expected.

The captured amount appears in the **Payment amount** field *after* the order is invoiced or shipped, which is when the payment is captured. Before that point, the **0.00** value correctly indicates that the payment is authorized but not yet captured.

To view the current payment status, select the sales order number on the **Online store transactions** page to open the sales order. On the **Payments** tab, the payment shows a status of **Authorized** (funds held) before fulfillment, and **Paid** (funds captured) after the order is invoiced or shipped.

## More information

- [Credit card setup, authorization, and capture](/dynamics365/finance/accounts-receivable/credit-card-authorizations?context=/dynamics365/context/commerce)
