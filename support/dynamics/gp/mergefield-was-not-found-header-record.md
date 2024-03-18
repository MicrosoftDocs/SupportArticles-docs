---
title: MergeField wasn't found in header record
description: Provides a solution to an error that occurs when you use the Letter Writing Assistant (LWA) to Prepare an Employee benefits.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Microsoft Dynamics GP hangs when selecting for payroll options for Benefit and deduction letters in LWA and/or get Invalid merge field error

This article provides a solution to an error that occurs when you use the Letter Writing Assistant (LWA) to Prepare an Employee benefits.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4341500

## Issue

When you use the Letter Writing Assistant (LWA) to **Prepare an Employee benefits and deduction letter** and select the **Benefit Summary** (For Payroll) or Open Enrollment Notification (For Payroll) letter template options, GP appears to hang, and/or you receive the "**Invalid Merge Field"** message box, and the letter in Microsoft Word will display the following error in these fields:

> "Error! MergeField was not found in header record of data source"

## Cause

By design. Dynamics GP appears to spin, but there's an error window open in the background that needs user action.

- The **For HR** template options should be used if you have HR installed. The system will automatically merge the fields needed for all benefits and deduction classifications on the same letter (if selected). So use the **FOR HR** types if you have HR installed.

- You can use the **For Payroll** template options, but user action is required, as the system isn't able to merge Payroll types to the HR classifications. The user will need to press **Alt-Tab** to find the **invalid merge field** window requiring the user action to map the fields in data source needed. In this window, the field having the issue is listed, and you can use the drop-down list to map the field to a corresponding field for one of the HR classification types that you want. Repeat for each field requiring action. The letter will then populate with the information for the fields you mapped. (If the user doesn't realize there's another window open in the background requiring user action, the LWA window for *Preparing letters ...* will just remain open and the user concludes that GP is locked.)

## Resolution

**If you have HR installed, the user should select one of the For HR letter templates** when trying to prepare an existing employee benefits and deductions letter in LWA: (The **For HR** options will automatically merge the fields to HR so ALL types of benefits/deductions can be listed on the same letter.)

- Benefit Summary (for HR)
- Open Enrollment Notification (for HR)

> [!NOTE]
> If you use one of the **For Payroll** options, then you must select **ALT-TAB** to find the Invalid Merge field window and map each field that it's having an issue with. (However it confines the letter to only ONE classification type on the letter at a time.)
>
> - Benefit Summary (for Payroll)
> - Open Enrollment Notification (for Payroll)
