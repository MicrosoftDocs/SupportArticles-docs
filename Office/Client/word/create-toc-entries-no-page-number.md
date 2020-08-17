---
title: How to create table of contents entries without a page number in Word
description: Describes how to create table of contents entries without a page number and how to change an entry without a page number in Word.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Word 2010
- Microsoft Word 2013
- Word 2016
- Word 2019
- Word for Microsoft 365
ms.reviewer: 
---
# How to create table of contents entries without a page number in Word

This article describes how to create table of contents entries without a page number and how to change an entry without a page number in Word.

_Original KB number:_ &nbsp; 319821

> [!NOTE]
> If you are a Small Business customer, find additional troubleshooting and learning resources at the [Support for Small Business](https://smallbusiness.support.microsoft.com/) site.  

This step-by-step article describes how to create table of contents (TOC) entries that contain no page number, without affecting the numbering for the rest of your table of contents.

This article assumes that you understand how to create a table of contents in Microsoft Word.

For more information about how to create a table of contents, click the following article numbers to view the articles in the Microsoft Knowledge Base:

- [285059](https://support.microsoft.com/help/285059) How to create a table of contents by marking text in Word
- [212346](https://support.microsoft.com/help/212346) How to create a table of contents and index with field codes in Word

Following example shows table of contents entries that contain no page numbers. You can use the following method to prevent table of contents entries from appearing with the same page number.

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
> In Word, hold down the CTRL key and then click a table of contents entry to move to that page in the document. This works for numbered and unnumbered TOC entries.

## How to create a TOC entry without a page number

### Word 2013 and above

> [!NOTE]
> In your document, create a table of contents. For more information about how to create a table of contents, check the following Microsoft KB article:  
>
> [285059](https://support.microsoft.com/help/285059) How to create a table of contents by marking text in Word

1. Position your cursor within the document where you want the TOC to be.
1. Select the **References** tab.

    In the Table of Contents group, click Table of Contents, and choose Custom Table of Contents from the dropdown. Notice that the Print Preview display doesn't display Heading 4 (the style we used for the annotations). This feature defaults to three levels, Heading 1, Heading 2, and Heading 3.

    :::image type="content" source="./media/create-toc-entries-no-page-number/table-of-contents.jpg" alt-text="table of contents":::

1. To add the annotations to the TOC, click Options. In the resulting dialog, enter 4 in the TOC level control to the right of Heading 4, and click OK. You might consider removing levels 2 and 3 because Heading 2 and Heading 3 are in use, but I recommend that you don't. You might add them later, and when the TOC doesn't update to show those levels, you might not remember why.

    :::image type="content" source="./media/create-toc-entries-no-page-number/toc-options.jpg" alt-text="TOC options":::

    Add a level for the annotations.

1. Uncheck the **Show page numbers** option. Before clicking OK, notice that the preview now displays Heading 4.

    :::image type="content" source="./media/create-toc-entries-no-page-number/show-page-numbers.jpg" alt-text="Show page numbers":::

    Disabling page numbering disables it for the entire TOC.

1. Click OK to return to the document. The following figure shows the resulting TOC. All page numbers are gone, but we want to remove the page number only for the annotation level. The default TOC doesn't include the annotations (Heading 4 text).

    :::image type="content" source="./media/create-toc-entries-no-page-number/result-toc.jpg" alt-text="Result TOC":::

## How to change to a TOC entry that doesn't have a page number

### Word 2013 and above

1. Click the **File** Button, and then click **Options**.

    :::image type="content" source="./media/create-toc-entries-no-page-number/file.png" alt-text="File":::

1. On the **Display** tab, select the **Show all formatting marks** check box, and then click **OK**.

    :::image type="content" source="./media/create-toc-entries-no-page-number/display.png" alt-text="Display tab":::

    > [!NOTE]
    > Next to the text that appears in the table of contents, you now see a TC field without a page number. The TC field resembles the following example:
    >
    > :::image type="content" source="./media/create-toc-entries-no-page-number/example.png" alt-text="Example":::

1. Select the TC field. Make sure that you include the opening bracket and the closing bracket.
1. On the **Insert** tab, click **Quick Parts**, and then click **Field**.

    :::image type="content" source="./media/create-toc-entries-no-page-number/field.png" alt-text="Field":::

    > [!NOTE]
    > For information about how to use the Field dialog box for a table of contents entry that contains no page number, see steps 5 through 9 of the [How to create a TOC entry without a page number](#how-to-create-table-of-contents-entries-without-a-page-number-in-word) section.

1. Click the **File** button, and then click **Word Options**.
1. On the **Display** tab, clear the **Show all formatting marks** check box, and then click **OK**.
1. Select the existing table of contents.
1. Press F9 to update the table of contents.
1. If you receive the following message, select **Update entire table**, and then click **OK**.

## References

For more information about how to use the Lead-in Emphasis feature to create a table of contents, check the following Microsoft KB article:

[285059](https://support.microsoft.com/help/285059) How to create a table of contents by marking text in Word 2013 and above
