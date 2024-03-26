---
title: The options to save a presentation as a webpage are not available in the Save As dialog box in PowerPoint 2010
description: Describes an issue in which the htm and the mht webpage file type is not available as a save option in PowerPoint 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - PowerPoint 2010
ms.reviewer: kemille
ms.date: 03/31/2022
---
# The save as webpage options are not available in PowerPoint 2010

## Symptoms

When you try to save a presentation as a webpage in Microsoft PowerPoint 2010, the following **Save as** type options are not available in the **Save As** dialog box:

- Web Page (*.htm;*.html)
- Single File Web Page (*.mht;*.mhtml)

## Workaround

To work around this issue, use the [PowerPoint object model](/office/vba/api/overview/powerpoint/object-model). This method provides compatibility with older [add-ins](/office/dev/add-ins/overview/office-add-ins) and macros, and enables you to save the file as `*.htm` or `*.mht`.

This method to save a PowerPoint file as a webpage (\*.htm; \*.html) to the desktop uses the **ppSaveAsHTML** argument for the *.htm file format. It does not include the **msoFalse** argument to embed True Type fonts.

To save your file as a webpage, follow these steps:

1. In PowerPoint 2010, open the presentation that you want to export to HTML.
2. Press Alt+F11 to open Microsoft Visual Basic for Applications.
3. Press Ctrl+G to open the **Immediate** pane.
4. In the **Immediate** pane, type the following command, and then press Enter:

    `ActivePresentation.SaveAs "<Drive>:\users\<username>\desktop\<filename>.htm", ppSaveAsHTML, msoFalse`

    > [!NOTE]
    >
    > - In this command, replace \<*Drive*>:\users\\<*username*>\desktop\\<*filename*>.htm` with the location where you want to save your file as a webpage.
    > - If you want to save the file as a single webpage in the `*.mht` or `*.mhtml` file format, replace the **htm** extension at the end of the file name with **mht**, and replace **ppSaveAsHTML** with **ppSaveAsWebArchive**. For example:
    `ActivePresentation.SaveAs "<Drive>:\users\<username>\desktop\<filename>.mht", ppSaveAsWebArchive, msoFalse`

## References

For more information about the **Presentation.SaveAs** method in PowerPoint 2010, see [Presentation.SaveAs Method (PowerPoint)](/office/vba/api/PowerPoint.Presentation.SaveAs).

For more information about the files types that can be passed to the  **Presentation.SaveAs** method, see [PpSaveAsFileType Enumeration (PowerPoint)](/office/vba/api/PowerPoint.PpSaveAsFileType)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
