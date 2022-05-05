---
title: Find a record by using ADO and Jet OLE DB provider
description: Lists a method of using ActiveX Data Objects (ADO) and OLE DB provider to find records in a Microsoft Jet database. To do this, you should be familiar with the Visual Basic programming, also have some knowledge of ADO and OLE DB provider.
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
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 3/31/2022
---

# How to find a record using ADO and Jet OLE DB provider

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

This article demonstrates how to use ActiveX Data Objects (ADO) and OLE DB to find records in a Microsoft Jet database. 

## More information

What follows are two example procedures. The first, CreateJetDB, creates a new Microsoft Jet database in the root directory of drive C and populates it with data. The second, CursorLocationTimed, demonstrates how to use the Find method with a server-side cursor and with a client-side cursor.

To create these procedures, follow these steps: 

1. Create a new Microsoft Access database.    
2. Create a new module.    
3. On the Tools menu, click References, and make sure the following references are selected: 

   Microsoft ActiveX Data Objects 2.1 Library or later version
 
   Microsoft ADO Ext. 2.1 for DDL and Security or later version   
4. Type or paste the following procedures:
```vb
Sub CreateJetDB()

Dim cat As ADOX.Catalog
   Dim cn As ADODB.Connection
   Dim rs As ADODB.Recordset
   Dim numrecords As Long
   Dim i As Long

Set cat = New ADOX.Catalog
   Set cn = New ADODB.Connection
   Set rs = New ADODB.Recordset

' Number of sample records to create
   numrecords = 250000

On Error Resume Next

'Delete the sample database if it already exists.
   'Change "findseek.mdb" to "findseek.accdb" for Access 2007.
   'Change the Provider to "Microsoft.ACE.OLEDB.12.0" for 
   'Access 2007 ACCDB databases.
   Kill "c:\findseek.mdb"
   On Error GoTo 0

' Create a new Jet 4.0 database name findseek.mdb
   'Change "findseek.mdb" to "findseek.accdb" for Access 2007.
   'Change the Provider to "Microsoft.ACE.OLEDB.12.0" for 
 'Access 2007 ACCDB databases.

cat.Create "Provider=Microsoft.Jet.OLEDB.4.0;" & _
   "Data Source=c:\findseek.mdb"

' Set the provider, open the database,
   'and create a new table called tblSequential.
   'Change "findseek.mdb" to "findseek.accdb" for Access 2007.
   'Change the Provider to "Microsoft.ACE.OLEDB.12.0" for 
   'Access 2007 ACCDB databases.

cn.Provider = "Microsoft.Jet.OLEDB.4.0"
   cn.Open "Data Source=c:\findseek.mdb"
   cn.Execute "CREATE TABLE tblSequential (col1 long, col2 text(75));"

'Open the new table.
   rs.Open "tblSequential", cn, adOpenDynamic, _
   adLockOptimistic, adCmdTableDirect

' Add sample records to the tblSequential table.
   For i = 0 To numrecords
      rs.AddNew
      rs.Fields("col1").Value = i
      rs.Fields("col2").Value = "value_" & i
      rs.Update
      Next i
   rs.Close

'Create a multifield Index on col1 and col2.
   cn.Execute "CREATE INDEX idxSeqInt on tblSequential (col1, col2);"

'Close the connection
   cn.Close

End Sub

Sub CursorLocationTimed()

Dim cn As ADODB.Connection
   Dim rs As ADODB.Recordset
   Dim i, j As Long
   Dim time As Variant

Set cn = New ADODB.Connection
   Set rs = New ADODB.Recordset

On Error GoTo ErrHandler

'Change "findseek.mdb" to "findseek.accdb" for Access 2007.
   'Change the Provider to "Microsoft.ACE.OLEDB.12.0" for 
   'Access 2007 ACCDB databases.
   cn.Open "Provider=Microsoft.Jet.OLEDB.4.0;" _
   &  "Data Source=c:\findseek.mdb"

' Specify how ADO should open the recordset:
   ' adUseServer - use the native provider to perform cursor
   ' operations
   ' adUseClient - use the client cursor engine in ADO
   ' NOTE: adUseServer more closely resembles DAO

' Time opening a recordset and doing 1000 finds (Server cursor
   ' engine)
   '
   rs.CursorLocation = adUseServer
   time = Timer

' Open the recordset and perform serveral Finds to locate records.
   ' Using the adCmdTableDirect opens a base table against Jet, which
   ' is generally the fastest, most functional way to access tables.

rs.Open "tblSequential", cn, adOpenDynamic, adLockOptimistic, _
   adCmdTableDirect

For i = 0 To 1000
      rs.Find "col1=" & i
   Next i

Debug.Print "Sequential Find + Open (Server) = " & Timer - time
   rs.Close

' Time opening a recordset and doing 1000 finds (Client cursor
   ' engine)

rs.CursorLocation = adUseClient
   time = Timer

rs.Open "tblSequential", cn, adOpenDynamic, _
   adLockOptimistic, adCmdTableDirect

For i = 0 To 1000
      rs.Find "col1=" & i
   Next i

Debug.Print "Sequential Find + Open (Client) = " & Timer - time
   rs.Close

Exit Sub

ErrHandler:

For j = 0 To cn.Errors.Count - 1
      Debug.Print "Conn Err Num : "; cn.Errors(j).Number
      Debug.Print "Conn Err Desc: "; cn.Errors(j).Description
   Next j

Resume Next

End Sub

```
5. To create the sample database, type the following line in the Immediate window, and then press ENTER:
    ```vb
    CreateJetDB
    
    ```

6. To demonstrate the Find method, type the following line in the Immediate window, and then press ENTER: 
    ```vb
    CursorLocationTimed
    
    ```

    You should see output similar to the following: 
     
    Sequential Find + Open (Server) = 0.28125
    
    Sequential Find + Open (Client) = 5.28125
    
    **NOTE** The resulting numbers may differ from computer to computer.   

## References

To learn more about ActiveX Data Objects, see [Microsoft ActiveX Data Objects (ADO)](https://msdn.microsoft.com/library/ms675532%28vs.85%29.aspx).
