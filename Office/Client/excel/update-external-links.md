---
title: Error message when you update external links
description: Provides a workaround for an issue in which you receive the error message Microsoft Excel cannot find name <Defined Name> or We can't update some of the links in your workbook right now when you update an external reference links that contain a three-dimensional reference in a defined name in an .xlsx file. This issue occurs in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
---

# Error message when you update external links that contain a three-dimensional reference

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Consider the following scenario:
- You create a workbook (workbook A) and save it as an .xlsx file in Microsoft Excel.
- You create a defined name under the **Formulas** tab that refers to a three-dimensional reference.
- You save workbook A.
- You create another workbook (workbook B) and save it as an .xlsx file.
- You add an external reference link to the defined name in workbook A.
- You save workbook B, you close both workbooks, and then you open workbook B again.
- You update external reference links when you are prompted to do this.

In this scenario, you receive one of the following error messages:

```adoc
Microsoft Excel cannot find name "Defined Name".
There are two possible reasons: The name you specified may not be defined. The name you specified is defined as something other than a rectangular cell reference. Check the name and try again.
```

```adoc
We can't update some of the links in your workbook right now. You can continue without updating their values, or edit the links you think are wrong.
```

## Workaround

To work around this issue, use either of the following methods:

- Save workbook A and workbook B as .xlsb files.
- Do not add an external reference link to a defined name that refers to a 3-D reference in workbook B.
