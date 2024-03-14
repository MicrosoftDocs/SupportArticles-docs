---
title: Information about the new connection objects in VBA
description: This article describes the new connection objects that were added to VBA from the GPConn.dll file in Microsoft Dynamics GP 10.0.
ms.reviewer: theley, dclauson
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Information about the new connection objects in VBA that replace the RetrieveGlobals.dll and RetrieveGlobals9.dll files in Microsoft Dynamics GP 10.0

This article describes the new connection objects that were added to VBA from the GPConn.dll file in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936115

## Introduction

In earlier versions of Microsoft Dynamics GP, one of the following files is used to retrieve the username of the user and the password of the user who is currently logged into Microsoft Dynamics GP:

- The RetrieveGlobals.dll file
- The RetrieveGlobals9.dll file

The RetrieveGlobals.dll and RetrieveGlobals9.dll files create a connection string in Microsoft Visual Basic for Applications (VBA) code. This connection string does not require the user to hard code the username and password.

## More information

In Microsoft Dynamics GP 10.0, new connection objects were added to the VBA code. These new connection objects replace the RetrieveGlobals.dll and RetrieveGlobals9.dll files in Microsoft Dynamics GP. This new VBA code lets you create an active connection based off the username and password of the user who is currently logged into Microsoft Dynamics GP. This new connection object is named **UserInfoGet**. This **UserInfoGet** connection object enables you to use the following properties and methods:

- The CompanyName property

- The CreateADOConnection method

- The IntercompanyID property

- The UserDate property

- The UserID property

- The UserName property

The following is a sample of code of the new **UserInfoGet** connection object.

```vb
Dim cn As New ADODB.connection
Dim rst As New ADODB.recordset
Dim cmd As New ADODB.Command

Private Sub PushButtonM79_AfterUserChanged()
cmd.CommandText = "Select * from RM00101"
Set rst = cmd.Execute
MsgBox (rst!custnmbr)
End Sub

Private Sub Window_AfterOpen()
Set cn = UserInfoGet.CreateADOConnection
cn.DefaultDatabase = UserInfoGet.IntercompanyID
cmd.ActiveConnection = cn
End Sub
```

## References

[How to use the new RetrieveGlobals9.dll file in Integration Manager and in Microsoft Dynamics GP 9.0](https://support.microsoft.com/help/913341)
