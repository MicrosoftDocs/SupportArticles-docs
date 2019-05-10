---
title: How to handle events for Excel by using Visual Basic .NET
description: 
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to handle events for Excel by using Visual Basic .NET

## Summary

This step-by-step article describes how to handle Microsoft Office Excel 2003 and Microsoft Office Excel 2007 events from an Automation client that you develop by using Visual Basic .NET.

### Create an event handler

You can create an event handler with Microsoft Visual Basic .NET 2003 or with Visual Basic .NET 2002 in either of the following ways. How you create an event handler with Visual Basic .NET depends on how you want to associate the event handler with events: 

- Typically, you create an event handler by using the Handles keyword with the WithEvents keyword. When you declare a variable by using the WithEvents keyword, Visual Basic .NET automatically connects to the events of that object at run time. To handle a specific event for that object, add the relevant handler by using the Class list and the Method list of the Visual Studio .NET environment while you are in Code view.    
- With the AddHandler keyword, Visual Basic .NET provides a second way to handle events. The AddHandler keyword and the RemoveHandler keyword, permit you to start and to stop event handling for a specific event dynamically. 

### Create the Visual Basic .NET Automation client

The following steps demonstrate how to use either way to handle Excel events from an Automation client that is developed by using Visual Basic .NET: 

1. Start Visual Studio .NET 2002 or Visual Studio .NET 2003. On the **File** menu, click **New**, and then click **Project**. Under **Visual Basic Projects**, select 
**Windows Application**.

    By default, Form1 is created.   
2. Add a reference to the Microsoft Excel Object Library. To do this, follow these steps:
   1. On the **Project** menu, click **Add Reference**.   
   2. On the **COM** tab, locate **Microsoft Excel 11.0 Object Library**, and then click **Select**.   
   3. Click **OK** in the **Add References** dialog box to accept your selections. If you receive a prompt to generate wrappers for the libraries that you selected, click **Yes**.   
   
3. On the **Project** menu, select **Add Module**. In the list of templates, select **Module**, and then click **Open**. Paste the following code in the new module:
    ```vb
       '==================================================================
       'Demonstrates Using a Delegate for Event Handling
       '==================================================================
    
    Private xlApp As Excel.Application
       Private xlBook As Excel.Workbook
       Private xlSheet1 As Excel.Worksheet
       Private xlSheet2 As Excel.Worksheet
       Private xlSheet3 As Excel.Worksheet
       Private EventDel_BeforeBookClose As Excel.AppEvents_WorkbookBeforeCloseEventHandler
       Private EventDel_CellsChange As Excel.DocEvents_ChangeEventHandler
    
    Public Sub UseDelegate()
          'Start Excel and then create a new workbook.
          xlApp = CreateObject("Excel.Application")
          xlBook = xlApp.Workbooks.Add()
          xlBook.Windows(1).Caption = "Uses WithEvents"
    
    'Get references to the three worksheets.
          xlSheet1 = xlBook.Worksheets.Item(1)
          xlSheet2 = xlBook.Worksheets.Item(2)
          xlSheet3 = xlBook.Worksheets.Item(3)
          CType(xlSheet1, Excel._Worksheet).Activate()
    
    'Add an event handler for the WorkbookBeforeClose event of the
          'Application object.
          EventDel_BeforeBookClose = New Excel.AppEvents_WorkbookBeforeCloseEventHandler( _
                AddressOf BeforeBookClose)
          AddHandler xlApp.WorkbookBeforeClose, EventDel_BeforeBookClose
    
    'Add an event handler for the Change event of both Worksheet 
          'objects.
          EventDel_CellsChange = New Excel.DocEvents_ChangeEventHandler( _
                AddressOf CellsChange)
          AddHandler xlSheet1.Change, EventDel_CellsChange
          AddHandler xlSheet2.Change, EventDel_CellsChange
          AddHandler xlSheet3.Change, EventDel_CellsChange
    
    'Make Excel visible and give the user control.
          xlApp.Visible = True
          xlApp.UserControl = True
       End Sub
    
    Private Sub CellsChange(ByVal Target As Excel.Range)
          'This is called when a cell or cells on a worksheet are changed.
          Debug.WriteLine("Delegate: You Changed Cells " + Target.Address + " on " + _
                            Target.Worksheet.Name())
       End Sub
    
    Private Sub BeforeBookClose(ByVal Wb As Excel.Workbook, ByRef Cancel As Boolean)
          'This is called when you choose to close the workbook in Excel.
          'The event handlers are removed and then the workbook is closed 
          'without saving changes.
          Debug.WriteLine("Delegate: Closing the workbook and removing event handlers.")
          RemoveHandler xlSheet1.Change, EventDel_CellsChange
          RemoveHandler xlSheet2.Change, EventDel_CellsChange
          RemoveHandler xlSheet3.Change, EventDel_CellsChange
          RemoveHandler xlApp.WorkbookBeforeClose, EventDel_BeforeBookClose
          Wb.Saved = True 'Set the dirty flag to true so there is no prompt to save.
       End Sub
    ```

4. Add another module to the project, and then paste the following code in the module: 

    ```vb
       '==================================================================
       'Demonstrates Using WithEvents for Event Handling
       '==================================================================
    
    Private WithEvents xlApp As Excel.Application
       Private xlBook As Excel.Workbook
       Private WithEvents xlSheet1 As Excel.Worksheet
       Private WithEvents xlSheet2 As Excel.Worksheet
       Private WithEvents xlSheet3 As Excel.Worksheet
    
    Public Sub UseWithEvents()
          'Start Excel and then create a new workbook.
          xlApp = CreateObject("Excel.Application")
          xlBook = xlApp.Workbooks.Add()
          xlBook.Windows(1).Caption = "Uses WithEvents"
    
    'Get references to the three worksheets.
          xlSheet1 = xlBook.Worksheets.Item(1)
          xlSheet2 = xlBook.Worksheets.Item(2)
          xlSheet3 = xlBook.Worksheets.Item(3)
          CType(xlSheet1, Excel._Worksheet).Activate()
    
    'Make Excel visible and give the user control.
          xlApp.Visible = True
          xlApp.UserControl = True
       End Sub
    
    Private Sub xlApp_WorkbookBeforeClose(ByVal Wb As Excel.Workbook, _
         ByRef Cancel As Boolean) Handles xlApp.WorkbookBeforeClose
          Debug.WriteLine("WithEvents: Closing the workbook.")
          Wb.Saved = True 'Set the dirty flag to true so there is no prompt to save
       End Sub
    
    Private Sub xlSheet1_Change(ByVal Target As Excel.Range) Handles xlSheet1.Change
          Debug.WriteLine("WithEvents: You Changed Cells " + Target.Address + " on Sheet1")
       End Sub
    
    Private Sub xlSheet2_Change(ByVal Target As Excel.Range) Handles xlSheet2.Change
          Debug.WriteLine("WithEvents: You Changed Cells " + Target.Address + " on Sheet2")
       End Sub
    
    Private Sub xlSheet3_Change(ByVal Target As Excel.Range) Handles xlSheet3.Change
          Debug.WriteLine("WithEvents: You Changed Cells " + Target.Address + " on Sheet3")
       End Sub
    ```

5. Add the following to the top of both Module1.vb and Module2.vb: 

    ```vb
    Imports Microsoft.Office.Interop
    ```
    **Note** The exact name for the Office namespace may differ depending on the version of the Office Primary Interop Assembly (PIA) that is registered in the Global Assembly Cache (GAC) when the reference is added to the solution. If you receive a build error message on this statement, check the name as it appears in Solution Explorer (under References) and then change the name as appropriate.   
6. In Solution Explorer, double-click **Form1.vb** to display the form in Design view.   
7. On the **View** menu, select **Toolbox** to display the Toolbox, and then add two buttons to Form1. Change the Text property of Button1 by typing Use WithEvents. Then change the Text property of Button2 by typing Use Delegates. 

8. On the **View** menu, select **Code** to display the Code window for the form. Add the following code to the Click event handlers for the buttons: 

    ```vb
    Private Sub Button1_Click(ByVal sender As System.Object, _
          ByVal e As System.EventArgs) Handles Button1.Click
            UseWithEvents()
        End Sub
    
    Private Sub Button2_Click(ByVal sender As System.Object, _
          ByVal e As System.EventArgs) Handles Button2.Click
            UseDelegate()
        End Sub
    ```

### Test the code

1. Press CTRL+ALT+O to display the Output window.   
2. Press F5 to build and to run the program.   
3. On the form, click **Use WithEvents**. 

    The program starts Excel and then creates a workbook with three worksheets.   
4. Add any data to cells on one or more worksheets. Press the ENTER key after each change. Examine the Output window in Visual Studio .NET to verify that the event handlers are called.   
5. Quit Excel.   
6. On the form, click **Use Delegates**. 

    Again, the program starts Excel and then creates a workbook with multiple worksheets.   
7. Add any data to cells on one or more worksheets. Press the ENTER key after each change. Examine the Output window in Visual Studio .NET to verify that the event handlers are called.   
8. Quit Excel and then close the form to end the debug session.   

## Troubleshooting

When you test the code, you may receive the following error message:

**An unhandled exception of type 'System.InvalidCastException' occurred in interop.excel.dll**

**Additional information: No such interface supported**


## References

For additional information about Microsoft Office development with Visual Studio .NET, visit the following Microsoft Developer Network (MSDN) Web site:
 
[Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)

For additional information about automating Excel from Visual Basic .NET, click the following article number to view the article in the Microsoft Knowledge Base:

[302094](https://support.microsoft.com/help/302094) HOWTO: Automate Excel from Visual Basic .NET to fill or to obtain data in a range by using arrays