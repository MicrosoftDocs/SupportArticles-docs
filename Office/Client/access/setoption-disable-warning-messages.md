---
title: Use SetOption to disable warning messages
description: Describes how to use the Application.SetOption method to disable warning messages in an Access application.
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
ms.reviewer: REBC
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to use SetOption to disable warning messages in an Access Application

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies only to a Microsoft Access database (.mdb or .accdb).

## Summary

This article shows you how to use the Application.SetOption method to disable warning messages in an Access application.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.Action queries and other processes that append, delete, or modify data typically present the user with a warning that the data is about to be modified. In a run-time application, however, it is often desirable to disable the warnings because checks and precautions are usually beyond the user's control.

You can accomplish this by using the SetWarnings method of the DoCmd object, but you may prefer to disable warnings for the entire application. To do that, you can use the SetOption method of the Application object. However, if you do so, you should also turn the warnings back on as the application quits.

To do this in a simple, one-form application, follow these steps:

1. Start Access, and then create a blank database named TestRun.   
2. Import the Customers table from the Northwind.mdb sample database.   
3. Create a new form in Design view, and then add an unbound combo box to the detail section.   
4. Set the following properties for the combo box:

    ```adoc
    Name: cboCountry
    Row Source: SELECT DISTINCT Customers.Country FROM Customers ORDER BY Customers.Country; 
    ```
5. Add a command button to the detail section of the form and name it cmdDelete.   
6. Set the OnClick property of the command button to the following event procedure:

   **DoCmd.OpenQuery "qryDeleteCustomers"**

7. Close the Visual Basic Editor.   
8. Save the form as DeleteCustomers, and then close it.   
9. Create a new query in Design view, and then add the Customers table.   
10. In Access 2002 or in Access 2003, click **Delete Query** on the **Query** menu.

    In Access 2007, click **Delete** in the **Query Type** group on the **Design** tab.   
11. Drag the asterisk (*) from the field list to the first column of the query design grid, and then drag the Country field to the second column.   
12. In the Criteria row of the Country column, type the following:
 
    **Forms![DeleteCustomers]![cboCountry]** 

13. Save the query as qryDeleteCustomers, and then close it.   
14. Open the DeleteCustomers form in Form view.   
15. Select a country from the combo box, click the command button, and note the warning that appears. Click No in the warning dialog box.   
16. Open the form in Design view, and then on the toolbar, click the Code button.   
17. In the Code window, type or paste the following procedures:
```vb
Private Sub Form_Load()

Application.SetOption "Confirm Action Queries", 0
   Application.SetOption "Confirm Document Deletions", 0
   Application.SetOption "Confirm Record Changes", 0

End Sub

Private Sub Form_Unload(Cancel As Integer)

Application.SetOption "Confirm Action Queries", 1
    Application.SetOption "Confirm Document Deletions", 1
    Application.SetOption "Confirm Record Changes", 1

End Sub

```

18. Close the Visual Basic Editor, and then save and close the form.   
19. Open the DeleteCustomers form, select a country, and then click the command button.

    **Note** that no warning dialog appears.   

In this example, the application's confirm options are disabled when the DeleteCustomers form is loaded and re-enabled when it is unloaded. In a more elaborate application, you might carry out the same actions in a startup form or switchboard.
