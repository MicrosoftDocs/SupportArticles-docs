---
title: Can't scroll records with mouse wheel
description: Describes that you cannot use the mouse wheel to scroll through records in an Access 2007 or Access 2010 form. This is expected behavior in Access 2003 and earlier versions. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Access 2010
  - Office Access 2007
ms.date: 03/31/2022
---

# You cannot use the mouse wheel to scroll through records in an Access 2007 or Access 2010 form

## Symptoms

In Form View in Microsoft Office Access 2007 or in Microsoft Access 2010, when you try to use the mouse wheel to move through records in a form, nothing happens. However, you can use the mouse wheel to move records up and down when you switch the form to Datasheet View.

## Cause

The mouse wheel behavior in Form View was intentionally changed in Access 2007 and in Access 2010 to reduce user confusion. In earlier versions of Access, the mouse wheel would sometimes move the scroll bar, or the mouse wheel would move records up or down. The mouse wheel behavior is now consistent and only moves the scroll bar. There is no property to change this behavior. 

## Workaround

You can continue to use your mouse wheel in Form View in Access 2007 and in Access 2010. To do this, enable your database, or move it to a trusted location. Then, follow these steps:

1. Open the form in Design View.   
2. Use the Alt+F11 key combination, or click **View Code** in the Tools group on the Ribbon, to open the Microsoft Visual Basic editor window.    
3. Paste the following code into the code window.

    ```vb
    Private Sub Form_MouseWheel(ByVal Page As Boolean, ByVal Count As Long)
    
    If Not Me.Dirty Then
    
    If (Count < 0) And (Me.CurrentRecord > 1) Then
    
    DoCmd.GoToRecord , , acPrevious 
    
    ElseIf (Count > 0) And (Me.CurrentRecord <= Me.Recordset.RecordCount) Then 
    
    DoCmd.GoToRecord , , acNext
    
    End If
    
    Else
    
    MsgBox "The record has changed. Save the current record before moving to another record."
    
    End If
    
    End Sub
    ```
4. Save and then open your form in Form View.   

This code forces the user to save a record in which changes were made before the user scrolls to another record. One of the main reasons for the change in the scroll behavior was that users would use the mouse wheel to scroll through records and automatically and unexpectedly save their changes to their record.
