---
title: Applying Multicurrency documents in Receivables Management
description: Applying Multicurrency documents in Receivables Management in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Applying Multicurrency documents in Receivables Management in Microsoft Dynamics GP

This article provides a resolution about applying Multicurrency documents in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4295209

## Symptoms

When you key a cash receipt (in USD) and select the **Apply** button, the invoice you need to apply to (in EUR) is not listed. (The functional currency ID is GBP.) Why isn't the invoice listed in the other originating currency ID?

## Cause

You must apply a multicurrency transaction to documents that are in the **same originating currency ID** or the **functional currency ID**.

|CASH RECEIPT IN:|INVOICE IN:|IS APPLY ALLOWED?|
|---|---|---|
|Functional - GBP|Functional - GBP|YES - on the fly|
|Functional - GBP|Originating - USD|YES*  (Two-step process)|
|Originating - USD|Functional - GBP|YES*  (Two-step process)|
|Originating - USD|Same originating - USD|YES - on the fly|
|Originating - USD|Different Originating - EUR|NO|
  
  How you access the **apply sales documents** window will also matter:

- IN PROCESS/APPLY ON THE FLY: In the **Cash Receipts entry** window, if you select the **APPLY button**, you will only be able to apply to documents in the **SAME originating currency ID** as the cash receipt is in.
- TWO STEP PROCESS: If you post the Cash receipt first (leaving it unapplied), and then navigate to **Transactions** > **Sales** > **Apply Sales Documents** window, you can apply the cash receipt to invoices that are in the **SAME originating currency ID** as the cash receipt, or invoices in the **FUNCTIONAL** currency ID.  

## Resolution

You would not be able to apply a cash receipt in originating currency ID, to an invoice that is not in the same originating currency ID or the functional currency ID.

To be able to apply them, one of the documents would need to be in the functional currency ID at least. So you could void it and rekey it in the functional currency ID.

The above applies to Microsoft Dynamics GP 2013 and later versions.  (when the company was required to have a functional currency ID set.)
