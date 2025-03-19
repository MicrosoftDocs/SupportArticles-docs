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
ms.reviewer: aruiz, gregmans, v-six
author: cloud-writer
ms.author: meerak
ms.date: 03/19/2025
---

# Using Process Explorer to list dlls running under the Outlook.exe process

## Summary

Process Explorer is a utility that provides information about which handles and dlls each process has open. In the context of Outlook troubleshooting, Process Explorer is commonly used to determine if you have any third-party dlls running under the Outlook.exe process. This is an important step as it raises a possibility that add-ins or other software on your computer might be causing problems in Outlook.

This article provides details on how you can use Process Explorer to output all dll files running under the Outlook.exe process.

## Obtaining Process Explorer

The first thing to do is to obtain the latest version of Process Explorer. It can be downloaded from [Process Explorer](/sysinternals/downloads/process-explorer).

Make sure to read the information on this page to introduce yourself to this tool.

## Running Process Explorer

After you download and extract Process Explorer, use the following steps to gather the list of dlls running under the Outlook.exe process.

1. Start Outlook.
2. Double-click Procexp.exe to start Process Explorer.
3. On the **View** menu, make sure **Show Lower Pane** is checked.
4. Press CTRL+D or select **View** > **Lower Pane View** > **DLLs** to enable DLL view mode.
5. In the Process Explorer top pane, scroll down the list of the files and then select Outlook.exe.
6. After the list of dlls running under Outlook.exe are listed in the bottom pane, select **Save As** on the **File** menu.
7. Save the file as Outlook.exe.txt.

## Analyzing the Process Explorer Output

The output text file is a tab-delimited text file that is best opened in Microsoft Excel so you can use the Filter function to quickly locate all non-Microsoft dlls loaded.

1. Start Microsoft Office Excel and open Outlook.exe.txt.
2. In the Text Import Wizard, use the following options:

    - Delimited
    - Tab delimiter
    - General column data format
3. Scroll down the worksheet and locate the following line:

   Name Description Company Name Version

   This is the list of all dlls (Microsoft and third-party) running under the Outlook.exe process.

4. Select the cell with "Name" just above the list of dlls and then turn on the Filter feature.

5. Select the filter drop-down in the Name field and then configure a Text Filter with the following parameters:

   Name - Contains - .dll

6. Select the filter drop-down in the**Company Name** field and then clear the check boxes containing "Microsoft".

## Identifying Microsoft and third-Party dlls

The filtered list of dlls displayed using the above steps contain third-party dlls running under Outlook. You can examine the **Company Name** column to determine the vendor responsible for the dll file.

In the filter list of dlls, there's also some dlls that ship with Outlook that don't display "Microsoft" in the **Company Name** column. To identify these Microsoft dlls, use the following steps in Outlook:

  1. Select the **File** tab on the ribbon, then select the **Options** button.
  2. In the **Outlook Options** dialog box, select **Add-Ins**.
  3. To examine COM add-ins, select **COM Add-ins** in the **Manage** drop-down and then select **Go**.
  4. Select each add-in in the **COM Add-ins** dialog box and then examine the .dll file name in the Location: information in the bottom of the dialog box. The name of the add-in should tell you if the dll file is made by Microsoft.
