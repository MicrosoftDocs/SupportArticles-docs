---
title: Excel opens a blank screen when you double-click a file icon or file name
description: Offers resolutions to an issue where you see a blank screen when you try to open an Excel workbook by double-clicking its icon or file name.
ms.date: 05/26/2025
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Open
  - CSSTroubleshoot
  - CI 147067
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Excel for Microsoft 365
  - Excel LTSC 2021
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Excel 2007
---

# Troubleshoot opening a blank screen when you double-click a file icon or file name in Excel

## Symptoms

When you double-click an icon or file name for a Microsoft Excel workbook, Excel starts and then displays a blank screen instead of the file that you expect to see.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, try the following options, as appropriate, in the given order.

## Option 1: Check for hidden sheets

An Excel sheet may inadvertently have been saved as a hidden document. To check this, follow these steps:

1. Go to the **View** tab.
1. Select **Unhide**.
1. Select a workbook from the list.
1. Select **OK**.

## Option 2: Minimizing and maximizing the window

Minimizing and then maximizing the window can sometimes refresh the Excel page and cause any hidden data to appear.

1. In the top-right corner of the Excel spreadsheet, select the minimize button.
1. In the task tray, right-click Excel, and then select your spreadsheet. (Or double click the Excel icon.)

After your sheet is maximized, your data may appear.

## Option 3: Disable hardware acceleration

To work around this problem, disable hardware acceleration until a fix is released by your video adapter manufacturer. Make sure to check regularly for updates to your video adapter driver.

To disable hardware acceleration, follow these steps:

1. Start any Office 2013, Office 2016, Office 2019, or Microsoft 365 Apps program.
1. On the **File** tab, select **Options**.
1. In the **Options** dialog box, select **Advanced**.
1. In the list of available options, select the **Disable hardware graphics acceleration** check box.

   The following screenshot shows this option in Excel.

   :::image type="content" source="media/error-when-send-commands-in-excel/disable-hardware-graphics-acceleration.png" alt-text="Select the Disable hardware graphics acceleration option to disable hardware acceleration in Office Options setting." border="false":::

1. Select the **OK** button.

> [!NOTE]
> For more information about hardware acceleration, see [Display issues in Office 2013 client applications](https://support.microsoft.com/help/2768648).

## Option 4: Ignore DDE

This problem may occur if the **Ignore other applications that use Dynamic Data Exchange (DDE)** check box in Excel options is selected.

When you double-click an Excel workbook in Windows Explorer, a dynamic data exchange (DDE) message is sent to Excel. This message instructs Excel to open the workbook that you double-clicked.

If you select the "Ignore" option, Excel ignores DDE messages that are sent to it by other programs. Therefore, the DDE message that is sent to Excel by Windows Explorer is ignored, and Excel does not open the workbook that you double-clicked.

To correct this setting, follow these steps.

> [!NOTE]
> This step can be skipped for Excel 2019, Excel LTSC 2021 and Excel O365.

1. In the upper-left corner of the Excel window, select **File** > **Options**.
1. On the left side of the **Options** window, select **Advanced**.
1. In the **Advanced** window, scroll down to the **General** section.
1. Clear the **Ignore other applications that use Dynamic Data Exchange (DDE)** check box, and then select the **OK** button at the bottom of the window.

> [!NOTE]
> For more information about how to turn off DDE, see ["An error occurred when sending commands to the program" in Excel](error-when-send-commands-in-excel.md).

## Option 5: Reset file associations

To check whether the file associations in the system are performing correctly, reset the Excel file associations to their default settings. To do this, follow the steps for your operating system.

### For Windows 10 and Windows 8.1

1. Locate the file that is opening incorrectly, and copy it to your desktop.
1. Right-click the file, and select **Properties**.
1. On the **General** tab, next to **Type of file**, the type of file will be indicated within parentheses. For example, (.docx), (.pdf), or (.csv).

The **Opens with** command shows you which app the file is currently associated with.

To open this type of file in a different app:

1. Select **Change**.
1. Select **More apps**.
1. Select the desired app, then select the **Always use this app** checkbox.
1. Select the **OK** button.

### For Windows 8

1. On the Start screen, type **Control Panel**.
1. Select or tap **Control Panel**.
1. Select **Default Programs**, then select **Set your default programs**.
1. Select **Excel**, then select **Choose default for this program**.
1. On the **Set Program Associations** screen, select **Select All**, and then select **Save**.

### For Windows 7

1. Select **Start**, then select **Control Panel**.
1. Select **Default Programs**.
1. Select **Associate a file type or protocol with a specific program**.
1. Select **Microsoft Excel Worksheet**, then select change program.
1. Under **Recommended Programs**, select **Microsoft Excel**.
1. If Excel does not appear in this list, select **Browse**, locate the Excel installation folder, select **Excel.exe**, then select **Excel**.

## Option 6: Repair User Experience Virtualization (UE-V)

If you are running Update User Experience Virtualization (UE-V), install Hotfix 2927019. To do so, see [Hotfix Package 1 for Microsoft User Experience Virtualization 2.0](https://support.microsoft.com/help/2927019).

If you aren't sure whether you are running UE-V, examine the program list in the **Programs and Features** item in Control Panel. An entry for "Company Settings Center" indicates that you are running UE-V.

## Option 7: Repair Office

Try to repair your Office programs. To do this, follow the steps for your installation type and operating system.

### For a Microsoft 365 Apps, Office LTSC 2021, or Office 2019 Click-to-Run installation

#### Windows 10

1. On the **Start** screen, type **Settings**.
1. Select or tap **Settings**.
1. In the **Settings** window, select or tap **Apps**.
1. In the **Apps & features** window, scroll down to your **Office** program, and select or tap it.
1. Select or tap the **Modify** button.
1. In the **How would you like to repair your Office programs** window, select or tap the **Online Repair** radio button, then select or tap the **Repair** button.

#### Windows 8

1. On the Start screen, type **Control Panel**.
1. Select or tap **Control Panel**.
1. Under **Programs**, select or tap **Uninstall a program**.
1. Select or tap **Microsoft 365**, then select or tap **Change**.
1. Select or tap **Online Repair**, then select or tap **Repair**. You may have to restart your computer after the repair process is finished.

#### Windows 7

1. Select **Start**, then select **Control Panel**.
1. double-click **Programs and Features**.
1. Select **Microsoft 365**, then select **Change**.
1. Select **Online Repair**, then select **Repair**.

   :::image type="content" source="media/error-when-send-commands-in-excel/online-repair-option.png" alt-text="Select the Online Repair option to repair office.":::

> [!NOTE]
> You may have to restart your computer after the repair process is complete.

### For an Office 2013, Office 2010, or Office 2007 installation

To repair Office 2013, Office 2010, or Office 2007, follow the steps in the following Office website topic:

[Repair an Office application](https://office.microsoft.com/outlook-help/repair-office-programs-ha010357402.aspx)

## Option 8: Turn off add-ins

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
