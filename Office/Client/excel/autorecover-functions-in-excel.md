---
title: Description of the Auto-Recover functions in Excel
description: Describes the Auto-Recover functions in Excel. The Auto-Recover feature saves copies of all open Excel workbooks at a fixed interval that you define. You can use this feature to recover the file when Excel closes unexpectedly.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# Description of the Auto-Recover functions in Excel

## Summary

Microsoft Excel now has a built-in Auto-Recover feature that has replaced the Auto-Save add-in that exists in versions of Excel that are earlier than Microsoft Excel 2002. The Auto-Recover feature saves copies of all open Excel files at a user-definable fixed interval. The files can be recovered if Excel closes unexpectedly, for example, during a power failure.

This article contains an overview of the Auto-Recover feature. 

## More Information

### How to configure the Auto-Recover settings

#### Microsoft Office Excel 2007 and Excel 2010
 
The controls to configure the Auto-Recover feature are in the **Save** settings in Excel Options.

Note To open the **Save** settings, click the Microsoft Office Button in Excel 2007 or the File menu in Excel 2010, clickExcel Options in 2007 or Options in Excel 2010, and then click **Save**.

To configure the Auto-Recover settings, follow these steps: 
 
1. Under **Save Workbooks**, click to select the **Save Auto-Recover info every check box to turn on the Auto-Recover feature.    
2. In the **minutes** box, you can type any integer from 1 through 120. This box sets the number of minutes that will occur between saves.

    The default is 10 minutes.    
3. In the **Auto-Recover file location** box, you can type the path and the folder name of the location in which you want the Auto-Recover files to stay.

    The default location is as follows: 

    **drive**:\Documents and Settings\**user_name**\Application Data\Microsoft\Excel 

    **Notes**  
      - If the location that you type is local (on your hard drive) or is on a network drive, and if this location does not exist, you receive the following error message: 

        Cannot access directory **path**. 

        To determine the unique number that is associated with the message that you receive, press CTRL+SHIFT+I. The following number appears in the lower-right corner of this message: 

        100100     
      - If you click to clear the **Auto-Recover file location** box but do not enter a new location, Auto-Recover files will continue to be saved to the location that you cleared. This will occur until you type a new location.

        The **Auto-Recover file location** box remains empty until you type a new location.    
     
4. You can turn off the Auto-Recover feature in an individual workbook. To do this, click to select the **Disable Auto-Recover for this workbook only** check box under the **Auto-Recover exceptions for** box. Make sure that the workbook name is selected in the **Auto-Recover exceptions for** box.    
 
#### Microsoft Office Excel 2003 and earlier versions of Excel
 
The controls to configure the Auto-Recover dialog box are on the Save tab of the Options dialog box.

Note To open the Options dialog box, click Options on the Tools menu.

To configure the Auto-Recover dialog box, follow these steps: 
 
1. Under Settings, click to select the **Save Auto-Recover info every check box to turn on the Auto-Recover feature.    
2. In the **minutes** box, you can type any integer from 1 through 120. This box sets the number of minutes that will occur between saves.

    The default is 10 minutes.    
3. In the **Auto-Recover file location** box, you can type the path and the folder name of the location in which you want the Auto-Recover files to stay.

    The default location is as follows: 

    **drive**:\Documents and Settings\**user_name**\Application Data\Microsoft\Excel 

    **Notes**  
      - If the location that you type is local (on your hard drive) and if the location does not exist, you receive the following error message: 

        Cannot access directory **path**.     
      - If the location that you type is on a network drive, you will not receive an alert until your first Auto-Recover attempt. You receive the following error message: 

        Microsoft cannot save Auto-Recover info to **path**. Please check the network connection or change the location on the Save tab of the Tools, Options dialog.     
      - If you clear the **Auto-Recover file location** box but do not enter a new location, Auto-Recover files will continue to be saved to the location that you cleared. This occurs until you type a new location.

        The **Auto-Recover file location** box remains empty until you type a new location.    
     
4. You can turn off the Auto-Recover feature in an individual workbook. To do this, click to select the Disable Auto-Recover check box under **Workbook options**.    
 
### When an Auto-Recover event is triggered
 
When an Excel file is open and Auto-Recover is turned on, Auto-Recover does not save the file until the first change is made to the file, the Auto-Recover save time interval passes, and Excel has been idle for some time (the default is 30 seconds). After Auto-Recover saves the file, the file is only saved at subsequent save intervals if further changes are made.
 
### When Auto-Recover files are deleted
 
To keep from filling up your Auto-Recover location with unneeded files, Auto-Recover files are automatically deleted in the following situations:

- When the file is manually saved.    
- The file is saved with a new file name using Save As.    
- You close the file.    
- You quit Excel, whether you choose to save the file or not.    
- You turn off Auto-Recover for the current workbook.    
- You turn off Auto-Recover by clearing the **Save Auto-Recover info every** check box.    
 
### Auto-Recover save timing
 
The Auto-Recover timer checks for changed Excel files at the interval you set in the minutes box on the Save tab in the Options dialog box. The timer starts when you start Excel.

> [!NOTE]
> In Excel 2007, the minutes box is in the **Save** category in the Excel Option dialog box. In Excel 2010, the minutes box is in the Save category under File, Options.

When the first save interval passes, Excel checks to see whether any open files have been changed. If Excel locates changed files, an idle timer starts. The purpose of the idle timer is to make sure that the user does not make entries in the worksheet while the save operation occurs. The idle timer restarts each time that the user makes an entry into the worksheet so the Auto-Recover save file is not created until both the save interval passes and no entries are made for the duration of the idle time.

The default idle time is 30 seconds. To change the default idle time, use the AutoRecoverDelay registry key. To do this, follow these steps.

Important This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 

[322756 ](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows 
 
1. Quit Excel if it is running.    
2. Click Start, click Run, type regedit in the Open box, and then click OK.    
3. Locate and then select one of the following registry keys, as appropriate for the version of Excel that you are running.

    For Microsoft Excel 2002: 

    **HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Excel\Options**

    For Excel 2003: 

    **HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Excel\Options** 

    For Excel 2007: 

    **HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Excel\Options** 

    For Excel 2010: 

    **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Excel\Options**     
4. On the Edit menu, click New, and then click DWORD value.    
5. Type the following name for the new value: 

    AutoRecoverDelay
1. Press ENTER.    
1. Right-click the **AutoRecoverDelay** registry key, and then click Modify.    
1. In the Value data box, type a number between 1 and 600. This is the number of seconds before Auto-Recover tries to save.    
1. When you are finished, click OK.   
1. Quit Registry Editor.    
 
> [!NOTE]
> Only manually performed actions in the program affect the idle timer. Formulas that automatically update the file do not affect the idle timer. Excel saves the file when the idle time is reached, between the automatic updates to the formulas.
 
### File formats that are saved by Auto-Recover
 
Auto-Recover saves all file formats that can be opened in Excel. To maintain speed and simplicity, Auto-Recover saves all files as the current Excel file format, regardless of the original file format opened. The file is saved as a hidden file with an arbitrary filename with the extension ".xar" (for example, ~ar18a.xar). 

When you try to save a recovered file upon reopening Excel after it closed unexpectedly, the original file format and name is suggested as the Save file type. Excel stores the original file name and it's related ".xar" file name in the registry for the purpose of recovery. 

### Auto-Recover and multiple instances of Excel
 
When more than one instance of Excel is running and one instance closes unexpectedly, a new instance of Excel is automatically started and the Auto-Recover files are opened. If all instances of Excel close unexpectedly, but the computer is still running, a single instance of Excel is started and all Auto-Recover files are opened. In the case of a power outage, all recovered files are opened when you start Excel again. 

### Compatibility
 
All Auto-Recover settings, except the Disable Auto-Recover workbook option, are stored in the system registry. Auto-Recover settings are compatible with files from previous versions of Excel is not an issue.

When the Disable Auto-Recover workbook option is set, and the file is opened in an earlier version of Excel, saved, and then reopened in a later version of Excel, the Disable Auto-Recover workbook option is not affected. 

## References

For more information about how to troubleshoot errors when you save Excel files, click the following article number to view the article in the Microsoft Knowledge Base:

[271513 ](https://support.microsoft.com/help/271513) How to troubleshoot errors when you save Excel files