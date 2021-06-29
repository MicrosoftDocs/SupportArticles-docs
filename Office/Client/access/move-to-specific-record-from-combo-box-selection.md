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
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: luche
appliesto:
- Access 2007
- Access 2003
- Access 2002
---

# How to move to a specific record from a Combo Box selection in Microsoft Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

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

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.CAUTION: If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

The following table compares the features (benefits and drawbacks) of the four methods:

|Method | 1|  2 |3| 4|
|---|---------|---------|----------|-----------------|
|Requires no code/macros|  |   | x |x|
|Saves on subforms| x |x |  |x |
|Can scroll to other records| x |  |x |x |
|Does not require a query| x |x |x|  |
|Can edit records| x |x |x|  |

**Note** These methods can also apply to text boxes.

### Method 1

1. Use the AutoForm: Columnar Wizard to create a new form that is based on the Products table, and then save the form as
frmComboTest.

   To do this in Microsoft Office Access 2003 and earlier versions of Access, follow these steps:
    1. In the Database window, click **Forms** under **Objects**.   
    2. Click **New** on the Database window toolbar.   
    3. In the **New Form** dialog box, click **AutoForm: Columnar**, select **Products** in the drop-down list, and then click **OK**.   
    4. Save the form as frmComboTest.   

    To do this in Microsoft Office Access 2007 or a later version, follow these steps:
    1. On the **Create** tab, click **More Forms** in the **Forms** group, and then click **Form Wizard**.   
    2. In the **New Form** dialog box, click **Form Wizard**, select the **Products** in the drop-down list, and then click **OK**.   
    3. In the **Form Wizard** dialog box, select the fields that you want to see in the new form, select the **Columnar** option to set the layout of the form, and then click **Finish**.   
    4. Save the form as frmComboTest.   
2. Use the Combo Box Wizard to add an unbound combo box. To do this, follow these steps: 
   1. Open the frmComboTest form in the Design view.   
   2. In the toolbar, make sure that **Control Wizards** is selected.

       **Note** In Access 2007 or a later version, make sure that **Control Wizards** is selected in the **Controls** group on the **Design** tab.   
   3. In the toolbar, click **Combo Box**, and then click on the **frmComboTest** form.

      **Note** In Access 2007 or a later version, click **Combo Box** in the **Controls** group on the **Design** tab, and then click the **frmComboTest** form. In the **Choose Builder** dialog box, click **Combo Box Wizard**, and then click **OK**.
   4. In the **Combo Box Wizard** dialog box, select the **Find a record on my form based on the value I selected in my combo box** option, and then click **Next**.   
   5. Include the **ProductID** and **ProductName** fields, and then click **Next**.   
   6. Click **Finish**.   

   The Combo Box Wizard creates an event procedure similar to the following:
    
   ```vb
   Private Sub Combo0_AfterUpdate()
        ' Find the record that matches the control.
        Dim rs As Object
    
    Set rs = Me.Recordset.Clone
        rs.FindFirst "[ProductID] = " & Str(Nz(Me![Combo20], 0))
        If Not rs.EOF Then Me.Bookmark = rs.Bookmark
   End Sub
   ```
3. View the frmComboTest form in Form view. 

   Notice that when you choose a product name in the combo box, you are moved to the record for the product that you selected.   

### Method 2

1. Use the AutoForm: Columnar Wizard to create a new form that is based on the Products table, and save the form as frmComboTest2.

   **Note** See the steps that are mentioned in the step 1 of Method 1.   
2. In the property sheet for the **frmComboTest2** form, set the **Filter** property on the **Data** tab as follows:[ProductName] = Forms![frmComboTest2]![cboLookup]
3. Add an unbound combo box named cboLookup, and then set the properties of the control as follows:

   ``` adoc
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

   ```adoc
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

   Notice that when you open the frmComboTest2 form and select a product name from the **cboLookup** combo box, the filter is set to that value.   

### Method 3

1. Create a new form that is not based on any table or query and save it as frmMain. Then add a combo box and set its properties as follows:

   ```adoc
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

2. Use the AutoForm: Tabular Wizard to create a second form that is based on the Products table, set the **DefaultView** property of the form to **Single Form**, and then save the form as frmSub.   
3. Use the frmSub form to create a subform control on the frmMain form.   
4. Set the subform control properties as follows:
   
   ```adoc
   Subform
   ----------------------------
   LinkChildFields: [ProductID]
   LinkMasterFields: cboLookup
   ```

   By changing the value in cboLookup control, Access ensures that the records in the subform match the combo box.

   The Orders form in the Northwind sample database illustrates this method. The Order Details subform is related by the **LinkMasterFields** and **LinkChildFields** properties.    

### Method 4

1. Create a table named tblProductSelect that has a single field, **ProductID**. Set the **Data Type** property of the field to Number and set the **Field Size** property to Long Integer. 

   **Note** A primary key is not necessary. Do not add records to this table.   
2. Create the following query named qryProductSelect that is based on a join between the **ProductID** fields of the tblProductSelect and Products tables. Include the following attributes in the query:
 
   ```adoc
   Query: qryProductSelect
   -----------------------------------------------
   Field: ProductID
   Table Name: tblProductSelect

   Field: <any other fields you are interested in>
   TableName: Products
   ```

3. Use the AutoForm: Columnar Wizard to create a form that is based on the qryProductSelect query, and then view the form in Form view.   
4. Right-click the text box control for the **ProductID** field, point to **Change To**, click **Combo Box**, and then make the following property assignments for this combo box:
   ```adoc
   Combo Box
   --------------------------
   ControlName: ProductID
   ControlSource: ProductID
   RowSourceType: Table/Query
   RowSource: Products
   ColumnCount: 1
   ColumnWidths: 2"
   BoundColumn: 1
   ```
5. Save the form as frmComboTest3, and then run the form.   
