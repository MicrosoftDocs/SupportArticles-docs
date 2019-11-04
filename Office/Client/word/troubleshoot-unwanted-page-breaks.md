---
title: Troubleshooting guide for unwanted page breaks
description: Describes how to troubleshoot page breaks that occur in a Word document at unexpected or unwanted locations
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: lorist 
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Word 2013
- Word 2010
- Word 2003
---

# Troubleshooting guide for unwanted page breaks

## Summary

This article describes how to troubleshoot page breaks that occur in a Word document at unexpected or unwanted locations.

> [!NOTE]
> It is easier to view page breaks in normal view than print layout view. To switch to normal view, in Word 2000, Word 2002 and Word 2003, on the Viewmenu, click Normal. In Word 2007, Word 2010 and Word 2013, click the View tab and then click Draft.

## More Information

### Check spacing before or after the paragraph

#### Word 2000, Word 2002, and Word 2003

1. Select the paragraph immediately before or after the unwanted page break.   
2. On the Format menu, click Paragraph.   
3. Click the Indents and Spacing tab, and then check to see whether Spacing Before or Spacing After is set to an unusually high value.   

#### Word 2007, Word 2010, and Word 2013

1. Select the paragraph immediately before or after the unwanted page break.   
2. On the Page Layout tab, click the Paragraph Dialog Box Launcher, and then click the Indents and Spacing tab. Or, right-click and choose Paragraph, and then click the Indents and Spacing tab.   
3. Check to see whether Spacing Before or Spacing After is set to an unusually high value.   

### Check the pagination options of the preceding paragraph

#### Word 2000, Word 2002, and Word 2003

1. Select the first paragraph on the page following the unwanted page break.   
2. On the Format menu, click Paragraph.   
3. Click the Line and Page Breaks tab.   
4. Check to see whether one of the following three pagination options is selected:

    - Page break before: Inserts a page break before a paragraph.   
    - Keep with next: Prevents a page break between the current and following paragraphs.
    - Keep lines together: Prevents a page break within a paragraph.   

#### Word 2007, Word 2010, and Word 2013

1. Select the first paragraph on the page following the unwanted page break.   
2. On the Page Layout tab, click the Paragraph dialog box launcher in the Paragraph group.   
3. Click the Line and Page Breaks tab.   
4. Check to see whether one of the following three pagination options is selected:   

    - Page break before: Inserts a page break before a paragraph.   
    - Keep with next: Prevents a page break between the current and following paragraphs.
    - Keep lines together: Prevents a page break within a paragraph.   

### Check the "From edge" setting

#### Word 2000, Word 2002, and Word 2003

1. On the File menu, click Page Setup, and then click to select the Margins tab.   
2. Look at the From edge setting for the Header or Footer to see whether it is too large.   

#### Word 2007, Word 2010, and Word 2013

1. On the Page Layout tab, click the Page Setup dialog box launcher in the Page Setup group.   
2. Click the Layout tab.   
3. Look at the From edge setting for the Header or Footer to see whether it is too large.   

> [!NOTE]
> This setting determines the distance from the edge of the page where Word starts printing the text of a header or footer. The default setting is 0.5 inch. A larger setting decreases the available print area for your document. 

### Check to see whether the text that follows the page break is in a table

Word includes an option that does not allow a page break to be inserted in a table cell. As a result, if the entire cell does not fit on the page, Word pushes the entire cell to the next page.

To change this option, follow these steps.

#### Word 2000, Word 2002, and Word 2003

1. Place the insertion point in the table.   
2. On the Table menu, click Table Properties.   
3. Click the Row tab.   
4. Click to select the **Allow row to break across pages** check box.   

This sets the page break option for the entire table.

#### Word 2007, Word 2010, and Word 2013

1. Place the insertion point in the table.   
2. Go to the Layout tab under Table Tools.   
3. In the Table group, click Properties.   
4. Click the Row tab.   
5. Click to select the **Allow row to break across pages** check box.   
This sets the page break option for the entire table.

### Search for manual (or "hard") page breaks

You may have inserted a manual page break by pressing CTRL+ENTER. Or, you may have inserted a manual page break by using one of the following methods, depending on your version of Word. 

#### Word 2002, Word 2002, or Word 2003

1. On the Insert menu, click Break.   
2. Select Page break, and then click OK.   

#### Word 2007, Word 2010, and Word 2013

On the Insert tab, click Page Breaks on the Pages group.

You can use the Replace command to remove manual page breaks by searching for manual page breaks.

**Note** Do not click the Replace All button when you remove manual page breaks unless your document contains no section breaks.

### Check for unexpected page breaks following "Normal" style text

If a series of Heading styles is used in a document (an outline, for example) followed by text that is formatted with the Normal style, an unexpected page break may occur following the Normal text. This problem occurs only in normal view and does not occur in outline view. Use one of the following methods to remove individual occurrences of an unwanted page break. 

#### Method 1: Apply the "Keep with Next" option to Normal text

##### Word 2000, Word 2002, and Word 2003

1. Select the Normal text.   
2. On the Format menu, click Paragraph.   
3. Click the Line and Page Breaks tab, and then click to select Keep with next.   
4. Click OK.   

##### Word 2007, Word 2010, and Word 2013

1. Select the Normal text.   
2. On the Page Layout tab, click the Paragraph dialog box launcher in the Paragraph group.   
3. Click the Line and Page Breaks tab, and then click to select Keep with next.   
4. Click OK.   

#### Method 2: Clear the "Keep with next" option from the heading

##### Word 2000, Word 2002, and Word 2003

1. Select the Heading text that precedes the Normal text.   
2. On the Format menu, click Paragraph.   
3. Click the Line and Page Breaks tab, and then click to clear the Keep with next check box.   
4. Click OK.   

##### Word 2007, Word 2010, and Word 2013

1. Select the Heading text that precedes the Normal text.   
2. On the Page Layout tab, click the Paragraph dialog box launcher in the Paragraph group.   
3. Click the Line and Page Breaks tab, and then click to clear the Keep with next check box.   
4. Click OK.   

#### Method 3: Permanently change the occurrence of unwanted page breaks

##### Word 2000, Word 2002, and Word 2003

1. On the Format menu, click Style.   
2. In the List list box, click All styles.   
3. In the Styles list, click Heading 1.   
4. Click Modify.   
5. Click Format, and then click Paragraph.   
6. Click the Line and Page Breaks tab.   
7. Click to clear the Keep with next check box, and then click OK.   
8. To make the change permanent for the current document and all new documents based on the active template, click to select **Add to template**. Otherwise, the changes that you make will only affect the current document.   
9. Click OK, and then click Close.   

##### Word 2007, Word 2010, and Word 2013

1. On the Home tab, go to the Styles group, and then click the Styles dialog box launcher to open the list of styles.   
2. In the Styles list, click Heading 1.   
3. Click Modify.   
4. Click Format, and then click Paragraph.   
5. Click the Line and Page Breaks tab.   
6. Click to clear the Keep with next check box, and then click OK.   
7. To make the change permanent for the current document and all new documents based on the active template, click to select **New document based on this template**. Otherwise, the changes that you make will only affect the current document.   
8. Click OK, and then click Close.   

### Microsoft support options

If you cannot resolve this issue, several support options are available to assist you.

#### Quickly find answers yourself online

Use Microsoft Online Support to search the Microsoft Knowledge Base and other technical resources for fast, accurate answers. You can also customize the site to control your search.

To begin your search, visit the following Web site:
[https://www.microsoft.com/support/](https://www.microsoft.com/support/)

#### Microsoft Product Support

Contact a Microsoft Product Support professional to assist you with troubleshooting problems.

For more information about obtaining help with troubleshooting Microsoft Windows, click Help Topics on the Help menu in Windows Explorer. On the Contents tab, double-click to open the Troubleshooting book. Then double-click to open the Contact Microsoft Technical Support book to view your support options.

For more information about obtaining help with troubleshooting Microsoft Word, click About Microsoft word on the Help menu, and then click Tech Support.

#### Microsoft Solution Providers

Microsoft Solution Providers are independent organizations that have teamed with Microsoft to use technology to solve business problems for companies of all sizes and industries.

To locate a Microsoft Solution Provider in your area in the U.S. and Canada, call the Microsoft Sales Information Center at (800) 426-9400. If you are outside the United States, contact your local subsidiary. To locate your subsidiary, see the Microsoft World Wide Offices Web site at
[https://www.microsoft.com/worldwide/](https://www.microsoft.com/worldwide/).
