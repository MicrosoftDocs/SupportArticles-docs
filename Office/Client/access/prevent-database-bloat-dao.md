---
title: Prevent database bloat after you use DAO
description: Describes how to prevent database bloat that occurs when the database grows rapidly in size after you use Data Access Objects (DAO) to open a recordset. To resolve this issue, you need to call the Close method of the recordset to explicitly close it.
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
ms.reviewer: ROBCOO
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to prevent database bloat after you use Data Access Objects (DAO)

Moderate: Requires basic macro, coding, and interoperability skills. 

This article applies only to a Microsoft Access database (.mdb).

## Symptoms

A Microsoft Access database has begun to bloat (or grow rapidly in size) after you implement Data Access Objects (DAO) to open a recordset. 

## Cause

If you do not release a recordset's memory each time that you loop through the recordset code, DAO may recompile, using more memory and increasing the size of the database. 

## Resolution

To avoid consuming unnecessary resources and increasing database size, use the Close method of the Recordset object to explicitly close the recordset's memory when you no longer need the recordset.

If the database has increased in size because you did not use the Close method of the Recordset object, you can reduce the size of the database by running the
 **Compact and Repair** utility (on the Tools menu). 

## More information

When you create a Recordset (or a QueryDef) object in code, explicitly close the object when you are finished. Microsoft Access automatically closes Recordset and QueryDef objects under most circumstances. However, if you explicitly close the object in your code, you can avoid occasional instances when the object remains open. The following steps show you how to use DAO to close a Recordset or QueryDef object. 

1. Start Microsoft Access.   
2. Open the sample database Northwind.mdb.

   **NOTE** The sample code in this article uses Microsoft Data Access Objects. For this code to run properly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click References on the Tools menu in the Visual Basic Editor, and make sure that the Microsoft DAO 3.6 Object Library check box is selected.

3. Copy the following code to a new module. The following sample code opens and closes a Recordset and a QueryDef object, and displays both Recordset and QueryDef information within message boxes.

    ```vb
    Option Compare Database
    Option Explicit
    
    Sub subCloseObjects()
        Dim db As DAO.Database
        Dim rs As DAO.Recordset
        Dim qd As DAO.QueryDef
    
    Set db = CurrentDb
        Set rs = db.OpenRecordset("Employees", dbOpenTable)
        Set qd = db.QueryDefs("Invoices")
    
    rs.MoveLast    'Move to the last record in the Recordset.
    
    MsgBox "The Employees Recordset is open." & vbCrLf & _
               "The last Employee ID is " & rs![EmployeeID] & "."
        MsgBox "The Invoices query definition is open." & vbCrLf & _
               "The first field in the query is " & qd.Fields(0).Name
    
    'Explicitly close the Recordset and QueryDef objects.
        rs.Close
        qd.Close
    End Sub
    
    ```

4. Run the subCloseObjects routine.
