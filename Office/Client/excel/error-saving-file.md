---
title: You receive an error message when you try to save a file in Excel
description: Describes several possible error messages that you may receive when you save a file in Excel. Discusses the causes and corresponding resolutions. You can temporarily save the file to a different disk drive to continue working with the file.
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
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
ms.reviewer: 
---
# Error while saving a file in Excel

This article documents a list or errors when you save a file in Excel.

_Original KB number:_ &nbsp; 214073

## Symptoms

When you save a document in Microsoft Excel, one of the following error messages may appear:

> Cannot access read-only document \<filename>  

> Disk is full.

> Document not saved.

> Document not completely saved.

> Document not saved. Any previously saved copy has been deleted.  
> The document is not saved.

> \<filename>.xls is locked for editing by *'user name'*. Click 'Notify' to open a read-only copy of the document and receive notification when the document is no longer in use.

## Cause

This problem occurs when the process to save Excel file gets interrupted, due to any of the following reasons:

- On network drive the connection got dropped or you have restricted permissions to save the file.
- Saving location/drive does not have sufficient space.
- Conflict with an antivirus software program.
- Removable disk got removed, such as a USB pen-drive or USB-HDD/SSD
- The 218-character path limitation is exceeded
- You save an Excel file that is shared.

## Resolution

To continue working with the file, save it to a different drive or location. The connection to the file must be restored before you can resume working with the file. In case of a hardware failure, you must correct the problem before you can save to that drive again.

## More information

When you work in a file, Microsoft Excel saves the file with a temporary file name and places this file in the same folder as the original file. When you save your file, the original file is then deleted and the temporary file is renamed with the original file name.

If this process is interrupted, your file may not be saved properly. You may also find one or more temporary files in the folder where you tried to save your file. In addition, you may receive one of several alerts or error messages.

The following information lists some of the possible messages you may receive and explanations as to why you may receive them:

### Cannot access read-only document \<file name>

If you are trying to make changes to the file that is ‘read-only’, this error will be displayed. This is because the administrator or the owner of the file has not given you the permission to edit the document and you can only read it. If the file does not have ‘read-only’ tag but this error keeps on appearing while you are trying to save the file in your folder, this could happen because:

- You open an existing file and try to save it.
- You save file to an external or network drive and the connection fails.

### Disk is full

The drive you are saving to does not have enough space or the disk was accidentally detached from the system. Delete some files from the current drive or save file to another drive.

### Document not saved," or "Document not saved

The process was interrupted while creating the temporary file because you accidentally pressed ESC, or there was some hardware/software failure, or some other media problem. The original file is still intact, unless your computer or workstation failed, the version of the file containing your current changes is still open in memory. Save the file to an alternate drive.

> [!NOTE]
> Any changes made in the last revision will be lost.

### Document not saved. Any previously saved copy has been deleted

The process was interrupted while deleting the original or renaming the temporary file. This problem will occur for the same reasons as the scenario described in the "'Document not saved,' or 'Document not completely saved'" section.

In this case, your original file is gone (though the temporary file may be readable). If your computer or workstation failed, use the temporary file. If the interruption was caused by something else, the version of the file containing your current changes is still open in memory. Save the file to an alternate drive.

## References

For more information, select the following article numbers to view the articles in the Microsoft Knowledge Base:

> [223812](https://support.microsoft.com/help/223812) Error message: Document not saved
