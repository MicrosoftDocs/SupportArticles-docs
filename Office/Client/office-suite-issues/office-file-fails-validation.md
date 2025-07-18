---
title: Office has detected a problem with this file
description: Works around a problem that generates an Office has detected a problem with this file error message  when an Office 2010 file fails validation.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: mdandige
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Security\Trust
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office 2010
ms.date: 06/06/2024
---

# "Office has detected a problem with this file" error in Microsoft Office 2010

## Symptoms

You perform one of the following actions in a Microsoft Office 2010 application:

- Open an embedded object   
- Perform a mail merge   
- Open a file from a viewer   

In this situation, you receive the following error message:

```adoc
Office has detected a problem with this file. To help protect your computer this file cannot be opened.
```

## Cause

This problem occurs because Office File Validation detects a problem with the file that may pose a security risk. You receive the error message for a malicious file or for a damaged file. 

## Workaround

To work around this problem, move the file to a trusted location.

**Note** If you still experience this problem, contact your system administrator.

## More Information

Office File Validation is a feature that performs security checks on files. If Office File Validation detects a problem with a file, the file cannot be opened. 

A trusted location is a folder on your computer or on a network. Any file that you put in a trusted location can be opened without being checked by the Trust Center. Additionally, the file is not opened in Protected View. 

Files from the Internet and from other potentially unsafe locations may contain viruses, worms, or other kinds of malware. These agents may harm your computer. To help protect your computer, Office 2010 opens files from these potentially unsafe locations in Protected View. By using Protected View, you can read a file and inspect its contents. Additionally, you can reduce the risks that are associated with the actions that are mentioned in the "Symptoms" section. 

For more information about trusted locations, see [Add, remove, or modify a trusted location for your files](https://officebeta.microsoft.com/infopath-help/add-remove-or-modify-a-trusted-location-for-your-files-ha010354311.aspx?ctt=1).
