---
title: Check Remittance report in Payables Management
description: This article describes the Check Remittance report in Payables Management in Microsoft Dynamics GP 
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/16/2024
---
# Information about the Check Remittance report in Payables Management in Microsoft Dynamics GP

This article describes the Check Remittance report in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856280

## Introduction

This article contains information about the Check Remittance report in Payables Management in Microsoft Dynamics GP.

## When to print the Check Remittance report

The Check Remittance report can be printed when one or more of the following conditions are true:

- When you print a check in the **Print Payables Checks** window, you click to select the **Separate Remittance** check box.

- The check pays more than 12 invoices.

- In the **Select Payables Checks** window, you click to select the **Print Previously Applied Documents** check box, and the previously applied documents contain more than 12 records.

- In the **Select Payables Checks** window, you click one or more check boxes under **Automatically Apply Existing Unapplied**, and the total document amount of the credit documents is more than the total document amount of the debit documents.

> [!NOTE]
> To open the **Print Payables Checks** window, use one of the following methods:

- On the **Transactions** menu, point to **Purchasing**, and then click **Print Checks**.

- Click the **Print Check** button in the following windows:

- On the **Transactions** menu, point to **Purchasing**, click **Select Checks**, and then click **Print Checks**.

- On the **Transactions** menu, point to **Purchasing**, click **Edit Checks**, and then click **Print Checks**.

- On the **Transactions** menu, point to **Purchasing**, click **Edit Check Batch**, and then click **Print Checks**.

## Reprint the Check Remittance report

To reprint the Check Remittance report, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then click **Process Remittance**.
2. Click **Remittance Form**, and then click **Process**.

> [!NOTE]
> You can only reprint the Check Remittance report when the check has not yet been posted.After a check has been posted, the Check Remittance report cannot be reprinted. The information to print the Check Remittance report is stored in the Apply To OPEN OPEN Temporary File (PM20100). The PM20100 is a temporary table that is cleared when a check is posted.

## Edit remittance information on unposted checks

To edit remittance information on unposted checks, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then click **Edit Check**.

2. In the **Vendor ID** list, click a vendor ID.

3. Click **Check Stub**.

4. In the **Payables Check Stub Documents** window, make the appropriate changes, click **OK**, and then click **Save**.

    > [!NOTE]
    > You can click to clear the **Print** check box for records that are not directly being paid by the check. You cannot click to clear the **Print** check box for documents that are directly being paid by the check.
