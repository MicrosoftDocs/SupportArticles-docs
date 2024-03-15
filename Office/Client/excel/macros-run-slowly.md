---
title: Excel macros that protect and unprotect worksheets may run slowly
description: Describes an issue in which macros in Excel 2013 may run slower than expected.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# Excel macros that protect and unprotect worksheets may run slowly

## Symptoms

Macros in Microsoft Excel 2013 run slower than in earlier versions of Excel. For example, you may notice that .xlsm files open very slowly or that it takes a long time to move to the next cell when you enter data in cells.

## Cause

Because of a new, stronger hashing algorithm (SHA-512) for encryption in Microsoft Office 2013, macros that protect worksheets and unprotect worksheets run slower if they protect or unprotect several worksheets sequentially.

## Resolution

This behavior is by design. It's not noticeable when you're manually protecting a worksheet. However, if you have code that protects or unprotects work sheets repeatedly, this behavior can cause a performance issue.

## More Information

The delay is caused by a stronger hashing algorithm (SHA-512) than is present in earlier versions. (The default hashing algorithm to protect files by requiring a password in Office 2010 is SHA1.) This change can cause a performance issue for some Office developers.  

For more information about worksheet protection, click the following article number to view the article in the Microsoft Knowledge Base:

[822924](https://support.microsoft.com/help/822924) Description of Office features that are intended to enable collaboration and that are not intended to increase security