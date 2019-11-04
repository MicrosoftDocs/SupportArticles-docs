---
title: Print a range of pages in a multiple-section document
description: Provides a guide to specify a page or a range of pages to be printed in a multiple-section document in Word.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Word 2013
- Word 2010
- Office Word 2003
---

# How to print a range of pages in a multiple-section document in Word 2013, Word 2010, Word 2007, and Word 2003

## Summary

This article discusses how to print a page or a range of pages in Microsoft Word 2013, in Microsoft Word 2010, in Microsoft Office Word 2007, and in Microsoft Office Word 2003.

## More Information

In Word, you can create a multiple-section document that uses different page numbering in each section. To specify a page or a range of pages to be printed, you must supply both the page number and the section number for the range that you want to print. In a multiple-section document that contains more than one page 1, Word cannot determine which page 1 to print unless you also supply a section number for that page. 

To print a range of pages across sections, use the following syntax in the **Pages** box: 

**PageNumberSectionNumber**-PageNumberSectionNumber

For example, you would type p1s1-p2s2 to print from page 1 of section 1 through page 2 of section 2.

To print a page or a range of pages in Word, follow these steps: 

1. Scroll to the page where you want to start to print, and then click anywhere in the margins. Note the page number and section number as shown in the status bar.   
2. Scroll to the last page that you want to include in the print selection, and then click anywhere in the margins. Note the page number and section number as shown in the status bar.   
3. In Word 2013, Word 2010 and in Word 2003, click **Print** on the **File** menu. In Word 2007, click the Microsoft Office Button, and then click Print.   
4. In Word 2013 and 2010, type the range of pages that you want to print in the **Pages** box in the **Settings** area. In Word 2007 and in Word 2003, click to select the **Pages** option in the **Page range** area, and then type the range of pages that you want to print in the box. 

    > [!NOTE]
    > When you type the range of pages, use the syntax p#s#-p#s#. For example, to print page 5 of section 3 through page 2 of section 4, type p5s3-p2s4. To print nonadjacent pages or nonadjacent sections, use a comma (,) to separate the page and section numbers when you type them. For example, to print sections 3 and 5 (but not section 4), type s3,s5. To print pages 2 through 5 of section 3 and pages 1 through 4 of section 5, type
    p2s3-p5s3,p1s5-p4s5.   
5. Click **OK** to print the range.   

> [!NOTE]
> This method is the only way to print certain pages by using the print options together with mail merged documents.

Printing pages in relation to their section depends on how the numbering is formatted. If the numbering in the document is set as continuous, referencing page 1 of a particular section most likely does not result in anything being printed. This occurs because, when the numbering is formatted as continuous, the page numbers in all sections except the first do not start with page 1. In this case, the page would have to be referenced according to its overall position in the documents page collection.

For example, in a document that is formatted as follows, here is what the pages would be for both restart and continuous numbering:

Section 1 : 4 pages 

Section 2 : 4 pages

|Restart numbering|Continuous|
|---|---|
|S1P1|S1P1 or P1|
|S1P2|S1P2 or P2|
|S1P3|S1P3 or P3|
|S1P4|S1P4 or P4|
|S2P1|S2P5 or P5|
|S2P2|S2P6 or P6|
|S2P3|S2P7|

## References

For more information about how to print a range of pages in a multiple-section document in Word 2002, click the following article number to view the article in the Microsoft Knowledge Base: 

[290984 ](https://support.microsoft.com/help/290984) How to print a range of pages in a multiple-section document in Word 2002
