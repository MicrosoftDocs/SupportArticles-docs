---
title: How Excel determines the current mode of calculation
description: Discusses how Excel determines the calculation mode. You can change the caculation mode in the Tools menu. You can press SHIFT+F9 to recaculate the active sheet and press F9 to recaculate all open documents.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: akeeler
ms.custom: 
  - Editing\Formulae
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - Excel 2010
  - Excel 2007
ms.date: 05/26/2025
---

# How Excel determines the current mode of calculation

## Summary

In Microsoft Excel, all currently open documents use the same mode of calculation, regardless of the mode in which they were saved.

## More Information

To help explain how the mode of calculation is determined, this article refers to the following hypothetical documents: 

|File name|Kind of document|Mode that is used to save the file|
|---|---|---|
|Auto1.xlsx|Workbook|Automatic|
|Manual1.xlsx|Workbook|Manual|
|Auto2.xlsx|Workbook|Automatic|

The following statements apply to calculation modes in Excel: 

- The first document that is opened uses the calculation mode with which it was last saved. Documents that are opened later use the same mode. For example, if you open Auto1.xlsx and then open Manual1.xlsx, both documents use automatic calculation (the mode used by Auto1.xlsx). If you open Manual1.xlsx and then open Auto1.xlsx, both documents use manual calculation.   
- Changing the calculation mode of one open document changes the mode for all open documents. For example, if Auto1.xlsx and Auto2.xlsx are both open, changing the calculation mode of Auto2.xlsx to manual also changes the mode of Auto1.xlsx to manual.   
- All sheets that are contained in a workbook use the same mode of calculation. For example, if Auto2.xlsx contains three worksheets, changing the mode of calculation of the first worksheet to manual also changes the mode of calculation to manual in the other two sheets.   
- If all other documents are closed and you create a new document, the new document uses the same calculation mode as the previously closed documents. However, if you use a template, the mode of calculation is the mode that is specified in the template.   
- If the mode of calculation in a workbook changed and the file is saved, the current mode of calculation is saved. For example, if Auto1.xlsx is opened, Manual1.xlsx is opened, and Manual1.xlsx is immediately saved, the mode of calculation is saved as automatic.   

### How to control the mode of calculation

All open documents use the same mode of calculation. You must follow special procedures to work with documents that use different calculation modes. For example, if you are working with Auto1.xlsx and you want to open Manual1.xlsx in manual calculation mode, take one of the following actions:  

- Set Auto1.xlsx to manual calculation mode before you open Manual1.xlsx.    
- Close Auto1.xlsx (and any other open documents) before you open Manual1.xlsx.    

There are four modes of calculation that you can select in Excel. They are as follows: 

- **Automatic**   
- **Automatic except for data tables**   
- **Manual**   
- **Recalculate workbook before saving**   

|Mode|Time when calculation occurs|
|---|---|
|Automatic|When you make any change to the document. All affected parts of the document are recalculated.|
|Automatic except tables|When you make any change to the document. All affected parts of the document except tables are recalculated. A table is recalculated only when a change is made to it.|
|Manual|When you press F9, click **Options** on the **Tools** menu, click the **Calculation** tab, and then click **Calc Sheet**.|
|Manual / Recalculate before saving|When you press F9 or click **Calc Sheet** on the **Calculation** tab on the **Tools/Options** menu. Calculation also occurs every time that you save the file if you have the checkbox "Recalculate workbook before saving" checked under **File** > **Options** > **Formulas**.<br/>:::image type="content" source="media/current-mode-of-calculation/recalculate-workbook-before-saving.png" alt-text="Screenshot to select the Recalculate workbook before saving checkbox.":::|

### Recalculate the active sheet

To recalculate only the active sheet, use one of the following methods:

- Press SHIFT+F9.    
- Click **Calculate Sheet** on the **Formulas** menu in the **Calculation** group.

### Recalculate all open documents

To recalculate all open documents, use one of the following methods: 

- Press F9.    
- Click **Calculate Now** on the **Formulas** menu in the **Calculation** group.   

### How to change the mode of calculation in Excel

To change the mode of calculation in Excel, follow these steps:

1. Click the **Microsoft Office Button**, and then click **Excel Options**.   
2. On the **Formulas** tab, select the calculation mode that you want to use.
