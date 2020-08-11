---
title: Excel or Word crashes on close
description: Article documenting Excel 2013 and Word 2013 crash for OffCAT Support
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: gregmans
appliesto:
- Excel 2013
- Word 2013
---

# Excel 2013 or Word 2013 crashes on close after using the Insert menu

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Microsoft Excel 2013 or Microsoft Word 2013 may crash on exit after certain actions, such as using the Insert menu.

If you then review the events in the Application Event log you find any of the following crash signatures for Event ID 1000.

For Microsoft Excel 2013

|Faulting application name|Version|Faulting module name|Version|Offset|
|---|---|---|---|---|
|Excel.exe|15.0.4623.1000|osf.dll|15.0.4623.1000|0x00016033 |
|Excel.exe|15.0.4621.1000|osf.dll|15.0.4609.1000|0x0000000000006D89 |
|Excel.exe|15.0.4615.1000|osf.dll|15.0.4609.1000|0x0000000000006D89|
|Excel.exe|15.0.4605.1000|osf.dll|5.0.4603.1000|0x00015F8D |
|Excel.exe|15.0.4569.1504|osf.dll|15.0.4569.1504|0x00015C8B|

For Microsoft Word 2013

|Faulting application name|Version|Faulting module name|Version|Offset|
|---|---|---|---|---|
|Winword.exe|15.0.4569.1504|osf.dll|15.0.4569.1504|0x00015C8B|
|Winword.exe|15.0.4623.1000|osf.dll|15.0.4609.1000|0x0000000000006D89|
|Winword.exe|15.0.4623.1000|osf.dll|15.0.4609.1000|0x00015FA1|
|Winword.exe|15.0.4615.1000|osf.dll|15.0.4609.1000|0x0000000000006D89|
|Winword.exe|15.0.4609.1000|osf.dll|15.0.4615.1000|0x00015FC9|

**Note** There may be other crash signatures related to this issue. Therefore, if you find a crashing event for Winword.exe or Excel.exe where the crashing module name is Osf.dll, we recommend following the resolution below.

## Cause

This has been identified as a problem in a DownloadManager (osf.dll) component of Microsoft Office 2013.

## Resolution

This issue is fixed in the Office 2013 hotfix package KB2825683 that is dated July 8, 2014. For more information, click the following article number to view the article in the Microsoft Knowledge Base: 

[2825683](https://support.microsoft.com/help/2825683) Hotfix KB2825683 for Office 2013 July 8, 2014 (Osfclient-x-none.msp)  

## More Information

You can use the following steps to review the Application event log: 

1. In Control Panel, open Administrative Tools.    
2. Double-click Event Viewer.   
3. In the left pane, select Application under Windows Logs.    
4. In the Actions pane, click Filter Current Log.   
5. In the Filter Current Log dialog box, enter 1000 (as shown in the following figure) and then click OK. 

   ![type 1000 in Filter Current Log dialog box](./media/excel-word-crash-on-close/filter-some-events-in-log.jpg)