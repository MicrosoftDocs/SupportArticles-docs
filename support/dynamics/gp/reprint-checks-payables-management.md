---
title: Reprint checks in Payables Management
description: Describes how to reprint checks that have already been processed or posted in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/16/2024
---
# How to reprint checks that have already been processed or posted in Payables Management in Microsoft Dynamics GP

This article describes how to reprint checks that have already been processed or posted in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954623

## Introduction

In Payables Management in Microsoft Dynamics GP, the reprint feature can only be used if checks haven't yet been processed or posted. This article describes how to reprint checks that have already been posted without using the reprint feature. The checks are reprinted using the same check numbers.

## More information

1. Void posted checks in the history tables.

    For more information about voiding posted checks in history tables, see [How to void transactions in Payables Management in Microsoft Dynamics GP](https://support.microsoft.com/help/858373).

2. Verify that the option to allow duplicate check numbers in the Checkbook Maintenance window is marked.

    1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
    2. In the **Checkbook ID** list, select the checkbook ID.
    3. Select the **Duplicate Check Numbers** check box.
    4. Select **Save**, and then close the Checkbook Maintenance window.

3. Re-create the check batch using the same restrictions, settings, and options as the original check batch.
    1. On the **Transactions** menu, point to **Purchasing**, and then select **Select Checks**.
    2. In the Batch ID field, type a new or use an existing batch ID.
    3. Use the same restrictions as the original batch.
    4. Use the same settings and options as the original batch.
    5. To build the batch, select **Build Batch**.
4. Print the checks.
    1. In the Select Payables Checks window, select **Print Checks**.
    2. In the **Batch ID** list, select the batch ID from step 3.
    3. In the **Check Number** field, type the first check number from the original check batch.
    4. Select **Print**.

    > [!NOTE]
    > The remittance of the original check batch will not be the same as the re-created batch because transactions printed on the remittance are automatically removed from the temporary table that is used when the report is printed.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
