---
title: How to add a button to a Word document and assign its Click event at run-time
description: Describes how to add a button to a Word document and assign its Click event at run-time
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to add a button to a Word document and assign its Click event at run-time

## Summary

This article demonstrates how you can use a Microsoft Visual Basic for Applications macro to programmatically add a control to a Microsoft Word document and add a Click event handler for that control.

## More Information

The following steps illustrate how you can create a Word macro that will add a control to a document and assign the Click event of that control at run-time. The steps are for Word. However, you can apply the same concepts to programmatically manipulate controls in Microsoft Excel workbooks.

> [!NOTE]
> The ability to manipulate the Visual Basic Project of a Microsoft Office document at run-time requires a reference to the Microsoft Visual Basic for Applications Extensibility library.

### Steps to create the sample

1. Start a new document in Word.
1. Press Alt+F11 to go to the Visual Basic Editor.
1. On the **Tools** menu, click **References**.
1. Select the reference for **Microsoft Visual Basic for Applications Extensibility**.
1. Insert a new module, and then add the following code example.

    ```vbscript
    Sub Test()
    
    'Add a command button to a new document
    Dim doc As Word.Document
    Dim shp As Word.InlineShape
    Set doc = Documents.Add
    
    Set shp = doc.Content.InlineShapes.AddOLEControl(ClassType:="Forms.CommandButton.1")
    shp.OLEFormat.Object.Caption = "Click Here"
    
    'Add a procedure for the click event of the inlineshape
    '**Note: The click event resides in the This Document module
    Dim sCode As String
    sCode = "Private Sub " & shp.OLEFormat.Object.Name & "_Click()" & vbCrLf & _
            "   MsgBox ""You Clicked the CommandButton""" & vbCrLf & _
            "End Sub"
    doc.VBProject.VBComponents("ThisDocument").CodeModule.AddFromString sCode
        
    End Sub
    ```
1. Run the macro "Test".
1. Once the macro "Test" finishes running, you will see a new **CommandButton** control on a new document. When you click the **CommandButton** control, the Click event of the control fires.

### Additional notes for Word 2002 and Word 2003

By default, access to a Word VBA project is disabled. When disabled, the code above may generate the run-time error '6068', "Programmatic Access to Visual Basic Project is not trusted." 
For more information about this error and how you can correct it, click the following article number to view the article in the Microsoft Knowledge Base:

[282830](https://support.microsoft.com/help/282830) Programmatic access to Office VBA project is denied