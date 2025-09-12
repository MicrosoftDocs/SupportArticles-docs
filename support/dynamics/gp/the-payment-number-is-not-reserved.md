---
title: The payment number isn't reserved
description: Provides a solution to an error that occurs when you post an invoice that has an attached deposit in Sales Order Processing in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# "The payment number is not reserved in Receivables Management" Error message when you post an invoice that has an attached deposit in Sales Order Processing

This article provides a solution to an error that occurs when you post an invoice that has an attached deposit in Sales Order Processing in Microsoft Dynamics GP.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862199

## Symptoms

When you try to post a Sales Order Processing (SOP) invoice, you receive the following error message:

> The payment number is not reserved in Receivables Management.

## Cause

The payment may not be in the RM00401 (RM Keys table) or have incorrect values.

## Resolution

To resolve this problem, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
2. Select **SALES** series.
3. Insert over **SALES WORK** and select **OK** to process.
4. Print the report to the screen and verify the RM00401 table was updated.
5. Now try to **post** the SOP invoice.
6. Verify.

    > [!NOTE]
    > If the issue persists, delete the payment on the SOP invoice. Save and close the invoice. Then go back into it and re-enter the payment on it again. Now try to post it.
