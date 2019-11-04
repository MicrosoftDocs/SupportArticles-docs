---
title: Changes in content layout between Word 2013 and earlier versions of Word
description: Provides information about changes to the layout of content that appear when you save a document that was created in an earlier version of Word in the Word 2013.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: Tomol, DK Pfeiffer, Dan Vasquez
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Word 2013
---

# Changes in content layout between Word 2013 and earlier versions of Word

##  Summary

Microsoft Word 2013 uses a new and improved layout engine and compatibility mode to help ensure that layout is consistent between different versions of Microsoft Word. 

When you open a document that is created in an earlier version of Word in Word 2013, the document opens in the compatibility mode. In this situation, the document name in the title bar is followed by "[Compatibility Mode]." 

When you save the document by using a new name, Word 2013 prompts you to maintain compatibility with earlier versions of Word. In this situation, if you select OK to upgrade to the newest file format, some minor changes may appear in the layout. If you click the Tell Me More button in the dialog box, you go to the following Microsoft website:

[Use Word 2013 to open documents created in earlier versions of Word](https://office.microsoft.com/word-help/use-word-2013-to-open-documents-created-in-earlier-versions-of-word-ha102749315.aspx)

##  More Information

This section lists some layout changes between different versions of Word if you use compatibility mode or if you save the document in the new Word 2013 file format.


- Figures (Pictures, Shapes, Textboxes Charts, SmartArt, and WordArt)
  - Earlier versions of Word allow for figures that have text wrapping applied to bleed off the edge of the page or be positioned in the bottom margin of a page. Word 2013 pushes figures that have text wrapping applied and have the Move object with text option enabled back onto the page. If figures are moved into the bottom margin, Word 2013 pushes the figures down to the next page.   
  - Word 2013 uses a new graphics format. The new format changes the size of shadows and the width of borders slightly.    
  - Word 2013 lays out text that is positioned next to a figure differently.   
   
- Tables
  - Earlier versions of Word align text inside tables with the text outside tables. In Word 2013, tables respect the UI settings, and the text inside tables is not forced to align with text outside the table. By default, tables are constrained by the margin in Word 2013.   
  - Word 2013 may shift tables slightly (the default amount is .08 inch) and make tables narrower. This behavior may cause lines to break earlier. This, in turn, makes cells taller and potentially causes the page to break earlier.   
   
- Footnotes
  - By default, Word 2013 positions footnotes in columns when a document has multiple columns. Additionally, footnotes begin in the first column on the page regardless of where the footnote reference appears in the body text. Word 2013 balances the footnotes across the footnote columns.   
   
- Overall Layout
  - The column balancing algorithm in Word 2013 is improved. This improvement changes the layout of text in columns.   
  - Word 2013 uses a new algorithm to determine the optimal way to align text and break lines. Therefore, there are changes to how lines and pages break.   
  - You cannot use the Hyphenation Zone setting in the **Hyphenation** dialog box for documents that are saved in the Word 2013 file format.   
  - When you apply the Show Text Boundaries setting in the **File Options Advanced** dialog box for documents that are saved in the Word 2013 file format, the text boundary lines are displayed around each paragraph. However, when the document is in compatibility mode, the text boundary lines are displayed around the edge of the page.   
   
**Note** For more information about how to update the layout in Word 2013 and maintain compatibility with other versions of Word, go to the following Microsoft website:

[More information about updates to the layout in Word 2013](https://blogs.office.com/b/microsoft-word/archive/2012/08/21/layout-in-the-new-word.aspx)
