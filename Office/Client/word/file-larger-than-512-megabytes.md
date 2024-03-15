---
title: Word cannot open this file because it is larger than 512 Megabytes
description: Provides workaround steps when you receive Word cannot open this file because it is larger than 512 Megabytes error in Word 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 03/31/2022
---

# "Word cannot open this file because it is larger than 512 Megabytes" when opening a document in Word 

## Symptoms

When you try to open a Word file, you receive an error:

> Word cannot open this file because it is larger than 512 Megabytes

## Cause

This is the maximum file size Word can open.

> [!NOTE]
> The maximum file size is limited to 32 MB for the total document text only and does not include graphics, regardless of how the graphics image is inserted (Link to file, Save with document, or Wrapping style) into the document. Therefore, if the file contains graphics, the maximum file size can be larger than 32 MB.

## Resolution

There is a workaround to resolve this issue.

Workaround Steps:

1. Rename the Word file to a Zip (.docx to .zip).   
2. Open Windows Explorer, locate, and then open the saved compressed file that has a .zip file name extension. 

    > [!NOTE]
    > To be able to change the 'docx' extension to 'zip', you have to have Windows Explorer's options set to show the extensions.

3. Select the word folder, and then open the media folder to display the graphics.   
4. Delete (or move to a new folder) some graphics to reduce the file size.   
5. Rename the file back to docx and open with Word. If Word displays some errors, because it cannot find some files, click Yes to recover the contents.   
6. There will be placeholders for the deleted (or moved images).   
7. Right-click the image placeholder, select Change Picture and browse to the folders where the pictures are saved to select the pictures.   
8. Click the arrow next to the Insert button and select Link to File.   
9. Save the document.   

## More Information

For more information about other Word for Windows operating limits, see [Operating parameter limitations and specifications in Word](https://support.microsoft.com/help/211489).
