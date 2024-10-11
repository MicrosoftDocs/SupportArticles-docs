---
title: Vacation paycode not distributing in Canadian Payroll for Dynamics GP
description: Department masks were set up to distribute, and it works for all paycodes except the Vacation type paycode. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# Vacation paycode not distributing in Canadian Payroll for Microsoft Dynamics GP

This article provides a solution to an issue where the distribution for the Vacation type paycode doesn't work correctly.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2501593

## Symptoms

General Ledger account masks in Dynamics GP are set up to change a department, and the distribution works correctly for all paycodes except the Vacation type paycode.

## Resolution

The vacation dollars are distributed when the vacation amounts are accrued. They aren't distributed when they're paid out. So, there's no functionality to track this when they're paid out, as you don't want it distributed twice.

On the accrual, only the debit is distributed. The credit books to the Vacation Payable Account that is set in the Payroll Control Accounts-Canada window and isn't distributed. By design, this field only allows one account.
