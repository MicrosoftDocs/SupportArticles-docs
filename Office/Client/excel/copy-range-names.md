---
title: Copy all range names programmatically
description: Describes how to create and use a macro to copy all of the range names from the active workbook to another workbook in Excel.
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
  - Excel 2007
  - Excel 2003
  - Excel 2002
  - Excel 2000
ms.date: 03/31/2022
---

# Copy all range names programmatically in Excel

## Summary

In Microsoft Office Excel, you can create a Microsoft Visual Basic for Applications (VBA) macro that you can use to copy all the range names from the active workbook to another workbook. 

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To create and use a macro to copy all of the range names from the active workbook to another workbook, use the steps in the following example: 

1. Start Excel, and then in a new workbook, click select cell A1.   
2. Perform one of the following actions: 
   - In Microsoft Office Excel 2007, click the **Formulas** tab, and then click **Define Name** in the **Defined Names** group.   
   - In Microsoft Office Excel 2003 in and earlier versions of Microsoft Excel, point to **Name** on the **Insert** menu, and then click **Define**.    
3. In the **Define Names** dialog box, in the **Names In workbook** box, type
Range1, and then click **OK**.   
4. Select cell B1.   
5. Perform one of the following actions: 
   - In Excel 2007, click the **Formulas** tab, and then click **Define Name** in the **Defined Names** group.   
   - In Excel 2003 and in earlier versions of Excel, point to **Name** on the **Insert** menu, and then click **Define**.   
6. In the **Define Names** dialog box, in the **Names In workbook** box, type
Range2, and then click **OK**.   
7. Press ALT+F11 to start the Visual Basic editor.   
8. On the **Insert** menu, click **Module**.   
9. On the module sheet, type the following code:

    ```vb
    Sub Copy_All_Defined_Names()
       ' Loop through all of the defined names in the active
       ' workbook.
         For Each x In ActiveWorkbook.Names
          ' Add each defined name from the active workbook to
          ' the target workbook ("Book2.xls" or "Book2.xlsm").
          ' "x.value" refers to the cell references the
          ' defined name points to.
          Workbooks("Book2.xls").Names.Add Name:=x.Name, _
             RefersTo:=x.Value
       Next x
    End Sub
    ```

10. Press ALT+F11 to return to Excel.   
11. Perform one of the following actions: 
    - In Excel 2007, click the **Microsoft Office Button**, point to **Save As**, click **Excel Macro-Enabled Workbook**, and then save the workbook as Book1.xlsm.   
    - In Excel 2003 and in earlier versions of Excel, click **Save** on the **File** menu, and then save the workbook as Book1.xls.   
12. Perform one of the following actions: 
    - In Excel 2007, click the **Microsoft Office Button**, click **New**, click **Blank Workbook**, and then click **Create**.   
    - In Excel 2003, click **New** on the **File** menu, and then click **Blank workbook** in the **New Workbook** task pane.   
    - In Excel 2002 and in earlier versions of Excel, click **New** on the **File** menu, click **Workbook**, and then click **OK**.   
13. Perform one of the following actions: 
    - In Excel 2007, click the **Microsoft Office Button**, point to **Save As**, click **Excel Macro-Enabled Workbook**, and then save the workbook as Book2.xlsm.   
    - In Excel 2003 and in earlier versions of Excel, click **Save As** on the **File** menu, and then save the workbook as Book2.xls.
14. Switch to Book1.

    > [!NOTE]
    > You may have to minimize or restore Book2 to see the Book1 button.   
15. Perform one of the following actions: 
    - In Excel 2007, click the **Developer** tab, and then click **Macros**.

        > [!NOTE]
        > If the **Developer** tab is not displayed, click the **Microsoft Office Button**, click **Excel Options**, click **Popular**, click to select the **Show Developer tab in the Ribbon** check box, and then click **OK**.   
    - In Excel 2003 and in earlier versions of Excel, point to **Macro** on the **Tools** menu, and then click **Macros**.   

16. In the **Macro name** list, click **Copy_All_Defined_Names**, and then click **Run**.   
17. Switch to Book2 and note that cell A1 is named Range1, and that cell B1 is named Range2.   
