---
title: You have not marked any batches for posting error when you select a batch in the Batch Recovery window in Microsoft Dynamics GP
description: Describes a problem that occurs with a batch in Microsoft Dynamics GP. Provides methods that you can use to resolve this problem.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "You have not marked any batches for posting" error when you select a batch in the Batch Recovery window in Microsoft Dynamics GP

This article provides methods to resolve the **You have not marked any batches for posting**  error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865968

## Symptoms

When you select a batch in the Batch Recovery window in Microsoft Dynamics GP, you receive the following error message:
> You have not marked any batches for posting.

## Cause

This problem occurs if the batch isn't responding.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Reconcile the batch

1. Have all users exit Microsoft Dynamics GP.
2. Use the appropriate method:
    - In Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, point to
     **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities** > **Financial**, and then click **Reconcile**.
    - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Utilities** on the **Tools** menu, point to **Financial**, and then click
 **Reconcile**.

### Method 2: Set the batch status to available

For more information about how to set the batch status to available by using Microsoft SQL Server, click the following article number to view the article in the Microsoft Knowledge Base:

[850289](https://support.microsoft.com/help/850289) A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP  

### Method 3: Use an automated solution

An automated solution script may be available that you can use to release the batch in the SY00800 table.

On this automated solutions Web site, select Microsoft Dynamics GP 10.0. In the **System Manager** area, for CannotPostBatch, click ClearBatchActivity10_v1.msi to download the solution.
