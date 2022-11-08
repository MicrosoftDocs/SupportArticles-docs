---
title: Not allowed to delete unposted documents
description: Provides a solution to an error that occurs when try to delete a document in the Payables Transaction Entry window in Microsoft Dynamics GP.
ms.reviewer: v-chrish, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "You aren't allowed to delete unposted documents" Error message when you try to delete a document in the Payables Transaction Entry window in Microsoft Dynamics GP

This article provides a solution to an error that occurs when try to delete a document in the Payables Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862156

## Symptoms

When you try to delete a document in the Payables Transaction Entry window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> You aren't allowed to delete unposted documents that have been printed.

## Cause

This problem occurs if the **Delete Unposted Printed Documents** check box isn't selected in the Payables Setup window.

## Resolution

To resolve this problem, follow these steps:

1. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Purchasing**, and then select **Payables**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, point to **Setup**, point to **Purchasing**, and then select **Payables**.
2.Select the **Delete Unposted Printed Documents** check box.
3.Select **OK**.
4.On the **Transactions** menu, point to **Purchasing**, and then select **Batches**.
5.Select the appropriate batch ID in the **Batch ID** list, and then select **Select**.
6.To delete all transactions in the batch, select **Delete**. To remove a specific invoice from the batch, select **Transactions**, use the **lookup** button to select the voucher number that you want, and then select **Delete**.
