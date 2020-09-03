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

## Symptoms

When you save a workbook in Microsoft Excel, one of the following error messages is displayed:

> Cannot access read-only document \<filename>  

> Disk is full.

> Document not saved.

> Document not completely saved.

> Document not saved. Any previously saved copy has been deleted.  
> The document is not saved.

> \<filename>.xls is locked for editing by *'user name'*. Click 'Notify' to open a read-only copy of the document and receive notification when the document is no longer in use.

## Cause

This problem occurs if the process to save an Excel workbook is interrupted for any of the following reasons:

- On a network drive, the connection is dropped, or you have restricted permissions to save the file.
- The location or drive does not have sufficient space to save in.
- A conflict exists with an antivirus software program.
- A removable disk, such as a USB pen-drive or USB-HDD/SSD, is removed.
- The 218-character path limitation is exceeded.
- An Excel file that you are saving is shared.


## Resolution

To continue working on the file, save it to a different drive or location. The connection to the file must be restored before you can resume working on it. In case of a hardware failure, you must correct the problem before you can save to that drive again.

## More information

When you work in a workbook, Microsoft Excel saves the file by giving it a temporary file name, and then puts the file into the same folder as the original file. When you save the workbook, the original file is deleted and the temporary file is renamed by using the original file name.

If this process is interrupted, the workbook may not be saved correctly. You may also find one or more temporary files in the folder where you tried to save your file. Additionally, you may receive one of several alerts or error messages.

The following information lists some of the possible messages that you may receive, and explains why you may receive them.

### Cannot access read-only document \<file name>

This this error message is displayed if you are trying to make changes to a file to which you have only read permissions. This is because the administrator or the owner of the file has not granted you permission to edit the file. If the file does not have the ”read-only” tag but this error message continues to appear while you are trying to save the file to your folder, either of the following reasons might be the cause:

- You open an existing file, and then try to save it.
- You save the file to an external or network drive, and the connection fails.

### Disk is full

The drive that you are saving to does not have enough space, or the disk was accidentally detached from the system. Delete some files from the current drive or save the file to another drive. 

### Document not saved," or "Document not saved

The process was interrupted while it was creating a temporary file because you accidently pressed ESC, or there was some hardware or software failure or some other media problem. The original file is still intact., Unless your computer or workstation failed, the version of the file that contains your current changes is still open in memory. Save the file to an alternative drive. 

> [!NOTE]
> Any changes made in the last revision will be lost.

### Document not saved. Any previously saved copy has been deleted

The process was interrupted while it was deleting the original file or renaming the temporary file. This problem occurs for the same reasons as in the scenario that is described in the "'Document not saved’ or ‘Document not completely saved'" section. 

In this case, your original file is deleted (although the temporary file may be readable). If your computer or workstation failed, use the temporary file. If the interruption was caused by something else, the version of the file that contains your current changes is still open in memory. Save the file to an alternative drive.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).