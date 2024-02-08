---
title: Right margin cut off in emails
description: Provides a solution to some formatting issues in Support around the RM Statement Word Template when they're emailed as PDF.
ms.reviewer: isolson, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Right margin cut off in emails for RM Statement Word Template as PDF in Microsoft Dynamics GP

This article provides a solution to some formatting issues in Support around the RM Statement Word Template when they're emailed as PDF.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3088424

## Symptoms

There have been seen some formatting issues in Support around the RM Statement Word Template when they're emailed as PDF. Ultimately, the body of the RM Statements gets reduced by about an inch on the right side, and part of the page gets cut off if you email your RM statements templates as PDF. The amount Due will also get cut off, and the outstanding balances. (screenshots below) It doesn't occur when sending as DOCX.

## Cause

It occurs with our standard Word Template, and Modified Word Templates that were based on the standard one at some point. This issue has been found in the following versions:

- Versions 14.00.0778 or higher of Microsoft Dynamics GP 2015 R2
- Versions 12.00.1920 or higher of Microsoft Dynamics GP 2013 R2

## Resolution

This issue (TFS #86927) is fixed in Dynamics GP 2016. For more information, see [Microsoft Dynamics GP 2016 new feature blog series schedule](https://community.dynamics.com/blogs/post/?postid=d4e7672c-b837-454e-a098-8ca0c6fb4805).

## Workaround

Use the following options as workarounds:

Option 1: Use the following steps to autofit the column and leave as pdf

1. Select all cells in the table in the body of the document in Report Writer. (that is, highlight the **body** section of the document in the Report Layout.)

2. Right-click and select **AutoFit** > **Fixed Column Width**

3. Save the changes.

4. Import in the modified template.

5. Assign the new template to your company and set as the default.

Option 2: Send the document in .docx instead

## More Information

This issue has also been documented in the [Word Template RM Statements Formatting when Emailing as PDF](https://community.dynamics.com/blogs/post/?postid=c3286958-c19b-49ff-be97-0954d4be122c) and includes screen prints.
