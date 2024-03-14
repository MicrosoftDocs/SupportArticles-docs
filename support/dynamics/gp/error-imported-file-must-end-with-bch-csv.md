---
title: Error when importing a Canadian Payroll import file in Dynamics GP
description: Describes an error when you import a Canadian Payroll file using the Canadian Payroll import Utility in Dynamics GP. A user may get an error message similar to - Imported file must end with _BCH.csv when File Type Selected is CSV.
ms.reviewer: theley, jakelaux, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# Error message when attempting to import a Canadian Payroll import file in Dynamics GP: "Imported file must end with _BCH.csv when File Type Selected is CSV"

This article fixes an error that occurs when you import a Canadian Payroll import file.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2622065

## Symptoms

When you try to import a Canadian Payroll import file, you receive the following error message:

> Imported file must end with _BCH.csv when File Type Selected is CSV

> [!NOTE]
> The error message may be slightly different depending on the type of file is being imported.

## Cause

This problem can occur if the file path where the import file is located contains a special character such as a period (.). The following path is an example of a path that would cause the error:

`C:\Users\firstnamelastname\documents\import_BCH.csv`

> [!NOTE]
> This is typically caused when the user login for Windows contains a period (.).

## Resolution

To solve this issue, move the import file to a file path that doesn't contain a special character. The following path is an example of a path that won't cause the error:

`C:\Users\<firstnamelastname>\documents\import_BCH.csv`

## More information

It's a known quality issue with Dynamics GP Canadian Payroll. However, it's not scheduled to be fixed at this time.
