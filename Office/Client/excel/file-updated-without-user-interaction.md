---
title: Excel Online updates file stored in document library without user interaction
description: Describes why some files automatically update in Excel Online when no changes have been made.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel for the web
---

# Excel Online updates a file stored in the document library without user interaction

## Summary

When you use Excel Online to open an Excel file stored in the document library, the fields such as Modified, Modified By, and Version are updated without user interaction in the following cases: 

- The file was created in Excel 2010, 2013, or 2016 MSI.    
- You open the file with Excel Online for the first time after uploading it to the document library.

## More information

This is by design. Excel applications have an internal calculation engine for each version, and Excel files contain information about which version of the calculation engine is used to create the file. The first time you open a file created in an earlier version of Excel using Excel Online, the recalculation is processed automatically. Due to this behavior, the file is updated without user interaction.

### Steps to Reproduce Behavior

1. Create a new file in Excel 2010, 2013, or 2016 MSI.    
2. Upload the file to the document library.    
3. Open the file with Excel Online.    
4. Close the file without any changes.    

The result is an updated file.
