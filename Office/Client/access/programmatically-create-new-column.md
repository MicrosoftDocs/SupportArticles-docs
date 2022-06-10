---
title: Create a new column programmatically in Access
description: Describes how to programmatically create a column in an Access report. Provides two methods to dynamically add the column to the report.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CI 162681
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# How to programmatically create a new column in an Access report

_Original KB number:_ &nbsp; 812719

## Summary

This article describes how to programmatically create a column in an Access report. You can dynamically add the column to the report by using either Method 1 or Method 2 that are described in the "More Information" section.

> [!NOTE]
> The sample code in this article uses Microsoft Data Access Objects. For this code to run properly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click **References** on the **Tools** menu in the Visual Basic Editor, and make sure that the **Microsoft DAO 3.6 Object Library** check box is selected.

## Method 1: Add Columns to the Report Programmatically

The example that follows shows you how to programmatically create an Access report. The code generates a report that is based on record source query. The generated report displays the **Firstname** column and the **Lastname** column of the **Employees** table of the Northwind.mdb sample database.

1. Start Access.
2. On the **Help** menu, click **Sample Databases**, and then click **Northwind Sample Database**.Close the **Main Switchboard** form when it appears.

   > [!NOTE]
   > In Access 2007, click **Sample** in the **Template Categories** pane, click **Northwind 2007**,and then click **Download**.

3. In the left pane, click **Reports**.

   > [!NOTE]
   > In Access 2007, skip this step.
4. In the right pane, double-click **Create report in Design View**.

   > [!NOTE]
   > In Access 2007, click **Report Design** in the **Reports** group on the **Create** tab.
5. On the **File** menu, click **Save**.

   > [!NOTE]
   > In Access 2007, click **Microsoft Office Button**, and then click **Save**.
6. In the **Save As** dialog box, type AccessColumnBuilder and then click **OK**.
7. Close the report.
8. In the left pane, select **Forms**.

   > [!NOTE]
   > In Access 2007, skip this step.
9. In the right pane, double-click **Create form in Design View**.

   > [!NOTE]
   > In Access 2007, click **Form Design** in the **Forms** group on the **Create** tab.
10. Add a command button to the form.

    > [!NOTE]
    > In Access 2007, click **Button** to add a button to the form in the **Controls** group on the **Design** tab.
11. Right-click the command button, click **Build Event**, click **Code Builder** in the **Choose Builder** dialog box, and then click **OK**.
12. Add the code that follows to the OnClick event of the command button:

    ```vb
    Dim txtNew As Access.TextBox
    Dim labNew As Access.Label
    Dim lngTop      As Long
    Dim lngLeft     As Long
    Dim lblCol    As  Long
    Dim rpt As Report
    Dim reportQuery As String
    Dim rs As DAO.Recordset
    Dim i As Integer
    Dim prevColwidth As long

    lngLeft = 0
    lngTop = 0

    ' Open the report to design.
    ' To make changes in the number of columns that appear at run time.

    DoCmd.OpenReport "AccessColumnBuilder", acViewDesign

    Set rpt = Reports![AccessColumnBuilder]

    ' Change the number of columns required as per your requirement.
    reportQuery = "SELECT FirstName, LastName FROM Employees"

    ' Open the recordset.
    Set rs = CodeDb().OpenRecordset(reportQuery)
    ' Assign the query as a record source to report control.
    rpt.RecordSource = reportQuery

    ' Set the value to zero so that the left margin is initialized.
    prevColwidth = 0
    lblCol = 0
    ' Print the page header for the report.
    For i = 0 To rs.Fields.Count - 1
    Set labNew = CreateReportControl(rpt.Name, acLabel, acPageHeader, _
      , rs.Fields(i).Name, lblcol, , , lngTop)
      labNew.SizeToFit
      lblCol = lblCol + 600 + labNew.Width
    Next

    ' Create the column depending on the number of fields selected in reportQuery.
    ' Assign the column value to new created column.
    For i = 0 To rs.Fields.Count - 1
      ' Create new text box control and size to fit data.
      Set txtNew = CreateReportControl(rpt.Name, acTextBox, _
         acDetail, , , lngLeft + 15 + prevColwidth, lngTop)
      txtNew.SizeToFit
      txtNew.ControlSource = rs(i).Name
      ' Modify the left margin depending on the number of columns
      ' and the size of each column.
      prevColwidth = prevColwidth + txtNew.width
    Next
    'To save the modification to the report,  uncomment the following line of code:
    'DoCmd.Save
    ' View the generated report.
    DoCmd.OpenReport "AccessColumnBuilder", acViewPreview

    ' This opens the report in preview.
    ```

13. Save and then run the form.
14. To preview the report, click the command button that you added in step 10.

    The records that follow appear on the first page:

    ```console
    First NameLast Name

    NancyDavolio

    MargaretPeacock

    ...............
    ```

    The report contains the **Firstname** column and the **Lastname** column of the **Employees** table. You can either save the report or make the required changes to the query and then run the report.

## Method 2: Add columns to the report at run time by setting the visible property of the existing column

This example shows you how to display a new column in a report by manipulating the Visible property of the control.

The report contains four columns. The `Visible` property of the first three columns is set to **yes**. The `Visible` property of the fourth column is set to **no**. On a page break, the `Visible` property of the fourth column is set to **yes** when the column appears.

1. Start Access.
2. On the **Help** menu, click **Sample Databases**, and then click **Northwind Sample Database**. Close the **Main Switchboard** form when it appears.

   > [!NOTE]
   > In Access 2007, click **Sample** in the **Template Categories** pane, click **Northwind 2007**, and then click **Download**.
3. To create a report that is named **Report1** and is based on the **Products** table, follow these steps:

   1. In the **Database** window, click **Reports** and then click **New**.

      > [!NOTE]
      > In Access 2007, click **Report Wizard** in the **Reports** group on the **Create** tab.

   2. In the **New Report** dialog box, click **Design View**, select **Products**, and then click **OK**.
   3. Add the following text boxes to the **Detail** section of the report. Align the text boxes.
   4. Put the corresponding labels in the **Page Header** section of the report. Align the labels.
      
      ```console
      Report: Report1
      --------------------------
      Caption: TestReport
      ControlSource: Products

      Label:
         Name: ProductName_label

      Text Box:
         Name: ProductName
         ControlSource: ProductName

      Label:
         Name: UnitPrice_label

      Text Box:
         Name: UnitPrice
         ControlSource: UnitPrice

      Label:
         Name: UnitsInStock_label

      Text Box:
         Name: UnitsInStock
         ControlSource: UnitsInStock

      Label:
         Name: TotalPrice_label
         Visible: No

      Text Box:
         Name:  TotalPrice
         ControlSource:  =[UnitPrice] * [UnitsInStock]
         Visible: No
      ```

4. Add a text box control with the following properties to the **Detail** section. Put the text box directly above the **ProductName** control.

   This control acts as a counter for the number of records in the report.

   ```console
   Text Box:
   -----------------------
   Name: Counter
   ControlSource: =1
   Visible: No
   RunningSum: Over All
   ```

5. On the **Toolbox**, click **Page Break**.

   > [!NOTE]
   > In Access 2007, click **Add or Remove Page Break** in the **Controls** group on the **Design** tab.
6. Add a page break control to the lower-left corner of the **Detail** section. Put the page break control directly below the **ProductName** control. Set the **Name** property to **PageBreak**.
7. In the **Detail** section, set the **OnFormat** property to the following event procedure:

   ```console
   If Me![Counter] Mod 2 = 0 Then Me![PageBreak].Visible = True _
   Else Me![PageBreak].Visible = False
   ```

8. To reduce the blank space in the report, put your pointer between the bottom of the **Detail** section and the **Page Footer** and then drag up.
9. In the **Page Footer** section, set the **OnPrint** property to the event procedure that follows:

   ```console
   If Me![PageBreak].Visible = True Then
    Me![TotalPrice].Visible = True
    Me![TotalPrice_label].Visible = True
   Else
    Me![TotalPrice].Visible = False
    Me![TotalPrice_label].Visible = False
   End If
   ```
   When **PageBreak** occurs, the **TotalPrice** column appears.
   
10. Preview the report. The records that follow appear on the first page:

    ```console
    Product NameUnit PriceUnit in Stock

    Cahi$18.0039

    Chang$19.0017
    ```

    > [!NOTE]
    > The first page of the report contains three columns.

    The records that follow appear on the second page:

    ```console
    Product NameUnit PriceUnit in StockTotal Amount

    Aniseed Syrup $10.0013    130

    Chef A...    $22.00 53    1166
    ```

    > [!NOTE]
    > The page break occurs after the first page. Therefore, the second page of the report contains four columns.

## References

For more information about how to programmatically create an Access report, visit the following article:

[Create a simple report](https://support.microsoft.com/office/create-a-simple-report-408e92a8-11a4-418d-a378-7f1d99c25304)
