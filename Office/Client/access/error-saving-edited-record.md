---
title: Can't edit a record in a form that's based on a multi-table view
description: Workarounds a problem that may occur in a multi-user environment when more than one user tries to access the same record at the same time in a multi-table view.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: wadejack
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# "This record has been changed by another user" error when you save an edited record in Access

_Original KB number:_ &nbsp; 837937

> [!NOTE]
> This article applies only to a Microsoft Access project (.adp). Requires basic macro, coding, and interoperability skills.

## Symptoms

When you edit a record in a form that is based on a multi-table view, and you are working in a multi-user environment, you may be unsuccessful when you try to save the changes to the record. You may also receive the following error message in the **Write Conflict** dialog box:

> This record has been changed by another user since you started editing it. If you save the record, you will overwrite the changes the other user made.<br/>
> Copying the changes to the clipboard will let you look at the values the other user entered, and then paste your changes back in if you decide to make the changes.

If you click either **Copy to Clipboard** or **Drop Changes** in the **Write Conflict** dialog box, you may notice that the changes that you made to the record are undone, and that the changes to the record that were made by the other user are now visible. However, if you edit the same record again, and you try to save the record, you may receive the error message that is mentioned in the "Symptoms" section again.

You may also notice the error message that is mentioned in the "Symptoms" section intermittently when you click **Save Record**.

> [!NOTE]
> You may not see this behavior when you use Microsoft Access 2000.

## Workaround

To work around this problem, use one of the following methods:

- Update the form that is based on the multi-table view

  On the first occurrence of the error message that is mentioned in the "Symptoms" section, you must click either **Copy to Clipboard** or **Drop Changes** in the **Write Conflict** dialog box. To avoid the repeated occurrence of the error message that is mentioned in the "Symptoms" section, you must update the recordset in the form before you edit the same record again.

  Notes
  - To update the form in Access 2003 or in Access 2002, click **Refresh** on the **Records** menu.
  - To update the form in Access 2007, click **Refresh All** in the **Records** group on the **Home** tab.

- Use a main form with a linked subform

  To avoid the repeated occurrence of the error message that is mentioned in the "Symptoms" section, you can use a main form with a linked subform to enter data in the related tables. You can enter records in both tables from one location without using a form that is based on the multi-table view.

  To create a main form with a linked subform, follow these steps:

  1. Create a new form that is based on the related (child) table that is used in the multi-table view. Include the required fields on the form.
  2. Save the form, and then close the form.
  3. Create a new form that is based on the primary table that is used in the multi-table view. Include the required fields on the form.
  4. In the Database window, add the form that you saved in step 2 to the main form.

     This creates a subform.

  5. Set the **Link Child Fields** property and the **Link Master Fields** property of the subform to the name of the field or fields that are used to link the tables.

## Status

Microsoft has confirmed that this is a bug in the Microsoft products that are listed in the "Applies to" section.

## More Information

In a multi-user environment, Microsoft Access project (.adp) uses a technique that is named
*optimistic record locking* to handle record contention. Therefore, when more than one user is working with the same record at the same time, one of the users may receive the error message that is mentioned in the "Symptoms" section. However, the error message that is mentioned in the "Symptoms" section may also intermittently appear when all the following conditions are true:

- The form is based on a multi-table view.
- The multi-table view is based on the tables that are involved in a parent-child relationship.
- The record that is being edited has been changed and committed by another user since you began editing the record.

You may notice that the same problem occurs when you use the multi-table view directly in a multi-user environment.

### Steps to reproduce the problem

1. Start Access.
2. Open the NorthwindCS.adp sample database project.
3. In the Database window, click **Queries** in the **Objects** section.
  
   > [!NOTE]
   > In Access 2007, click **Query Wizard** in the **Other** group on the **Create** tab.

4. In the right pane, double-click **Create view in designer**.

   > [!NOTE]
   > In Access 2007, in the **New Query** dialog box, click **Design View**, and then click **OK**.

5. In the **Add Table** dialog box, double-click both **Orders** and **Order Details** on the **Tables** tab, and then click **Close**.
6. Type or paste the following query in the SQL pane:

   ```
   SELECT     
   dbo.Orders.OrderID, 
   dbo.[Order Details].ProductID, 
   dbo.[Order Details].Quantity, 
   dbo.Orders.ShipName
   FROM         
   dbo.Orders 
   INNER JOIN
   dbo.[Order Details] 
   ON 
   dbo.Orders.OrderID = dbo.[Order Details].OrderID
   ```

   Notes
   > [!NOTE]
   > - In Access 2003 or in Access 2002, if the SQL pane is not visible, point to **Show Panes** on the **View** menu, and then click **SQL**.
   > - In Access 2007, on the **Design** tab, click **SQL** in the **Tools** group to open the SQL pane.
7. Save the view asOrderView.
8. On the **View** menu, click **Datasheet View**.

   > [!NOTE]
   > In Access 2007, on the **Design** tab, click the arrow under **View**, and then click **Datasheet View**.
9. Edit a record in the OrderView view.

   > [!NOTE]
   > Make sure that the record has not been saved.
10. Open another instance of the NorthwindCS.adp sample database project.
11. Edit the same record that you edited in step 9.
12. On the **Records** menu, click **Save Record**.

    > [!NOTE]
    > In Access 2007, click **Microsoft Office Button**, and then click **Save**.

    You may receive the error message that is mentioned in the "Symptoms" section.
