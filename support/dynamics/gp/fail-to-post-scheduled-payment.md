---
title: Error when you post a scheduled payment in Receivables Management
description: Provides a solution to an error that occurs when you post a scheduled payment in Receivables Management in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you post a scheduled payment in Receivables Management in Microsoft Dynamics GP 9.0: "The fiscal period that contains the document date is closed"

This article provides a solution to an error that occurs when you post a scheduled payment in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933357

## Symptoms

When you post a scheduled payment in Receivables Management in Microsoft Dynamics GP 9.0, you receive the following error message:

> The fiscal period that contains the document date is closed.

## Cause

This problem occurs if the date of the scheduled payment occurs in a fiscal period that is closed.

## Resolution

To resolve this problem, follow these steps:

1. Click **Tools**, point to **Setup**, point to **Company**, and then click **Fiscal Periods**.
2. Click to clear the check box for the period in which you posted the scheduled payment.
3. Click **OK**.
4. Post the scheduled payment.
