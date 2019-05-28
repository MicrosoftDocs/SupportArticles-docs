---
title: How to call Microsoft Excel macros that take parameters
description: Explains how to use automation and the Run method to call macros procedures stored in Excel workbooks. The macro procedures that take parameters cause a slight change in the syntax.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to call Microsoft Excel macros that take parameters

## Summary

Using Automation, you can manipulate Microsoft Excel. It is possible to call macro procedures that are stored in Microsoft Excel Workbooks by using the Run method of the Microsoft Excel Application object. Microsoft Excel macro procedures that take parameters cause a slight change in the syntax. Included below is a code sample showing how to call a Microsoft Excel macro procedure from Visual Basic. 

## More Information

### Step-by-Step Example

1. Start a new Project in Visual Basic. Form1 is created by default.    
2. Place a CommandButton on Form1.    
3. In the General Declarations section of Form1, enter this code:

    ```vb
          Option Explicit
    
    Private Sub Command1_Click()
           Dim oExcelApp As Object
    
    ' Create a reference to the currently running excel application
           Set oExcelApp = GetObject(, "Excel.application")
           ' Make the Excel Application Visible.
           oExcelApp.Visible = True
           ' Run the excel procedure
           oExcelApp.run "proc", "David", 30
          End Sub
    ```

4. Start Microsoft Excel. Book1 is created by default.

5. Add a new module to the workbook.

    For Excel 5.0 and 7.0: From the Insert menu, choose Macro, and select the Module Option. This will give you a new module sheet, Module1.
    
    For Excel 97 and later: Press ALT+F11 to start the Visual Basic Editor. Click Module on the Insert menu.    
6. In Module1, type the following code:

    ```vb
    Sub Proc(sParam1 As String, iParam2 As Integer)
            MsgBox sParam1 & " is " & iParam2 & " Years Old"
          End Sub
    ```

7. Leave the workbook open in Microsoft Excel and switch to your project in Visual Basic.   
8. From Visual Basic, press F5 to run the project. Click the command button, and you should see a dialog box appear with the text "David is 30 years old" in it.   

## References

For more information about using Visual Basic to Automate Excel, see the following: 
 
[219151](https://support.microsoft.com/help/219151) How To Automate Microsoft Excel from Visual Basic