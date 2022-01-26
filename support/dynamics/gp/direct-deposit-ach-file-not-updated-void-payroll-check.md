---
title: The direct-deposit ach file isn't updated when you void a payroll check in Microsoft Dynamics GP
description: Describes a problem in which the direct-deposit .ach file isn't updated when you void a payroll check in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# The direct-deposit ach file isn't updated when you void a payroll check in Microsoft Dynamics GP

This article provides methods to fix an issue where the direct-deposit `.ach` file isn't updated.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852309

## Symptoms

When you void a payroll check in Microsoft Dynamics GP, the direct-deposit `.ach` file isn't updated.

## Resolution

Use one of the following methods to resolve this problem:

- Contact the bank to determine whether the bank can remove the lines from the `.ach` file that you voided in Microsoft Dynamics GP.
- Void all the checks, perform the check run again, and then create a new `.ach` file that contains the correct information.
- Perform the check run again with the correct information in the Print Checks window by following these steps:
  1. Print checks to the screen.
  2. In the Post window, click **Create Deposits**. Don't close the Post window after you create the deposits.
  3. Click **Transactions**, point to **Payroll**, and then click **Generate ACH File** to create the file.
  4. Verify that all the information is the same as the information in the first check run. Sometimes, the Federal Insurance Contributions Act (FICA) amount is off by one cent. If the totals are correct, close the Post Payroll Checks window. Nothing is posted to the payroll or to the general ledger. If the information is different in the second pay run, we recommend that you void the checks and then process the check run again.
- Edit the `.ach` file.

> [!IMPORTANT]
> We do not recommend that you edit the .ach file. Additionally, we don't support attempts to edit the `.ach` file. If you change information in this file, the file may not meet National Automated Clearing House Association (NACHA) requirements.
