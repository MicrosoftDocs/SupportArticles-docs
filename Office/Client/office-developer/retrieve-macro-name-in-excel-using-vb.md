---
title: Retrieve the names of macros from an Excel workbook by using Visual Basic 6.0
description: Describes how to retrieve the names of macros from an Excel workbook by using Visual Basic 6.0.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to retrieve the names of macros from an Excel workbook by using Visual Basic 6.0

## Summary

This step-by-step article describes how to use Visual Basic 6.0 to retrieve the names of macros from an Excel workbook.

### Requirements
 
The following items describe the recommended hardware, software, network infrastructure, skills and knowledge, and service packs that you need: 

- Excel 2000, Excel 2002, Office Excel 2003, or Office Excel 2007   
- Excel macros   
- Visual Basic for Applications   

### Create an Excel workbook with two macros

1. Start Excel. A new blank workbook is created.   
2. Press ALT+F11 to start the Visual Basic Editor.   
3. In Project Explorer, double-click
**ThisWorkbook** to start the code editor.   
4. Paste the following code for two simple macros in the code editor:
    ```vb
    Option Explicit
    
    Sub Macro_A()
        MsgBox "This is Macro A"
    End Sub
    
    Sub Macro_B()
        MsgBox "This is Macro B"
    End Sub
    ```

5. Close the Visual Basic Editor, and return to the spreadsheet view.   
6. In Excel 2003 and in earlier versions of Excel, save the workbook as C:\Abc.xls.

    In Excel 2007, save the workbook as a macro-enabled workbook that is named C:\Abc.xlsm.   
7. Close the workbook and quit Excel.   

### Create a Visual Basic application to list the macros in the workbook

1. In Visual Basic 6.0, create a new Standard EXE project.   
2. On the **Project** menu, click
**References**. In the **References** dialog box, select the following references:

    - Microsoft Visual Basic for Applications Extensibility 5.3   
   - For Microsoft Excel 2000:
Microsoft Excel 9.0 Object Library   
   - For Microsoft Excel 2002:
Microsoft Excel 10.0 Object Library   
   - For Microsoft Office Excel 2003:
Microsoft Excel 11.0 Object Library   
   - For Microsoft Office Excel 2007:
Microsoft Excel 12.0 Object Library   
   
3. Click **OK**.   
4. Add a button to the form. The button has the default name Command1.   
5. Add a list box to the form. The list box has the default name List1.   
6. Define a click event handler procedure for the button. Use the following code for this procedure, to display information about the macros that are defined in C:\Abc.xls: 
    ```vb
    Private Sub Command1_Click()
        ' Declare variables to access the Excel workbook.
        Dim objXLApp As Excel.Application
        Dim objXLWorkbooks As Excel.Workbooks
        Dim objXLABC As Excel.Workbook
    
    ' Declare variables to access the macros in the workbook.
        Dim objProject As VBIDE.VBProject
        Dim objComponent As VBIDE.VBComponent
        Dim objCode As VBIDE.CodeModule
    
    ' Declare other miscellaneous variables.
        Dim iLine As Integer
        Dim sProcName As String
        Dim pk As vbext_ProcKind
    
    ' Open Excel, and open the workbook.
        Set objXLApp = New Excel.Application
        Set objXLWorkbooks = objXLApp.Workbooks    
        Set objXLABC = objXLWorkbooks.Open("C:\ABC.XLS")
    
    ' Empty the list box.
        List1.Clear
    
    ' Get the project details in the workbook.
        Set objProject = objXLABC.VBProject
    
    ' Iterate through each component in the project.
        For Each objComponent In objProject.VBComponents
    
    ' Find the code module for the project.
            Set objCode = objComponent.CodeModule
    
    ' Scan through the code module, looking for procedures.
            iLine = 1
            Do While iLine < objCode.CountOfLines
                sProcName = objCode.ProcOfLine(iLine, pk)
                If sProcName <> "" Then
                    ' Found a procedure. Display its details, and then skip 
                    ' to the end of the procedure.
                    List1.AddItem objComponent.Name & vbTab & sProcName
                    iLine = iLine + objCode.ProcCountLines(sProcName, pk)
                Else
                    ' This line has no procedure, so go to the next line.
                    iLine = iLine + 1
                End If
            Loop
            Set objCode = Nothing
            Set objComponent = Nothing
        Next
    
    Set objProject = Nothing
    
    ' Clean up and exit.
        objXLABC.Close
        objXLApp.Quit
    End Sub
    
    ```

### Test the sample

1. Build and run the application.   
2. Click the command button. The list box displays the names of all of the macros and the workbook that contains them, as follows:
ThisWorkbook Macro_A
ThisWorkbook Macro_B

### Troubleshooting
 
Because of enhanced security provisions in Excel 2002, Excel 2003, and Excel 2007, you may receive the following error message from the Visual Basic program when you use Excel 2002, Excel 2003, or Excel 2007:  Programmatic access to Visual Basic Project is not trusted.
  
For more information about this problem and how to resolve it, click the following article number to view the article in the Microsoft Knowledge Base:

[282830](https://support.microsoft.com/help/282830) PRB: Programmatic access to Office XP VBA project is denied

## References

For more information, see the following Microsoft Developer Network (MSDN) Web site: 

[Microsoft Office Development With Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx) 

For more information, see the following Knowledge Base articles: 

[219905](https://support.microsoft.com/help/219905) How to dynamically add and run a VBA macro from Visual Basic