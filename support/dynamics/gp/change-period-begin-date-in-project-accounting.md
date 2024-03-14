---
title: Error when you change the Period Begin date in Project Accounting
description: Provides a solution to an error that occurs when you change the Period Begin date in Project Accounting in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, Beckyber
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# Error when you change the Period Begin date in Project Accounting in Microsoft Dynamics GP: "This is an invalid Reporting Date. It will be adjusted."

This article provides a solution to an error that occurs when you change the Period Begin date in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2495145

## Symptoms

You receive an error when you enter 53 for the **Rep Period** and you change the **Period Begin** date on your timesheets, equipment logs, or miscellaneous logs in Project Accounting in Microsoft Dynamics GP:

> This is an invalid Reporting Date. It will be adjusted.

You are unable to enter the transaction with that date and reporting period combination.

## Cause

When you enter 53 for the **No of Reporting Periods per Year** and you have selected Weekly for **Reporting Periods** in setup, you must enter a Period Begin date that is the first day of the weekly period. If you do not, then the system will error and will revert your period and date back to the default.

## Resolution

When you use 53 for your reporting period on your transaction, the date entered for your **Period Begin** must be the first day of that period. It is also true that a **Rep Period** of 53 will never default in when you create a cost transaction. It must always be manually entered to be used and the correct beginning date chosen.

Typically weekly reporting periods only have 52 reporting periods. 53 is allowed as a way to accommodate leap years.

Here is an example of how the setup can be utilized for a 53rd weekly period.

Setup:

- **Reporting Periods**: Weekly
- **No of Reporting Periods per Year**: 53
- **First Date of Reporting Period 1**: 1/01/2012
- **User Date**: 12/25/2016

When I create my cost transaction with a User Date of 12/25/2016, 1 defaults in for the **Rep Period** and 12/25/16 and 12/31/16 are the dates. If I want this transaction to post to the 53rd reporting period, I must first change the **Rep Period** field to 53. When that occurs my dates are automatically changed but they are not correct. I must manually change the **Period Begin** date to be 12/25/16. When I do this, my **Period End** date goes to 12/31/16 and I can post my transaction.

> [!NOTE]
> If I use the VCR button to advance the period dates, my reporting period is set to 2.

## More information

> [!NOTE]
> In the example above, if I do not enter 12/25/16 as my Period Begin date and instead enter 12/26/16 for example, I will receive the warning message This is an invalid Reporting Date. It will be adjusted.

At this time, my reporting period and dates will go back to the entries that defaulted in when I started my cost transaction.
