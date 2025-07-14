---
title: Build dynamic query with values from search form
description: Explains how to create a search form and how to use it to dynamically build the appropriate SQL string by using the BuildCriteria method and values from the search form.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: FELIXL
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# How to build a dynamic query with values from a search form in Access

Advanced: Requires expert coding, interoperability, and multiuser skills.

This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file.

## Summary

This article shows you how to dynamically build criteria for a query string with values from a search form in Microsoft Access.

## More information

Sometimes, you may want to create a form that serves as a search form. You want to be able to enter values on the form and dynamically build the appropriate SQL string. The following steps show you how to dynamically build a query string that uses the BuildCriteria method.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.CAUTION: If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

### Step-by-Step Example

1. Start Access.   
2. On the **Help** menu, point to **Sample Databases**, and then click **Northwind Sample Database**.   
3. Open the Customers form in Design view.   
4. Add a command button and a text box to the form, and then set the following properties:
 
```adoc
 Command Button
 ------------------------
 Name: cmdSearch
 Caption: Search
 OnClick: Event Procedure

Text Box
 --------------
 Name: txtSQL
 Width: 4.4583"
 Height: 1.25"
```
5. Set the **OnClick** property of the command button to the following event procedure:

```vb
Private Sub cmdSearch_Click()
    On Error Resume Next

Dim ctl As Control
    Dim sSQL As String
    Dim sWhereClause As String

'Initialize the Where Clause variable.
    sWhereClause = " Where "

'Start the first part of the select statement.
    sSQL = "select * from customers "

'Loop through each control on the form to get its value.
    For Each ctl In Me.Controls
        With ctl
            'The only Control you are using is the text box.
            'However, you can add as many types of controls as you want.
            Select Case .ControlType
                Case acTextBox
                    .SetFocus
                    'This is the function that actually builds
                    'the clause.
                    If sWhereClause = " Where " Then
                        sWhereClause = sWhereClause & BuildCriteria(.Name, dbtext, .Text)
                    Else
                        sWhereClause = sWhereClause & " and " & BuildCriteria(.Name, dbtext, .Text)
                    End If
            End Select
        End With
    Next ctl

'Set the forms recordsource equal to the new
    'select statement.
    Me.txtSQL = sSQL & sWhereClause
    Me.RecordSource = sSQL & sWhereClause
    Me.Requery

End Sub

```

6. Save the form, and then open it in Form view.   

   Note that when you click the **Search** command button, the **txtSQL** text box reflects the query that was created from the values on the Customers form. Also, the Customers form has been requeried so that it reflects the results of the new SQL string.

## References

For more information about the BuildCriteria method, in the Visual Basic Editor, click Microsoft Visual Basic Help on the Help menu, type buildcriteria method in the Office Assistant or the Answer Wizard, and then click Search to view the topic.
