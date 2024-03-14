---
title: Excel workbook is not activated when you run a macro
description: Provides a workaround for an issue that prevents the Workbook.Activate method from working as expected if the ScreenUpdating property is set to False in Excel 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: akeeler, prash, xlkbpre
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office 2013 Service Pack 1
  - Excel 2013
ms.date: 03/31/2022
---

# Excel workbook is not activated when you run a macro that calls the Workbook.Activate method

## Symptoms 

When you run a macro that calls the [Workbook.Activate](https://msdn.microsoft.com/library/office/ff821837.aspx) method in a Microsoft Excel 2013 workbook, the workbook is not activated if the [ScreenUpdating](https://msdn.microsoft.com/library/office/ff193498.aspx) property is set to False.

## Workaround

To work around this issue, set the ScreenUpdating property to True before you call the Activate method. You can set it back to False, as needed, after the Activate method runs, as in the following code example: 

```vb
Application.ScreenUpdating = True
Workbooks(1).Activate
Application.ScreenUpdating = False
```

> [!NOTE]
> This code may introduce a screen flash and may alter the content that's displayed for Excel while the macro runs.

## More Information

In Excel 2013, the single document interface (SDI) feature was introduced. Excel 2013 workbooks are now top-level windows in Windows. In this configuration, Windows handles the activation of windows instead of Excel managing the child windows as it does in earlier versions of the program. 

In the scenario that's described in the "Symptoms" section, Excel requests that Windows activate the workbook, but the workbook's window does not meet the Windows activation requirements.
