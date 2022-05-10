---
title: Common Dialog API usage in an Access database
description: Discusses how to use the Common Dialog API in an Access database to replace the Common Dialog functionality.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# How to use the Common Dialog API in a database in Access 2003 or Access 2007

_Original KB number:_ &nbsp; 888695

## INTRODUCTION

This article describes how to use the Common Dialog API in Microsoft Office Access 2003 or in Microsoft Office Access 2007 to replace the Common Dialog Box functionality. The functionality is included only in the Microsoft Office 2000 Developer Edition or in the Microsoft Office XP Developer Edition.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

## Steps to replace the Common Dialog functionality

### Microsoft Office Access 2003

1. In Access, open the sample database that is named Northwind.mdb.

   > [!NOTE]
   > The Northwind.mdb database for Access 2003 is typically located in the `C:\Program Files\Microsoft Office\OFFICE11\Samples` folder.

2. Under **Objects** in the Northwind Database window, click **Forms** .
3. In the **Database window** toolbar, click **New**.
4. In the **New Form** dialog box, click **Design View**, and then click **OK**.
5. Add a text box to Form1, right-click the text box, and then click **Properties**.
6. Click the **All** tab, click **Name**, typeText1, and then close the **Properties** dialog box.
7. Right-click the label control that is associated with the **Text1** text box, click **Properties**, and then click the **All** tab.
8. Click **Caption**, type Text1, and then close the **Properties** dialog box.
9. Add a command button to **Form1**, right-click the command button, click **Properties**, click **Name**, type Command1, click **Caption**, and then type Command1.
10. Click the **Event** tab, click **[Event Procedure]** in the **On Click** list, and then click the ellipsis button to start the Microsoft Visual Basic Editor.
11. Modify the code in the Command1_Click procedure to the following:

    ```vb
    Private Sub Command1_Click()
     Me!Text1 = LaunchCD(Me)
    End Sub
    ```

12. On the **Insert** menu, click **Module**, and then insert the following code into Module1:

    ```vb
    Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias _
    "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long

    Private Type OPENFILENAME
     lStructSize As Long
     hwndOwner As Long
     hInstance As Long
     lpstrFilter As String
     lpstrCustomFilter As String
     nMaxCustFilter As Long
     nFilterIndex As Long
     lpstrFile As String
     nMaxFile As Long
     lpstrFileTitle As String
     nMaxFileTitle As Long
     lpstrInitialDir As String
     lpstrTitle As String
     flags As Long
     nFileOffset As Integer
     nFileExtension As Integer
     lpstrDefExt As String
     lCustData As Long
     lpfnHook As Long
     lpTemplateName As String
    End Type

    Function LaunchCD(strform As Form) As String
     Dim OpenFile As OPENFILENAME
     Dim lReturn As Long
     Dim sFilter As String
     OpenFile.lStructSize = Len(OpenFile)
     OpenFile.hwndOwner = strform.hwnd
     sFilter = "All Files (*.*)" & Chr(0) & "*.*" & Chr(0) & _
      "JPEG Files (*.JPG)" & Chr(0) & "*.JPG" & Chr(0)
     OpenFile.lpstrFilter = sFilter
     OpenFile.nFilterIndex = 1
     OpenFile.lpstrFile = String(257, 0)
     OpenFile.nMaxFile = Len(OpenFile.lpstrFile) - 1
     OpenFile.lpstrFileTitle = OpenFile.lpstrFile
     OpenFile.nMaxFileTitle = OpenFile.nMaxFile
     OpenFile.lpstrInitialDir = "C:\"
     OpenFile.lpstrTitle = "Select a file using the Common Dialog DLL"
     OpenFile.flags = 0
     lReturn = GetOpenFileName(OpenFile)
        If lReturn = 0 Then
            MsgBox "A file was not selected!", vbInformation, _ 
              "Select a file using the Common Dialog DLL"
         Else
            LaunchCD = Trim(Left(OpenFile.lpstrFile, InStr(1, OpenFile.lpstrFile, vbNullChar) - 1))
         End If
    End Function
    ```

13. On the **Debug** menu, click **Compile Northwind**, and then close the Visual Basic Editor.
14. On the **View** menu, click **Form View**.
15. Click **Command1**, and then click a file in the window that opens.

    The path of the file appears in the **Text1** text box.

### Microsoft Office Access 2007

1. In Access 2007, open the sample database that is named Northwind.accdb.
2. On the **Create** tab, click **Form** in the **Forms** group.
3. On the **Format** tab, click the down arrow below **View**, and then click **Design View**.
4. Add a text box to Form1, right-click the text box, and then click **Properties**.
5. Click the **All** tab, click **Name**, and then type Text1.
6. Right-click the label control that is associated with the **Text1** text box, click **Properties**, and then click the **All** tab.
7. Click **Caption**, and then type Text1.
8. Add a command button to **Form1**, right-click the command button, click **Properties**, click **Name**, type Command1, click **Caption**, and then type Command1.
9. Click the **Event** tab, click **[Event Procedure]** in the **On Click** list, and then click the ellipsis button (**...**) to start the Microsoft Visual Basic Editor.
10. Modify the code in the Command1_Click procedure to resemble the following code example.

    ```vb
    Private Sub Command1_Click()
     Me!Text1 = LaunchCD(Me)
    End Sub
    ```

11. On the **Insert** menu, click **Module**, and then insert code that resembles the following code example into Module1.

    ```vb
    Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias _
    "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long

    Private Type OPENFILENAME
     lStructSize As Long
     hwndOwner As Long
     hInstance As Long
     lpstrFilter As String
     lpstrCustomFilter As String
     nMaxCustFilter As Long
     nFilterIndex As Long
     lpstrFile As String
     nMaxFile As Long
     lpstrFileTitle As String
     nMaxFileTitle As Long
     lpstrInitialDir As String
     lpstrTitle As String
     flags As Long
     nFileOffset As Integer
     nFileExtension As Integer
     lpstrDefExt As String
     lCustData As Long
     lpfnHook As Long
     lpTemplateName As String
    End Type

    Function LaunchCD(strform As Form) As String
     Dim OpenFile As OPENFILENAME
     Dim lReturn As Long
     Dim sFilter As String
     OpenFile.lStructSize = Len(OpenFile)
     OpenFile.hwndOwner = strform.hwnd
     sFilter = "All Files (*.*)" & Chr(0) & "*.*" & Chr(0) & _
      "JPEG Files (*.JPG)" & Chr(0) & "*.JPG" & Chr(0)
     OpenFile.lpstrFilter = sFilter
     OpenFile.nFilterIndex = 1
     OpenFile.lpstrFile = String(257, 0)
     OpenFile.nMaxFile = Len(OpenFile.lpstrFile) - 1
     OpenFile.lpstrFileTitle = OpenFile.lpstrFile
     OpenFile.nMaxFileTitle = OpenFile.nMaxFile
     OpenFile.lpstrInitialDir = "C:\"
     OpenFile.lpstrTitle = "Select a file using the Common Dialog DLL"
     OpenFile.flags = 0
     lReturn = GetOpenFileName(OpenFile)
        If lReturn = 0 Then
            MsgBox "A file was not selected!", vbInformation, _ 
              "Select a file using the Common Dialog DLL"
         Else
            LaunchCD = Trim(Left(OpenFile.lpstrFile, InStr(1, OpenFile.lpstrFile, vbNullChar) - 1)) 
         End If
    End Function
    ```

12. On the **Debug** menu, click **Compile Northwind**, and then close the Visual Basic Editor.
13. On the **Format** tab, click the down arrow below **View**, and then click **Form View**.
14. Click **Command1**, and then click a file in the window that opens.

    The path of the file appears in the **Text1** box.
