---
title: You receive an error when using the built-in wizards
description: Fixes an issue in which you receive an error when using the built-in wizards after installing Microsoft Office 2010 SP1.
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
ms.reviewer: kswallow
appliesto:
- Access 2010 64 bit
---
# Fix an error in Microsoft Access 2010 while using the built-in wizards after installing Microsoft Office 2010 SP1

This article provides resolution to an error when you use the built-in wizards in Access 2010.

_Original KB number:_ &nbsp; 2581301

## Symptoms

When using the built-in wizards in Microsoft Office Access 2010 (64-bit) with Service Pack 1 (SP1), you receive the error:

> The database cannot be opened because the VBA project contained in it cannot be read. The database can be opened only if the VBA project is first deleted. Deleting the VBA project removes all code from modules, forms and reports. You should back up your database before attempting to open the database and delete the VBA project.

> Cannot update. Database or object is read-only.

> The Visual Basic for Applications project in the database is corrupt.

> Microsoft Access can't find the wizard. This wizard has not been installed, or there is an incorrect setting in the Windows Registry, or this wizard has been disabled.

> [!NOTE]
> This issue is specific to Microsoft Office Access 2010 (64-bit) and does not occur on 32-bit version of Access 2010.

## Cause

While installing the Office 2010 SP1, the built-in wizard files were not successfully updated.

## Resolution

To resolve this problem, follow these steps:

1. Close all instances of Microsoft Office Access 2010.
1. Rename the files listed below to (.old extension). These files are located at C:\Program Files\Microsoft Office\Office14\ACCWIZ.

    |     Original File Name    |     Rename To:      |
    |---------------------------|---------------------|
    |     Acwzmain.accde        |     Acwzmain.old    |
    |     Acwzlib.accde         |     Acwzlib.old     |
    |     Acwztool.accde        |     Acwztool.old    |
    |     Utility.accda         |     Utility.old     |

> [!NOTE]
> Before renaming files, ensure file extensions are visible. To see file name extensions in File Explorer:

1. Open File Explorer.
1. In File Explorer, select the **File name extensions** check box under the **View** tab.
1. Now, run Access 2010 again.
1. Once the program reconfigures, you should be able to use the wizards again.

### Did this fix the problem

If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).

## References

- [Error message when you run a compiled Microsoft Access MDE, ACCDE, or ADE file in Access 2010: "The database cannot be opened because the VBA project contained in it cannot be read" (64-bit only).](https://support.microsoft.com/help/2533794)
- ["Cannot update. Database or object is read-only" error in a query against a linked SharePoint view if there are unlinked lookup fields in Access.](https://support.microsoft.com/help/3200677)
- [Common file name extensions in Windows](https://support.microsoft.com/help/4479981)
