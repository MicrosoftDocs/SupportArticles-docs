---
title: Microsoft 365 is changing its build numbers to a five-digit format
description: Describes that the format of build numbers for Microsoft 365 is changing from four digits to five digits in June 2018.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Business 
  - Microsoft 365 Apps for business
  - Microsoft 365 Family
  - Microsoft 365 Apps for enterprise
  - Microsoft 365 Personal
  - Project Pro for Microsoft 365
  - Visio Pro for Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 is changing its build numbers to a five-digit format

## Summary

In June 2018, Microsoft 365 is changing its build numbers from a four-digit to a five-digit format. This change is shown in the following table. 

|Version| Digit mask| Example |
|-----|----|---|
|Old|4.4|build 1234.5678 |
|New|5.5|build 12345.67890 |

To locate the build number of an Office installation, start an Office application, select **File** > **Account**, and then look under **About \\\<ProgramName\>**. 

## More Information

### How does this change affect me?

If you're an information worker, this change shouldn't affect you. You'll see this change only in the Backstage build version number. This change won't affect the functionality of any application.

If you're an IT Professional or an ISV, this change shouldn't affect any of your manageability tools if those tools have no hardcoded logic that expects to find four-digit build numbers. This expectation also applies to any line-of-business (LOB) applications that may rely on logic that detects build version numbers.

> [!NOTE]
> The major version number in Office binary files remains **16.0**. Therefore, this change doesn't affect registry hive locations or file folder locations.
