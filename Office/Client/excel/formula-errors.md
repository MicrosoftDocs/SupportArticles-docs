---
title: Formula errors when list separator is not set correctly
description: Describes formula errors when list separator is not set correctly.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Excel 2016
- Excel 2013
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
---

# Formula errors in Excel when list separator is not set correctly

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When entering a formula an error will occur if trying to use a symbol that is not the default 'list separator' in the Windows Regional settings.
```adoc
"We found a problem with this formula. Try clicking Insert Function on the Formulas tab to fix it, or click Help for more info on common formula problems."
```

## Cause

If the error occurs when you use a character to separate the arguments you expect to work and Excel will not accept it, then this is typically caused by either or both of the following scenarios:

- The list separator in Windows - Regional Settings does not match what is being typed for the Excel formula.
- The 'Use system separators' option is set in Excel Advanced Options and does not match what is being typed for the Excel formula.

## Resolution

To work around the error message follow the following steps:

1. Determine if 'Use system separators' is selected in Excel options. From the File menu, select Options. Select Advanced. In the 'Editing options' group determine if 'Use system separators' is unselected. If it is unselected, you can select it to have Excel use the Windows Regional settings or specify the 'Thousands separator' you want to use.

    If the 'Use system separators' is enabled, then look in the Region (Regional) Settings in the Windows Control Panel. The list separator is specified in the Additional settings.

2. Use the same character as the designated list separator in Windows settings when creating the formula(s).

3. Use the Reset button to reset the options to match the default for the selected country or modify the Windows List Separator to a different character (some special characters cannot be used).

> [!NOTE]
> By default, Microsoft Excel uses the system separators that are defined in the regional settings in Control Panel. If you sometimes need to display numbers with different separators for thousands or decimals, you can temporarily replace the system separators with custom separators. To do that please follow the steps in the following [article](https://support.office.com/article/c093b545-71cb-4903-b205-aebb9837bd1e).
>
> The comma is the default list separator for US - English Locale.

Changing the List separator in the Windows Region settings will affect the delimiter used when opening or saving a Comma-separated value (.csv) file as Excel utilizes the Windows list separator character for the delimiter in .csv files.
