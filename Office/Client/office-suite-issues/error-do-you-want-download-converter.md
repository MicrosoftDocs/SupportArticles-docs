---
title: Can't open a file (.xslx, .docx, .pptx) in Excel 2010, Word 2010, or PowerPoint 2010
description: Discusses an issue in which you receive an error message to download a converter when you try to open an Excel 2010 workbook (.xlsx), a Word 2010 document (.docx), or a PowerPoint 2010 presentation (.pptx).
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: troubleshooting
ms.author: v-six
appliesto:
- Microsoft Word 2010
- Microsoft Excel 2010
- Microsoft PowerPoint 2010
- - Microsoft Word 2007
- Microsoft Excel 2007
- Microsoft PowerPoint 2007
ms.reviewer: jenl
---
# Error message while trying to open a file (.xslx, .docx, .pptx) in Excel 2010, Word 2010, or PowerPoint 2010

_Original KB number:_ &nbsp; 967950

## Symptoms

> [!note]
> This issue does not apply to Office 2013 or newer versions as they support the standard Open XML formats. For more information, see [Open XML Formats and file name extensions](https://support.microsoft.com/office/open-xml-formats-and-file-name-extensions-5200d93c-3449-4380-8e11-31ef14555b18).

When you try to open a file (.xlsx, .docx, .pptx) in Microsoft Excel 2010, Word 2010, or PowerPoint 2010, you receive one of the following error messages:

> This file was created by a newer version of Microsoft Excel and a converter is needed to open it. Do you want to download the converter from the Microsoft Office Web site?

> This file cannot be opened by using Microsoft Excel. Do you want to search the Microsoft Office Online Web site for a converter that can open the file?

> [!NOTE]
> The above messages are displayed when you try to open an Excel file. When you try to open a Word or PowerPoint file, the product names in the message are replaced accordingly.

## Cause

The file (.xlsx, .docx, or .pptx) that you are trying to open may have been created by a third-party (non-Microsoft) software product in compliance with the International Standard ISO/IEC 29500 Office Open XML (OOXML). However, Excel 2007, Excel 2010, Word 2007, Word 2010, PowerPoint 2007, and PowerPoint 2010 don't support all the standards that are outlined by ISO/IEC 29500.

## Resolution

To resolve this issue, follow these steps:

1. Go to the Microsoft Download Center to download and install the [OOXML Strict Converter for Office 2010](https://www.microsoft.com/download/details.aspx?id=38828).
2. Open the file in Excel 2010, Word 2010, or PowerPoint 2010.
3. Click **Open** when the following message appears.

    ![This is the screenshot for this step. ](./media/error-do-you-want-download-converter/screenshot.png)

4. When the file opens, select **Save As** to save the file in Excel 2010, Word 2010, or PowerPoint 2010 default format.

    > [!NOTE]
    > If your issue wasn't resolved by the download, see one of the following Office Blogs:
    >
    > - [The Microsoft Excel Support Team Blog](/archive/blogs/the_microsoft_excel_support_team_blog/do-you-want-to-download-the-converter-when-you-try-to-open-a-file-in-excel-word-or-powerpoint-kb-article)
    > - [Microsoft Office Word Support Team Blog](/archive/blogs/wordonenotesupport/do-you-want-to-download-the-converter-when-you-try-to-open-a-file-in-excel-word-or-powerpoint-kb-article)
    > - [Business Graphics Products - Support Blog](/archive/blogs/bgp/do-you-want-to-download-the-converter-when-you-try-to-open-a-file-in-excel-word-or-powerpoint-kb-article)
