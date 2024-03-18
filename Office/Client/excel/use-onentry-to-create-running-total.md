---
title: Use OnEntry macro to create a running total in a cell comment
description: Provides step-by-step instruction to create a running total in a cell comment in Excel by using the OnEntry macro.
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
  - Microsoft Excel
ms.date: 03/31/2022
---

# Use the OnEntry macro to create a running total in a cell comment in Excel

## Summary

In Microsoft Excel you can avoid circular references when you create a running total by storing the result in a non-calculating part of a worksheet. This article contains a sample Microsoft Visual Basic for Applications procedure that does this by storing a running total in a cell comment. 

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### To Create a Running Total in a Cell

1. Open a new workbook in Microsoft Excel.   
2. Start the Visual Basic Editor (press ALT+F11).   
3. On the **Insert** menu, click **Module**.   
4. Type the following macros into this module:

    ```vb
       ' The Auto_Open name forces this macro to run every time
       ' the workbook containing this macro is opened.
   
    Sub Auto_Open()
       '  Every time a cell's value is changed,
       '  the RunningTotal macro runs.
          Application.OnEntry = "RunningTotal"
       End Sub
     
       '----------------------------------------------------------
       ' This macro runs each time the value of a cell changes.
       ' It adds the current value of the cell to the value of the
       ' cell comment. Then it stores the new total in the cell comment.
       Sub RunningTotal()
    
    On Error GoTo errorhandler      ' Skip cells that have no comment.
    
    With Application.Caller
    
       '     Checks to see if the cell is a running total by
       '     checking to see if the first 4 characters of the cell
       '     comment are "RT= ". NOTE: there is a space after the equal
       '     sign.
             If Left(.Comment.Text, 4) = "RT= " Then
    
       '        Change the cell's value to the new value in the cell
       '        plus the old total stored in the cell comment.
                RT = .Value + Right(.Comment.Text, Len(.Comment.Text) - 4)
                .Value = RT
    
       '        Store the new total in the cell note.
                .Comment.Text Text:="RT= " & RT
            End If
          End With
    
    Exit Sub      ' Skip over the errorhandler routine.
    
    errorhandler: ' End the procedure if no comment in the cell.
          Exit Sub
    
    End Sub
    
       '--------------------------------------------------------------
       ' This macro sets up a cell to be a running total cell.
       Sub SetComment()
          With ActiveCell
       '     Set comment to indicate that a running total is present.
       '     If the ActiveCell is empty, multiplying by 1 will
       '     return a 0.
             .AddComment
             .Comment.Text Text:="RT= " & (ActiveCell * 1)
          End With
       End Sub
    ```

5. After typing the macros, click **Close and Return to Microsoft Excel** on the **File** menu.   
6. Save and close your the workbook, and then re-open it.

    The Auto_Open macro that you typed is run when you open the workbook.    
7. Select cell C3.

    This is the cell that will contain a comment with the running total.           
8. Follow these steps to run the SetComment macro: 

    1. On the Tools menu, point to Macro, and then click Macros.   
    2. In the Macro dialog box, click SetComment, and then click Run.   

### An Example of Using the Running Total

To use the running total, follow these steps: 

1. Type the number 10 in cell C3.   
2. Select cell C3 and notice the comment displays "RT= 10" (without the quotation marks).   
3. Type the number 7 in cell C3.   
4. Select cell C3 and notice the comment displays "RT= 17" (without the quotation marks).   

### To Remove the Running Total

To remove the running total, follow these steps: 

1. Select the cell that contains the running total that you want removed.   
2. Right-click the cell and click Delete Comment on the shortcut menu.   
