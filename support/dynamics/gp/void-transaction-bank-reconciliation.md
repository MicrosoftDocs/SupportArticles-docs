---
title: Void a transaction in Bank Reconciliation
description: Describes how to void a transaction in Bank Reconciliation in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Bank Reconciliation
---
# How to void a transaction in Bank Reconciliation in Microsoft Dynamics GP

This article describes how to void a transaction in Bank Reconciliation in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858473

## Introduction

When you void a transaction that was entered in Bank Reconciliation, the amounts that were posted to accounts when the transaction was posted will be reversed automatically. Also, the checkbook balance will be updated by the voided transaction amount. If history isn't kept, voided transactions will be deleted after the transaction is posted. If history is kept, voided transactions will be stored for auditing and security purposes.

Transactions that originate in other modules must be voided in the other modules to maintain accurate accounting records in Microsoft Dynamics GP. If you use Bank Reconciliation to void a transaction that was entered in another module, you receive a warning message that suggests that you void the transaction in the other module. You may continue through this message. However, the original transaction remains in the module in which the transaction was created.

## More Information

The following conditions must be true before a transaction can be voided:

- The transaction must be fully distributed.
- The transaction can't be flagged for reconciliation.
- The transaction can't be reconciled or previously voided.
- The transaction must exist in the CM Transaction file.
- The checkbook that is assigned to the transaction must exist, and the cash account must be assigned to the checkbook.

To void a transaction in the Bank Transaction Entry window, follow these steps:

1. Select **Transactions**, point to **Financial**, and then select **Bank Transactions**.
2. In the **Option** list, select **Void Transaction** to void checks, withdrawals, and adjustments.
3. Select the lookup button next to the **Checkbook ID** field, and then double-click the checkbook ID of the checkbook that is used for the transaction that you want to void.
4. Select the lookup button next to the **Number** field, and then double-click the transaction that you want to void.

    > [!NOTE]
    > If you enter a duplicate document number, the first document will be displayed. If you void a transaction that originated in another module, enter the offset accounts and the amounts to reverse in the original distributions.
5. Select **Void**. The distributions in the scrolling window are posted, the checkbook will be updated, and the distribution amounts are posted to the general ledger.
6. When you close the Bank Transaction Entry window, the Bank Transaction Posting Journal is printed. Transactions that have been voided since you opened the window are marked with an asterisk (*) on the report.
