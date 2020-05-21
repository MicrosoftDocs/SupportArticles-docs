---
title: Hide sheets and use xlVeryHidden constant in a macro
description: Describes that how to hide sheets and use xlVeryHidden constant in a macro.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel 2007
- Excel 2003
- Excel 2000
---

# Hide sheets and use the xlVeryHidden constant in a macro

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

In Microsoft Excel, you can hide sheets in a workbook so that a user cannot see them. You can hide any type of sheet in a workbook, but you must always leave at least one sheet visible.

## More information

### Hiding a Sheet Using Menu Commands

To hide a sheet, point to Sheet on the Format menu, and then click Hide. To unhide a sheet, point to Sheet on the Format menu, and then click Unhide. Select the appropriate sheet and then click OK.

> [!NOTE]
> You cannot hide module sheets because they appear in the Visual Basic Editor.

### Hiding a Sheet with a Visual Basic Macro

You can also hide or unhide a sheet using a Microsoft Visual Basic for Applications macro or procedure. When you use Visual Basic code, you can use the xlVeryHidden property to hide a sheet and keep the Unhide dialog box from listing it. When you do this, the only way to make the sheet visible again is to create another Visual Basic macro.

In a Visual Basic macro, use the Visible property to hide or unhide a sheet. You can set the Visible property to True, False, or xlVeryHidden. True and False have the same effect as using the Unhide or Hide menu commands. The xlVeryHidden argument hides the sheet and also keeps the Unhide dialog box from displaying it.

### Sample Visual Basic Code

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.The following samples show you how to use the Visible property of a Sheet object.

```vb
   Sub UnhideSheet()
       Sheets("Sheet1").Visible = True
    End Sub
```

```vb
    Sub HideSheet()
       Sheets("Sheet1").Visible = False
    End Sub
```

The following sample illustrates how to use the xlVeryHidden argument of the Visible property to hide a worksheet:

```vb
    Sub VeryHiddenSheet()
       Sheets("Sheet1").Visible = xlVeryHidden
    End Sub
```
