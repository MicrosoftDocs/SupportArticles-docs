---
title: Workbook loads slowly the first time that it is opened
description: Provides the resolution to make sure the file in Excel can be opened as usual.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: christm 
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Microsoft Office Excel 2007
- Excel 2010Excel 2013
- Excel 2016
---

# Workbook loads slowly the first time that it is opened in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

When you open a file in Microsoft Excel for the first time, the file may take more time than usual to load.

Also, when you close the file, you may receive the following prompt: 

> Do you want to save the changes you made to \<Filename>?

> [!NOTE]
> In this message, **Filename** represents the name of the file that you are closing.

Microsoft Excel recalculates formulas when it opens files that were last saved by an earlier version of Excel.

##  Cause

This problem occurs because a file is recalculated the first time that you open it if the file was last saved in a previous version of Excel.

Starting in Microsoft Excel 2000, Excel forces a complete recalculation of all workbooks that are opened if they were previously saved in an earlier version of Excel, regardless of the link-update status. To fully recalculate the workbook, Excel forces updates of all external references as well, even if you choose not to update when you are prompted to. This process occurs because Excel is updating the workbook calculation chain to the current version.

##  Resolution

After you save the workbook in the later version of Excel, the workbook will take less time to open on subsequent tries. 

##  References

For more information about Excel fully recalculating workbooks when they are opened for the first time, click **Microsoft Excel Help** on the **Help** menu, type **About the way Excel recalculates workbooks that were created in earlier versions** in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.