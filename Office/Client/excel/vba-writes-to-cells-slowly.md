---
title: VBA writes to cells slowly when ActiveX controls are invisible
description: Discusses that VBA code writes formulas to cells slowly when ActiveX controls are invisible in Excel 2016. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
---

# VBA code writes to cells slowly when many ActiveX controls are invisible in Excel 2016

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Consider the following scenario:
- You are working in Excel for Office 365, Excel 2016 or a later version.    
- A worksheet contains many ActiveX controls that are set to be invisible.    
- You have VBA code that writes many formulas to cells.

In this scenario, Excel writes to the cells very slowly when you run the VBA code.

**Example**

1. In an Excel 2016 worksheet, create 105 ActiveX controls as option buttons.
2. Set the **Visible** property of the option buttons to **False**.
3. Run the following VBA code:

    ```vb
    For row = 1 To 20000
    
        For col = 1 To 5
           Cells(row, col).Formula = "=Func()"
        Next
    Next
    ```

You notice that this code runs much slower than it does in earlier versions of Excel.

## Cause

This issue occurs because of a design change in Excel. Because of this change, the following behavior occurs when VBA code writes a formula to a cell: 

- Excel makes invisible ActiveX controls visible.    
- The VBA code writes a formula to a cell.     
- Excel makes the ActiveX controls invisible again.    

## Workaround

To work around this issue, use one of the following methods: 

- Review the code and architecture, and reassess whether you require as many ActiveX controls as you have.    
- Replace the ActiveX controls with Form Controls in affected workbooks.    
- Temporarily make the ActiveX controls visible when the code runs.  

## Status

Microsoft has confirmed that this is an issue in the products that are listed in the "Applies to" section.
