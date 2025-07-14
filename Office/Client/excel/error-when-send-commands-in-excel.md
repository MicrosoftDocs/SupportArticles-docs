---
title: An error occurred when sending commands to the program in Excel
description: Discusses that you receive an An error occurred when sending commands to the program error message when you try to open an Excel workbook by double-clicking its icon or file name. Provides multiple resolutions.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Reliability
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
ms.date: 05/26/2025
---

# "An error occurred when sending commands to the program" in Excel

## Symptoms

You receive the following error message in Microsoft Excel. This error indicates that some process that is running inside Excel won't let Excel close.
An error occurred when sending commands to the program

## Resolution

To resolve this problem, try the following methods, as appropriate, in the given order.

### Method 1: Ignore DDE
 
To correct this setting, follow these steps: 
 
1. Select **File** > **Options**.    
2. Select **Advanced**, scroll down to the **General** section, and then clear the **Ignore other applications that use Dynamic Data Exchange (DDE)** check box in the **General** area. 
3. Select**OK**.    
 
This problem may occur if the **Ignore other applications that use Dynamic Data Exchange (DDE)** check box in Excel options is selected.  
 
When you double-click an Excel workbook in Windows Explorer, a dynamic data exchange (DDE) message is sent to Excel. This message instructs Excel to open the workbook that you double-clicked.

If you select the "Ignore" option, Excel ignores DDE messages that are sent to it by other programs. Therefore, the DDE message that is sent to Excel by Windows Explorer is ignored, and Excel doesn't open the workbook that you double-clicked.

> [!NOTE]
> For more information about how to turn off DDE, see the following Microsoft Knowledge Base article:

[211494 "There was a problem sending the command to the program" error in Excel ](https://support.microsoft.com/help/211494) 

If these steps don't resolve the problem, go to Method 2.

### Method 2: Repair User Experience Virtualization (UE-V)
 
If you're running Update User Experience Virtualization (UE-V), install [Hotfix Package 1 for Microsoft User Experience Virtualization 2.0 (KB2927019)](https://support.microsoft.com/help/2927019).

If you aren't sure whether you're running UE-V, examine the program list in the **Programs and Features** item in Control Panel. An entry for "Company Settings Center" indicates that you're running UE-V.

If these steps don't resolve the problem, go to Method 3.

### Method 3: Reset file associations

To check whether the file associations in the system are performing correctly, reset the Excel file associations to their default settings. To do this, follow the steps for your operating system.Windows 10  
 
1. Right-click the Excel workbook, point to **Open with**, and then click **More apps**.    
2. Select the version of Excel you want to use to open this file type, such as **Excel 2016**.    
3. Click to select **Always use this app to open .xlsx files**.    
4. Click **OK**.    
    
**Windows 8**  
 
1. On the Start screen, type Control Panel.    
2. Select **Control Panel**.    
3. Select **Default Programs** > **Set your default programs**.    
4. Select **Excel** > **Choose default for this program**.    
5. On the **Set Program Associations** screen, select **Select All** > **Save**.    
 
**Windows 7**  
 
1. Select **Start** > **Control Panel**.    
2. Select **Default Programs**.    
3. Select **Associate a file type or protocol with a specific program**.   
4. Select **Microsoft Excel Worksheet**, and then select change program.    
5. Under **Recommended Programs**, select **Microsoft Excel**.    
6. If Excel does not appear in this list, select **Browse**, locate the Excel installation folder, select **Excel.exe** > **Excel**.    
    
If these steps do not resolve the problem, go to Method 4.

### Method 4: Repair Office

Try to repair your Office programs. To do this, follow the steps for your installation type and operating system.

**For a Microsoft 365 Click-to-Run installation**

Windows 10  
 
1. In the search box, type **Control Panel**, and then click **Control Panel** in the search results.    
2. Under **Programs**, click **Uninstall a program**.    
3. Click **Microsoft 365** > **Change**.    
4. Click **Online Repair** > **Repair**.    
 
> [!NOTE]
> You may have to restart your computer after the repair process is completed. Windows 8  

1. On the Start screen, type Control Panel.    
2. Select **Control Panel**.    
3. Under **Programs**, select **Uninstall a program**.    
4. Select **Microsoft 365 **> **Change**.    
5. Select **Online Repair** > **Repair**.

> [!NOTE]
> You may have to restart your computer after the repair process is finished.    
 
Windows 7  

1. Select **Start** >**Control Panel**.    
2. Double-click **Programs and Features**.    
3. Select **Microsoft 365 **> **Change**.    
4. Select **Online Repair** > **Repair**.

> [!NOTE]
> You may have to restart your computer after the repair process is complete.

:::image type="content" source="media/error-when-send-commands-in-excel/online-repair-option.png" alt-text="Select the Online Repair option to repair office.":::
    
**For an Office 2016, 2013, Office 2010, or Office 2007 installation**

To repair Office 2013, Office 2010, or Office 2007, follow the steps in the following Office website topic:
   
[Repair Office programs](https://office.microsoft.com/outlook-help/repair-office-programs-ha010357402.aspx) 

If these steps do not resolve the problem, go to Method 5.

### Method 5: Turn off add-ins
 
Excel and COM add-in programs can also cause this problem. These two kinds of add-ins are located in different folders. For testing, disable and isolate the conflict by turning off each add-in one at a time. To do this, follow these steps: 
 
1. On the **File** menu, select **Options** > **Add-Ins**.    
2. In the **Manage** list at the bottom of the screen, select **COM Add-Ins** > **Go**.    
3. Clear one of the add-ins in the list, and then select **OK**.    
4. Restart Excel by double-clicking the icon or file name for the workbook that you are trying to open. 
5. If the problem persists, repeat steps 1-4, except select a different add-in in step 3.    
6. If the problem persists after you clear all the COM Add-ins, repeat steps 1-4, except select **Excel Add-Ins** in step 2, and then try each of the Excel add-ins one at a time in step 3.    
 
If Excel loads the file, the add-in you last turned off is causing the problem. If this is the case, we recommend that you visit the manufacturer's website for the add-in to learn whether an updated version of the add-in is available. If a newer version of the add-in is not available, or if you don't have to use the add-in, you can leave it turned off.

If Excel does not open the file after you turn off all the add-ins, the problem has a different cause.

If these steps do not resolve the problem, go to Method 6.

### Method 6: Disable hardware acceleration
 
To work around this problem, disable hardware acceleration until a fix is released by your video card manufacturer. Make sure to check regularly for updates to your video card driver.

To disable hardware acceleration, follow these steps: 
 
1. Start any Office 2013 program.    
2. On the **File** tab, select **Options**.    
3. In the **Options** dialog box, select **Advanced**.    
4. In the list of available options, select the **Disable hardware graphics acceleration** check box.

    The following screen shot shows this option in Excel.
    
    :::image type="content" source="media/error-when-send-commands-in-excel/disable-hardware-graphics-acceleration.png" alt-text="Select the Disable hardware graphics acceleration option to disable hardware acceleration in Office Options setting." border="false":::

5. Select **OK**.    
 
> [!NOTE]
> For more information about hardware acceleration, see [Performance and display issues in Office 2013 client applications (KB2768648)](https://support.microsoft.com/help/2768648).

If these steps do not resolve the problem, go to Method 7.

### Method 7: Verify or install the latest updates
 
You may have to set Windows Update to automatically download and install recommended updates. Installing any important, recommended, and optional updates can frequently correct problems by replacing out-of-date files and fixing vulnerabilities.

For more information about Office updates, click the following article number to go to the article in the Microsoft Knowledge Base:
   
[Office Updates](https://technet.microsoft.com/library/dn789213%28v=office.14%29)  

[Microsoft Support](https://support.microsoft.com/contactus/?ws=support) 

## More Information

There are many possible reasons that might lead to this error. 
 
- The Excel workbook tries to access data from another application that is still active.    
- Too many Excel add-ins have been added to the program, or one of the add-ins is corrupted.    
- You might have taken one of the following actions:  
  - Use a third-party add-in or application    
  - Try to open an embedded object    
  - Save or open a file    
  - Try to use the Send as Attachment option    
  - Call another application from the Excel workbook    
 
For more information about this problem and for additional troubleshooting steps, see the following Microsoft Knowledge Base articles: 

[2616247 Why does "An error occurred when sending commands to the program" appear when opening Excel 2010 files? (Easy Fix Article) ](https://support.microsoft.com/help/2616247)

[2994633 Excel: How to Troubleshoot Excel opening blank when you double-click a file icon or file name ](https://support.microsoft.com/help/2994633)
