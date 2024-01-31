---
title: Print from Modern App creates large file
description: Describes an issue that occurs when you print from Modern App as this creates a large spool file when you select Advanced Printing features such as number of pages per sheet.
ms.date: 09/24/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
ms.subservice: printing
---
# Printing from Modern App creates large spool file when you select Advanced Printing features

This article describes an issue that occurs when you print from Modern App as this creates a large spool file when you select Advanced Printing features such as number of pages per sheet.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2989058

## Symptoms

Consider the following scenario:

- You have a system that is running Windows 10.
- You have a document open in a Modern App that contains images and text on multiple pages, for example a PDF file.
- You try to print the file by using a PostScript or PCL6-based printer driver.
- Within the printer properties, you select the print feature to include more than one page per sheet.

In this scenario when the print job is sent to the print queue, you may notice that the size of the print job is larger than the file size.

## Cause

This issue is expected behavior as the spooled data has to be converted from XPS data to an Enhanced MetaFile (EMF). This is so that data can be converted by the GDI engine into the Printer Definition Language (PDL) data that the print device can then receive.

In some cases, the JPEG pass-through won't be used, as rotation of JPEG images is unsupported in this scenario.

## Resolution

To work around this issue, you have to limit the size of the spooled data. Print the documents from a desktop application as there will be no data conversion required for the print device.
