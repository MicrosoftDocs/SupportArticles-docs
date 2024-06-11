---
title: Can't enter a large amount of text in Memo field
description: Discusses a problem in which you receive an error message when you enter a large amount of text in a Memo field that contains an index in Access.
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
ms.reviewer: GARYRA
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# "Run-time error '3709'" when you enter a large amount of text in a Memo field that contains an index in Access

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Symptoms

In a Microsoft Access database, when you create a Memo field that includes an index or you create a field name that includes the automatically indexed text, you cannot enter the text that includes more than approximately 3450 characters into the field. When you try to enter more text into the field or try to edit the existing data, you receive the following error message:

```adoc
Run-time error '3709':

The search key not found in any record.
```

## Resolution

If you must enter a large amount of text in the Memo field, delete the index for the Memo field. To do so follow these steps:

1. Open the table with the Memo field in Design view.   
2. On the View Menu, click Indexes.

   **Note** In Microsoft Office Access 2007, click the **Design** tab, and then click **Indexes** in the **Show/Hide** group.   
3. Click the index for the Memo field, and then delete it.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More information

This behavior does not occur in versions of Microsoft Access before Microsoft Access 2000 because Memo fields could not be indexed in Jet 3.5 and earlier.

### Steps to reproduce the behavior in Access 2003

1. In a new database, create a new table with the following properties, and then save it as Table1:

    ```adoc
    Table: Table1
    ------------------------
    Field Name: Id
    Data Type: AutoNumber
    Primary Key
    
    Field Name: MyCode
    Data Type: Memo
    ```
2. Add the following record to the Table1 table:

    ```adoc
    Id MyCode
    ------------------------------------
    1 This is the Memo test data
    ```
3. Copy the following SQL statement, paste it into a new query in SQL view, and then save the query as query1:

   **UPDATE Table1 SET Table1.MyCode = [MyCode] & " " & [MyCode];**

4. Create the following module, and then save it Module1:
    ```vb
    Sub TestMemoUpdate()
        Dim i As Integer
        Docmd.setwarnings false
        For i = 1 To 10
        Docmd.openquery "Query1"   
        Next i
        Docmd.setwarnings true
    End Sub
    
    ```

5. Place your pointer so that it is in the procedure. Press F5 to run the code.
