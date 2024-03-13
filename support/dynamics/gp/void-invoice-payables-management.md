---
title: Void an invoice in Payables Management
description: Explains how to void an invoice, depending on the applied status of the invoice and of the apply document.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to void an invoice that is applied in Payables Management in Microsoft Dynamics GP

This article explains how to void an invoice, depending on the applied status of the invoice and of the apply document.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866374

## Introduction

There are three methods that you can use to void an invoice in Payables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains. Use one of the following methods depending on the applied status of the invoice and of the apply document.

## Method 1

Use this method when the following conditions are true:

- The apply document is fully applied to the invoice.
- The apply document and the invoice are in the history tables.

1. Void the apply document. To do it, follow these steps:
    1. On the **Transactions** menu, select **Purchasing**, and then select **Void Historical Transactions**.
    2. In the Void Historical Payables Transactions window, select the **Void** check box for the apply document that you want to void.
    3. Select **Void**.
    4. When you're prompted to print posting journals, select the destination, and then select **OK**.
    5. Close the Void Historical Payables Transactions window.
2. Void the invoice. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Open Transactions**.
    2. In the **Vendor ID** list, select the vendor whose invoice you want to void.
    3. Select the **Void** check box for the invoice that you want to void.
    4. Select **Void**.
    5. When you're prompted to print posting journals, select the destination, and then select **OK**.
    6. Close the Void Open Payables Transactions window.

## Method 2

Use this method when the following conditions are true:

- The apply document is only partially applied to the invoice.
- The invoice is in open tables.

> [!NOTE]
> If all the involved documents are still in the open tables, you can unapply the credit document in the Apply Payables Documents window instead of voiding the credit document. To open the Apply Payables Documents window, point to **Purchasing** on the **Transactions** menu, and then select **Apply Payables Documents**.

1. Create an additional invoice for the amount remaining on the apply document. To do it, follow these steps:
    1. On the **Transactions** menu, select **Purchasing**, and then select **Transaction Entry**.
    2. In the Payables Transaction Entry window, enter an invoice for the vendor with the apply document that you want to void, enter a value in the **Purchases** field for the amount remaining on the apply document, and then leave the **Batch ID** field blank.
    3. Select **Post**.
    4. Close the Payables Transaction Entry window, select the destination when you're prompted to print posting journals, and then select **OK**.
2. Apply the additional invoice to the apply document. To do it, follow these steps:
    1. On the **Transactions** menu, select **Purchasing**, and then select **Apply Payables Documents**.
    2. In the **Vendor ID** list, select the vendor who has the additional invoice that you want to apply.
    3. In the **Document No.** list, select the apply document.
    4. Select the **Apply** check box that is next to the additional invoice that you created.
    5. Select **OK**.
3. Void the Apply document. To do it, follow these steps:
    1. On the **Transactions** menu, select **Purchasing**, and then select **Void Historical Transactions**.
    2. In the Void Historical Payables Transactions window, select the **Void** check box for the apply document that you want to void.
    3. Select **Void**.
    4. When you're prompted to print posting journals, select the destination, and then select **OK**.
    5. Close the Void Historical Payables Transactions window.
4. Void the invoice. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Open Transactions**.
    2. In the **Vendor ID** list, select the vendor whose invoice you want to void.
    3. Select the **Void** check box for the invoice that you want to void.
    4. Select **Void**.
    5. When you're prompted to print posting journals, select the destination, and then select **OK**.
    6. Close the Void Open Payables Transactions window.

## Method 3

Use this method when the following conditions are true:

- The apply document is fully applied.
- The invoice is only partially applied.

1. You can void the apply document that is fully applied, even if the invoice is only partially applied. To void the Apply document, follow these steps:
    1. On the **Transactions** menu, select **Purchasing**, and then select **Void Historical Transactions**.
    2. In the Void Historical Payables Transactions window, select the **Void** check box for the apply document that you want to void.
    3. Select **Void**.
    4. When you're prompted to print posting journals, select the destination, and then select **OK**.
    5. Close the Void Historical Payables Transactions window.
2. Void the invoice. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Open Transactions**.
    2. In the **Vendor ID** list, select the vendor whose invoice you want to void.
    3. Select the **Void** check box for the invoice that you want to void.
    4. Select **Void**.
    5. When you're prompted to print posting journals, select the destination, and then select **OK**.
    6. Close the Void Open Payables Transactions window.

> [!NOTE]
> If you don't want to maintain history for these transactions, you don't have to void the documents. Instead, you can use the Remove Payables Transaction History window to remove the documents from the history tables.
