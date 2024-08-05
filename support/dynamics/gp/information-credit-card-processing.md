---
title: Information on credit card processing
description: Provides general information on how the credit card processing functions in Payables Management for Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Information on credit card processing in Payables Management in Microsoft Dynamics GP

This article provides an overview of how credit card processing functions in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970112

## Introduction

1. Set up the credit card in the Credit Card Setup window.
    1. Select **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company** and then select **Credit Cards**.
    2. Enter a **Card Name**.
    3. Select the **Used by Company** check box.
    4. Select **Credit Card**.
    5. Assign a **Vendor ID** (that is "credit card vendor").

2. Enter credit card payments in the Transaction Entry window (on the fly) or in the Manual Payment Entry window.

    - To open the Payables Transaction Entry window, select **Transactions**, point to **Purchasing**, and then select **Transactions**. This option is applicable if the invoice to be paid hasn't yet been posted.
    - To open the Payables Manual Payment Entry window, select **Transactions**, point to **Purchasing**, and then select **Manual Payments**. This option is applicable if the invoice has already been posted. Use the Apply Payables Documents window to apply the manual payment to the invoice.
    - To open the Apply Payables Documents window, select **Transactions**, point to **Purchasing**, and then select **Apply To**.

3. The credit card payment, similar to a computer check, uses **PAY** (debit) and **CASH** (credit) distribution records. Keep in mind that an invoice uses **PURCH** (debit) and **PAY** (credit) distribution records.

    **Invoice transaction example**

    |Distribution Type|Account Number|Debit Amount|Credit Amount|
    |---|---|---|---|
    |PURCH|000-1300-01|100.00||
    |PAY|000-2100-00||100.00|

      **Credit card payment example**

    |Distribution Type|Account Number|Debit Amount|Credit Amount|
    |---|---|---|---|
    |PAY|000-2100-00|100.00||
    |CASH|xxx-xxxx-xx||100.00|

    > [!NOTE]
    > xxx-xxxx-xx is the accounts payable account of the credit card vendor.

4. The account for the **CASH** distribution record defaults from the Vendor Account Maintenance window of the credit card vendor. If there's no default account set up, the account must be manually entered in the Payables Transaction Entry Distribution window.

    1. To open the Vendor Account Maintenance window, select **Cards**, point to **Purchasing**, and then select **Vendor**. In the Vendor Maintenance window, after entering in the vendor to review, select **Distributions**.

    2. To open the Payables Transaction Entry Distribution window, select **Distributions** in the corresponding window the credit card payment is being processed, and enter the appropriate account.

5. Posting a credit card payment generates an outstanding invoice (that is, OPEN status) for the credit card vendor. This credit card invoice doesn't have distribution records.

    > [!NOTE]
    > However, the **PURCH** distribution record of the original invoice, and the **CASH** distribution record of the credit card payment transaction, nets to a payable amount to the credit card vendor. It's consistent with step 4 where the pair of PAY distribution records cancel each other.

    **Example**

    |Distribution Type|Account Number|Debit Amount|Credit Amount|
    |---|---|---|---|
    |PURCH|000-1300-01|100.00||
    |PAY|000-2100-00||100.00|
    |PAY|000-2100-00|100.00||
    |CASH|xxx-xxxx-xx||100.00|

    > [!NOTE]
    > xxx-xxxx-xx is the accounts payable account of the credit card vendor.

6. If you want to void the credit card payment (for example, a different invoice should have been paid instead), both the credit card payment and the credit card invoice should be voided.

    - To void the credit card payment, use the Void Historical Payables Transactions window. On the **Transactions** menu, point to **Purchasing**, and then select **Void Historical Transactions**.

    - To void the credit card invoice, use the Void Open Payables Transactions window. On the **Transactions** menu, point to **Purchasing**, and then select **Void Open Transactions**. If a payment applied to the invoice, you must void the payment first.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
