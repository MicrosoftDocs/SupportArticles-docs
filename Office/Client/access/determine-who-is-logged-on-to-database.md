---
title: Determine who is logged on to a database
description: Describes how to determine who is logged on to a database by using Microsoft Jet UserRoster in Access.
author: simonxjx
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
ms.author: v-six
ms.reviewer: KSWALLOW 
appliesto:
- Access 2007
---

# How to determine who is logged on to a database by using Microsoft Jet UserRoster in Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Advanced: Requires expert coding, interoperability, and multiuser skills.

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

This article shows you how to use Microsoft Visual Basic for Applications to output a list of users who are logged onto a database.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

When you use the following sample code, the following information is returned:

- Computer name.   
- Logon name.   
- Whether or not the user is currently connected to the database. (A user's ID remains in the lock database until the last user disconnects or until the slot is reclaimed for a new user connection.)   
- Whether or not the user connection was terminated under normal circumstances.   

This information can also be used to isolate problems with database corruption that is associated with the activities of a specific user.

### Procedure

> [!CAUTION]
> If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

To determine who is logged onto a database, follow these steps:

1. Open the sample database, Northwind.mdb.

   **Note** In Access 2007, open the Northwind2007 sample database, close the Northwind2007 sample database, and then reopen the Northwind2007 sample database.   
2. On the View menu, point to Database Objects, and then click Modules.

    **Note** In Access 2007, click **Visual Basic** in the **Macro** group on the **Database Tools** tab.   
3. Click New.

    **Note** In Access 2007, click **Module** on the **Insert** menu in the Visual Basic Editor.   
4. Type or paste the following code:

    **Note** The sample code in this article uses Microsoft ActiveX Data Objects. For this code to run properly, you must reference the Microsoft ActiveX Data Objects 2.1 or later version Library. To do so, click **References** on the **Tools** menu in the Visual Basic Editor, and make sure that the **Microsoft ActiveX Data Objects 2.1 Library** check box is selected.
    ```vb
    Sub ShowUserRosterMultipleUsers()
        Dim cn As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        Dim i, j As Long
    
    Set cn = CurrentProject.Connection
    
    ' The user roster is exposed as a provider-specific schema rowset
        ' in the Jet 4.0 OLE DB provider.  You have to use a GUID to
        ' reference the schema, as provider-specific schemas are not
        ' listed in ADO's type library for schema rowsets
    
    Set rs = cn.OpenSchema(adSchemaProviderSpecific, _
        , "{947bb102-5d43-11d1-bdbf-00c04fb92675}")
    
    'Output the list of all users in the current database.
    
    Debug.Print rs.Fields(0).Name, "", rs.Fields(1).Name, _
        "", rs.Fields(2).Name, rs.Fields(3).Name
    
    While Not rs.EOF
            Debug.Print rs.Fields(0), rs.Fields(1), _
            rs.Fields(2), rs.Fields(3)
            rs.MoveNext
        Wend
    
    End Sub
    
    ```

5. Save the module as ShowUsers.   
6. Press CTRL+G to open the Immediate Window.
7.  Type the following line in the Immediate window, and then press ENTER:
    ```vb
    ShowUserRosterMultipleUsers
    
    ```
    **Note** that the Immediate window returns a list of users who are logged onto the database.

