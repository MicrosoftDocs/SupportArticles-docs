---
title: Unexpected behavior when using different print quality for Excel sheets
description: Provides a workaround for unexpected behavior when you use different print quality for sheets in Excel.
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
  - Excel 97
ms.date: 03/31/2022
---

# Unexpected behavior when you use different print quality for sheets in Excel

## Symptoms

When you print multiple worksheets in Microsoft Excel, multiple print jobs may be generated. This may cause the following behavior to occur:

- If you are printing to a file, only some of the sheets are printed to the file; remaining sheets are printed to your printer.
- If you are printing to a file, you may be prompted to enter the name of the output file multiple times.

  As a result, more than one output file is generated. Each file contains part of the complete printout.

- If you are using a Microsoft Visual Basic for Applications macro to print the sheets, the macro may fail because there are multiple requests for names for the output files.
- If you are printing to a network printer that is heavily used, your print jobs may be mixed in with other users' print jobs.

## Cause

This behavior occurs if you use different print quality settings to print the worksheets. When you print multiple worksheets in Microsoft Excel, each change in the print quality setting forces Microsoft Excel to create a new print job using that print quality setting.

> [!NOTE]
> This behavior does not occur when you print the same worksheets in earlier versions of Microsoft Excel.

## Workaround

To work around this behavior, make sure that all of the worksheets you are printing use the same print quality settings. You can do this manually or you can use a Visual Basic macro to change the print quality.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.The following Visual Basic macro ensures that all worksheets in a workbook use the same print quality settings:

```vb
   Sub SetPrintQuality()

For Each xSheet In ActiveWorkbook.Sheets
           xSheet.PageSetup.PrintQuality = 600
       Next xSheet

End Sub
```

This macro assumes that your printer is capable of printing at 600 dots per inch (dpi). If your printer cannot print at this resolution, change the value in the third line of the macro to an appropriate value for your printer (for example, 150, 300, 600, or 1200).

After you run this macro, all of the worksheets use the same print quality setting, and the behavior no longer occurs.

## Status

This behavior is by design.

## More information

The following steps demonstrate the behavior:

1. Create a new workbook that contains three worksheets, for example, Sheet1, Sheet2, and Sheet3.
2. In each worksheet, enter the following values:

   Sheet1:

   A1: Sheet1 - 300 DPI

   Sheet2:

   A1: Sheet2 - 600 DPI

   Sheet3:

   A1: Sheet3 - 300 DPI

3. Click Sheet1. On the **File** menu, click **Page Setup**, and then click the **Page** tab. In the **Print Quality** list, click "300 dpi" and click **OK**.

4. Repeat step 3 for Sheet2 and Sheet3, setting the **Print Quality** to "600 dpi" and "300 dpi" respectively.

   Note that each worksheet uses a different print quality than the worksheet that precedes it.

5. Right-click the sheet tab for Sheet1. On the shortcut menu, click **Select All Sheets**.

6. On the **File** menu, click **Print**. In the **Printer** section of the Print dialog box, click to select the **Print To File** check box. Then, click **OK**.

The following behavior may occur:

- If you are using a printer driver that is connected to the FILE: port, the Print To File dialog box appears three times.
- If you are using a printer driver that is connected to the LPT1:, LPT2:, or any other port that is connected to a printer, the Print To File dialog box appears only once for Sheet1. The other worksheets are printed to the printer.
- If you use a Visual Basic macro to print the worksheets, the Print To File dialog box may appear more than once. If you are using the SendKeys method to send the name of the output file to the Print To File dialog box, the macro may fail if the dialog box appears more than once.

If you change the print quality of Sheet3 to 600 dpi, two print jobs are generated: one at 300 dpi (Sheet1), and one at 600 dpi (Sheet2 and Sheet3). If you change the print quality of Sheet1 to 600 dpi, two print jobs are generated: one at 600 dpi (Sheet1 and Sheet2), and one at 300 dpi (Sheet3).
