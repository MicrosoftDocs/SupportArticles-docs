---
title: Using fixed allocation accounts
description: Describes how to use fixed allocation accounts or variable allocation accounts with Analytical Accounting in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
---
# Using fixed allocation accounts or variable allocation accounts with Analytical Accounting in Microsoft Dynamics GP

This article describes how to use fixed allocation accounts and variable allocation accounts with Analytical Accounting in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 953723

## Introduction

Fixed allocation accounts and variable allocation accounts don't maintain balances because they're allocated out among distribution accounts. So Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0 won't allow fixed allocation accounts or variable allocation accounts to be directly linked to an Accounting Class. Instead, the individual distribution accounts should be linked to the Accounting Class using these steps.

## More information

1. On the **Cards** menu, point to **Financial**, point to **Analytical Accounting**, and then select **Accounting Class**.
2. In the **Class ID** list, select a class ID.
3. If the **Analysis Type** field is set to **Required** for the transaction dimensions in the class, you must select a default dimension code in the **Trx Dimension Code Default** column. If you don't want to select a default dimension code for the transaction, you must change the **Analysis Type** field to **Optional**.
4. Select **Accounts**.
5. In the **Link** column, select the check box to link the appropriate distribution accounts. If you're prompted to continue, select **Continue**.
6. Close the Account Class Link window, and then select **Save** in the Accounting Class Maintenance window.
7. Post a transaction using the fixed allocation account or the variable allocation account. You can't enter or edit any Analytical Accounting information at this point.
8. After the transaction is posted, you can add or edit any Analytical Accounting assignments in the Edit Analysis window. To open this window, on the **Transactions** menu, point to **Financials**, point to **Analytical Accounting**, and then select **Edit Analysis**. You can add or change any Analytical Accounting assignments for the distribution accounts or override any default dimension codes that were used.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
