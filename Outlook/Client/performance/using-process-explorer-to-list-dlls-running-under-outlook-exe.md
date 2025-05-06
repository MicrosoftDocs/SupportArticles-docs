---
title: Using Process Explorer to list dlls running under Outlook.exe
description: This article provides details on how you can use Process Explorer to output all dll files running under the Outlook.exe process.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Add-in error
  - CSSTroubleshoot
appliesto:
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.reviewer: gbratton, v-shorestris
author: cloud-writer
ms.author: meerak
ms.date: 03/25/2025
---

# Determine which third-party DLLs are currently running under the Outlook.exe process

Third-party add-ins or other software on your computer can potentially cause problems in Microsoft Outlook. To determine which third-party DLLs are currently running under the Outlook.exe process, follow these steps:

1. Start Outlook.

2. Run Sysinternals [Process Explorer](/sysinternals/downloads/process-explorer) (procexp.exe). In Process Explorer:

   1. Enter "outlook.exe" in the top-right search box.

   2. Select the **OUTLOOK.EXE** process.

   3. Select **View** \> **Show Lower Pane** to show the lower pane.

   4. Select **View** \> **Lower Pane View** \> **DLLs** to list the DLL files that run under the Outlook.exe process.

   5. In the lower-pane, right-click on any column header, select the **Select Columns** \> **DLL** \> **Version** checkbox, and then select **OK**.

   6. Select **File** \> **Save As** \> **Save** to save the lower-pane data to a tab-delimited text file.

3. In Microsoft Excel:

   1. Select **File** \> **Open**, and then select the tab-delimited text file to open the **Text Import Wizard**.

   2. In the Text Import Wizard, accept the default options, and then select **Finish**.

   3. On the row that contains the **Name**, **Description**, **Company**, **Path**, and **Version** column headers:

   4. Right-click the **Name** cell and add a [filter](https://support.microsoft.com/office/filter-data-in-a-range-or-table-01832226-31b5-4568-8806-38c37dcc180e) to only show values that contain ".dll". The filtered list contains all Microsoft and third-party DLLs that run under the Outlook.exe process.

   5. Right-click the **Company Name** cell and add a filter to exclude values that contain "Microsoft". The filtered list now only contains third-party DLLs and possibly some DLLs that have an empty value in the **Company Name** column.

4. In Outlook:

   1. Select **File** \> **Options** \> **Add-ins** to display a list of add-ins.

   2. For each active add-in in the list:

      1. Select the add-in. This displays the add-in **Publisher** and **Location** values under the list.

      2. Compare the add-in file name (specified in the **Location** value) to the name of each DLL that has an empty **Company Name** value in your filtered list from step 3e. If you find a match, enter the **Publisher** value as the **Company Name** value. If you enter "Microsoft", reapply the filter from step 3e to exclude the Microsoft DLL from the filtered list.

      The filtered list now contains only the third-party DLLs that are currently running under the Outlook.exe process.