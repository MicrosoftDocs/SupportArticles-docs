---
title: Errors have been found in this check batch 
description: Provides a solution to an error that occurs when you try to print a batch of checks in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Errors have been found in this check batch. Please correct the errors before printing" Error message when you try to print a batch of checks in Payables Management in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to print a batch of checks in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 854239

## Symptoms

When you try to print a batch of checks in Payables Management in Microsoft Dynamics GP, you may receive the following error message:

> Errors have been found in this check batch. Please correct the errors before printing.

## Cause

This problem occurs because the batch of checks includes a vendor that has the **Hold** check box selected in the Vendor Maintenance window.

## Resolution

To resolve this problem, select to clear the **Hold** check box for the vendor or release the vendor that has the **Hold** check box selected from the batch. After you do it, you can print the check batch successfully.

### Method 1

Select to clear the **Hold** check box for the vendor. To do it, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Vendor**.
2. In the **Vendor ID** field, type a vendor ID or select a vendor by using the lookup window.
3. Select to clear the **Hold** check box.
4. Select **Save**.

### Method 2

Release the vendor that has the **Hold** check box selected from the batch. To do it, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Edit Check Batch**.
2. In the **Batch ID** field, type a batch ID or select a batch by using the lookup window.
3. Select to clear the **Vendor ID** check box to remove the vendor from the batch.
4. Select **OK**.

## Workaround

To work around this problem, print an edit list of the check batch. To do it, follow these steps:

1. On the **Transactions** menu, select **Purchasing**, and then select **Batches**.
2. In the Payables Batch Entry window, enter or select a batch ID in the **Batch ID** field.
3. Select the printer icon in the upper-right corner, and then specify the report destination.
4. Verify that the report contains errors.
5. Note the errors and transactions that are included in the batch.
