---
title: File path you entered is too long
description: You get The file path you entered is too long error when you save an Excel workbook that has a long path name to OneDrive.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
search.appverid: 
- MET150
appliesto:
- Excel 2016
- Excel 2013
---

# "File path you entered is too long" when saving Excel file in OneDrive

## Symptom

When you try to save a Microsoft Excel workbook in OneDrive, you receive the following error message:

```adoc
The file path you entered is too long. Enter a shorter file name or select a shorter file path, and then try saving the file again.   
```

## Cause

This issue occurs because the total length of the path and the file name, including the file name extension, exceeds 255 characters.  

> [!NOTE]
> This limitation includes the characters that represent the server name, the characters in folder names, the backslash character between folders, and the characters in the file name.

## Resolution

To fix the issue, make sure that the path of the file contains no more than 255 characters. To do this, use one of the following methods: 
 
- Rename the file so that it has a shorter name.    
- Rename one or more folders that contain the file so that they have shorter names.    
- Save the file to a folder that has a shorter path.    
