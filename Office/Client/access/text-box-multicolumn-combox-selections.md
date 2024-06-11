---
title: Populate text boxes with multicolumn Combo Box selections
description: Provides step-by-step guide to populate several text boxes with the selections made in a multicolumn combo box, and save the contents of the text boxes as one record in a table. Requires basic macro, coding, and interoperability skills
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
ms.reviewer: V-DARMAC
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to populate text boxes with multicolumn Combo Box selections

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies to a Microsoft Access database (.mdb) and to a Microsoft Access project (.adp).

## Summary

This article explains how to populate several text boxes with the selections made in a multicolumn combo box, and then save the contents of the text boxes as one record in a table.

## More information

> [!CAUTION]
> If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements. To update text boxes with selections made in a multi-column combo box, use the following steps:

1. Open the sample database Northwind.mdb.   
2. Create a new table in Northwind.mdb that includes the following fields:
 
   ```adoc
   Table: Table1
   ----------------------
   Field Name: ID
   Data Type: Autonumber
   Primary Key
   ---
   Field Name: FirstName
   Data Type: Text
   ---
   Field Name: LastName
   Data Type: Text
   ---
   Field Name: Title
   Data Type: Text
   ```

3. Create a new form in Northwind.mdb that contains the following controls:

    ```adoc
    Form: Form1
    ----------------------
    RecordSource: Table1
    ---
    Control Type: Text Box
    Name: txtFirstName
    ControlSource: FirstName
    ---
    Control Type: Text Box
    Name: txtLastName
    ControlSource: LastName
    ---
    Control Type: Text Box
    Name: txtTitle
    ControlSource: Title
    ```
4. Add a combo box to Form1. In the Combo Box wizard, follow these steps:
   1. Click **I want the combo box to look up the values in a table or query**, and then click Next.   
   2. Click Table: Employees, and then click Next.    
   3. Move the LastName, FirstName, and Title fields from the Available Fields list to the Selected Fields list by selecting each field, and then clicking the > button. Click Next.   
   4. Click Next, click **Remember the value for later use**, and then click Next.   
   5. In the **What label would you like for your combo box** box, type Make Selection, and then click Finish.
5. Right-click the combo box that you created in step 4, and then click **Properties**.   
6. Click the Other tab, and then type cboNames in the Name box.   
7. Click the Event tab, click the After Update event box, and then click the Build (...) button.   
8. Click Code Builder, and then click OK.   
9. In the Visual Basic Editor, type the following code:
```vb
Private Sub cboNames_AfterUpdate()
   Me.txtFirstName = Me![cboNames].column(1)
   Me.txtLastName = Me![cboNames].column(2)
   Me.txtTitle = Me![cboNames].column(3)
End Sub

```

10. Quit the Visual Basic Editor, and then open the Form1 form in Form view.   
11. Click an item in the combo box, and then click Next Record. Repeat this step for each record that you want to save.   
12. Open Table1 in Table view to confirm that new records have been saved. Note that after you click an item in the combo box, the AfterUpdate property runs the event procedure that populates the three text boxes on the form, and a new record is added to Table1.
