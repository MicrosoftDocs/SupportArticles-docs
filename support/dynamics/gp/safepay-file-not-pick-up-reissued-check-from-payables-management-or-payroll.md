---
title: SafePay not picking up reissued check from Payables Management or Payroll
description: When a check is voided and reissued on the same day in Payables Management, the Safe Pay file does not pick up the reissued check.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Safe Pay file does not pick up a reissued check from Payables Management or Payroll using Microsoft Dynamics GP

This article provides a resolution for the issue that the Safepay file doesn't pick up a reissued check from Payables Management or Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2477785

## Symptoms

When a check is voided and reissued on the same day in Payables Management, the Safe Pay file doesn't pick up the reissued check.

## Cause

Transactions can only be uploaded to the bank once, so you can't reuse the same check number on the same day.

## Resolution

The reissued check needs to be dated the next day. The bank is not able to process the reissued check if it is dated the same day as the original check and void, so the reissued check must have a different date in order for the Safepay file to pick it up to send to the bank again.
