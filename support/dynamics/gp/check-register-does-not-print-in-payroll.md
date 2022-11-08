---
title: Check Register does not print in Payroll
description: The Check Register report in Payroll doesn't print, but it's marked to print. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Check Register does not print in Payroll in Microsoft Dynamics GP

This article provides a resolution for the issue that Check Register report in Payroll doesn't print in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2469779

## Symptoms

The *Check Register* report in Payroll doesn't print, but it's marked to print. The user is prompted to print the *Direct Deposit Check Register* instead and may cancel out of this report if there are no direct deposits in the checkrun.

## Cause

When Direct Deposit for Payroll is active, the *Direct Deposit Check Register* will replace the *Check Register* report. This behavior is by design.

## Resolution

Print the *Direct Deposit Check Register* report to see it's just titled *Check Register* on the printed copy and it will include a list of both check and direct deposit transactions.

To check if Direct Deposit is activated, follow these steps:

1. Select the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **Payroll** and select **Direct Deposit**.
2. Verify if Active is marked.
3. Select **OK**.

## More information

The *Direct Deposit Check Register* report will include both checks and direct deposit transactions. This report replaces the *Check Register* when direct deposit is active.

The *Direct Deposit Register* report will include only the direct deposit transactions.
