---
title: Check Remittance report in Payables Management
description: This article describes the Check Remittance report in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 09/13/2024
ms.custom: sap:Financial - Payables Management
---
# Information about the Check Remittance report in Payables Management in Microsoft Dynamics GP

This article introduces how to print or reprint the Check Remittance report and how to edit the remittance information on unposted checks in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856280

## When to print the Check Remittance report

The Check Remittance report can be printed when one or more of the following conditions are true:

- When you print a check in the **Print Payables Checks** window, select the **Separate Remittance** checkbox.
- The check pays more than 12 invoices.
- In the **Select Payables Checks** window, select the **Print Previously Applied Documents** checkbox, and the previously applied documents contain more than 12 records.
- In the **Select Payables Checks** window, select one or more checkboxes under **Automatically Apply Existing Unapplied**, and the total document amount of the credit documents is more than the total document amount of the debit documents.

> [!NOTE]
> To open the **Print Payables Checks** window, use one of the following methods:
>
> - On the **Transactions** menu, point to **Purchasing**, and then select **Print Checks**.
> - On the **Transactions** menu, point to **Purchasing**, select **Build Payment Batch** and then select the **Print Check** button.

## Reprint the Check Remittance report

To reprint the Check Remittance report, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Process Remittance**.
2. Select **Remittance Form** > **Process**.

> [!NOTE]
> You can only reprint the Check Remittance report when the check has not yet been posted. After a check has been posted, the Check Remittance report can't be reprinted. The information to print the Check Remittance report is stored in the Apply To OPEN OPEN Temporary File (PM20100). The PM20100 is a temporary table that is cleared when a check is posted.

## Edit remittance information on unposted checks

To edit remittance information on unposted checks, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Build Payment Batch**.
2. In the **Vendor ID** list, select a vendor ID.
3. Select **Check Stub**.

4. In the **Payables Check Stub Documents** window, make the appropriate changes, select **OK**, and then select **Save**.

    > [!NOTE]
    > You can clear the **Print** checkbox for records that aren't directly being paid by the check. You can't clear the **Print** checkbox for documents that are directly being paid by the check.
