---
title: Can't view or change an Office document that's saved as a Web page
description: Describes how you cannot view or change an Office document that is saved as a Web page and stored in Windows SharePoint Services. To work around this problem, you can save the document as a single-file Web page or use the Upload Multiple Files option.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Web Server Integration (SharePoint & Non-SharePoint)
  - Save
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Excel
  - Microsoft PowerPoint
  - Microsoft Word
ms.date: 06/06/2024
---

# "The page cannot be found" or "Missing file" error when you view or change an Office document

## Symptoms

When you save a Microsoft Word document, a Microsoft Excel document, or a Microsoft PowerPoint presentation as a Web page and then you upload the Web page to the document library of your Microsoft Windows SharePoint Services Web site, you may experience one or more of the following symptoms:

- When you try to view the Web page, you receive the following error message:

  **The page cannot be found**

  **HTTP 404 - File not found**

- When you view the Web page, a box that contains a red "X" appears on the Web page instead of the graphic that you expect.
- When you try to edit the Web page (click the file name of the Web page in the document library, and then click **Edit in Microsoft Office ProgramName**), the Microsoft Office program starts as expected, however, a **Problems During Load** dialog box appears on your screen. The dialog box contains an error message that is similar to the following:

  ```asciidoc
  Problems came up in the following areas during load

  Missing file: Path/FileName
  ```

## Cause

This problem may occur if the following conditions are true:

- You save a Word document, an Excel document, or a PowerPoint presentation as a Web page (.htm or .html file).
- You do not use the **Upload Multiple Files**option after you click **Upload Document** on the **Shared Documents** page of your Windows SharePoint Web site to upload the document.

When you save a Word document, an Excel document, or a PowerPoint presentation as a Web page that uses an .htm or html extension, a main HTML file is created in addition to a folder that contains supporting files for the Web page. The folder uses the same name as the HTML file of the Web page. If you do not use the **Upload Multiple Files** option to upload the Web page, only the main HTML file of the Web page is uploaded to the document library. The thicket, or folder that contains graphics files and other files that are associated with the Web page is not uploaded to the document library. As a result, you may experience the symptoms that are described earlier in the "Symptoms" section of this article when you try to edit or view the Web page in the document library.

## Workaround

To work around this problem, use one of the following methods as appropriate to your situation.

### Method 1: Save the Office Document As a Single-File Web Page (*.mht; *.mhtml)

Save the Office document as a single-file Web page (.mht or .mhtml file) and then upload the Web page to the document library of your Windows SharePoint Services Web site. To save a Word document, an Excel document, or a PowerPoint presentation as a single-file Web page, follow these steps:

1. Start the Office program and open the document that you want to save as a single-file Web page.
2. On the **File** menu, click **Save as Web Page**.
3. In the **Save As** dialog box, click **Single File Web Page (.mht; .mhtml)** (if it is not already selected).
4. Specify a file name and a location where you want to save the Web page, and then click **Save**.

### Method 2: Use the Upload Multiple Files Option in Windows SharePoint Services

Use the **Upload Multiple Files** option to upload the Web page to the document library of a Windows SharePoint Services Web site. By doing so, you make sure that the HTML file and all other files that are associated with the Web page are uploaded to the document library. To use the **Upload Multiple Files** option to upload the Web page to the document library of a Windows SharePoint Services Web site, follow these steps:

1. In the document library of the Windows SharePoint Services Web site, click **Upload Document**.
2. On the **DocumentLibraryName** Document Library: Upload Document page, click **Upload Multiple Files**.
3. In the left pane, locate, and then click the folder that contains the main HTML file of the Office document that you saved as a Web page.
4. In the right pane, click to select the check box that is next to the HTML file of the Web page.
5. In the left pane, locate, and then click the folder that contains the thicket.
6. In the right pane, click to select the check boxes next to all the files that are stored in the thicket.
7. Click **Save and Close**.
8. Click **Yes** when you are prompted to confirm the upload operation.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More Information

For more information about Windows SharePoint Services, visit the following Microsoft Web site:

[https://technet.microsoft.com/windowsserver/sharepoint/default.aspx](https://technet.microsoft.com/windowsserver/sharepoint/default.aspx)
