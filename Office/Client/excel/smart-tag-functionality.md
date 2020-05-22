---
title: Description of the smart tag functionality in Excel
description: Describes how smart tags work in Excel. The article contains steps to turn on smart tags and to transfer smart tags between Office programs.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
---

# Description of the smart tag functionality in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

This article describes the functionality of the smart tags feature in Microsoft Excel.

## More Information

Smart tags are designed to recognize specific data and then offer action options based on the type of data recognized. The actions are made available with a button that appears near the cell that contains the recognized data. The button appears when the cell is activated or when you move the mouse pointer over the cell.

### How to turn on smart tags

 Smart tag functionality is turned off by default. Before you can use smart tag functionality, you must turn on smart tag recognition. To do this, follow these steps, as appropriate for the version of Excel that you are running.

#### Microsoft Office Excel 2007

1. Click the **Microsoft Office Button**, and then click **Excel Options**.
2. Click **Proofing**.
3. Click **AutoCorrect Options**.
4. In the **AutoCorrect** dialog box, click the **Smart Tags** tab.
5. Click to select the **Label data with smart tags** check box.
6. In the **Recognizers** box, click to select the check boxes next to the specific smart tag recognizers that you want to turn on, and then click **OK**.
7. Click **OK** to close the **Excel Options** dialog box.

#### Microsoft Office Excel 2003 and earlier versions of Excel

1. On the Tools menu, click AutoCorrect Options.
2. In the AutoCorrect dialog box, click the Smart Tags tab.
3. Click to select the **Label data with smart tags** check box.
4. In the Recognizers box, click to select the check boxes next to the specific smart tag recognizers that you want to turn on, and then click OK.

### Smart tag recognition

- A worksheet cell that contains data recognized by a smart tag is marked with a purple cell indicator in the bottom-right corner of the cell. The smart tag button appears when the cell is selected or when you move the pointer over the cell. When you click the smart tag button, the actions available from the smart tag are listed. If the active cell contains a smart tag, and you move the mouse pointer over another cell that contains a smart tag, two smart tag buttons appear. If a range of cells is selected, the smart tag button appears only for cells that you move the pointer over.
- A cell can contain more than one smart tag.
- Excel can only pass the entire contents of a cell to a smart tag. For example, if "I like MSFT" is entered in a cell, "MSFT" is not recognized as a financial symbol by the MSN MoneyCentral Financial Symbols smart tag.
- Excel does support smart tags that span multiple cells.

### Smart tag persistence

- You can transfer smart tags from one Office program to another Office program by using the Clipboard. If a smart tag is available in Microsoft Word but not in Excel, you can paste it into Excel, and its actions will be available. However, the limitations related to the way that the contents of Excel cells are recognized still apply.
- Smart tags remain in a cell if any of the following conditions are true:

  - The formatting of the cell is changed.
  - Rows or columns are inserted or deleted around the cell.
  - The cell is moved.
  - The cell is cut or copied and then pasted.
  - The cell is auto-filtered.
  - The cell is rearranged because of a sort operation.
  - The cell is hidden.

- Smart tag are removed from a cell if any of the following conditions are true:

  - The data in a cell is changed or deleted.
  - The data in a cell is pasted over.
  - New data is dragged into a cell.

- If a single cell that contains recognized data is pasted into a range of cells, the smart tag is not pasted into the cells.
- When you protect a worksheet, this prevents you from adding or removing smart tags from cells in the worksheet. However, the smart tags that are already in a protected worksheet perform as expected.
- Smart tags can be embedded in a workbook so that they are saved with the file. When you save a workbook that contains embedded smart tags as a Web page (HTML or MHTML), and then view the Web page in Microsoft Internet Explorer 5.5 or later, the smart tags are available. Only the custom actions of the smart tags are listed in the Smart Tag Actions list.

  To turn on smart tag embedding, follow these steps, as appropriate for the version of Excel that you are running.

  **Excel 2007**

  1. Click the **Microsoft Office Button**, and then click **Excel Options**.
  2. Click **Proofing**.
  3. Click **AutoCorrect Options**.
  4. In the **AutoCorrect** dialog box, click the **Smart Tags** tab.
  5. Click to select the **Embed smart tags in this workbook** check box, and then click **OK**.
  6. Click **OK** to close the **Excel Options** dialog box.

  **Excel 2003 and earlier versions of Excel**

  1. On the Tools menu, click AutoCorrect Options.
  2. In the AutoCorrect dialog box, click the Smart Tags tab.
  3. Click to select the **Embed smart tags in this workbook** check box.
  4. Click OK.

- If you invoke a smart tag action, this is not included in the list of changes made when you track changes in a shared workbook.
- Cells in a PivotTable or QueryTable are passed to the recognizers when the PivotTable or the QueryTable is created or refreshed in the same manner as normal cells.
- The smart tag is removed from any cell that changes as a result of a recalculation, and the cell is then re-evaluated by the smart tag recognizers.

### Smart tag limitations

- You cannot undo the removal of a smart tag by clicking Undo.
- Smart tags are not re-pasted after an undo and redo of a paste operation. If smart tags are turned off, the Redo command results in no smart tag in the cell. If smart tags are turned on, the cell is passed to the recognizers and is recognized again.
- There is a limit of 65,530 smart tags per worksheet.

##  References

For more information about smart tags, click the following article number to view the article in the Microsoft Knowledge Base:

[288958](https://support.microsoft.com/help/288958) How to remove smart tags from a workbook