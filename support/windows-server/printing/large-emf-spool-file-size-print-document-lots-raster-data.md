---
title: EMF spool file size grows big when you print a document that contains lots of raster data
description: Describes a problem where the size of the Enhanced Metafile (EMF) spool file may grow very big when you print a document that contains many groups of raster data. A resolution is provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting:-print-spooler, csstroubleshoot
---
# The size of the EMF spool file may become very large when you print a document that contains lots of raster data

This article provides a resolution for an issue where the size of the Enhanced Metafile (EMF) spool file grows very big when you print a document that contains many groups of raster data.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 919543

## Symptoms

When you print a document that contains lots of raster data, the size of the Enhanced Metafile (EMF) spool file may become very large. Files such as Adobe .pdf files or Microsoft Word .doc/.docx documents may contain lots of raster data. Adobe .pdf files and Word .doc/.docx documents that contain gradients are even more likely to contain lots of raster data.

## Cause

This problem occurs because Graphics Device Interface (GDI) doesn't compress raster data when the GDI processes EMF spool files and generates EMF spool files.

This problem is very prominent with printers that support higher resolutions. The size of the raster data increases by four times if the dots-per-inch (dpi) in the file increases by two times. For example, a .pdf file of 1 megabyte (MB) may generate an EMF spool file of 500 MB. Therefore, you may notice that the printing process decreases in performance.

## Resolution

To resolve this problem, bypass EMF spooling. To do this, follow these steps:

1. Open the properties dialog box for the printer.
2. Click the **Advanced** tab.
3. Click the **Print directly to the printer** option.

> [!NOTE]
> This will disable all print processor-based features such as the following features:
>
> - N-up
> - Watermark
> - Booklet printing
> - Driver collation
> - Scale-to-fit

Once EMF spooling is turned off, you can use the Application to perform any N-up printing needed.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. 

## More information

### Steps to reproduce the problem

1. Open the properties dialog box for any inbox printer.
2. Click the **Advanced** tab.
3. Make sure that the **Print directly to the printer** option isn't selected.
4. Click to select the **Keep printed documents** check box.
5. Print an Adobe .pdf document that contains many groups of raster data.
6. Check the size of the EMF spool file.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
