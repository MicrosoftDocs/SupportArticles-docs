---
title: Beginning balances don't show on Balance Sheet
description: Provides a resolution for the issue that beginning balances don't display on the Advanced Financial Analysis Balance Sheet report in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 06/22/2022
---
# Beginning Balances don't appear correctly on the Balance Sheet

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856112

## Symptoms

Beginning Balances for the current year don't show on the **Advanced Financial Analysis Balance Sheet** report for the month of January.

## Resolution

You'll need to close the previous fiscal year (**Routines** > **Financial** > **Year End Closing**), using the steps that are outlined in [Year-end closing procedures for General Ledger in Microsoft Dynamics GP](year-end-closing-procedures-gl.md). If you don't close the fiscal year, your Balance Sheet Accounts won't have a beginning balance created for them. Your Profit and Loss accounts will still hold a balance, as this amount hasn't yet passed through the Retained Earnings account. Both of the above procedures will occur when you run through a successful year end close.
