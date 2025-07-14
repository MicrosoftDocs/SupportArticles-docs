---
title: Command bars of Excel add-ins are not displayed or removed automatically
description: Describes issues in which command bars that are included in Excel add-ins are not displayed or removed when the add-ins are loaded or unloaded in Excel 2013.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Extensibility\AddIns
  - CSSTroubleshoot
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
ms.date: 05/26/2025
---

# Command bars of add-ins are not displayed or removed in Excel 2013 or later when you load or unload the add-ins

## Symptoms

When you use add-ins in Microsoft Excel 2013 or later, you experience the following issues.

### Issue 1

When you load an Excel add-in (xlam) or an Excel 97-2003 add-in (xla), the command bars of the add-in aren't displayed automatically. Instead, you must close all workbooks and then restart Excel to display the command bars.

### Issue 2

When you unload an Excel add-in (.xlam) or an Excel 97-2003 add-in (.xla) or close an Excel macro-enabled workbook (.xlsm) that contains command bars, the command bars of the add-in or the macro-enabled workbook aren't removed from all open workbooks.

## Cause

These issues occur because of the Single Document Interface (SDI) in Excel 2013 or later. When you use a legacy CommandBar object to create menu items, the menu items are added to the Add-Ins tab of the ribbon. In Excel 2013 or later, each workbook has its own ribbon. Therefore, when you load or unload add-ins after the ribbon of the workbook is created, the ribbon isn't updated. 

The following code sample creates menu items by using the CommandBar object:

```vb
Application.CommandBars("Worksheet Menu Bar").Controls.Add Type:=msoControlPopup
```

## Workaround

To work around issue 1, close all open workbooks, and then restart Excel. 

To work around issue 2, use one of the following methods:

- Replace command bars with a Ribbon (XML) item in the add-in or the macro-enabled workbook. For more information about the Ribbon (XML), see [Ribbon XML](https://msdn.microsoft.com/library/vstudio/aa942866.aspx).
- In the Workbook_BeforeClose event of the add-in or the macro-enabled workbook, loop through all open windows, and remove the command bars. The following is a code sample:

    ```vb
    For Each wnd In Application.Windows
            wnd.Activate
            Application.CommandBars("<ToolbarName>").Delete
    Next wnd
    ```
> [!NOTE]
> In this code, the placeholder <**ToolbarName**> represents a command bar name.
