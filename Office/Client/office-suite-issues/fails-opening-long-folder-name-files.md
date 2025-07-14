---
title: Can't open an Office file that has a long folder name
description: Describes a problem where you may receive an error message when you open an Office file that has a long folder name.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Word 2002
  - Microsoft PowerPoint 2002
  - Microsoft Access 2002
  - Microsoft Excel 2002
  - Microsoft Outlook 2002
ms.date: 06/06/2024
---

# Error message when you open an Office file that has a long folder name

For a Microsoft Office 2000 version of this article, see [325573](https://support.microsoft.com/help/325573).

## Symptoms

When you open specific files in Microsoft Office Excel 2007, you receive the following error message if the files are in folders that have long names:

```asciidoc
'<filename>.<extension>' could not be found. Check the spelling of the file name, and verify that the file location is correct. If you are trying to open the file from your list of most recently used files on the File menu, make sure that the file has not been renamed, moved, or deleted.
```

When you open specific files that are in folders that have long folder names in Microsoft Word 2002, Microsoft PowerPoint 2002, Microsoft Access 2002, Microsoft Excel 2002, and Microsoft Outlook 2002, you receive one of the following error messages:

**Filename is not valid.**

**The file could not be accessed.**

**The path you entered, is too long. Enter a shorter path.**

**File Name could not be found. Check the spelling of the filename, and verify that the file location is correct.**

## Cause

This behavior occurs because the 2007 Office suites, Microsoft Office 2003, and Microsoft Office XP have a character limitation of 256 characters for folder names.

## Workaround

To resolve this behavior, make sure that the path of the file contains less than 256 characters. To do this, use one of the following methods:

- Rename the file so that it has a shorter name.
- Rename one or more folders that contain the file so that they have shorter names.
- Move the file to a folder with a shorter path name.

## More Information

You also receive the error messages that are described in the "Symptoms" section of this article when you save or open a file that meets the following situations:

- Word 2002:

  The total length of both the path and the file name, including the file name extension, exceeds 255 characters.

- PowerPoint 2002:

  The total length of both the path and the file name, including file name extension, exceeds 256 characters.

- Access 2002:

  The total length of both the path and the file name, including file name extension, exceeds 249 characters.

- Excel 2002:

  The total length of both the path and the file name, including file name extension, exceeds 218 characters.

- Outlook 2002:

  The total length of both the path and the file name, including file name extension, exceeds 255 characters.

  > [!NOTE]
  > This limitation includes three characters that represent the drive, the characters in the folder names, the backslash character between folders, and the characters in the file name.
