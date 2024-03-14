---
title: Create application-level event handlers in Excel
description: Discusses how to create application-level event handlers in Excel.
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
  - Excel 2007
  - Excel 2003
  - Excel 2002
  - Excel 2000
ms.date: 03/31/2022
---

# Create application-level event handlers in Excel

## Summary

If you want a particular event handler to run whenever a certain event is triggered, you can write an event handler for the Application object. Event handlers for the Application object are global, which means that as long as Microsoft Excel is open, the event handler will run when the appropriate event occurs, regardless of which workbook is active when the event occurs.

This article describes how to create an Application-level event handler and provides an example.

## More information

To create an Application-level event handler, you must use the following basic steps:

- Declare a variable for the Application object using the WithEvents keyword. The WithEvents keyword can be used to create an object variable that responds to events triggered by an ActiveX object (such as the Application object).NOTE: WithEvents is valid only in a class module.
- Create the procedure for the specific Application event. For example, you can create a procedure for the WindowResize, WorkbookOpen, or SheetActivate event of the object you declared using WithEvents.   
- Create and run a procedure that starts the event handler.   

The following example uses these steps to set up a global event handler that displays a message box whenever you resize any workbook window (the event firing the event handler).

### Creating and Initiating the Event Handler

1. Open a new workbook.   
2. On the **Tools** menu, point to **Macro**, and then click **Visual Basic Editor**. 

    > [!NOTE]
    > In Microsoft Office Excel 2007, click **Visual Basic** in the **Code** group on the **Developer** tab.   
3. Click Class Module on the Insert menu. This will insert a module titled "\<book name> - Class1 (Code)" into your project.
4. Enter the following line of code in the Class1 (Code) module:

    ```vb
    Public WithEvents appevent As Application
    ```
    The WithEvents keyword makes the appevent variable available in the Object drop-down in the Class1 (Code) module window.       
5. In the Class1 (Code) module window, click the Object drop-down and then click appevent in the list.   
6. In the Class1 (Code) module window, click the Procedure drop-down and then click WindowResize in the list. This will add the following to the Class1 (Code) module sheet:

    ```vb
       Private Sub appevent_WindowResize(ByVal Wb As Excel.Workbook, _
           ByVal Wn As Excel.Window)

       End Sub
    ```

7. Add code to the Class1 (Code) module sheet so that it appears as follows:

    ```vb
           Public WithEvents appevent As Application
    
    Private Sub appevent_WindowResize(ByVal Wb As Excel.Workbook, _
               ByVal Wn As Excel.Window)
    
    MsgBox "you resized a window"
    
    End Sub
    ```

    Next, you have to create an instance of the class and then set the appevent object of the instance of the Class1 to Application. This happens because when you declare a variable, WithEvents, at design time, there is no object associated with it. A WithEvents variable is just like any other object variable - you have to create an object and assign a reference to the object to the WithEvents variable.

8. On the Insert menu click Module to insert a general type module sheet into your project.   
9. In this module sheet, enter the following code:

    ```vb
          Dim myobject As New Class1
    
          Sub Test()
              Set myobject.appevent = Application
          End Sub
    ```

10. Run the test macro.

    You have just set the event handler to run each time you resize a workbook window in Microsoft Excel.   
11. On the File menu, click **Close and Return to Microsoft Excel**.   
12. Resize a workbook window. A message box with "you resized a window" will be displayed.   

### How to Turn Off the Event Handler

If you close the workbook that contains the above project, the application-level event handler will be turned off. To programmatically turn off the event handler, do the following:

1. Start the Visual Basic Editor.   
2. In the macro code you entered in Step 9, change the macro to:

    ```vb
          Sub test()
              Set myobject.appevent = Nothing
          End Sub
    ```

3. Run the test macro again.   
4. On the File menu, click **Close and Return to Microsoft Excel**.   
5. Resize a workbook window. 

    The message box will not display.
