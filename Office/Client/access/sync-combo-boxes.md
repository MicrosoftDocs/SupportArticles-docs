---
title: Synchronize two combo boxes
description: Explains that the AfterUpdate property runs an event procedure when you select a category in the first combo box. This sets the RowSource property of the second combo box to make sure that it changes. Both combo boxes are now synchronized.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: tado
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# How to synchronize two combo boxes on a form in Microsoft Access

This article describes the AfterUpdate property runs an event procedure when you select a category in the first combo box.

_Original KB number:_ &nbsp; 289670

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies to a Microsoft Access database (.mdb/.accdb) and to a Microsoft Access project (.adp).

## Summary

This article describes how to synchronize two combo boxes so that when you select an item in the first combo box, the selection limits the choices in the second combo box.

> [!NOTE]
> This article explains a technique that is demonstrated in the sample file, FrmSmp00.mdb.

## More Information

The following example uses the sample database Northwind.mdb. The first combo box lists the available product categories, and the second combo box lists the available products for the category selected in the first combo box:

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

1. Open the sample database Northwind.mdb.
2. Create a new form that is not based on any table or query with the following combo boxes, and then save the form as Categories And Products.

   ```console
   Combo Box 1
   -------------------------------
   Name:          Categories
   RowSourceType: Table/Query
   RowSource:     Categories
   ColumnCount:   2
   ColumnWidths:  0";1"
   BoundColumn:   1
   AfterUpdate:   [Event Procedure]

   Combo Box 2
   --------------------------
   Name:          Products
   RowSourceType: Table/Query
   ColumnWidths:  2"
   Width:         2"
   ```

   > [!NOTE]
   > If you are in an Access project, the `RowSourceType` will be Table/View/StoredProc.

3. Add the following code to the AfterUpdate event procedure of the Categories combo box:

   ```vb
   Me.Products.RowSource = "SELECT ProductName FROM" & _
      " Products WHERE CategoryID = " & Me.Categories & _
      " ORDER BY ProductName"
   Me.Products = Me.Products.ItemData(0)
   ```

4. View the Categories And Products form in Form view.

   > [!NOTE]
   > When you select a category in the first combo box, the second combo box is updated to list only the available products for the selected category.

### Notes

In this example, the second combo box is filled with the results of an SQL statement. This SQL statement finds all the products that have a CategoryID that matches the category that is selected in the first combo box.

Whenever a category is selected in the first combo box, the `AfterUpdate` property runs the event procedure, which sets the second combo box's `RowSource` property. This refreshes the list of available products in the second combo box. Without this procedure, the contents of the second combo box would not change.
