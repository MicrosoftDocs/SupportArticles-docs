---
title: Create an SQL pass-through query by using ADO
description: Explains how to create an SQL pass-through query in Access by using VBA with ADO. You can use this query to send commands directly to the database server. This article requires you to reference ADO and ADOX libraries to complete the sample.
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
ms.reviewer: GURPALH
appliesto:
- Access 2002
---

# How to use ADOX to create an SQL pass-through query in Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Moderate: Requires basic macro, coding, and interoperability skills. 

This article applies only to a Microsoft Access database (.accdb and .mdb).

## Summary

This article shows you how to create an SQL pass-through query in Microsoft Visual Basic for Applications (VBA) with Microsoft ActiveX Data Objects (ADO). 

## More information

You can write a function in Visual Basic for applications that creates an SQL pass-through query. An SQL pass-through query is made up of an SQL statement and a connection string. When you run the query, it sends commands directly to the database server for processing. This removes the overhead of the Microsoft Jet database engine. 

With the Data Access Object (DAO) model, you could use SQL pass-through queries to improve performance when you accessed external data. With ADO, you can use the Microsoft OLE DB Provider for SQL Server to directly access a SQL Server without the overhead of Microsoft Jet or ODBC. You can also use the Microsoft OLE DB Provider for ODBC to access data in any ODBC data source. 

Although you no longer have to create SQL pass-through queries in your Microsoft Jet database to improve performance, you can still do so by using ADOX and the Jet Provider. The following code shows you how to create an SQL pass-through query.

NOTE: The sample code in this article uses both ADO and ActiveX Data Objects Extensions for Data Definition Language and Security (ADOX). For this code to run properly, you must click References on the Tools menu in the Visual Basic Editor and make sure that the following two references are selected: 

- Microsoft ActiveX Data Objects 2.1 Library
- Microsoft ADO Ext. 2.6 for DDL and Security

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To create an SQL pass-through query in code, follow these steps: 

1. Open the sample Northwind database.   
2. Create a new module, and then type or paste the following code:
```vb
Function CreateSPT(SPTQueryName As String, strSQL As String)

Dim cat As ADOX.Catalog
  Dim cmd As ADODB.Command

Set cat = New ADOX.Catalog
  Set cmd = New ADODB.Command

cat.ActiveConnection = CurrentProject.Connection

Set cmd.ActiveConnection = cat.ActiveConnection

cmd.CommandText = strSQL
  cmd.Properties("Jet OLEDB:ODBC Pass-Through Statement") = True

'Modify the following connection string to reference an existing DSN for 
 'the sample SQL Server PUBS database.

cmd.Properties _
     ("Jet OLEDB:Pass Through Query Connect String") = _
       "ODBC;DSN=myDSN;database=pubs;UID=sa;PWD=;"
  cat.Procedures.Append SPTQueryName, cmd

Set cat = Nothing
  Set cmd = Nothing

End Function

```

3. To test this function, type the following line in the Immediate window, and then press ENTER:

   **?CreateSPT("MySptQuery", "Select * from Authors")**   
