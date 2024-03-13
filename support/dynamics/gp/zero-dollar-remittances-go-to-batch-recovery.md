---
title: Zero-dollar Remittances go to Batch Recovery
description: When posting a computer check batch for Electronic Funds Transfers (EFT), the valid EFT's will post, but the zero-dollar remittances will not post and go to batch recovery. Provides a resolution.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Zero-dollar Remittances go to Batch Recovery when processing EFT payments in Payables Management

This article provides a resolution for the issue that the zero-dollar remittances will not post and go to batch recovery when processing EFT payments in Payables Management for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2506000

## Symptoms

When you post a computer check batch for Electronic Fund Transfers (EFT) in Payables Management in Microsoft Dynamics GP, the valid EFTs will post. However, the zero-dollar remittances will not post and go to batch recovery.

## Cause

This behavior can occur if the following conditions are true:

- You use your own EFT check numbers in the Checkbook setup
- The value in the Next EFT Payment Number field contains the prefix REMIT
- The checkbook is marked to Not Allow Duplicate Checks

A posting issue may occur if the new REMIT number has already been used in the past. The next number for EFT is stored in the Checkbook Electronic Funds Master (CM00101) table. However, the process for assigning check numbers to zero-dollar remittances goes to the PM Keys (PM00400) tables and gets the maximum REMIT number last used. The two could overlap and cause a duplicate, which would cause these transactions to go to Batch Recovery since duplicate checks are not allowed in that checkbook.

## Resolution

If the batch is in Batch Recovery, use the steps below to resolve the issue. However, if you have already posted the batch, then skip to step 3 to prevent the zero-dollar remittances from going to Batch Recovery in future checkruns.

1. Process the batch in Batch Recovery. To do this, on the Microsoft Dynamics GP menu, point to **Tools**, point to **Routines**, and then select **Batch Recovery**. Select the batch and select **Continue**.

    > [!NOTE]
    > If the batch will not leave Batch Recovery, then follow the steps in the following article to set the batch back to Available status using SQL Server Management Studio.  
    > [A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-a-batch-is-held-in-the-posting-receiving-busy-marked-locked-or-edited-status-in-microsoft-dynamics-gp-dbdf1009-33db-9776-ac87-15215697cf84)

2. In the Payables Batch Entry window, select the batch and the select **Post**.

    > [!NOTE]
    > If the zero-dollar remittances are the only transactions in the check batch, it should post the second time because it can increment correctly off the last used REMIT number in the PM Keys table.

3. Change the Next EFT Payment number on the checkbook to start with a different prefix. To do this, follow these steps:

    1. Select **Cards**, point to **Financial**, and then select **Checkbook**.
    2. Select the **Checkbook ID**.
    3. Select the **EFT Bank** button, and then select **PayablesOptions**.
    4. In the EFT Payment Numbers section, replace the prefix `REMIT` with a different prefix such as `EFT` in the **NEXT EFT Payment Number** field.
    5. Select **OK** to close the window. Select **OK** again and select **Save**.
