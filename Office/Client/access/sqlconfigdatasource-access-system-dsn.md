---
title: Use SQLConfigDataSource to create system DSN
description: Describes how to create a system DSN. Use VBA in Access to call the SQLConfigDataSource function.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: robdil
appliesto: 
  - Access 2007
  - Access 2002
ms.date: 06/06/2024
---

# How to use SQLConfigDataSource to create an Access system DSN

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies to a Microsoft Access database (.mdb or accdb) and to a Microsoft Access project (.adp).

## Summary

You can't create a system DSN by using the RegisterDatabase method. To create a system DSN, use the ODBC API call for SQLConfigDataSource.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

## More information

The following example uses the API call for SQLConfigDataSource to create a system DSN. The example creates a data source for the sample database Northwind.mdb when the database is located at C:\Northwind.mdb.

1. Copy the sample database Northwind.mdb to the root directory of drive C.   
2. Create a new Access database.   
3. Create a module and type the following lines in the Declarations section:
```vb
Option Explicit
Const ODBC_ADD_SYS_DSN = 4       'Add data source
Const ODBC_CONFIG_SYS_DSN = 5    'Configure (edit) data source
Const ODBC_REMOVE_SYS_DSN = 6    'Remove data source

Private Declare Function SQLConfigDataSource Lib "ODBCCP32.DLL" (ByVal _
   hwndParent As Long, ByVal fRequest As Long, ByVal _
   lpszDriver As String, ByVal lpszAttributes As String) As Long

```

4. Type the following procedure:

```vb
Function Build_SystemDSN(DSN_NAME As String, Db_Path As String)

Dim ret%, Driver$, Attributes$

Driver = "Microsoft Access Driver (*.MDB)" & Chr(0)
   Attributes = "DSN=" & DSN_NAME & Chr(0)
   Attributes = Attributes & "Uid=Admin" & Chr(0) & "pwd=" & Chr(0)
   Attributes = Attributes & "DBQ=" & Db_Path & Chr(0)

ret = SQLConfigDataSource(0, ODBC_ADD_SYS_DSN, Driver, Attributes)

'ret is equal to 1 on success and 0 if there is an error
   If ret <> 1 Then
       MsgBox "DSN Creation Failed"
   End If

End Function

```

5. In the Immediate window, type the following line, and then press ENTER:

   **? Build_SystemDSN("My SampleDSN","c:\Northwind.mdb")**   
6. Click Start, point to Settings, and then click Control Panel.    
7. In Control Panel, click ODBC Data Sources, **ODBC Data Sources (32-bit)**, or **32bit ODBC**.    
8. Click the System DSNtab. Note that **My SampleDSN** has been added to the
System Data Sources list.
