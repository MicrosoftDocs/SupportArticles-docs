---
title: Error packing batch entry file -1
description: Provides a resolution for the Packing batch entry file -1 error in Canadian Payroll in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Update Masters "Error packing batch entry file -1" in Canadian Payroll

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 5003811

## Symptoms

You receive the following error message during the Update Masters process in Canadian Payroll:

> Error Packing Batch Entry File -1

## Cause

This error typically means that someone was in the Batch Entry table, tried to access the batch, or selected something when the Update Masters process was being run. The error indicates that someone tried to access the batch, but it doesn't necessarily mean that is caused damaged to the batch. You'll need to review the data to determine if damage occurred.

## Resolution

To solve this issue, you've to:

1. Restore to a backup.
2. Under **Transactions** > **Payroll Batches**, select the affected batch and select **RESET**.
3. Now you can run Update Masters again.

Another option (unsupported) would be to see [Order that Canadian Payroll is updated during Update Masters for Microsoft Dynamics GP](order-that-canadian-payroll-is-updated-during-update-masters.md) to review the list of tables that are updated during the Update Masters process. Determine in the list of tables what transactions were successfully updated and which weren't. Then you can either recreate the batch for the missing items, or regenerate payments or update the tables manually in SQL on your own (as that isn't supported). If everything appears correct, then it should be okay.
