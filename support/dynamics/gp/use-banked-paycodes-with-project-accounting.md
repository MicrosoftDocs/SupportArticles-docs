---
title: Use Banked paycodes with Project Accounting
description: Introduces a method to use Banked paycodes in Canadian Payroll with Project Timesheet entry.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Can you use Banked paycodes with Project Accounting?

This article introduces a method to use "Banked" paycodes in Canadian Payroll with Project Timesheet entry.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4015423

## Summary

Is there a way to use "Banked" paycodes in Canadian Payroll with Project Timesheet entry?

Currently there isn't a way for Project Accounting to see/allow the user to use Banked Paycodes (such as Banked overtime pay or "BOT") in Canadian Payroll. However, you can use the following workaround:

1. Synchronize CDN Payroll to the US Payroll (**Tools** | **Utilities** | **Payroll-Canada** | **Import and Export** | **Fill U.S. Payroll Files** button)
2. Then go into US Payroll, and create a Paycode (with the same paycode name) within US Payroll for the Banked paycode. Assign it a pay rate, and so on, so that the project will get updated with the correct costs.  (**Tools** | **Setup** | **Payroll** | **Paycode**)
3. Assign the US Paycode to the employee. (**Cards** | **Payroll** | **Employee**). This US Paycode will now appear in the list of Paycodes that could be used in timesheets.

Overall, the banked paycode isn't really an income type paycode, but it seems that when you post that entry, and put it into a CDN Payroll batch, that CDN Payroll recognizes it for what it really should be on the Canadian Payroll side and handles it properly.

## More information

The Fill U.S. Payroll tables doesn't write "banked" paycodes to the U.S. Tables.

However, the "Relief" paycode is an "income" type paycode and not a banked paycode, so the US Payroll synchronization will touch the "Relief" code. It will overwrite the US Paycode and may not update the fields correctly. US Payroll doesn't have any functionality for banked paycodes, so it doesn't update correctly. There's no work-around for this income type paycode. You may need to explore a customization to get around it.
