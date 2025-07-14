---
title: The image part with relationship rID8 was not found in Microsoft Word
description: Fixes an issue in which you cannot save and open a Word document into which you imported an image.
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shraycha
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Pictures
  - CSSTroubleshoot
appliesto: 
  - Microsoft Word
ms.date: 06/06/2024
---

# "The image part with relationship rID8 was not found" error in Microsoft Word

## Symptoms

When you save and then open a Microsoft Word document into which you imported an image, you see the following message displayed in the place of the picture:

> The image part with relationship ID rID8 was not found in the file

## Cause

This occurs when there is a missing target in the XML document. The target field is set to "NULL."

## Resolution

To resolve this error, follow the steps below:

1. Use File Explorer to browse to the folder where the document is stored.
2. Right-click the file and select **Rename**. Change the extension of the file from .docx to .zip, then select Enter.

   > [!NOTE]
   > If you see a dialog box that asks "Are you sure you want to change it?", select **Yes**.

3. Double click the file (or right-click and select **Open**).
4. Browse to the word/_rels folder.
5. Open the file document.xml.rels file in Notepad or any text editor.

   > [!NOTE]
   > In many cases, if you double-click an XML file, it will open in a web browser which will not allow you to edit the file. To open in Notepad, select **Start** and then type notepad. Start Notepad, select **Open**, and then browse to the folder listed in step 4. If you do not see the file, type **.** in the **File name** field and select Enter.

6. Search the document.xml.rels file for rID8.
7. In the example below, the target is incorrectly set to NULL:

    ```console
    <Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="NULL"/>
    ```

    As a fix, replace NULL with the name of the image (which should be stored in the media folder):

    ```console
    <Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/yourimagename.jpeg"/>
    ```

8. Save and close the XML file.
9. Use File Explorer to browse again to the file and change the extension from .zip to .docx.
10. Open the file and check to see if the image appears.
