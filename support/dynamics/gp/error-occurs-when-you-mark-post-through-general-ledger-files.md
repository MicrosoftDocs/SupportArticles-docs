---
title: You cannot mark the option Post Through General Ledger Files error when marking Post Through General Ledger Files
description: You cannot mark the option Post Through General Ledger Files for Computer Checks as Analytical Accounting has been activated. This error occurs when you mark the Post Through General Ledger Files option. This is by design.
ms.reviewer: jaredha
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "You cannot mark the option Post Through General Ledger Files for Computer Checks as Analytical Accounting has been activated" error when marking the Post Through General Ledger Files option

This article describes a by design behavior that you can't mark the **Post Through General Ledger Files** option in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944891

## Symptoms

You receive the following error when marking the Post Through General Ledger Files for the Computer Checks origin of the Purchasing series in the Posting Setup window:

> You cannot mark the option Post Through General Ledger Files for Computer Checks as Analytical Accounting has been activated.

## Status

This issue is working as designed.

## More information

The option to Post Through General Ledger Files won't be available for Computer Checks when Analytical Accounting is installed and activated. This is to ensure that any Analytical Accounting analysis information for distribution accounts linked to accounting classes can be entered before the transactions are posted to the General Ledger. Because it isn't possible to enter analysis information while building a check batch, the batch must be stopped before posting to the General Ledger so this information can be entered and validated. There's no Analytical Accounting validation that occurs on the check batch during the check run, so the validation must be done in the General Ledger before posting. The system will, therefore, not allow computer check batches to be posted through to the General Ledger.
