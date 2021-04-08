---
title: Error (Do you want to download the converter) in Office
description: Discusses an issue in which you receive an error message to download a converter when you try to open an Excel 2010 workbook (.xlsx), a Word 2010 document (.docx), or a PowerPoint 2010 presentation (.pptx).
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: troubleshooting
ms.author: luche
appliesto:
- Microsoft Word 2010
- Microsoft Excel 2010
- Microsoft PowerPoint 2010
ms.reviewer: jenl
---
# Error message (Do you want to download the converter?) when trying to open a file in Word, Excel, or PowerPoint

_Original KB number:_ &nbsp; 967950

> [!note]
> This issue doesn't apply to Office 2013 and newer versions as they support the standard Open XML formats. For more information, see [Open XML Formats and file name extensions](https://support.microsoft.com/office/open-xml-formats-and-file-name-extensions-5200d93c-3449-4380-8e11-31ef14555b18).

> [!note]
> Support for Office 2010 ended on October 13, 2020. This means that Microsoft no longer provides technical support, bug fixes, or security updates, and customers that continue to use them may face increased security risks and compliance issues over time. Microsoft recommends customers update to either Office 2019 or Microsoft 365 Apps. For more information, see [Support for Office 2010—and Office 2016 for Mac—has ended: Here’s what you need to know - Microsoft 365 Blog](https://www.microsoft.com/microsoft-365/blog/2020/10/13/support-for-office-2010-and-office-2016-for-mac-has-ended-heres-what-you-need-to-know/).

## Symptoms

When you try to open a file (.docx, .xlsx, or .pptx) in Word 2010, Excel 2010, or PowerPoint 2010, you see one of the following error messages:

> This file was created by a newer version of Microsoft Excel and a converter is needed to open it. Do you want to download the converter from the Microsoft Office Web site?

> This file cannot be opened by using Microsoft Excel. Do you want to search the Microsoft Office Online Web site for a converter that can open the file?

> [!NOTE]
> The above messages are displayed when you try to open an Excel file. When you try to open a Word or PowerPoint file, the product names in the message are replaced accordingly.

## Cause

The file you’re trying to open (.docx, .xlsx, or .pptx) may have been created by a third-party (non-Microsoft) software product in compliance with the International Standard ISO/IEC 29500 Office Open XML (OOXML). However, Word 2010, Excel 2010, and PowerPoint 2010 (as well as Word 2007, Excel 2007, and PowerPoint 2007) don't support all ISO/IEC 29500 standards.

## Resolution

To resolve this issue, follow the steps below.

1. Go to the Microsoft Download Center to download and install the [OOXML Strict Converter for Office 2010](https://www.microsoft.com/download/details.aspx?id=38828).
2. Open the file again in Word 2010, Excel 2010,  or PowerPoint 2010.
3. Select **Open** when the following message appears:

    ![Screenshot of the message, selecting the Open button.](./media/error-do-you-want-download-converter/select-open.png)

4. When the file opens, select **Save As** to save the file in the Word 2010, Excel 2010, or PowerPoint 2010 default format.

    > [!NOTE]
    > If you are still experiencing issues after running this procedure, see the following Office Blogs for additional resources that may be useful:
    >
    > - [Microsoft Office Word Support Team Blog](https://blogs.technet.microsoft.com/wordonenotesupport/2016/11/02/do-you-want-to-download-the-converter-when-you-try-to-open-a-file-in-excel-word-or-powerpoint-kb-article/)
    > - [The Microsoft Excel Support Team Blog](https://blogs.technet.microsoft.com/the_microsoft_excel_support_team_blog/2016/11/02/do-you-want-to-download-the-converter-when-you-try-to-open-a-file-in-excel-word-or-powerpoint-kb-article/)
    > - [Business Graphics Products Support Team Blog](https://blogs.technet.microsoft.com/bgp/2016/11/02/do-you-want-to-download-the-converter-when-you-try-to-open-a-file-in-excel-word-or-powerpoint-kb-article/)

## More information

A Word document (.docx), Excel workbook (.xlsx), or PowerPoint presentation (.pptx) can be created by non-Microsoft software products by using the standards that are outlined by ISO/IEC 29500. Therefore, Office versions released after the 2007 Microsoft Office suite Service Pack 2 (SP2) have supported many of the requirements of the ISO/IEC 29500 standard. However, not all of the standards are supported in Microsoft Office.

For more information about the adoption of the ISO 29500 standard by Microsoft, see  [Microsoft Expands List of Formats Supported in Microsoft Office](https://news.microsoft.com/2008/05/21/microsoft-expands-list-of-formats-supported-in-microsoft-office/).