---
title: How to create table of contents in Word entries without a page number
description: Describes how to create table of contents entries without a page number and how to change an entry without a page number in Word.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Tables
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Microsoft Word 2013
  - Microsoft Word 2010
ms.reviewer: 
ms.date: 06/06/2024
---
# How to create table of contents entries without a page number in Word

> [!NOTE]
> If you are a Small Business customer, find additional troubleshooting and learning resources at the [Support for Small Business](https://smallbusiness.support.microsoft.com/) site.  

## Summary

This article describes how to create table of contents (TOC) entries that contain no page number so that the entries don’t affect the numbering of the rest of the entries.

This article assumes that you understand how to create a table of contents in Microsoft Word. For more information about how to create a table of contents, see the following articles:

- [Insert a table of contents](https://support.microsoft.com/office/insert-a-table-of-contents-882e8564-0edb-435e-84b5-1d8552ccf0c0)
- [How to create a table of contents and index with field codes in Word](https://support.microsoft.com/help/212346/how-to-create-a-table-of-contents-and-index-with-field-codes-in-word)

The following example shows table of contents entries that contain no page numbers. You can use the following method to prevent table of contents entries from having the same page number.


```console
Baseball............................................................1
   Origins and Early History
   Development of Baseball Leagues
   Professional Baseball Government
Current Major and Minor Leagues.....................................2
   American League..................................................2
   National League..................................................3
```

> [!NOTE]
> In Word, hold down the CTRL key, and then select a table of contents entry to move to that page in the document. This works for both numbered and unnumbered TOC entries.

## How to create a TOC entry without a page number

### Word 2013 and later

1.	In your document, create a table of contents, or use an existing table.
2.	Position the cursor at the location within the document where you want to put the TOC.
3.	Select the **References** tab.

    In the **Table of Contents** group, select **Table of Contents**, and then select **Custom Table of Contents** from the list. Notice that the Print Preview display (**Figure A**) doesn't display Heading 4 (the style that we used for the annotations). This feature defaults to three levels, Heading 1, Heading 2, and Heading 3.

    **Figure A**

    :::image type="content" source="media/create-toc-entries-no-page-number/table-of-contents.png" alt-text="Screenshot to select Table of Contents in the Table of Contents window.":::

4.	To add the annotations to the TOC, select **Options**. In the dialog box that opens, enter **4** in the **TOC level** control to the right of Heading 4, and then select OK (see **Figure B**). 

    > [!NOTE]
    > Although you might consider removing levels 2 and 3 because Heading 2 and Heading 3 are in use, we recommend that you keep them because you might want to add them later, and not remember why the TOC doesn't update to show those levels.

    **Figure B**
    :::image type="content" source="media/create-toc-entries-no-page-number/toc-options.png" alt-text="Screenshot shows steps to add the annotations to the T O C.":::

    Add a level for the annotations.

5. Clear the **Show page numbers** check box (**Figure C**). Before you do this, notice that the preview now displays Heading 4.

    **Figure C**

    :::image type="content" source="media/create-toc-entries-no-page-number/show-page-numbers.png" alt-text="Screenshot to clear the Show page numbers check box.":::

    > [!NOTE]
    > Disabling page numbering disables it for the entire TOC.

6.	Select **OK** to return to the document. 

    > [!NOTE]
    > **Figure D** shows the resulting TOC. All page numbers are gone. However, we want to remove the page number for only the annotation level. The default TOC doesn't include the annotations (Heading 4 text). 

    **Figure D**

    :::image type="content" source="media/create-toc-entries-no-page-number/result-toc.png" alt-text="Screenshot shows the resulting T O C, all page numbers are gone.":::


### How to change to a TOC entry that doesn't have a page number

#### Word 2013 and later

1. Select **File** > **Options**.

    :::image type="content" source="media/create-toc-entries-no-page-number/file-options.png" alt-text="Screenshot to select the File option and then select Options.":::

1. On the **Display** tab, select the **Show all formatting marks** check box, and then select **OK**.

    :::image type="content" source="media/create-toc-entries-no-page-number/word-option-display.png" alt-text="Screenshot to select the Show all formatting marks check box and then select OK.":::

    > [!NOTE]
    > Next to the text that appears in the table of contents, you now see a TC field without a page number. The TC field resembles the following example:
    >
    > :::image type="content" source="media/create-toc-entries-no-page-number/example-tc-field.png" alt-text="Screenshot shows an example of a T C field without a page number.":::

1. Select the TC field. Make sure that you include the opening bracket and the closing bracket.
1. On the **Insert** tab, select **Quick Parts**, and then select **Field**.

    :::image type="content" source="media/create-toc-entries-no-page-number/quick-parts-field.png" alt-text="Screenshot to select Quick Parts and then select the Field item.":::

    > [!NOTE]
    > For information about how to use the Field dialog box for a table of contents entry that contains no page number, see steps 5 through 9 of the “[How to create a TOC entry without a page number](#how-to-create-a-toc-entry-without-a-page-number)” section.


1. Select **File** > **Word Options**.
1. On the **Display** tab, clear the **Show all formatting marks** check box, and then select **OK**.
1. Select the existing table of contents.
1. Press F9 to update the table of contents.
1. If you receive the following message, select **Update entire table**, and then select **OK**.

    `Word is updating the table of contents. Select one of the following options:`

## References

For more information about how to use the Lead-in Emphasis feature to create a table of contents, see [How to use style separators with heading style to generate a TOC in Word](https://support.microsoft.com/office/how-to-use-style-separators-with-heading-style-to-generate-a-toc-in-word-48af64fa-9b3c-4232-be20-cf244cef7fea?ui=en-us&rs=en-us&ad=us).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
