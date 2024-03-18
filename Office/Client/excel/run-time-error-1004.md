---
title: Unable to make changes to legend entries in a chart in Excel
description: Explains that you may receive a runtime error message when you use a VBA macro to change legend entries in an Excel chart. You must reduce the font size of the chart legend text before you change the legend entries.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# "Run-time Error 1004" when you make changes to legend entries in a chart in Excel

## Symptoms

When you run a Microsoft Visual Basic for Applications (VBA) macro that uses the LegendEntries method to make changes to legend entries in a Microsoft Excel chart, you may receive the following error message:

**Run-time error '1004': Application or object-defined error**

## Cause

This behavior occurs when the Excel chart contains more legend entries than there is space available to display the legend entries on the Excel chart. When this behavior occurs, Microsoft Excel may truncate the legend entries.

Because the LegendEntries method in your VBA macro uses what appears for the legend (in this case, the truncated legend entries), the error message that is mentioned in the "Symptoms" section of this article occurs when there are more entries than there is space available to display the legend entries on the Excel chart.

## Workaround

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs.

For more information about the support options that are available and about how to contact Microsoft, visit the following Microsoft Web site:

[https://support.microsoft.com](https://support.microsoft.com/)

To work around this behavior, create a macro that reduces the font size of the Excel chart legend text before your VBA macro makes changes to the chart legend and then restore the font size of the chart legend so that it is similar to the following macro example.

> [!NOTE]
> You must have an Excel chart on your worksheet for this macro to run correctly.

```vb
Sub ResizeLegendEntries()

With Worksheets("Sheet1").ChartObjects(1).Activate
      ' Store the current font size
      fntSZ = ActiveChart.Legend.Font.Size

'Temporarily change the font size.
      ActiveChart.Legend.Font.Size = 2

'Place your LegendEntries macro code here to make
         'the changes that you want to the chart legend.

' Restore the font size.
      ActiveChart.Legend.Font.Size = fntSZ
   End With

End Sub
```