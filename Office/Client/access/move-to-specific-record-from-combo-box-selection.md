---
title: Move to specific record from Combo Box selection
description: Describes how to programmatically move to a specific record from a Combo Box selection in Microsoft Access. This article assumes that you are familar with Visual Basic controls.
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
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to move to a specific record from a Combo Box selection in Microsoft Access

Moderate: Requires basic macro, coding, and interoperability skills. 

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

This article shows you four methods of moving to a specific record based on selection from a combo box. The methods are as follows: 

- In the AfterUpdate event of a combo box, execute code that uses the FindFirst method.   
- In the AfterUpdate event of a combo box, call a macro that requeries the **Filter** property of a form.   
- Use a Form/Subform, with a combo box on the main form, and the data in the subform, bound by the LinkMasterFields and LinkChildFields properties of the subform control.   
- Base the form on a query that joins two tables, and then use the AutoLookup technique to bind a combo box to the field that controls the join.   

These four methods are outlined in the "More Information" section of this article and are based on the Northwind sample database.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

> [!CAUTION]
> If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

The following table compares the features (benefits and drawbacks) of the four methods:

|Method                     | 1 | 2 | 3 | 4 |
|---------------------------|---|---|---|---|
|Requires no code/macros    |   |   | x |   |
|Subform is not required    | x | x |   |   |
|Can scroll to other records| x |   | x |   |
|Does not require a query   | x | x | x | x | 
|Can edit records           | x | x | x | x |
|Opens form in other modes  |   |   |   | x |

> [!NOTE]
> These methods can also apply to text boxes.

### Method 1

1. Create a table named Products that has the ProductID field and the ProductName field.
2. Use the **AutoForm: Columnar Wizard** to create a new form that is based on the Products table, and then save the form as frmComboTest.

   To do this in Microsoft Office Access 2003 and earlier versions of Access, follow these steps:

    1. In the **Database** window, click **Forms** under **Objects**.
    2. Click **New** on the Database window toolbar.
    3. In the **New Form** dialog box, click **AutoForm: Columnar**, select the Products table in the drop-down list, and then click **OK**.
    4. Save the form as frmComboTest.

   To do this in Microsoft Office Access 2007 or a later version, follow these steps:
 
    1. On the **Create** tab, click **Form Wizard** in the **Forms** group.
    2. In the **From Wizard** dialog box, select the Products table in the drop-down list.
    3. Select the fields that you want to see in the new form, and then click **Next**.
    4. Select the **Columnar** option to set the layout of the form, and then click **Next**.
    5. Type *frmComboTest* as the form title, and then click **Finish**.

3. Use the **Combo Box Wizard** to add an unbound combo box. To do this, follow these steps:

   1. Open the frmComboTest form in the Design view.
   2. In the toolbar, make sure that **Control Wizards** is selected.

   > [!NOTE]
   > In Access 2007 or a later version, make sure that **Use Control Wizards** is selected in the **Controls** group on the **Design** tab.

   3. Create a combo box on the frmComboTest form.

   > [!NOTE]
   > In Access 2007 or a later version, click **Combo Box** in the **Controls** group on the **Design** tab, and then click the frmComboTest form. In the **Choose Builder** dialog box, click **Combo Box Wizard**, and then click **OK**.

   4. In the **Combo Box Wizard** dialog box, select the **Find a record on my form based on the value I selected in my combo box** option, and then click **Next**.
   5. Select the ProductID and ProductName fields, and then click **Next**.
   6. Click **Finish**.

   The **Combo Box Wizard** creates an event procedure that is similar to the following:
    
   ```vb
   Private Sub Combo0_AfterUpdate()
        ' Find the record that matches the control.
        Dim rs As Object
    
    Set rs = Me.Recordset.Clone
        rs.FindFirst "[ProductID] = " & Str(Nz(Me![Combo20], 0))
        If Not rs.EOF Then Me.Bookmark = rs.Bookmark
   End Sub
   ```

4. View the frmComboTest form in the Form view. 

   Notice that when you choose a product name in the combo box, you are moved to the record for the product that you selected.

### Method 2

1. Create a new form based on the Products table by using the **AutoForm: Columnar Wizard** as instructed in the step 2 of method 1, and then save the form as frmComboTest2.
2. On the **Property Sheet** page of the frmComboTest2 form, set the **Filter** property on the **Data** tab to `[ProductName] = Forms![frmComboTest2]![cboLookup]`.
3. Add an unbound combo box named cboLookup, and then set the properties of the control as follows:

   ``` output
   Combo Box
   -----------------------------------------------------
   ControlName: cboLookup
   ControlSource: <leave blank>
   RowSourceType: Table/Query
   RowSource: Select [ProductName] from Products;
   BoundColumn: 1
   ColumnWidths: 1"
   AfterUpdate: mcrLocateProduct
   ```
4. Create the following macro named mcrLocateProduct: 

   ```output
   Action
   --------------------------------------
   SetValue
   Requery

   mcrLocateProduct Actions
   --------------------------------------
   SetValue
   Item: Forms![frmComboTest2].FilterOn
   Expression: True
   ```

   Notice that when you open the frmComboTest2 form and select a product name from the cboLookup combo box, the filter is set to that value.   

### Method 3

1. Create a new form based on the Products table by using the **AutoForm: Columnar Wizard** as instructed in the step 2 of method 1, and then save the form as frmSub.
2. On the **Property Sheet** page of the frmSub form, set the **Default View** property on the **Format** tab to **Single Form**.
3. Create a new form (that is not based on any table or query) and save it as frmMain. Then, add a combo box and set its properties as follows:

   ```output
   Combo Box
   ----------------------------
   ControlName: cboLookup
   ControlSource: <leave blank>
   RowSourceType: Table/Query
   RowSource: Products
   ColumnCount: 4
   ColumnWidths: 0";2"
   BoundColumn: 1
   ```

5. Insert a Subform control of the frmSub form. 
   
   - Go to **Design** > **Subform/Subreport**, and then cancel the SubForm Wizard.
   - Drag and drop the frmSub from the navigation pane into the frmMain form.

6. Set the subform control properties as follows:
   
   ```output
   Subform
   ----------------------------
   LinkChildFields: [ProductID]
   LinkMasterFields: cboLookup
   ```

   By changing the value in cboLookup control, Access ensures that the records in the subform match the combo box.

   The Orders form in the Northwind sample database illustrates this method. The Order Details subform is related by the **LinkMasterFields** and **LinkChildFields** properties. 

### Method 4: Use the OpenForm macro action with the WHERE clause

1. Create a new form based on the Products table by using the **AutoForm: Columnar Wizard** as instructed in the step 2 of method 1, and then save the form as frmComboTest5.
2. Add an unbound combo box named cboLookup, and then set the properties of the control as follows:

   ```output
   Combo Box
   -----------------------------------------------------
   ControlName: cboLookup
   ControlSource: <leave blank>
   RowSourceType: Table/Query
   RowSource: SELECT [ProductID], [ProductName] FROM Products ORDER BY [ProductName];
   BoundColumn: 1
   ColumnCount: 2
   ColumnWidths: 0";1"
   ```

4. In the Macro Builder, create a new embedded macro in the `AfterUpdate` event for the cboLookup combo box.
5. In the **Add New Action** drop-down list, select **OpenForm**, and then set the following properties:

   ```output
   Form Name:   frmComboTest5
   View:        Form
   Filter Name: <leave as empty>
   Where Condition: [ID] = [Forms]![frmComboTest5]![cboLookup].value
   Data Mode: <optional>
   Window Mode: <optional>
   ```

5. Save and close the macro.
6. Save and run the form.

After you change the value of the combo box, the form will be closed and opened again with a filter applied.
