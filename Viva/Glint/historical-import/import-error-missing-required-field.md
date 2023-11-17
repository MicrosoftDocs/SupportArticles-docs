---
title: Missing required field error during historical imports
description: Fix the missing required field error when you import historical data in Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 11/18/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI184015
localization_priority: Normal
---

# Error "missing required field" during historical imports

## Symptoms

When you import historical data from a .csv file into Viva Glint, you receive an error message that has the following format:

> Error at line 2: missing required field – [\<user\>, \<responses to survey questions\>]

Here is an example:

> Error at line 2: missing required field - [reed@contoso.com, 4, We have wonderful career progression in the organization., 4,, 3, There is cool promotion opportunities in the organization. That makes me proud. I'm really excited about the future here. 4,, 3,, 5, We have cool team work in the organization., 5, We have fantastic recognition on my team. , 2,, 4, There is energizing support., 4, We have energizing department structure. This is really important to me.,...]

## Cause

This issue occurs because the .csv file that's imported into Viva Glint isn't encoded correctly.

## Resolution

To fix the issue, follow these steps:

1. Open the .csv file in a text editor, such as Notepad++ or Sublime.
1. Resave the file in UTF-8 encoding. Don't save in UTF-8 with BOM encoding.
1. Import the file again.
