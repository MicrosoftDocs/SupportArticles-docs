---
title: Use ActiveX Data Object with VBA
description: Describes how to use ActiveX Data Object (ADO) with VBA on a window in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains.
ms.reviewer: theley, kvogel
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to use ActiveX Data Object (ADO) with VBA on a window with Microsoft Dynamics GP and with Microsoft Business Solutions - Great Plains 8.0

This article describes how to use ActiveX Data Object (ADO) with VBA on a window in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942327

## Introduction

When you use ActiveX Data Object (ADO) to connect to Microsoft SQL Server from a Microsoft Visual Basic for Applications (VBA) form, the best practice is as follows:

- Open the connection when the window is open.
- Close the connection when the window is closed.

When you follow this practice, the connection is available when the window is open. So the connection isn't continuously opened and closed. However, the connection is continuously opened and closed if the connection code is contained in an individual event script.

Consider the following scenario:

- You select the **Close** box.
- You receive the following message:
    > Do you want to save?
- You select **Cancel**.

In this scenario, the VBA Window_AfterClose() code is still run. Also, the connection is closed even though the window is still open.
> [!NOTE]
> You will receive an error the next time that you try to use the connection that is now closed.

## More information

To avoid this issue, use the following Boolean variable:  
OKtoCloseADO

You can use this variable to make sure that the connection doesn't close if a user ends the closure of a window. To open and close a connection for a form, use the appropriate method to apply the example fix code.

### Method 1: Microsoft Dynamics GP 10.0

Use the following example code.

```vb
Dim cn As New ADODB.Connection
Dim rst As New ADODB.Recordset
Dim cmd As New ADODB.Command
Dim sqlstring As String

Dim OKtoCloseADO As Boolean

Private Sub Window_BeforeOpen(OpenVisible As Boolean)
    ' ADO Connection
    Set cn = UserInfoGet.CreateADOConnection
    ' Use a client-side cursor so that a recordset count can be obtained later.
    cn.CursorLocation = 3
    ' Set the database to the currently logged-in database.
    cn.DefaultDatabase = UserInfoGet.IntercompanyID
End Sub

Private Sub Window_BeforeClose(AbortClose As Boolean)
    OKtoCloseADO = True
End Sub

Private Sub Window_AfterClose()
    If OKtoCloseADO Then
        ' Close the ADO Connection.
        If rst.State = adStateOpen Then rst.Close
        If cn.State = adStateOpen Then cn.Close
        Set cn = Nothing
        Set rst = Nothing
        Set cmd = Nothing
    End If
End Sub

Private Sub Window_AfterModalDialog(ByVal DlgType As DialogType, PromptString As String, Control1String As String, Control2String As String, Control3String As String, Answer As DialogCtrl)
    Select Case PromptString
        ' Save the document from the Dialog box (browse or close the window).
        Case "Do you want to save or delete the document?"
            If Answer = dcButton3 Then
                OKtoCloseADO = False
            End If
     
        Case Else
     End Select
End Sub
```

### Method 2: Microsoft Business Solutions - Great Plains 8.0

Use the RetrieveGlobals.dll file to return an ADO connection object that lets you connect to Microsoft Dynamics GP data.

Use the following example code.

```vb
Dim cn As New ADODB.Connection
Dim rst As New ADODB.Recordset
Dim cmd As New ADODB.Command
Dim sqlstring As String

Dim OKtoCloseADO As Boolean

Private Sub Window_BeforeOpen(OpenVisible As Boolean)
    Dim userinfo As New RetrieveGlobals.retrieveuserinfo
    Dim luserid As String
    Dim lintercompanyid As String
    Dim lsqldatasourcename As String
    Dim lsqlpassword As String
    Dim constring As String

    ' RetrieveGlobals section.
    lsqldatasourcename = userinfo.sql_datasourcename()
    luserid = userinfo.retrieve_user()
    lsqlpassword = userinfo.sql_password()
    lintercompanyid = userinfo.intercompany_id()
    'MsgBox (luserid & " " & lsqlpassword & " " & lintercompanyid & " " & lsqldatasourcename)

    ' Create a connection string.
    constring = "Provider=MSDASQL" & _
                ";Data Source=" & lsqldatasourcename & _
                ";User ID=" & luserid & _
                ";Password=" & lsqlpassword & _
                ";Initial Catalog=" & lintercompanyid
    'MsgBox constring

    ' ADO connection section.
    With cn
        .ConnectionString = constring
        .CursorLocation = 3 ' adClient
        .Open
    End With
End Sub

Private Sub Window_BeforeClose(AbortClose As Boolean)
    OKtoCloseADO = True
End Sub

Private Sub Window_AfterClose()
    If OKtoCloseADO Then
        ' Close the ADO Connection.
        If rst.State = adStateOpen Then rst.Close
        If cn.State = adStateOpen Then cn.Close
        Set cn = Nothing
        Set rst = Nothing
        Set cmd = Nothing
    End If
End Sub

Private Sub Window_AfterModalDialog(ByVal DlgType As DialogType, PromptString As String, Control1String As String, Control2String As String, Control3String As String, Answer As DialogCtrl)
    Select Case PromptString
        ' Save the document from the Dialog box (browse or close the window).
        Case "Do you want to save or delete the document?"
            If Answer = dcButton3 Then
                OKtoCloseADO = False
            End If
     
        Case Else
     End Select
End Sub
```
