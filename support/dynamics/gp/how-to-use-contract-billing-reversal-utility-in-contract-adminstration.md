---
title: How to use Contract Billing Reversal utility in Contract Administration
description: Introduces how to use the Contract Billing Reversal utility in Contract Administration in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use the Contract Billing Reversal utility in Contract Administration in Microsoft Dynamics GP

This article describes the steps to use the **Contract Billing Reversal** utility in Contract Administration in Microsoft Dynamics GP. The Contract Billing Reversal window is used to reverse a contract that has been billed, so that the contract can be billed again.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952837

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, point to **Service Utilities**, and then select **Contract Billing Reversal**.

2. In the **Invoice Date** field, type the date of the invoice you want to reverse.
3. Mark the check box next to the invoice you want to reverse.
4. Select **Reverse**.
5. Select **OK** when you receive the following message:
   > This process will reverse contract billing. If you need to reverse revenue recognition, use the contract revenue recognition reversal process.

6. Print the SVC_Contract_Reversal_Audit_Trail report if you are prompted.

> [!NOTE]
> When you follow the earlier steps, the invoice will be reversed and a new invoice line will be created that will be available to bill.
