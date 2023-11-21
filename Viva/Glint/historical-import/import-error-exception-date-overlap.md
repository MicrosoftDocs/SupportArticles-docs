---
title: Exception date overlap error during historical imports
description: Fix the Duplicate entry error when you import historical data in Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 11/21/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI184018
localization_priority: Normal
---

# Exception date overlap error when processing historical imports

## Symptoms

You receive the following error message when the Viva Glint app processes a historical import:

> Errors (1)  
> Must correct to continue.
>
> Chosen exception date ('yyyy-mm-dd') overlaps an existing survey cycle/pulse. Please choose a different date.

## Cause

This issue occurs because the exception date that's selected overlaps with the start date of an existing or scheduled survey in your survey program.

## Resolution

To fix the issue, select a different exception date that's in the past and doesn't overlap with the start date of any existing or scheduled surveys in the survey program. 

> [!IMPORTANT]
> You can't select the exception dates that you selected during any failed historical imports for the same survey in the past. For example, if you tried to import the survey by using October 16, 2023 as the exception date, but it failed, then you can't use October 16, 2023 as the exception date again. Select a different date.

To check the start date for all completed and scheduled surveys in the program, follow these steps:

1. From the admin dashboard, select the **Configure** symbol.
1. Select **Survey Programs**, and then select your survey program.
1. In the list of surveys, review the start date for all the surveys listed in the **Completed** tab. If your survey program is marked as **Approved**, you can also review the start dates for the surveys listed in the **Upcoming and Live** tab.
