---
title: Image DPI is changed after you print to PDF from Word 2013 or 2010
description: Works around an issue in which the image DPI is changed after you convert the documents to PDF files by using PDF printer.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: Laura Holzwarth (STRUCK), Fish Ge
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Word 2010
  - Word 2013
ms.date: 03/31/2022
---

# Image DPI is changed after you print to PDF from Word 2013 or Word 2010

## Symptoms

Assume that you convert the documents to PDF files by using PDF printer (for example, Adobe Acrobat or PDF Creator)in Microsoft Word 2013 or Word 2010. In this situation, you notice that the dots per inch (DPI) of some images may change from the original DPI in the document.

## How Word determines the DPI when printing PDF documents 

Word 2010 and Word 2013 use a single DPI for the whole document when printing to a PDF document. This DPI is determined by the capabilities of the printer. During printing, Word will try to adjust the image to reach the print DPI. 

For example, the PDF printer is treated as a printer with a highest DPI of 600. Word chooses between three print modes: Low, Medium, and High. If the print quality is set to High, the content will be printed by using the highest supported DPI. In this case it is 600 DPI. If the print quality is set to Medium, the content will be printed by using half of the highest DPI (300). Low print quality means the content will be printed by using a quarter of the highest DPI (150).

The following table shows the Default print quality in Word 2013 and Word 2010:

|Product|Default print quality|
|--|--|
|Word 2013|Medium|
|Word 2010|High|

Note If the printer can only handle a single tile at the time, the print quality is automatically set to Low.

##  Workaround

Important
 
Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, you can change the default print quality by adding the following reg key:

**Word 2013**

Registry subkey: [HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options]

Registry Value Name: PrintHighQualityDefault

Registry Value Type: REG_DWORD

Registry Value Data: 1

**Word 2010**

Registry subkey: [HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options]

Registry Value Name:  PrintMediumQualityDefault

Registry Value Type:    REG_DWORD

Registry Value Data:    1

For more information about how to add the reg, see [How to add, modify, or delete registry subkeys and values by using a .reg file](https://support.microsoft.com/help/310516).

##  More Information

For each image, Word determines whether there is a difference between the window (the original page) and the viewport (the printed page). When differences occur, for example, if the size of the page content according to Word does not match the size of the page it will print to, Word will scale up or down the total number of pixels it prints by using the ratio between the window and the viewport.

Finally, for each image, Word may scale the output if the total number of pixels is more than it can hold in memory for a given print job (based partially, on whether the printer will accept tiled printing or not).