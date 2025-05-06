---
title: Missing required field error during historical imports
description: Fix the missing required field error when you import historical data in Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 11/19/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI184015
---

# "Missing required field" error during historical imports

## Symptoms

When you import historical data from a .csv file into Viva Glint, you receive an error message that has the following format:

> Error at line 2: missing required field – [\<user\>, \<responses to survey questions\>]

Here is an example:

> Error at line 2: missing required field - [reed@contoso.com, 4, We have wonderful career progression in the organization., 4,, 3, There are cool promotion opportunities in the organization. That makes me proud. I'm really excited about the future here. 4,, 3,, 5, We have cool team work in the organization., 5, We have fantastic recognition on my team. , 2,, 4, There is energizing support., 4, We have energizing department structure. This is really important to me.,...]

## Cause

This issue occurs because the .csv file that's imported into Viva Glint is missing one of the required fields for your Raw Score File. 

## Resolution

To fix the issue, follow these steps:

1. If the data file has a .csv extension, use the [Text Import Wizard](https://support.microsoft.com/office/text-import-wizard-c5b02af6-fda1-4440-899f-f78bafe41857) to import the data into Excel by preserving the data in the original format.
2. Review required columns for historical import [Raw Score Files](/viva/glint/setup/import-historical-response-data#raw-score-file).
3. Update column headers and columns to match requirements.
4. Save the edited file as .csv with UTF-8 encoding (with or without BOM), and then upload the file again.
