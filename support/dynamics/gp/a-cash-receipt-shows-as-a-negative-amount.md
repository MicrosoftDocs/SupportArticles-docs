---
title: A cash receipt shows as a negative amount
description: Provides a solution to an issue where a cash receipt showing as a negative amount in the Bank Deposit Entry window in Bank Reconciliation.
ms.reviewer: theley, cwasiwick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# Why is a cash receipt showing as a negative amount in the Bank Deposit Entry window in Bank Reconciliation?

This article provides a solution to an issue where a cash receipt showing as a negative amount in the Bank Deposit Entry window in Bank Reconciliation.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4465278

## Issue

Why is my receipt showing as a negative amount in the Bank Deposit Entry window in Bank Reconciliation?

## Cause

It's by design when you void a cash receipt that has already been deposited. The system is letting you know that you're off by this amount and must do something with it. You can't deposit and reconcile it, and also void it. You must do one or the other, so the system is letting you know that there's a problem that you must account for.

## Resolution

You must investigate if the receipt was deposited and is valid, or truly should be voided, because you can't do both. The system puts a negative cash receipt in the system to let you know there's a problem that must be researched.

- If the receipt truly was deposited by the bank, then it should not have been voided.
- If the cash receipt truly should be voided and wasn't deposited to the bank, then the deposit should be voided first (to rescue the checkbook balance). It will mark the cash receipt as undeposited in which case you can then void it (to back out the GL).
