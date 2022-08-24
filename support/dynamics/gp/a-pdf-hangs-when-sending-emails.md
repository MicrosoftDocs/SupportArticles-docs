---
title: A pdf hangs when sending emails
description: Provides a solution to an issue where a pdf hangs and a .docx comes through as .docx.htm extension.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# When sending emails for RM Statements using the default BLANK FORM report option, a pdf hangs and a .docx comes through as .docx.htm extension in Fabrikam only

This article provides a solution to an issue where a pdf hangs and a .docx comes through as .docx.htm extension.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4464034

## Symptom

When trying to use the Word template functionality to send an e-mail for RM Statements with the default BLANK FORM report option, and using this extension for the customer statement:

- **.PDF** causes GP to hand and you have to task-manager out of Dynamics GP.
- **.DOCX** results in an email with a .DOCX **.HTM** extension instead of just .DOCX.

## Cause

Even though the BLANK FORM displays **on blank paper** for the form, the SQL table (RM40501) stores a 1 (long form) as the form instead of a 5 (on blank paper). **It's an issue in Fabrikam only**, as live companies don't have any default report options. (CR 92466 - won't fix at this time.)

## Resolution

To work around this issue, your options include:

1. Open the BLANK FORM option and toggle the form setting. Select a different form and save, and then select **on blank paper** again and save.
2. Or create a brand new report option with **on blank paper** as the form.

## More information

If you would like to see it fixed, log a [product suggestion](https://experience.dynamics.com/ideas/) and include your business justification. Which will help to track customer votes to help increase the priority of this issue?
