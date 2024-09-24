---
title: Error when you open a Word document or an Excel worksheet
description: Discusses the problem where you may receive an error message when you open a Word or an Excel file. You may experience the problem when the file is added in the list of disabled files for the Office program.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Word 2007
  - Excel 2007
  - Word 2003
  - Excel 2003
ms.date: 06/06/2024
---

# "The document caused a serious error the last time it was opened" when you open a file

## Symptoms

When you try to open a file that Microsoft Office Excel or Microsoft Office Word could not open previously, you may receive the following error message:

```asciidoc
The document 'Filename' caused a serious error the last time it was opened. Would you like to continue opening it? You may receive this message every time you try to open the file.
```

## Cause

This problem occurs because the file appears on the list of disabled files for the Microsoft Office program. The program adds a file to this list if the file causes a serious error, such as causing the program to quit unexpectedly (crash) during two or more tries to open it. This message allows you to avoid potential problems that may occur if you open the file.

## Resolution

To resolve this problem, remove the file from the list of disabled files. To do so, follow these steps:

### Word 2003 or Excel 2003

1. In Word 2003 or Excel 2003, click
**About Microsoft **Program**** on the **Help** menu to view the list of disabled files.   
2. Click **Disabled Items**.   
3. To re-enable one of the listed items, click the item, and then click **Enable**.    

### Word 2007 or Excel 2007

1. In Word 2007 or Excel 2007, click the **Microsoft Office Button**, and then click **Word Options** to view the list of disabled files.   
2. In the left pane, click
**Add-Ins**.   
3. In the right pane, select **Disabled Items** in the **Manage** list, and then click
**Go**.   
4. To re-enable one of the listed items, click the item, and then click **Enable**.   

> [!NOTE]
> Although a file is enabled, the program may still be unable to open it. The file may still cause serious errors.
