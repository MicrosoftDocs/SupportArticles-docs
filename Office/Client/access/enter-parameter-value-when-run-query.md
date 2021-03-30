---
title: Enter Parameter Value dialog box appears
description: Describes a problem that may occur when you try to run a query, a form, or a report in Access. The Enter Parameter Value dialog box may appear unexpectedly.
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
ms.reviewer: STECLEVE
appliesto:
- Access 2007
- Access 2003
- Access 2002
---

# "Enter Parameter Value" dialog box appears when you run a query, a form, or a report

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Moderate: Requires basic macro, coding, and interoperability skills. 

This article applies only to a Microsoft Access database (.mdb).

## Symptoms

When you try to run a query, a form, or a report, the Enter Parameter Value dialog box may appear unexpectedly. 

## Cause

This behavior occurs when a field, a criteria, an expression, or a control in a query, a form, or a report references a name that Access cannot find. For example, a name could be misspelled or a field may not be available within that scope. 

## Resolution

To resolve this behavior, rename the reference to a valid field name. If you do not know where the reference is located, run the Database Documenter for the object listed in the Enter Parameter Value dialog box, and then output the information to a text file. To do so, follow these steps: 

- If you use Access 2002 and 2003, follow these steps:
  1. On the **Tools** menu, point to **Analyze**, and then click **Documenter**.   
  2. Click the tab that corresponds to the type of database object that you are looking for, and then click to select the check box of the query, the form, or the report that you tried to run.

     **Note** If the object is a form or a report, include all source queries and subforms or subreports in your list of selections.   
  3. Click **Options** to specify which feature of the selected object you want to print, and then click **OK**.   
  4. Click **OK** to close the **Documenter** dialog box.   
  5. On the **File** menu, click **Export**.   
  6. In the **Save as type** list, click **Text Files**, and then complete the remainder of the information as needed.   
  7. Open the exported file in Microsoft Word, and then search for the parameter requested in the **Enter Parameter Value** dialog box.
- If you use Access 2007 or a later version, follow these steps:
  1. On the **Database Tools** tab, click **Database Documenter** in the **Analyze** group.   
  2. Click the tab that corresponds to the type of database object that you are looking for, and then click to select the check box of the query, the form, or the report that you tried to run.

     **Note** If the object is a form or a report, include all source queries and subforms or subreports in your list of selections.   
  3. Click **Options** to specify which feature of the selected object you want to print, and then click **OK**.   
  4. Click **OK** to close the **Documenter** dialog box.   
  5. In **Data** group, click **Text File**, and then complete the remainder of the information as needed.   
  6. Open the exported file in Microsoft Word, and then search for the parameter requested in the **Enter Parameter Value** dialog box.   
   
If you cannot run the Database Documenter, check to see if there is a missing reference. The most common missing reference in this case is to the Utility.mda. To check for this reference, follow these steps: 

1. In the Database window, click **Modules** under **Objects**.

   **Note** If you use Access 2007 or a later version, on the Database Tools tab, click **Visual Basic**, and then go to step 3.   
2. Select any existing module, and then click Design or insert a new module. This will start the Visual Basic Editor.   
3. On the Tools menu, click References.   
4. In the Available References list, look for any reference that has "MISSING: " in front of the name. Click to clear the check box.

   **NOTE** If you do not need a reference to Utility.mda, skip to step 8.   
5. Click Browse.   
6. In the Files of type list, click Add-ins (*.mda).   
7. Browse to the folder that contains Utility.mda, select it, and then click Open. By default, this file is in the folder C:\Program Files\Microsoft Office\Office\1033.   
8. Click OK.   
9. On the Debug menu, click Compile **database name**.   
10. On the File menu, click **Close and Return to Microsoft Access**.   

## More information

### Steps to reproduce the behavior in Access 2002 or in Access 2003

> [!CAUTION]
> If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

1. Open the sample database Northwind.mdb.    
2. Open the Order Subtotals query in **Design view**.   
3. Rename the **OrderID** field to **OrderIDNumber**.   
4. Close the query, and then click Yes to save the changes.   
5. Run the Order Subtotals query.   

Note that the Enter Parameter Value dialog box appears.   
