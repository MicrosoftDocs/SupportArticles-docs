---
title: Office 365 is changing its build numbers to a five-digit format
description: Describes that the format of build numbers for Office 365 is changing from four digits to five digits in June, 2018.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: Office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Office 365 Enterprise
- Office 365 Business
- Office 365 Home
- Office 365 ProPlus
- Office 365 Personal
- Project Pro for Office 365
- Visio Pro for Office 365
---

# Office 365 is changing its build numbers to a five-digit format

## Summary

In June, 2018, Microsoft Office 365 is changing its build numbers from a four-digit to a five-digit format. This change is shown in the following table. 

|Version| Digit mask| Example |
|-----|----|---|
|Old|4.4|build 1234.5678 |
|New|5.5|build 12345.67890 |

To locate the build number of an Office installation, start an Office application, select **File** > **Account**, and then look under **About \<ProgramName>**. 

## More Information

### How does this affect me?

If you're an information worker, this change shouldn't affect you. You will see this change only in the Backstage build version number. This change will not affect the functionality of any application.

If you're an IT Professional or an ISV, this change shouldn’t affect any of your manageability tools if those tools have no hardcoded logic that expects to find four-digit build numbers. This expectation also applies to any line-of-business (LOB) applications that may rely on logic that detects build version numbers.

> [!NOTE]
> The major version number in Office binary files remains **16.0**. Therefore, this change doesn’t affect registry hive locations or file folder locations.
