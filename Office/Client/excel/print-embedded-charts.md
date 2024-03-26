---
title: Programmatically print all embedded charts on a worksheet
description: Describes how to print all embedded charts on a worksheet programmatically.
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
  - Excel 2000
ms.date: 03/31/2022
---

# Print all embedded charts programmatically on a worksheet in Excel

In Microsoft Excel, you can create a Microsoft Visual Basic for Applications macro that prints all embedded charts in an Excel worksheet. Each chart is printed on a separate page.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To create a sample macro that can print all the embedded charts in a worksheet and print each chart to a separate page, follow these steps:

1. Start Excel, and then open the workbook containing the worksheet with the embedded charts.   
2. Press ALT+F11 to start the Visual Basic Editor.   
3. On the Insert menu, click Module.
4. In the module sheet, type or paste the following code:

    ```vb
    Sub PrintEmbeddedCharts()
         Dim ChartList As Integer
         Dim X As Integer
         ' Variable chartlist stores a count of all embedded charts.
         ChartList = ActiveSheet.ChartObjects.Count
         ' Increments the counter variable 'X' in a loop.
         For X = 1 To ChartList
             ' Selects the chart object.
             ActiveSheet.ChartObjects(X).Select
             ' Makes chart active.
             ActiveSheet.ChartObjects(X).Activate
             ' Prints one copy of active chart.
             ActiveChart.PrintOut Copies:=1
         Next
    End Sub
    ```

5. On the File menu, click **Close and Return to Microsoft Excel**.   
6. Select the worksheet that contains the embedded charts.   
7. on the Tools menu, point to Macro, and then click Macros.    
8. In the **Macro name** list, click PrintEmbeddedCharts, and then click Run.   
