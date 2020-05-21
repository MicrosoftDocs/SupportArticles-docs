---
title: You cannot use external references with data validation in Excel
description: Discusses a problem in which you cannot use external references with data validation in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Excel 2007
- Excel 2003
- Excel 2002
- Excel 97
---

# You cannot use external references with data validation in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you type a cell reference to a cell in the Source or Formula box in the Data Validation dialog box, and then click OK, you receive the following error message:

**You may not use references to other worksheets or workbooks for Data Validation criteria.**

## Cause

This issue occurs after you follow these steps:

1. You select the cells to which you want to apply Data Validation, and then click Validation on the Data menu.

   > [!NOTE]
   > In Microsoft Office Excel 2007, you click **Data Validation** in the **Data Tools** area on the **Data Validation** tab.

2. You click the Settings tab, and then click Custom in the Allow list.
3. You specify a cell reference to a cell in another worksheet or workbook in the Source or Formula box.

The Data Validation command lets you add restrictions on data that is typed into specific cells. However, the cells that contain the data criteria can refer only to cells within the same worksheet as the cells that are restricted.

## Workaround

To work around this issue, specify a cell that is in an external worksheet as Data Validation criteria if a local cell refers to the criteria cell. To do this, follow these steps:

1. On the File menu, click New, click Workbook, and then click OK.

   > [!NOTE]
   > In Excel 2007, click the **Microsoft Office Button**, and then click **New**. In the **New Workbook** dialog box, click **Blank and recent**, click **Blank Workbook**, and then click **Create**.

2. Select cell A1.
3. On the Data menu, click Validation, and then click the Settings tab.
   
   > [!NOTE]
   > In Excel 2007, click **Data Validation** in the **Data Tools** area on the **Data Validation** tab, and then click the **Setting** tab.

4. In the Allow list, click **Whole number**.
5. In the Data list, click **equal to**.
6. In the Value box, type a reference to a cell on the worksheet. For example, type =$B$1. 
7. Click OK.
8. In the cell that you referenced in step 6, type a formula that refers to the external criteria cell. For example, in cell B1, type the following formula:

   **=Sheet2!$C$1**

9. In the external cell, type the criteria value that you want to use for Data Validation. For example, in cell C1 of Sheet2, type 5.
10. You may now type only the Data Validation criteria (for example, 5) in cell A1 of Sheet1.

## More Information

Excel includes a tool that lets you specify what data are valid for individual cells or for cell ranges in a worksheet. This tool is called Data Validation.

To access the tool in MIcrosoft Office Excel 2003 and in earlier versions of Excel, click Validation on the Data menu. To access the tool in Excel 2007, click **Data Validation** in the **Data Tools** area on the **Data Validation** tab.

Restrictions include values, dates, times, or lists of text or values. Restrictions can be limited to exact matches or ranges of cells. You can type the validating values in the Data Validation dialog box, or you can store them in worksheet cells. These validating cells must be on the same worksheet as the cells that are being restricted.