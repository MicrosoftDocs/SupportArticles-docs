---
title: Too Many Fields Defined error
description: Explains that you may receive an unexpected error message when you try to save a table after adding a new field or changing the properties of an existing field since the internal column count to track the number of fields in the table has reached 255.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
ms.date: 05/26/2025
---

# "Too Many Fields Defined" error when you save a table in Access

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies only to a Microsoft Access database (.mdb).

## Symptoms

When you save a table after you add a new field or change the properties of an existing field, you receive the following error message:

**Too many fields defined.**

This message is followed by:

**Errors were encountered during save. Data types were not changed.**

You receive these messages even though you have 255 or fewer fields defined in the table.

**NOTE** You also receive this message if you add or modify fields in a report that is based on a table that has too many fields.

## Cause

The internal column count that Microsoft Access uses to track the number of fields in the table has reached 255, even though you may have fewer than 255 fields in the table. This can happen because Access does not change the internal column count when you delete a field. Access also creates a new field (increasing the internal column count by 1) for every field whose properties you modify.

## Resolution

To free the internal column count for deleted fields or for fields whose properties you modify, do one of the following:

- Compact the database. To do so, point to Database Utilities on the Tools menu, and then click **Compact and Repair Database.**
- Create a new copy of the table. To do so, follow these steps:   

  1. Make note of any relationships with the table.   
  2. Select the table.   
  3. On the File menu, click Save As.   
  4. In the Save Table '**table name**' To box, type a new name, and then click OK.   
  5. Select the same table that you selected in step 2, and then press DELETE. 
  6. Rename the table that you saved in step 3 to the original table name.   
  7. Re-establish any relationships with the new table.   

## More information

In Access, you can define up to 255 fields in a table. If you create 255 fields and then delete 10, Access does not release the fields from the internal column count. Also, for every field whose properties you modify, Access creates a new field and does not release the original field from the internal column count.

### Steps to Reproduce the Behavior

> [!NOTE]
> The sample code in this article uses Microsoft Data Access Objects. For this code to run properly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click References on the Tools menu in the Visual Basic Editor, and make sure that the Microsoft DAO 3.6 Object Library check box is selected.

1. Create the following Visual Basic for Applications code to create a new table with 255 fields:

```vb
' ****************************************************************
' Declarations section of the module
' ****************************************************************
    
Option Compare Database
    Option Explicit
    
    ' ****************************************************************
    ' The Fill_Table() function creates a table in the current database
    ' named Field Test with 255 fields, each of which has a Text data
    ' type and a size of one character.
    ' ****************************************************************
    
    Function Fill_Table()
    
    Dim mydb As DAO.Database
       Dim tbl As DAO.TableDef
       Dim fld As DAO.Field
       Dim i As Integer
    
    Set mydb = CurrentDb()
       Set tbl = mydb.CreateTableDef("Field Test")
          For i = 0 To 254
             Set fld = tbl.CreateField("Field" & CStr(i + 1))
             fld.Type = dbText
             fld.Size = 1
             tbl.Fields.Append fld
          Next i
          mydb.TableDefs.Append tbl
    
    End Function
```

2. Type the following line in the Immediate window to run the function and to create the table:

    ```vb
    Fill_Table
    ```

3. View the Field Test table in Design view, and then delete the last field so that there are only 254 fields defined in the table.   
4. Add the field again, and try to save the table. Note that you receive the following error messages:

    ```adoc
    Too many fields defined.
    
    Errors were encountered during the save operation. Fields were not added. Properties were not updated.
    ```


## References

For more information about database specifications, click Microsoft Access Help on the Help menu, type Access specifications in the Office Assistant or the Answer Wizard, and then click Search to view the topics returned.
