---
title: Store selected items as comma-delimited string
description: Explains how to retrieve selected items from a multiple selection list box and then store the selected items as a comma-delimited string in Microsoft Access.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- CI 111294
- CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: mattbum
appliesto:
- Access 2007
- Access 2003
- Access 2002
- Access 2000
---

# How to retrieve the selected items in a multiple selection List Box as a comma-delimited string in Microsoft Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file.

Moderate: Requires basic macro, coding, and interoperability skills. 

## Summary

This article describes how to retrieve selected items from a multiple selection list box and then store the selected items as a comma-delimited string in Microsoft Access.

## More Information

In Microsoft Access, the value of the MultiSelect property of the list box in a form or in a report determines whether the list box is a single selection list box or a multiple selection list box. In a multiple selection list box, you can select multiple list items at one time.

You can use the Value property of the list box to retrieve the selected item from the list box. However, when you use a multiple selection list box and you try to retrieve the selected items by using the Value property, the Value property returns Null. 

You can retrieve the selected items in a multiple selection list box and then store the selected items as a comma-delimited string programmatically. To do this, follow these steps:

1. Start Microsoft Access.   
2. Open the Northwind sample database.   
3. In the **Objects** section of the Database window, click **Forms**.

   **Note** In Access 2007, click **Form Design** in the **Forms** group on the **Create** tab.   
4. In the right pane, double-click **Create form in Design view**.

   **Note** In Access 2007, skip this step.   
5. Add the following controls to the form, and then set the properties of controls as specified:
    ```adoc
    List Box
    ----------------------------------------------------
    Name : NamesList
    Row Source Type : Table/Query
    Row Source : SELECT First Name FROM Employees
    Multi Select : Extended
    Width : 3.5"
    Height : 0.75"
    
    Text Box
    -----------------------
    Name : mySelections
    Width : 3.5"
    Height : 0.25"
    
    Command Button
    ----------------------------------
    Name : testmultiselect
    Caption : Display Selected Items
    Width : 1.375"
    Height : 0.3"
    
    Command Button
    ----------------------
    Name : ClrList
    Caption : Clear List
    Width : 1.375"
    Height : 0.3"
    ```
6. On the **View** menu, click **Code**.

   **Note** In Access 2007, click **View Code** in the **Tools** group on the **Design** tab.   
7. Paste the following code in the Visual Basic Editor:

```vb
Option Compare Database
Option Explicit

Private Sub Form_Current()
    Dim oItem As Variant
    Dim bFound As Boolean
    Dim sTemp As String
    Dim sValue As String
    Dim sChar As String
    Dim iCount As Integer
    Dim iListItemsCount As Integer

sTemp = Nz(Me!mySelections.Value, " ")
    iListItemsCount = 0
    bFound = False
    iCount = 0

Call clearListBox

For iCount = 1 To Len(sTemp) + 1
    sChar = Mid(sTemp, iCount, 1)
        If StrComp(sChar, ",") = 0 Or iCount = Len(sTemp) + 1 Then
            bFound = False
            Do
                If StrComp(Trim(Me!NamesList.ItemData(iListItemsCount)), Trim(sValue)) = 0 Then
                    Me!NamesList.Selected(iListItemsCount) = True
                    bFound = True
                End If
                iListItemsCount = iListItemsCount + 1
            Loop Until bFound = True Or iListItemsCount = Me!NamesList.ListCount
            sValue = ""
        Else
            sValue = sValue & sChar
        End If
    Next iCount
End Sub

Private Sub clearListBox()
    Dim iCount As Integer

For iCount = 0 To Me!NamesList.ListCount
        Me!NamesList.Selected(iCount) = False
    Next iCount
End Sub

Private Sub testmultiselect_Click()
    Dim oItem As Variant
    Dim sTemp As String
    Dim iCount As Integer

iCount = 0

If Me!NamesList.ItemsSelected.Count <> 0 Then
        For Each oItem In Me!NamesList.ItemsSelected
            If iCount = 0 Then
                sTemp = sTemp & Me!NamesList.ItemData(oItem)
                iCount = iCount + 1
            Else
                sTemp = sTemp & "," & Me!NamesList.ItemData(oItem)
                iCount = iCount + 1
            End If
        Next oItem
    Else
        MsgBox "Nothing was selected from the list", vbInformation
        Exit Sub  'Nothing was selected
    End If

Me!mySelections.Value = sTemp
End Sub

Private Sub clrList_Click()
    Call clearListBox
    Me!mySelections.Value = Null
End Sub

```
8. Close the Visual Basic Editor.   
9. Save the form as Form1.   
10. Close the form.   
11. Open the Form1 form in Form view: 

    1. In the **Objects** section of the **Database** Window, click **Forms**.

       **Note** In Access 2007, in the navigation pane, click the **Forms** group.   
    2. In the right pane, right-click **Form1**, and then click **Open**.

       **Note** In Access 2007, right-click **Form1**, and then click **Open**. 
12. Select multiple items in the list box. To do this, click an item in the list box, hold down the CTRL key, and then click more items in the list box.   
13. Click **Display Selected Items**.   

The items that are selected from the multiple selection list box are displayed as a comma-delimited string in the text box.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
