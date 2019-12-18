---
title: Excel 2013 crashes when working on multiple workbooks
description: Describes an issue in which Excel 2013 crashes when working on multiple workbooks. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
ms.reviewer: jansur
appliesto:
- Excel 2013
---

# Excel 2013 crashes when working on multiple workbooks

## Symptoms

While you are working with multiple Excel workbooks, Microsoft Excel 2013 crashes when you are interacting with one of editor windows shortly before the workbook owning this editor window is closed.

When you examine your Application event log, you find an event (Event ID = 1000) with a crash signature that matches one of the following.

|Application Name|Application Version|Module Name|Module Version|Offset|
|---|---|---|---|---|
|Excel.exe|15.0.4517.1004|Excel.exe|15.0.4517.1004|0x00A83E00|
|Excel.exe|15.0.4569.1504|Excel.exe|15.0.4569.1504|0x00A8FEBF|
|Excel.exe|15.0.4605.1000|Excel.exe|15.0.4605.1000|0x00A8FD81|
|Excel.exe|15.0.4535.1507|Excel.exe|15.0.4535.1507|0x00A86CAD|
|Excel.exe|15.0.4551.1003|Excel.exe|15.0.4551.1003|0x00A86D07|

## Cause

This problem is caused by a known issue in certain builds of Microsoft Excel 2013.

## Resolution

If you find a crash signature in your Application event log that matches one of the signatures in the table in the System section, please install the latest update for Excel. The method of updating depends on whether you have a Click-to-Run installation of Office or an MSI installation of Office.

To see whether you are using a Click-to-Run installation of Office 2013, click the File tab in Excel and then click Account. If you see "Office Updates" under Product Information, as shown in the following figure, you are using a Click-to-Run installation of Office.

![](./media/crash-when-work-on-multiple-workbooks/check-office-updates.PNG)

If you do not see "Office Updates" under Product Information, you have an MSI installation of Office 2013.

For the latest updates for Office, reference [Office updates](https://docs.microsoft.com/officeupdates/?redirectedfrom=MSDN).

## More Information

The following crash signatures have not been correlated to reproducible steps that cause the crash. Crash signatures are based on a combination of the different elements listed in the signature data. So, if you find one of these crash signatures in your application event log, then the update recommended by this article has a very high chance of stopping these particular crashes on your computer.
