---
title: Force Excel to open in a new instance by default
description: Describes how to set a registry key to force Excel to open in a new instance when launched. This is a common request for large workbooks when using 32-bit Excel.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-kccross, akeeler, v-lisalozano
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Open
  - CSSTroubleshoot
  - CI 11127
search.appverid: 
  - MET150
appliesto: 
  - Excel for Microsoft 365
  - Microsoft Excel 2024 
  - Microsoft Excel 2021 
  - Microsoft Excel 2016
ms.date: 04/13/2026
---

# How to force Excel to open in a new instance by default

## Symptoms

In Microsoft Excel, when you open multiple workbooks, they all open in the same instance of Excel. However, in some situations, you may want to open each workbook in a new instance, such as:

- You're working with large Excel workbooks.
- You want to undo actions in only the active workbook.

This article explains how to do so by configuring a registry key.

> [!NOTE]
> This method works only when you use the Excel icon to open the application without selecting a file. If you use the follow ways, the workbooks will still open in the same Excel instance as designed:
> 
> - You use File Open within the Excel application.
> - You select a file when you use the Excel taskbar icon to open the application.
> - You double-click an Excel workbook in Windows Explorer.

For more information about Excel instances, and how to start a new instance in other ways, see [Repair an Office application](https://support.microsoft.com/office/7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

## Cause

By opening each workbook in its own instance, the workbook has a dedicated 2 gigabytes (GB) of memory to use. It's important if you are experiencing out-of-memory issues in a 32-bit version of Excel.

> [!NOTE]
> If you're using the [Large Address Aware option](#more-information), this limit may be increased.

## Resolution

To change the default setting, install the latest version of Office, and then add the key to the registry.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit all instances of Excel.
2. Start Registry Editor. In Windows 10 or 11, click **Start**, and then type *regedit* in the Search box. Then select regedit.exe in the search results.
3. Locate and select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Options`
4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Enter **DisableMergeInstance**, and then press Enter.
6. In the **Details** pane, right-click **DisableMergeInstance**, and then select **Modify**.
7. In **Value data**, enter **1**, and then click **OK**.

## More Information

32-bit versions of Excel 2016 can take advantage of the Large Address Aware (LAA) functionality after installation of the [May 3, 2016, update for Outlook 2013 (KB3115031)](https://support.microsoft.com/help/3115031), build 16.0.6868.2060 for O365 Current Channel subscribers. This change lets 32-bit installations of Excel 2016 consume double the memory when users work on a 64-bit Windows OS. The system provides this capability by increasing the user mode virtual memory from 2 GB to 4 GB. This change provides 50-percent more memory (for example, from 2 GB to 3 GB) when users work on a 32-bit system. For more information about LAA, see [Large Address Aware capability change for Excel.](https://support.microsoft.com/help/3160741)

> [!NOTE]
> There are some known issues in opening each Excel workbook in its own instance. For example, see [You cannot paste any attributes into a workbook in another instance of Excel](https://support.microsoft.com/help/917637).
