---
title: Use the Attributes property for TableDef objects
description: Describes the usage and code example of Attributes property for TableDef objects in Access.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: chriswy
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# How to use the Attributes property for TableDef objects in Access

_Original KB number:_ &nbsp; 210362

> [!NOTE]
> Requires expert coding, interoperability, and multiuser skills. This article applies only to a Microsoft Access database (.mdb/.accdb).

## Summary

You can use the `Attributes` property of a `TableDef` object to determine specific table properties. For example, you can use the `Attributes` property to find whether a table is a system table or a linked (attached) table.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.NOTE: The sample code in this article uses Microsoft Data Access Objects. For this code to run properly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click **References** on the **Tools** menu in the Visual Basic Editor, and make sure that the Microsoft DAO 3.6 Object Library check box is selected.

## TableDef attributes

The `Attributes` property of a `TableDef` object specifies characteristics of the table represented by the `TableDef` object. The `Attributes` property is stored as a single Long Integer and is the sum of the following Long constants:

|Constant|Value|Description|
|-----|-----|-----|
|dbAttachExclusive|65536|For databases that use the Microsoft Jet database engine,  indicates the table is a linked table opened for exclusive use.|
|dbAttachSavePWD|131072|For databases that use the Jet database engine, indicates the user ID and password for the linked table should be saved with the connection information.|
|dbSystemObject|-2147483646|Indicates the table is a system table.|
|dbHiddenObject|1|Indicates the table is a hidden table (for temporary use).|
|dbAttachedTable|1073741824|Indicates the table is a linked table from a non-Open Database Connectivity (ODBC) database, such as Microsoft Access or Paradox.|
|dbAttachedODBC|536870912|Indicates the table is a linked table from an ODBC database, such as Microsoft SQL Server or ORACLE Server.|

For a `TableDef` object, use of the `Attributes` property depends on the status of `TableDef`, as the following table shows:

|TableDef|Usage|
|-----|-----|
|Object not appended to collection|Read/write|
|Base table|Read-only|
|Linked table|Read-only|

When checking the setting of this property, you can use the AND operator to test for a specific attribute. For example, to determine whether a table object is a system table, perform a logical comparison of the `TableDef` Attributes property and the `dbSystemObject` constant.

## Sample code

> [!NOTE]
> The sample code in this article uses Microsoft Data Access Objects. For this code to run properly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click **References** on the **Tools** menu in the Visual Basic Editor, and make sure that the **Microsoft DAO 3.6 Object Library** check box is selected.

The following user-defined sample function loops through all the tables in a database and displays a message box listing each table name and whether or not the table is a system table:

```vb
Option Compare Database   'Use database order for string comparisons.

Option Explicit

Function ShowTableAttribs()
   Dim DB As DAO.Database
   Dim T As DAO.TableDef
   Dim TType As String
   Dim TName As String
   Dim Attrib As String
   Dim I As Integer

Set DB = CurrentDB()

For I = 0 To DB.Tabledefs.Count - 1
      Set T = DB.Tabledefs(I)
      TName = T.Name
      Attrib = (T.Attributes And dbSystemObject)
      MsgBox TName & IIf(Attrib, ": System Table", ": Not System" & _
        "Table")
   Next I

End Function
```

## References

For more information about the Attributes property, click **Microsoft Visual Basic Help** on the **Help** menu, type *object properties* in the Office Assistant or the Answer Wizard, and then click **Search** to view the topics returned.
