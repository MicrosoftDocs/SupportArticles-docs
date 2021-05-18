---
title: Rename Excel Sheet with Cell Contents by Using Macro
description: This article is made to help you to manage worksheet specially rename Excel sheet automatically with cell contents by using Macro in Microsoft Excel versions 2003, 2007, 2010 and 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010
- Excel 2007
- Excel 2003
---

# Step by Step: Rename Excel Sheet with Cell Contents by Using Macro

This article was written by [Raddini Rahayu](https://mvp.microsoft.com/en-US/mvp/raddini%20gusti%20rahayu-4038228), Microsoft MVP.

## Case

Here are weekly sales activity reports. In example, there are 15 people in this case. Nancy, the admin reports, she is assigned summarizing each sales data into one file where all sales are separated on each sheet. For easily arranging data, each sheet she gave the name matches the sales name on that sheet. At first, Nancy feels comfortable with this, but as more data and demands rapid processing, she was so overwhelmed. To overcome this, Nancy wants to the name sheets changed automatically according to the sales name on each sheet without manually rename it.

![users' error ](./media/use-macro-rename-sheet/error.png)

## Solutions

The best solutions to overcome the Nancy's problem is by using macro. This macro designed for each sheet in that file regardless of the number of sheets. The name of each sheet will change according to the sales name that has been determined in the same location on each sheet.

## How to Execute

### First Step

- Designing report formats and specify the cell location where the sales name will be placed. In this case, the location is at cell J2. This report format should be the same on each sheet.
- Keep the sheet names on the default name (Sheet1, Sheet2, Sheet3, etc).

    ![first step](./media/use-macro-rename-sheet/first-step.png)

### Last Step

#### Macro Coding Step

After we know the cell location where the sales name will be placed, now we can continue the next step, Macro coding.

1. On the Developer tab, select Visual Basic in Code category, or press key combination Alt+F11 on the keyboard, so Visual Basic window is displayed.

    ![visual basic window appears](./media/use-macro-rename-sheet/vb-window.png)

2. On the project task pane click Sales Report.xlsx(Workbook Name), then on Insert menu select Module and write the following script:

    ```vb
    Sub RenameSheet()
    
    Dim rs As Worksheet
    
    For Each rs In Sheets
    rs.Name = rs.Range("B5")
    Next rs
    
    End Sub
    ```

     ![write script](./media/use-macro-rename-sheet/write-script.png)

3. Press the F5key on the keyboard, if there is no debug close the Visual Basic window and return to Excel. If there is debugged, check back your script.
4. Return to Excel and see what happens, if the codes are correct, now the name of each sheet is renamed in accordance with the existing sales name on each sheet.
![successful result](./media/use-macro-rename-sheet/result.png)
That's it. Hopefully usefully.

[!INCLUDE [Community Solutions Content Disclaimer](../../../includes/community-solution-content-disclaimer.md)]
