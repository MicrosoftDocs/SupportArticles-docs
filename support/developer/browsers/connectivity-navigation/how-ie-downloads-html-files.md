---
title: Via download manager to download HTML files
description: When downloading an HTM-file via Download Manager, the Open-command is not displayed, but only Save/Save As and Cancel.
ms.date: 06/09/2020
ms.reviewer: 
---
# How Internet Explorer downloads HTML-files through Download Manager

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about downloading documents containing html extension.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions
_Original KB number:_ &nbsp; 2846926

## Summary

When a website wants to raise an **Open/Save** dialog for a resource, it can do so, by adding a `Content-Disposition: attachment` header to the response. If the document to be downloaded contains one of the following extensions, Internet Explorer will only provide **Save**, **Save As** and **Cancel** as choices in the dialog. Internet Explorer will hide the `Open` command in case Internet Explorer itself will be the default handler for the extension.

- `htm`
- `html`
- `mht`
- `mhtml`
- `shtm`
- `xml`
- `xsl`

After the download has been finished via the **Save** button, the information bar at the bottom on the webpage will then provide the possibility to open the downloaded document from the folder to which it had been downloaded.

## More information

This behavior is By Design and had been introduced with Internet Explorer 9.

A description about the Content-Disposition, see [How To Raise a "File Download" Dialog Box for a Known MIME Type](https://support.microsoft.com/help/260519/how-to-raise-a-file-download-dialog-box-for-a-known-mime-type).

In case that another application than Internet Explorer (for example, Notepad.exe) will be default handler for the given extension, the Open-button will be offered and will then launch the application with the document.

A description about the configuration of the default handler is available, see [Change which programs Windows 7 uses by default](https://support.microsoft.com/help/18539/windows-7-change-default-programs).
