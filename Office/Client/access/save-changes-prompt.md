---
title: Use BeforeUpdate to prompt you to verify save operation
description: Describes how to use a BeforeUpdate event procedure to prompt you to verify the save operation before Access automatically saves changes.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: chriswy
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# How to prompt user to save changes to record in a form in Access

_Original KB number:_ &nbsp; 197103

> [!TIP]
> Requires basic macro, coding, and interoperability skills.

## Summary

When you move to the next record on a form or close a form, Microsoft Access automatically saves any changes that you have made to the current record. This article shows you how to use a BeforeUpdate event procedure to prompt you to verify the save operation before Microsoft Access will continue.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

## More Information

> [!CAUTION]
> If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

This example uses the BeforeUpdate event procedure in the Customers form to prompt the user to confirm changes before Microsoft Access will save the record:

1. Open the sample database Northwind.mdb, and open the Customers form in Design view.
2. Set the form's `BeforeUpdate` property to the following event procedure:

   ```vb
   Private Sub Form_BeforeUpdate(Cancel As Integer)

    ' This procedure checks to see if the data on the form has
    ' changed. If the data has changed, the procedure prompts the
    ' user to continue with the save operation or to cancel it. Then
    ' the action that triggered the BeforeUpdate event is completed.

    Dim ctl As Control

    On Error GoTo Err_BeforeUpdate

    ' The Dirty property is True if the record has been changed.
    If Me.Dirty Then
      ' Prompt to confirm the save operation.
      If MsgBox("Do you want to save?", vbYesNo + vbQuestion, _
              "Save Record") = vbNo Then
         Me.Undo
      End If
    End If

   Exit_BeforeUpdate:
    Exit Sub

   Err_BeforeUpdate:
    MsgBox Err.Number & " " & Err.Description
    Resume Exit_BeforeUpdate
   End Sub
   ```

3. On the **Debug** menu, click **Compile Northwind**.
4. On the **File** menu, click **Save Northwind**.
5. On the **File** menu, click **Close And Return to Microsoft Access**.

Now, when you make a change to a record, and then you either move to a different record or close the form, you are prompted to confirm that you want to save the current record. If you click **No**, the record is reset and the operation continues as normal.
