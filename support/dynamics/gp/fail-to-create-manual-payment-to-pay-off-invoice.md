---
title: Issues when you create a manual payment to pay off an invoice
description: Describes that the PAY type account is not entered in the Account field of the Analytical Payables Manual Payment Entry window when you create a manual payment to pay off an invoice. Provides a workaround.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:Financial - Payables Management
---
# You experience multiple symptoms when you create a manual payment to pay off an invoice if you change the vendor default account in Payables Management in Microsoft Dynamics GP

This article provides help to resolve issues that occur when when you create a manual payment to pay off an invoice in Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 938210

## Symptoms

The following symptoms occur when you create a manual payment to pay off an invoice in Payables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0:

- The PAY type account is not entered in the **Account** field of the Analytical Payables Manual Payment Entry window.

- Analytical Accounting distributions do not populate the AAG30000 table after you post the manual payment to the General Ledger.This problem occurs if you change the vendor default account in Payables Management.

## Resolution

- Microsoft Dynamics GP 10.0

    To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP 10.0.

- Microsoft Dynamics GP 9.0

    To resolve this problem, install hotfix rollup 936946.

## Workaround

To work around this problem, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then click **Manual Payments**.
2. In the **Payables Manual Payment Entry** window, select the manual payment that you created, and then click **Apply**.
3. In the Apply Payables Documents window, select the invoice that you want to pay off, and then click **OK**.

    > [!NOTE]
    > The Analytical Accounting window opens.
4. Close the **Analytical Accounting** window.
5. In the **Payables Manual Payment Entry** window, click **Distributions** to make sure that the correct distribution accounts are updated.
6. In the **Distributions** window, click **Default**.
7. On the **Extras** menu, click **Analytical Accounting** to open the Analytical Transaction Entry window.

    > [!NOTE]
    > The accounts are now updated based on the posted invoice.
8. Post the manual payment.The General Ledger and the Analytical Accounting accounts now display the correct account information.

## Status

Microsoft has confirmed that this is a problem in the Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 9.0, and Microsoft Business Solutions - Great Plain 8.0.
