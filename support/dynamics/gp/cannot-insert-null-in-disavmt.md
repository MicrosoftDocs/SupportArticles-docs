---
title: Cannot insert null in DISAVMT when you use eConnect to integrate Payables Transactions into Microsoft Dynamics GP
description: Cannot insert null in DISAVMT when you use eConnect to integrate Payables Transactions into Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, dclauson
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Cannot insert null in DISAVMT when you use eConnect to integrate Payables Transactions into Microsoft Dynamics GP

This article provides a solution to an error that occurs when you use eConnect to integrate Payables Management Transactions into Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 976357

## Symptoms

When you use eConnect to integrate Payables Management Transactions, you may receive the error:

> Cannot insert the value NULL into column 'DISAVAMT', table 'TWO.dbo.POP10300'; column does not allow nulls. INSERT fails. The statement has been terminated.

## Cause

The message that you receive is because the drop-down list for **Discount Type** field is blank that will cause the null error to be returned.

## Resolution

To resolve the issue, you have to open the Payment Terms Setup window through the following method.

1. Select the Vendor ID that you use on the payables transaction in the Vendor Maintenance window.
2. Click the **Options** button.
3. Click the **Payment Terms** hyperlink.

    > [!NOTE]
    > The Payment Terms Setup window will open.
4. Check the **Discount Type** field to see whether the drop-down list is blank.
5. If the drop-down list is blank select either the **Percent** or **Amount** value and then press the **Save**.

This process will set the drop-down list to the specific value that you have specified instead of blank. This allows for the payables transaction to be integrated.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
