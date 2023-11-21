---
title: Exception date overlap error during historical imports
description: Fix the exception date overlap error that occurs when Viva Glint processes a historical import.
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

When the Viva Glint app processes a historical import, you receive the following error message:

> Errors (1)  
> Must correct to continue.
>
> Chosen exception date ('yyyy-mm-dd') overlaps an existing survey cycle/pulse. Please choose a different date.

## Cause

This issue occurs because the exception date that's selected overlaps the start date of an existing or scheduled survey in your survey program.

## Resolution

To fix the issue, select a different exception date that's in the past and that doesn't overlap the start date of any existing or scheduled surveys in the survey program. 

> [!IMPORTANT]
> You can't select the same exception dates that you previously selected during any failed historical imports for the same survey. For example, if you tried to import the survey by using October 16, 2023, as the exception date, and that attempt failed, then you can't use October 16, 2023, as the exception date again.

To check the start date for all completed and scheduled surveys in the program, follow these steps:

1. In the admin dashboard, select the **Configure** symbol.
1. Select **Survey Programs**, and then select your survey program.
1. In the list of surveys, review the start date for all the surveys that are listed on the **Completed** tab. If your survey program is marked as **Approved**, you can also review the start dates for the surveys that are listed on the **Upcoming and Live** tab.
