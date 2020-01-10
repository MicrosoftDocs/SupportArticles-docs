---
title: Force Excel to open in a new instance by default
description: Describes how to set a registry key to force Excel to open in a new instance when launched. This is a common request for large workbooks when using 32-bit Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel for Office 365
- Excel 2016
- Excel 2013
---

# How to force Excel to open in a new instance by default

## Symptoms

In Microsoft Excel 2013 and later versions, when you open multiple spreadsheets, they all open in the same instance of Excel. However, in some situations, such as when you're working with large Excel spreadsheets, you may want to open each one in a new instance. This article explains how to do that by configuring a registry key. 

> [!NOTE]
> This method works only when you use the Excel icon to open the application. If you use File Open within the Excel application or double-click a file in Windows Explorer, the files will still open in the same instance as designed. 

## Cause

By opening each spreadsheet in its own instance, the spreadsheet has a dedicated 2 gigabytes (GB) of memory to use. This is important if you are experiencing out-of-memory issues in a 32-bit version of Excel. 

> [!NOTE]
> If you are using the Large Address Aware option (see the "More Information" section), this limit may be increased.

## Resolution

To change the default setting, install the latest version of Office (build numbers referenced in the following table), and then add the key to the registry. The versions of Office that have the update include the following:

|Version|Release date|Build number|
|----|---|---|
|Office 365 for 2016 (Current Channel Subscribers)|May 3, 2016|Build 16.0.6868.2060|
|[Office 365 for 2013](https://support.microsoft.com/gp/office-2013-365-update)|June 7, 2016|Build 15.0.4833.1001|
|[Excel 2013 (MSI)](https://support.microsoft.com/help/3115162)|June 7, 2016|Build 15.0.4833.1000|
|[Excel 2016 (MSI)](https://support.microsoft.com/help/3115139)|June 7, 2016|Build 16.0.4393.1000 |

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit all instances of Excel.   
2. Start Registry Editor: 
   - In Windows 10, click Start, type regeditin the Search box, and then select regedit.exe in the search results.   
   - In Windows 8 or Windows 8.1, move the pointer to the upper-right corner, select Search, enter regeditin the search box, and then select regedit.exein the search results.     
3. Locate and select the following registry subkey:

   **HKCU\Software\Microsoft\Office\16.0\Excel\Options**   
4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.   
5. Enter DisableMergeInstance, and then press Enter.   
6. In the Detailspane, press and hold (or right-click) DisableMergeInstance, and then select Modify.   
7. In the Value databox, enter 1, and then click OK.   

## More Information

32-bit versions of Excel 2016 can take advantage of the Large Address Aware (LAA) functionality after installation of the [May 3, 2016, update for Outlook 2013 (KB3115031)](https://support.microsoft.com/help/3115031), build 16.0.6868.2060 for O365 Current Channel subscribers. This change lets 32-bit installations of Excel 2016 consume double the memory when users work on a 64-bit Windows OS. The system provides this capability by increasing the user mode virtual memory from 2 GB to 4 GB. This change provides 50-percent more memory (for example, from 2 GB to 3 GB) when users work on a 32-bit system. For more information about LAA, see [Large Address Aware capability change for Excel.](https://support.microsoft.com/help/3160741)

> [!NOTE]
> There are some known issues in opening each Excel spreadsheet in its own instance. For example, see [You cannot paste any attributes into a workbook in another instance of Excel](https://support.microsoft.com/help/917637).
