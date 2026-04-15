---
title: Excel opens a blank screen when you double-click a file icon or file name
description: Offers resolutions to an issue where you see a blank screen when you try to open an Excel workbook by double-clicking its icon or file name.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Open
  - CSSTroubleshoot
  - CI 147067
  - CI 11127
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: akeeler, v-lisalozano
appliesto: 
  - Excel for Microsoft 365
  - Microsoft Excel 2024
  - Microsoft Excel 2021
  - Microsoft Excel LTSC 2021
  - Microsoft Excel 2019
  - Microsoft Excel 2016
ms.date: 04/13/2026
---

# Troubleshoot opening a blank screen when you double-click a file icon or file name in Excel

## Symptoms

When you double-click an icon or file name for a Microsoft Excel workbook, Excel starts and then displays a blank screen instead of the file that you expect to see.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, try the following options, as appropriate, in the given order.

## Option 1: Check for hidden sheets

An Excel sheet may have inadvertently been saved as a hidden document. To check this, follow these steps:

1. Go to the **View** tab.
1. Select **Unhide**.
1. Select a workbook from the list.
1. Select **OK**.

## Option 2: Minimize and maximize the window

Minimizing and then maximizing the window can sometimes refresh the Excel page and cause any hidden data to appear.

1. In the top-right corner of the Excel spreadsheet, select the minimize button.
1. In the task tray, right-click Excel, and then select your spreadsheet. (Or double click the Excel icon.)

After your sheet is maximized, your data may appear.

## Option 3: Reset file associations

To check whether the file associations in the system are performing correctly, reset the Excel file associations to their default settings. To do this, follow the steps for your operating system.

### For Windows 10 and Windows 11

1. Locate the file that is opening incorrectly, and copy it to your desktop.
1. Right-click the file, and select **Properties**.
1. On the **General** tab, next to **Type of file**, the type of file will be indicated within parentheses. For example, (.docx), (.pdf), or (.csv).

The **Opens with** command shows you which app the file is currently associated with.

To open this type of file in a different app:

1. Select **Change**.
1. Select **More apps**.
1. Select the desired app, then select the **Always use this app** checkbox.
1. Select the **OK** button.

## Option 4: Repair User Experience Virtualization (UE-V)

If you are running Update User Experience Virtualization (UE-V), install Hotfix 2927019. To do so, see [Hotfix Package 1 for Microsoft User Experience Virtualization 2.0](https://support.microsoft.com/help/2927019).

If you aren't sure whether you are running UE-V, examine the program list in the **Programs and Features** item in Control Panel. An entry for "Company Settings Center" indicates that you are running UE-V.

## Option 5: Repair Office

Try to repair your Office programs. To do this, follow the steps for your installation type and operating system.

### For a Microsoft 365 Apps, Office LTSC 2021, or Office 2019 Click-to-Run installation

#### For Windows 10 and Windows 11

1. On the **Start** screen, type **Settings**.
1. Select or tap **Settings**.
1. In the **Settings** window, select or tap **Apps**.
1. In the **Apps & features** window, scroll down to your **Office** program, and select or tap it.
1. Select or tap the **Modify** button.
1. In the **How would you like to repair your Office programs** window, select or tap the **Online Repair** radio button, then select or tap the **Repair** button.

## Option 6: Turn off add-ins

Excel and COM add-in programs can also cause this problem. These two kinds of add-ins are located in different folders. For testing, disable and isolate the conflict by turning off each add-in one at a time. To do this, follow these steps:

1. On the **File** menu, select **Options**, and then select **Add-Ins**.
1. In the **Manage** list at the bottom of the screen, select **COM Add-Ins** item, and then select **Go**.
1. Clear one of the add-ins in the list, then select **OK**.
1. Restart Excel by double-clicking the icon or file name for the workbook that you are trying to open.
1. If the problem persists, repeat steps 1-4, except select a different add-in in step 3.
1. If the problem persists after you clear all the COM Add-ins, repeat steps 1-4, except select **Excel Add-Ins** in step 2. Then, try each of the Excel add-ins one at a time in step 3.  

If Excel loads the file, the add-in that you last turned off is causing the problem. If this is the case, we recommend that you visit the manufacturer's website for the add-in to learn whether an updated version of the add-in is available. If a newer version of the add-in is not available, or if you don't have to use the add-in, you can leave it turned off.

If Excel does not open the file after you turn off all the add-ins, the problem has a different cause.

If none of the above options works, please make sure Excel is not in Compatibility mode.

If you still experience this problem after you try all these options, contact [Microsoft Support](https://support.microsoft.com/) for additional troubleshooting help.
