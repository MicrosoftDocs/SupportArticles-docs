---
title: Access database engine cannot find the input table
description: Describes the issue in which you receive an error when you try to open a table in an Access 2010 template (*.accdt). Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: wouterst, tputt, krislill, jenl
appliesto: 
  - Access 2010
ms.date: 03/31/2022
---

# "The Microsoft Office Access database engine cannot find the input table" when you try to open a table in an Access 2010 template

## Symptoms

Consider the following scenario:

- You create a Microsoft Access 2010 database.   
- You link a table in this database to external Data Services tables from Business Data Catalog (BDC) service system tables on a Microsoft SharePoint server.   
- You save the database as an Access 2010 template (.accdt), and then you hydrate the template.   
- You try to open the table that is linked to the Data Services tables.   

In this scenario, you receive the following error message:

```adoc
The Microsoft Office Access database engine cannot find the input table or query 'MSysBDCMetadata'. Make sure that it exists and that its name is spelled correctly.
```

## Cause

This issue occurs because the BDC system tables that you linked to are not included in the template that you saved from the database. 

## Workaround

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To work around this issue, follow these steps:

1. In Access 2010, create a blank database.   
2. On the **External Data** tab, in the **More** drop-down list that is in the **Import & Data** group, click **Data Services**.   
3. In the **Create Link to Data Services** dialog box, click **Install new connection**.    
4. Select the source XML file that defines the connection, and then click **Open**.   
5. Click **Close**.   
6. On the **Database Tools** tab, in the **Macro** group, click **Visual Basic**.   
7. On the **Insert** menu, click **Module**.   
8. In the new module, add the following code.

    ```vb
    '// Set all the MSysBDC* system tables  so that they become visible to Save As Template
    
    '// This should only be needed as soon as in the database that will be used to create the template (accdt)
    
    Sub PrepareBDCTables()
    
    Dim db As Database, tbl As TableDef
    
    Set db = CurrentDb
    
    For Each tbl In db.TableDefs
    
    If tbl.Name Like "MSysBDC*" Then
    
    '//Set all the bdc tables  so that they are visible to the save as template wizard
    
    tbl.Attributes = 0
    
    End If
    
    Next
    
    End Sub
    ```

9. On the **View** menu, click **Immediate Window**.   
10. Type the following command, and then press ENTER: 

    PrepareBDCTables
    
    **Note** This command makes the BDC tables available to the template.   
11. In the **Project** pane, right-click the new module, and then click **Remove module_name**.   
12. Click **No** when you are prompted to export the module.   
13. Close the Microsoft Visual Basic editor.   
14. On the **File** tab, click **Save & Publish**.   
15. Under **Save Database As**, click **Template (*.accdt)**.   
16. In the **Create New Template from This Database** dialog box, enter information for the template, and then click to select the **Include data in template** check box.   
17. Click **OK**.   
