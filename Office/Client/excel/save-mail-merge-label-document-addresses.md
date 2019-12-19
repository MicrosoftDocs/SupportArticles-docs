---
title: How to save addresses from a Word mail-merge label document to Excel
description: Provides the detailed steps to save the addresses from a Word document that contains mail-merged labels to an Excel workbook.
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

# How to save the addresses from a Word mail-merge label document to Excel

## Summary

This article describes how to save addresses that are contained in a Microsoft Word mail merged label document to a Microsoft Excel workbook.

## More Information

The following steps assume that you already have an existing Word mail merged label document that contains the addresses that you want to save in an Excel workbook. To save addresses that are contained in a Word mail merged label document to an Excel workbook, follow these steps, as appropriate for the version of Excel that you are running.

### Microsoft Office Excel 2007

1. Start Microsoft Office Word 2007, and then open the Word document that contains your merged address labels.
2. Click the **Home** tab.
3. In the **Editing** group, click **Replace**.
4. On the **Replace** tab, click **More**.
5. With the insertion point in the **Find what**box, click **Special**, and then click **Section Break**.

   You should see **^b** in the **Find what** box.

6. Leave the **Replace with** box blank, and then click **Replace All**.
7. Click **Close** to close the **Find and Replace** dialog box.
8. Under **Table Tools**, click the **Layout** tab.
9. In the **Table** group, click **View Gridlines**.
10. Delete all blank columns in your merged address label document.

    To do this, click inside a blank column, click **Delete** in the **Rows & Columns** group, and then click **Delete Columns**.

    > [!NOTE]
    > Repeat this step until each blank column is deleted in the address labels table.
11. Replace all paragraph marks with a tab. To do this, follow these steps:
    1. Click the **Microsoft Office Button**, and then click **Word Options**.
    2. Click **Display**.
    3. Click to select the **Show all formatting marks** check box, and then click **OK**.
    4. Click the **Home** tab.
    5. In the **Editing** group, click **Replace**.
    6. On the **Replace** tab, click **More**.
    7. On the **Replace** tab, delete the contents of the **Find what** box.

       With the insertion point in the **Find what**box, click **Special**, and then click **Paragraph Mark**.
    8. Delete the contents of the **Replace with** box.

       With the insertion point in the **Replace with** box, click **Special**, and then click **Tab Character**.
    9. Click **Replace All**.
    10. Click **Close**.

12. Click the **Layout** tab.
13. With the insertion point in the table, click **Convert to Text** in the **Data** group.
14. In the **Convert Table to Text** dialog box, click **Paragraph marks**, and then click **OK**.
15. Click the **Microsoft Office Button**, and then click **Save As**.
16. In the **Save As** dialog box, change the **Save as type** box to **Plain Text (*.txt)**.

    Type a new name for your address list in the **File name** box, and then click **Save**.
17. If a **File Conversion** dialog box appears, click **Windows (Default)**, click to select the **Insert line breaks** check box, make sure that the **End lines with** box has **CR/LF** selected, and then click **OK**.
18. Close your new file, and then exit Word.
19. Start Excel 2007.
20. Click the **Microsoft Office Button**, and then click **Open**.

    Change the **Files of type** box to **All Files (*.*)**, and then open the file that you saved in step 16.  
21. When the **Text Import Wizard** starts, accept the default settings, and then click **Finish**.

### Microsoft Office Excel 2003 and earlier versions of Excel

1. Start Word, and then open the Word document that contains your merged address labels.
2. On the **Edit** menu, click **Replace**.
3. On the **Replace** tab, click **More**.
4. With the insertion point in the **Find what**box, click **Special**, and then click **Section Break**.

   You should see **^b** in the **Find what** box.
5. Leave the **Replace with** box blank, and then click **Replace All**.
6. Click **Close**.
7. On the **Table** menu, click **Show Gridlines**.
8. Delete all blank columns in your merged address label document.

   To do this, click inside a blank column, on the **Table** menu, point to **Select**, and then click **Column**.
9. On the **Table** menu, point to **Delete**, and then click **Columns**.
10. Repeat steps 8 and 9 for each blank column in your merged label document that you want to remove.
11. Replace all paragraph marks with a tab. To do this, follow these steps:

    1. On the **Tools** menu, click **Options**.
    2. On the **View** tab, click to select the **All** check box, and then click **OK**.
    3. On the **Edit** menu, click **Replace**.
    4. Click **More** to expand the **Replace** tab.
    5. On the **Replace** tab, delete the contents of the **Find what** box.

       With the insertion point in the **Find what** box, click **Special**, and then click **Paragraph mark**.
    6. Delete the contents of the **Replace with** box.

       With the insertion point in the **Replace with** box, click **Special**, and then click **Tab Character**.
    7. Click **Replace All**.
    8. In the **Find and Replace** dialog box, click **Close**.

12. With the insertion point in your Word table, point to **Convert** on the **Table** menu, and then click **Table to Text**.
13. In the **Convert Table to Text** dialog box, click **Paragraph marks**, and then click **OK**.
14. On the **File** menu, click **Save As**.
15. In the **Save As** dialog box, change the **Save as type** box to **Plain Text (*.txt)** (Text Only (*.txt)).

    Type a new name for your address list in the **File name** box, and then click **Save**.
16. If a **File Conversion** dialog box appears, click **Windows (Default)**, click to select the **Insert line breaks** check box, make sure that the **End lines with** box has **CR/LF** selected, and then click **OK**.
17. Close your new file, and then exit Word.
18. Start Excel.
19. On the **File** menu, click **Open**.

    Change the **Files of type** box to **All Files (*.*)**, and then open the file that you saved in steps 14, 15, and 16.
20. When the **Text Import Wizard** starts, accept the default settings, and then click **Finish**.
