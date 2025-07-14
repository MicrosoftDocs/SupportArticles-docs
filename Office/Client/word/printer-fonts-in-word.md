---
title: Using printer fonts in Word
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 06/06/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Word
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Printing
  - CI 122387
  - CSSTroubleshoot
ms.reviewer: sergeym
description: Explains how to use printer fonts in Microsoft Word after the feature has been deprecated.
---

# Information about using printer fonts in Microsoft Word

## Summary

Printer fonts are fonts native to a printer, as opposed to the fonts installed in the Windows operating system. Printer fonts can only be used on that printer and are not visible on screen.

> [!NOTE]
> The "Use fonts that are stored on the printer" option was removed from Word in version 11929.xxxxx.

Printer fonts currently have limited platform support. They can be used only in Windows and Win32 apps by using Windows APIs. However, they can't be used on MacOs, iOs, Android, or Windows UAP apps, and can't be exported to other formats.

## Use printer fonts in Word

Printer fonts can still be used in Office apps, but you must first install the font into Windows. Finding the font, however, may be an issue. Some suggestions are listed below on how to find printer fonts.

- Search the printer manufacturer’s website. For example, Zebra Printers have their fonts freely available on their web site.
- License them from original font vendor.
- Search third-party font distributors for fonts with similar designs and metrics.

For more information about using printer fonts in Word, see [Use printer device fonts](/troubleshoot/windows/win32/printer-device-fonts).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
