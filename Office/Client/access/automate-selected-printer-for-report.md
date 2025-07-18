---
title: Automate process of selecting printer for a report
description: Describes how to programmatically select a printer and print the reports with the options that you predefine. Assumes you are familiar with the Access database and Visual Basic programming.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: V-DARMAC
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# How to automate the process of selecting the printer for a report in Microsoft Access

Novice: Requires knowledge of the user interface on single-user computers.

This article applies to a Microsoft Access database (.mdb) or Microsoft Access database (.accdb) file.

## Summary

If you want to print a report to a particular printer, you can manually select the printer and all of the print options, or you can automate the process so that with a click of a button, you can switch printers and then print your report with the options that you predefine. This article explains how to automate the process of printer selection.

## More information

This procedure uses two examples:

- Printing to a laser printer.
- Printing to a dot-matrix printer.

You can substitute the particular printers that you want to use. To automate the process of printer selection for a particular report, follow these steps:

1. Create the following three reports:
   - rptLaserPrinter
   - rptDotMatrix
   - rptMyReport

   > [!NOTE]
   > rptMyReport represents the actual report that you want to print.
2. To set the printer options, follow these steps:

   1. Open **rptLaserPrinter** in Design view.
   2. On the **File** menu, click **Print**.

      > [!NOTE]
      > In Access 2007 or a later version, click the **Microsoft Office** button, and then click **Print**.
   3. In the **Print** dialog box, click the laser printer that you want to use in the **Name** box, and then click **OK**.
   4. Click **Properties**, set any print options that you want, such as the orientation and paper size, and then click **OK**.
   5. Repeat steps a to d for rptDotMatrix. Click the dot-matrix printer in step c.
3. In the Database window, click **Modules**, click **New**, and then type the following function:

   > [!NOTE]
   > In Access 2007 or a later version, click **Module** in the **Other** group on the **Create** tab.

   ```vb
   Function ChangePrinter(rptToChange As String, rptPrinter As String)

   Dim rpt1 As Report, rpt2 As Report

   DoCmd.OpenReport rptToChange, acViewDesign
   DoCmd.OpenReport rptPrinter, acViewDesign

   Set rpt1 = Reports(rptToChange)
   Set rpt2 = Reports(rptPrinter)

   rpt1.PrtDevNames = rpt2.PrtDevNames

   DoCmd.Close acReport, rptPrinter, acSaveNo
   DoCmd.OpenReport rptToChange, acViewPreview
   End Function
   ```

   > [!NOTE]
   > The **ChangePrinter** function copies the **PrtDevNames** property from one report to another. You can then copy the print options that you set for the **rptLaserPrinter** and **rptDotMatrix** reports to a specific report that you want to print.
   >
   > The **acSaveNo** property is used in the `DoCmd.Close acReport, rptPrinter, acSaveNo` line of the code. If you don't use this option, and you save the PrtDevName of a non-default printer to the report design, the report will not be able to find the printer when it runs the next time. You will receive the following error message:
   >
   > This document was previously formatted for the printer \<PrinterName> on \<Port>; but that printer isn't available. Do you want to use the default printer \<DefaultPrinterName> on \<Port>?
4. Save the module as **Module1**, and then exit the Visual Basic Editor.
5. Create the following form:

   ```adoc
   Form: frmForm1
   ------------------------------
   RecordSource: Unbound

   Control Type: Command Button
   Name: cmdLaser
   Caption: Laser
   Control Type: Command Button
   Name: cmdDotMatrix
   Caption: Dot Matrix
   ```

6. On the **View** menu, click **Code**.

   > [!NOTE]
   > In Access 2007 and later, click **View Code** in the **Tools** group on the **Design** tab.
7. In the Visual Basic Editor, type the following procedures:

   ```vb
   Private Sub cmdLaser_Click ()

   Call ChangePrinter("rptMyReport", "rptLaserPrinter")
   DoCmd.PrintOut

   End Sub

   Private Sub cmdDotMatrix_Click ()

   Call ChangePrinter("rptMyReport", "rptDotMatrix")
   DoCmd.PrintOut

   End Sub
   ```

8. Exit the Visual Basic Editor, and then change the **On Click** property of both command buttons to **[Event Procedure]**. To do so, follow these steps:

     1. In Design view, click the command button, and then click **Properties** on the **View** menu.

        In Access 2007 or a later version, click the command button in the design view, and then click **Property Sheet** in the **Tools** group on the **Design** tab.
     2. Click the **Event** tab, click the **On Click** property, click the down arrow, and then click **[Event Procedure]**.

9. To print **rptMyReport** to a specific printer, open **frmForm1** in Form view, and then click the appropriate button.

## References

For more information about how to control your printer from Microsoft Access, see [PrtDevMode Property](/previous-versions/office/developer/office2000/aa207072(v=office.10)).
