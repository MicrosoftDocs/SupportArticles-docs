---
title: Can't add or delete records with ADO methods
description: Describes a problem that may occur when you use ActiveX Data Objects (ADO) with the AddNew method or with the Delete method of the Recordset object. When you open the recordset with an unspecified lock type in Access, you may receive an error message.
author: helenclu
manager: dcscontentpm
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
ms.date: 05/26/2025
---

# You cannot add records or delete records with the ADO AddNew method or with the Delete method

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies to a Microsoft Access database (.mdb or .accdb) and to a Microsoft Access project (.adp).

## Symptoms

When you are using ActiveX Data Objects (ADO), if you use the AddNew or Delete method of the Recordset object, and you open the recordset with an unspecified lock type, you may receive one of the following error messages:  

```adoc
Run-time error '3251': Object or provider is not capable of performing requested operation. 
```

-or-

```adoc
Run-time error '3251':
The operation requested by the application is not supported by the provider. 
```

-or-
```adoc
Run-time error '3251':
Current Recordset does not support updating. This may be a limitation of the provider, or of the selected locktype. 
```

## Cause

By default, ADO recordsets are opened with a lock type of adLockReadOnly, which does not allow additions and deletions. 

## Resolution

To allow additions and deletions, open the recordset with a lock type of either adLockOptimistic or adLockPessimistic, as in the following code sample:

```vb
Sub DelFirstRec()
   Dim rs As ADODB.Recordset
   Set rs = New ADODB.Recordset

rs.Open "Select * from TestTable", CurrentProject.Connection, _
            adOpenKeyset, adLockOptimistic
   rs.MoveFirst
   rs.Delete
   rs.Close
End Sub

```

**NOTE** You can use this sample code to resolve the behavior in the "Steps to Reproduce Behavior" section of this article. 

## More information

### Steps to Reproduce Behavior

1. In a new Access database, create the following new table and name it TestTable:

    ```adoc
    Table:TestTable
    ----------------------------
    Field Name: ID
    Data Type: Autonumber
    Indexed: Yes (No Duplicates)
    
    Field Name: Name
    Data Type: Text
    ```

2. Open the new table in Datasheet view, and then type the following test data:
 
    ```adoc
    ID Name
    -----------------
    1 Beverages
    2 Condiments
    3 Confections
    4 Dairy
    5 Grains
    6 Meat
    7 Produce
    8 Seafood
    ```

3. **NOTE** The sample code in this article uses Microsoft ActiveX Data Objects. For this code to run properly, you must reference the Microsoft ActiveX Data Objects 2.x Library (where 2.x is 2.1 or later.) To do so, click References on the Tools menu in the Visual Basic Editor, and make sure that the Microsoft ActiveX Data Objects 2.x Library check box is selected. 

   Create a module, and then type the following line in the Declarations section if it is not already there:

    **Option Explicit**

4. Type the following procedure:

```vb
Sub DelFirstRec()
   Dim rs As New ADODB.Recordset

rs.Open "Select * from TestTable", CurrentProject.Connection, adOpenKeyset
   rs.MoveFirst
   rs.Delete
   rs.Close
End Sub

```

5. To test this function, type the following line in the Immediate window, and then press ENTER: 

   **DelFirstRec**
 
   Note that you receive the error message that is mentioned in the "Symptoms" section of this article. Also, when you check the table, you see that no records have been deleted.   
