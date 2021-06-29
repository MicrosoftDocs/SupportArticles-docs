---
title: Create DSN-less connection to SQL for linked table
description: Describes methods for how to create a DSN-less connection to SQL Server for linked tables in Microsoft Access.
author: helenclu
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
ms.author: luche
ms.reviewer: willchen
appliesto:
- Access 2003
- Access 2002
---

# How to create a DSN-less connection to SQL Server for linked tables in Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies only to a Microsoft Access database (.accdb and .mdb).

## Introduction

This article describes how to create a connection to Microsoft SQL Server for linked tables in Microsoft Access that does not use a data source name (DSN). This is also known as a DSN-less connection.

## More information

You can use a DSN to create linked SQL Server tables in Microsoft Access. But when you move the database to another computer, you must re-create the DSN on that computer. This procedure may be problematic when you have to perform it on more than one computer. When this procedure is not performed correctly, the linked tables may not be able to locate the DSN. Therefore, the linked tables may not be able to connect to SQL Server.

When you want to create a link to a SQL Server table but do not want to hard-code a DSN in the **Data Sources** dialog box, use one of the following methods to create a DSN-less connection to SQL Server.

### Method 1: Use the CreateTableDef method

The CreateTableDef method lets you create a linked table. To use this method, create a new module, and then add the following AttachDSNLessTable function to the new module.

```vb
'//Name     :   AttachDSNLessTable
'//Purpose  :   Create a linked table to SQL Server without using a DSN
'//Parameters
'//     stLocalTableName: Name of the table that you are creating in the current database
'//     stRemoteTableName: Name of the table that you are linking to on the SQL Server database
'//     stServer: Name of the SQL Server that you are linking to
'//     stDatabase: Name of the SQL Server database that you are linking to
'//     stUsername: Name of the SQL Server user who can connect to SQL Server, leave blank to use a Trusted Connection
'//     stPassword: SQL Server user password
Function AttachDSNLessTable(stLocalTableName As String, stRemoteTableName As String, stServer As String, stDatabase As String, Optional stUsername As String, Optional stPassword As String)
    On Error GoTo AttachDSNLessTable_Err
    Dim td As TableDef
    Dim stConnect As String

For Each td In CurrentDb.TableDefs
        If td.Name = stLocalTableName Then
            CurrentDb.TableDefs.Delete stLocalTableName
        End If
    Next

If Len(stUsername) = 0 Then
        '//Use trusted authentication if stUsername is not supplied.
        stConnect = "ODBC;DRIVER=SQL Server;SERVER=" & stServer & ";DATABASE=" & stDatabase & ";Trusted_Connection=Yes"
    Else
        '//WARNING: This will save the username and the password with the linked table information.
        stConnect = "ODBC;DRIVER=SQL Server;SERVER=" & stServer & ";DATABASE=" & stDatabase & ";UID=" & stUsername & ";PWD=" & stPassword
    End If
    Set td = CurrentDb.CreateTableDef(stLocalTableName, dbAttachSavePWD, stRemoteTableName, stConnect)
    CurrentDb.TableDefs.Append td
    AttachDSNLessTable = True
    Exit Function

AttachDSNLessTable_Err:

AttachDSNLessTable = False
    MsgBox "AttachDSNLessTable encountered an unexpected error: " & Err.Description

End Function

```

To call the AttachDSNLessTable function, add code that is similar to one of the following code examples in the Auto-Exec macro or in the startup form Form_Open event:

- When you use the Auto-Exec macro, call the AttachDSNLessTable function, and then pass parameters that are similar to the following from the RunCode action. 

    ```vb
        AttachDSNLessTable ("authors", "authors", "(local)", "pubs", "", "")
    ```

- When you use the startup form, add code that is similar to the following to the Form_Open event. 
    ```vb
    Private Sub Form_Open(Cancel As Integer)
        If AttachDSNLessTable("authors", "authors", "(local)", "pubs", "", "") Then
            '// All is okay.
        Else
            '// Not okay.
        End If
    End Sub
    ```

**Note** You must adjust your programming logic when you add more than one linked table to the Access database.

### Method 2: Use the DAO.RegisterDatabase method

The DAO.RegisterDatabase method lets you create a DSN connection in the Auto-Exec macro or in the startup form. Although this method does not remove the requirement for a DSN connection, it does help you resolve the issue by creating the DSN connection in code. To use this method, create a new module, and then add the following CreateDSNConnection function to the new module.

```vb
'//Name     :   CreateDSNConnection
'//Purpose  :   Create a DSN to link tables to SQL Server
'//Parameters
'//     stServer: Name of SQL Server that you are linking to
'//     stDatabase: Name of the SQL Server database that you are linking to
'//     stUsername: Name of the SQL Server user who can connect to SQL Server, leave blank to use a Trusted Connection
'//     stPassword: SQL Server user password
Function CreateDSNConnection(stServer As String, stDatabase As String, Optional stUsername As String, Optional stPassword As String) As Boolean
    On Error GoTo CreateDSNConnection_Err

Dim stConnect As String

If Len(stUsername) = 0 Then
        '//Use trusted authentication if stUsername is not supplied.
        stConnect = "Description=myDSN" & vbCr & "SERVER=" & stServer & vbCr & "DATABASE=" & stDatabase & vbCr & "Trusted_Connection=Yes"
    Else
        stConnect = "Description=myDSN" & vbCr & "SERVER=" & stServer & vbCr & "DATABASE=" & stDatabase & vbCr 
    End If

DBEngine.RegisterDatabase "myDSN", "SQL Server", True, stConnect

'// Add error checking.
    CreateDSNConnection = True
    Exit Function
CreateDSNConnection_Err:

CreateDSNConnection = False
    MsgBox "CreateDSNConnection encountered an unexpected error: " & Err.Description

End Function

```

**Note** If the RegisterDatabase method is called again, the DSN is updated.

To call the CreateDSNConnection function, add code that is similar to one of the following code examples in the Auto-Exec macro or in the startup form Form_Open event:

- When you use the Auto-Exec macro, call the CreateDSNConnection function, and then pass parameters that are similar to the following from the RunCode action. 

    ```vb
        CreateDSNConnection ("(local)", "pubs", "", "")
    ```

- When you use the startup form, add code that is similar to the following to the Form_Open event. 

    ```vb
    Private Sub Form_Open(Cancel As Integer)
        If CreateDSNConnection("(local)", "pubs", "", "") Then
            '// All is okay.
        Else
            '// Not okay.
        End If
    End Sub
    ```

> [!NOTE]
> This method assumes that you have already created the SQL Server linked tables in the Access database by using "myDSN" as the DSN name.