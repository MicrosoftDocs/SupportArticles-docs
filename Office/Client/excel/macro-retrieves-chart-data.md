---
title: Macro to extract data from a chart in Excel
description: Provides a macro to extract data from a chart in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2002
ms.date: 03/31/2022
---

# Macro to extract data from a chart in Excel

## Summary

In Microsoft Excel, you can retrieve data from a chart even when the data is in an external worksheet or workbook. This is useful in situations where the chart was created from, or linked to, another file that is unavailable or has been damaged in some way. When the source data to a chart is lost, the data can still be retrieved from the chart itself, by using a Microsoft Visual Basic for Applications macro.

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

The following sample macro places the chart's source data in a worksheet called "ChartData" in the active workbook, beginning in the first column and first row.

1. Enter the following macro code in a module sheet:

   ```vb
   Sub GetChartValues()
      Dim NumberOfRows As Integer
      Dim X As Object
      Counter = 2

      ' Calculate the number of rows of data.
      NumberOfRows = UBound(ActiveChart.SeriesCollection(1).Values)

      Worksheets("ChartData").Cells(1, 1) = "X Values"

      ' Write x-axis values to worksheet.
      With Worksheets("ChartData")
         .Range(.Cells(2, 1), _
         .Cells(NumberOfRows + 1, 1)) = _
         Application.Transpose(ActiveChart.SeriesCollection(1).XValues)
      End With

      ' Loop through all series in the chart and write their values to
      ' the worksheet.
      For Each X In ActiveChart.SeriesCollection
         Worksheets("ChartData").Cells(1, Counter) = X.Name

         With Worksheets("ChartData")
            .Range(.Cells(2, Counter), _
            .Cells(NumberOfRows + 1, Counter)) = _
            Application.Transpose(X.Values)
         End With

         Counter = Counter + 1
      Next

   End Sub
   ```

2. Insert a new worksheet into your workbook and rename it to "ChartData" (without the quotation marks).
3. Select the chart from which you want to extract the underlying data values.

   > [!NOTE]
   > The chart can either be embedded on a worksheet or on a separate chart sheet.

4. Run the GetChartValues macro.

   The data from the chart is placed in the "ChartData" worksheet.

### Steps to Link the Chart to the Recovered Data

To have the chart be interactive with the recovered data, you need to link the chart to the new data sheet rather than retain the links to the missing or damaged workbook.

1. Select the chart, and click a series to find the sheet name to which the chart is linked in the damaged or missing workbook. The sheet name appears in the series formula in the formula bar.
   
   > [!NOTE]
   > The sheet name may follow the workbook name, which is enclosed in square brackets such as "[Book1]," and precede the exclamation point "!" (or apostrophe and exclamation point "'!") that indicates the beginning of a cell reference. The sheet name includes only the characters between the closed square bracket symbol "]" and the exclamation point (or apostrophe and exclamation point). Leave out any apostrophe if it is immediately before the exclamation mark, because an apostrophe can not be the last character in a sheet name.

2. Double-click the tab of the new sheet called ChartData.
3. Type the original sheet name from step 1 over the highlighted "ChartData" and press ENTER. This name must be the same as the sheet name from the damaged or missing workbook.
4. If you have not saved this file with the chart and data sheet, save the file.
5. In Excel 2003 or Excel 2002, click Links on the Edit menu, and then click Change Source.

    In Excel 2007, click the **Data** tab, click **Edit Links** in the **Connenctions** group, and then click **Change Source**.
6. In the Source File box, select the link to change, and then click Change Source.
7. In the Change Links dialog box, select the new file with the recovered data and chart, and then click OK.
8. If you receive the following error message

   **Your formula contains an invalid external reference to a worksheet.**

   it is likely that the sheet name that you typed in step 3 is not the same as the original. Go back to step 1.

9. The Source File box may now be blank. This indicates that all links point to the active file rather than the missing or damaged file. Click Close.

The chart now references and interacts with the recovered data on the renamed sheet in the active workbook.