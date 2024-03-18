---
title: Cannot access Excel through ADO and ODBC
description: You can't edit an Excel worksheet through ADO and ODBC because this worksheet is saved or opened as ReadOnly.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# PRB: "Operation must use an updateable query" When you access Excel through ODBC

## Symptoms

When you edit an Excel worksheet through ADO and ODBC, you may receive the following error message if you use an ADO DataControl object:

```asciidoc
[Microsoft][ODBC Excel Driver] Operation must use an updateable query.
```

If you use a Recordset object that is generated with ADO code, you may receive the following error message when you edit an Excel worksheet through ADO and ODBC:

```asciidoc
Run-time error '-2147467259(80004005)': [Microsoft][ODBC Excel Driver] Operation must use an updateable query.
```

## Cause

This problem occurs if you try to edit a worksheet that is saved or opened as ReadOnly.

> [!NOTE]
> ReadOnly is the default setting for an ODBC connection to Excel, with or without a data source name (DSN). Therefore, the user must always change that setting to edit data.

## Resolution

To resolve this problem, use the following methods:

- Make sure that the LockType property of the Recordset object is not set to ReadOnly.
- Make sure that the file that you are trying to open is not saved as ReadOnly.
- If you are connecting through a DSN, follow these steps:

  1. Open Control Panel, and then click ODBC Data Source Administrator.
  2. Double-click your DSN.
  3. In the ODBC Microsoft Excel Setup dialog box, click Options.
  4. Make sure that the ReadOnly check box is not selected.

- If you are using a DSN-less connection, make sure to include the "ReadOnly=0" option in the connection string. For example:

  ```vb
  cn.Open "Driver={Microsoft Excel Driver (*.xls)};DBQ=C:\MyDoc.xls;ReadOnly=0;"
  ```

## Status

This behavior is by design.

## More Information

### Steps to Reproduce the Behavior

1. Create a new Standard EXE project in Visual Basic.
2. On the Project menu, click References, and then add a reference to Microsoft ActiveX Data Objects Library.
3. Add a Command button to Form1.
4. Add the following code to Form1:

   ```vb
   Dim rs As ADODB.Recordset
   Dim cn As ADODB.Connection

   Private Sub Form_Load()
     Command1.Caption = "Edit"
   End Sub

   Private Sub Command1_Click()
     Dim DocPath As String

     DocPath = App.Path & "\Test.xls"

     Set cn = New Connection
     Set rs = New Recordset

     cn.Open "Driver={Microsoft Excel Driver (*.xls)};DBQ=" & DocPath & ";ReadOnly=1"
     rs.LockType = adLockOptimistic
     rs.Open "TB1", cn
     rs.AddNew
     rs.Fields(1).Value = "New Value"
     rs.Update

     rs.Close
     cn.Close
     Set rs = Nothing
     Set cn = Nothing
   End Sub  
   ```

5. Save the application.
6. Create a new Excel worksheet, and then save the worksheet as Test.xls.
7. On the Insert menu, point to Name, and then click Define.
8. Create a new table inside the Excel worksheet, and then name the table TB1.
9. Save the worksheet in the same folder as the Visual Basic application.
10. Press F5 to run the application.

## References

For additional information, see the following article:

[Office Space: Tips and Tricks for Scripting Microsoft Office Applications](https://support.microsoft.com/help/257819)