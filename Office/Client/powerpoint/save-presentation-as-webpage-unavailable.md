---
title: The options to save a presentation as a webpage are not available in the Save As dialog box in PowerPoint 2010
description: Describes an issue in which the htm and the mht webpage file type is not available as a save option in PowerPoint 2010.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- PowerPoint 2010
ms.reviewer: kemille
---
# The options to save a presentation as a webpage are not available in the Save as dialog box in PowerPoint 2010

This articles documents an issue in which the option to save a presentation as a webpage is not available in PowerPoint 2010.

_Original KB number:_ &nbsp; 980553

## Symptoms

When you try to save a presentation as a webpage in Microsoft PowerPoint 2010, the following **Save as type** options are not available in the **Save As** dialog box:

- **Web Page (*.htm; \*.html)**  
- **Single File Web Page (*.mht; \*.mhtml)**

## Workaround

To work around this issue, you can use the [PowerPoint object model](https://docs.microsoft.com/office/vba/api/overview/powerpoint/object-model). This method provides compatibility with older [add-ins](https://docs.microsoft.com/office/dev/add-ins/overview/office-add-ins) and macros and lets you save the file as \*.htm or \*.mht.

The method to save the PowerPoint file as a webpage (\*.htm; \*.html) to the desktop is without embedding True Type fonts (**msoFalse**) argument, and by using the **ppSaveAsHTML** argument for the *.htm file format.

Follow these steps, exactly as given below to save your file as a webpage:

1. In PowerPoint 2010, open the presentation that you want to export to HTML.
1. Press Alt+F11.
1. Press Ctrl+G.
1. Type the following in the pane that is now open and then press Enter:

    ```console
    ActivePresentation.SaveAs "<Drive>:\users\<username>\desktop\<filename>.htm", ppSaveAsHTML, msoFalse
    ```

    Replace \<Drive>:\users\\\<username>\desktop\\\<filename>.htm with the location where you wish to save your file as a webpage.

    > [!NOTE]
    > If you wish to save the file as a single webpage with "\*.mht" or "\*.mhtml" file format, just replace **htm** extension at the end of the file name with **mht**, and replace **ppSaveAsHTML** with **ppSaveAsWebArchive**.

    Example:

    ActivePresentation.SaveAs "\<Drive>:\users\\\<username>\desktop\\\<filename>.mht", ppSaveAsWebArchive, msoFalse

For more information about the SaveAs method in PowerPoint 2010, go to the following Microsoft website:

[Presentation.SaveAs Method (PowerPoint)](https://docs.microsoft.com/office/vba/api/PowerPoint.Presentation.SaveAs)

For more information about the files types that can be passed to the SaveAs method, go to the following Microsoft website:

[PpSaveAsFileType Enumeration](https://docs.microsoft.com/office/vba/api/PowerPoint.PpSaveAsFileType)
