---
title: Check Printing when you choose process later in Payables Management
description: Describes an issue where you receive the Check Printing status when choosing process later in Payables Management.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Check Printing" status when choosing process later in Payables Management

This article describes an issue where you receive the "Check Printing" status when choosing process later in Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855595

## Symptoms

If you click **Process Later** in the **Post Payables Checks** window for a computer check, and then you print the check, you receive the following status message:

> Check Printing

You continue to receive this message even after you try the busy batch procedures.

For more information about the busy batch procedures, click the following article number to view the article in [A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-a-batch-is-held-in-the-posting-receiving-busy-marked-locked-or-edited-status-in-microsoft-dynamics-gp-dbdf1009-33db-9776-ac87-15215697cf84).

## More information

The Check Printing status persists for the computer check batch until you actually post the batch.

You can select the batch in the **Post Payables Checks** window. To do this, click **Transactions**, click **Purchasing**, and then click **Post Checks**.

You cannot select the batch in the **Batches** window. If you try to do this, you receive the following warning message:

> You cannot edit the batch or transactions in the batch. Use Post Payable Checks window to continue processing.
