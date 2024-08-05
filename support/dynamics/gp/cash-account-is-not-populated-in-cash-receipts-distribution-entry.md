---
title: Cash account not populated in Cash Receipts Distribution Entry
description: The cash account field is not populated in the Cash Receipts Distribution Entry window if you enter a cash receipt in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# The cash account field is not populated in Cash Receipts Distribution Entry if you enter a cash receipt

This article provides a resolution for the issue that the cash account field is not populated in the Cash Receipts Distribution Entry window if entering a cash receipt in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936588

## Symptoms

If you enter a cash receipt, the cash account field is not populated in the Cash Receipts Distribution Entry window in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

## Cause

This issue occurs because of one of the following causes.

Cause 1

The **Cash Account from** option is set to **Customer**. If this setting is true, the **Cash** field in the Posting Accounts Setup window and in the Customer Account Maintenance window does not contain an account. See Resolution 1 in the Resolution section.

Cause 2

You have Payment Document Management installed, and this functionality is enabled. To confirm whether Payment Document Management is installed and is enabled, select **Tools**, point to **Setup**, point to **Company**, and then select **Payment Document Setup**. If this functionality is installed and is enabled, the **Enable Payment Document Management for Sales** check box is selected. See Resolution 2 in the Resolution section.

## Resolution

To resolve this issue, use the appropriate resolution.

### Resolution 1

To populate the Posting Accounts Setup window, follow these steps:

1. Select **Tools**, point to **Setup**, point to **Posting**, and then select **Posting Accounts**.

2. In the **Display** list, select **Sales**.
3. Select the cash posting account, select the lookup button next to **Accounts**, and then select an account for the cash posting account.

To populate the Customer Account Maintenance window, follow these steps:

1. Select **Cards**, point to **Sales**, and then select **Customer**.

2. Select the lookup button next to **Customer ID**, and then double-click the customer from the cash receipt transaction.
3. Select **Accounts**.
4. Note the option that is selected in the **Cash Account from** area.

   If the **Cash Account from** option is set to **Checkbook**, verify that the checkbook has a valid cash account setup. To do this, select **Cards**, point to **Financials**, select **Checkbook**, and then select the checkbook ID.

   If the **Cash Account from** option is set to **Customer**, make sure that the cash account is selected.

### Resolution 2

Payment Document Management is used in several Latin America and European countries/regions. This functionality lets you enter sales and purchasing transactions by using payment methods other than the following methods:

- Cash
- Check
- Credit card

If you do not use this functionality, uninstall Payment Document Management by using the Microsoft Dynamics GP CD. If you plan to use the Payment Document Management functionality, you must enter information in the Sales Payment Document Entry window before you can enter information in the Cash Receipts Distribution window.
