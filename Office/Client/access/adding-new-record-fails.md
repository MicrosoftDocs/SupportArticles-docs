---
title: Unable to add a new record programmatically
description: Fixes an issue in which you receive an error message if you try to add a new record to a table by using the NotInList event of the combo box on a form.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# "The text you entered isn't an item in the list" error when you add a new record to a table

_Original KB number:_ &nbsp; 824176

> [!NOTE]
> This article applies only to a Microsoft Access database (.mdb). Requires basic macro, coding, and interoperability skills.

## Symptoms

When you try to programmatically add a new record to a table by using the NotInList event of the combo box on a form, you might receive the following error message:

> The text you entered isn't an item in the list.<br/>
> Select an item from the list, or type the text that matches one of the listed items.

However, the new record is successfully added to the table. As a result, the new item that you entered is added to the list of items in the combo box.

## Cause

This problem occurs when the combo box is bound to a Number data type column and the format property for the column is set to **Currency** or to **Euro**.

## Workaround

To work around this problem, type the value in the combo box that matches the format of the column that the combo box is bound to. For example, if the format of the column is **Currency**, type $20 instead of 20.

However, if the format of the column is set to **Euro**, you might not be able to enter a number that matches the format of the column.

> [!NOTE]
> If you reset the **Format** property of the column, the problem does not occur.

## More Information

You might also receive the error message when you type a number that corresponds to an item in the combo box that already exists. This problem might occur if the number that you type does not match the formatted entries of the underlying recordset that already exists.

### Steps to reproduce the behavior in Microsoft Office Access 2003

1. Start Microsoft Access.
2. Create a new Db1.mdb database.
3. To create the required sample table, follow these steps:

   1. In the Database window, click **Tables** under **Objects**.
   2. In the right pane, double-click **Create table in Design view**.
   3. In the first row of the **Field Name** column, typeID, and then set the corresponding **Data Type** to **AutoNumber**.
   4. In the second row of the **Field Name** column, typeRates, and then set the corresponding **Data Type** to **Number**.
   5. In the **Field Properties** pane, click the **General** tab.
   6. Set the **Format** property to **Currency**.
   7. On the **File** menu, click **Save**.
   8. In the **Save As** dialog box, type Rates, and then click **OK**.
   9. On the **File** menu, click **Close**.
4. In the Database window, click **Forms** under **Objects**.
5. In the right pane, double-click **Create form in Design view**.
6. Add a **ComboTest** combo box to the form, and then set the properties as follows:
   
   |Property|Value|
   |---|---|
   |Name:|ComboTest|
   |Bound Column:|1|
   |RowSourceType:|Table/Query|
   |Row Source:|SELECT Rates.ID, Rates.Rates FROM Rates;|
   |Auto Expand:|Yes|
   |Limit to List:|Yes|
   |Column Count:|2|
   |Column Widths:|0";1"|

7. On the **View** menu, click **Code** to open the Microsoft Visual Basic Editor.
8. Paste the following code in the **NotInList** event of the **ComboTest** combo box.

   > [!NOTE]
   > The sample code in this article uses Microsoft Data Access Objects. For this code to run correctly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click **References** on the **Tools** menu in the Visual Basic Editor, and make sure that the **Microsoft DAO 3.6 Object Library** check box is selected.

   ```vb
   Dim Db As DAO.Database
   Dim Rs As DAO.Recordset
   Dim Msg As String

       Msg = "'" & NewData & "' is not in the list." & vbCr & vbCr
       Msg = Msg & "Do you want to add it?"
       If MsgBox(Msg, vbQuestion + vbYesNo) = vbNo Then
           Response = acDataErrContinue
          MsgBox "Try again."
       Else
           Set Db = CurrentDb
           Set Rs = Db.OpenRecordset("Rates", dbOpenDynaset)

           Rs.AddNew
           Rs![Rates] = NewData
           Rs.Update
           Response = acDataErrAdded

       End If
   ```

9. On the **File** menu, click **Save**.
10. In the **Save As** dialog box, type FormTest, and then click **OK**.
11. On the **File** menu, click **Close**.
12. In the right pane of the Database window, double-click **FormTest**.
13. Type a number in the combo box, and then press the ENTER key.

    The **NotInList** event is triggered. You receive the error message that is mentioned in the "Symptoms" section of this article.

## References

For more information about the NotInList event, click **Microsoft Access Help** on the **Help** menu, type *NotInList Event* in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.
