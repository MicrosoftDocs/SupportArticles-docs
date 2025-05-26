---
title: How to loop through the references to view their properties in Microsoft Access
description: Provides the steps to loop through the References collection and get the properties of each reference by using a Visual Basic for Applications procedure in Microsoft Access.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 120588
  - CSSTroubleshoot
ms.reviewer: beckymc
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
  - Microsoft Office Access 2000
search.appverid: MET150
ms.date: 05/26/2025
---

# How to loop through the references to view their properties in Microsoft Access

## Summary

When you view the location of references with the References dialog box on the Tools menu, the trailing portion of the path name may be truncated because of the limitations of the dialog box. This article shows you how to use a Visual Basic for Applications procedure to loop through the References collection and retrieve the properties of each reference.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. It includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.

## More information

To loop through the References collection and retrieve the properties of each reference, follow these steps:

1. Create a module and type the following line in the **Declarations** section if it isn't already there:

    ```vb
    Option Explicit
    ```

1. Type the following procedure:

    ```vb
    Function ReferenceInfo()

        Dim strMessage  As String
        Dim strTitle    As String
        Dim refItem     As Reference

        On Error Resume Next

        For Each refItem In References
            If refItem.IsBroken Then
                strMessage = "Missing Reference:" & vbCrLf & refItem.FullPath
            Else
                strMessage = "Reference: " & refItem.Name & vbCrLf _
                           & "Location: " & refItem.FullPath & vbCrLf
            End If
            Debug.Print strMessage
        Next refItem

    End Function
    ```

1. To test this function, type the following line in the Immediate window, and then press ENTER:

    ```vb
    ? ReferenceInfo
    ```

    > [!NOTE]
    > Each reference is listed in the Immediate window.

## References

For more information about the References collection, in the Visual Basic Editor, click Microsoft Visual Basic Help on the Help menu, type reference object in the Office Assistant or the Answer Wizard, and then select Search.

For more information about enumerating through the References collection by using the For Each...Next statement, in the Visual Basic Editor, click **Microsoft Visual Basic Help** on the **Help** menu, type next in the Office Assistant or the Answer Wizard, and then select **Search**.
