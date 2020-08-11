---
title: How to troubleshoot errors when you save Excel workbooks
description: Describes how to troubleshoot errors that occur when you try to save workbooks in Microsoft Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
---

# How to troubleshoot errors when you save Excel workbooks

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

You may have problems when you try to save a Microsoft Excel workbook if one or more of the following conditions are true: 
 
- You save an Excel workbook to a network drive on which you have restricted permissions.    
- You save an Excel workbook to a location that does not have sufficient drive space.    
- The connection to the Excel workbook is lost.    
- There is a conflict with an antivirus software program.    
- You save an Excel workbook that is shared.    
- The 218-character path limitation is exceeded when you save an Excel workbook.    
  
## Workarounds and resolutions 

The following sections include workarounds to save your workbooks and troubleshooting steps to help you find the cause of the problem. We recommend that you first try to save changes in any open Excel workbooks before you start troubleshooting. 
 
### Workarounds to save Excel workbooks

To work around this problem and try to save your work before you troubleshoot, use the following methods. Depending on the cause of the problem, you may be unable to recover the current file as-is. However, the following methods are typically successful. These methods are listed in order of format retention when you are trying to keep the original file formatting.

> [!NOTE]
> The following methods may not save all the latest changes, formatting, and feature sets of the workbook that are specific to the version of Excel that you are using. The following methods are intended to let you obtain a usable, saved version of the file. These methods require you to save the file to your local hard disk by using a unique file name.  
   
#### Method 1: Save the workbook by using a new file name

1. On the **File** menu, select **Save As**.    
2. Save the Excel workbook by using a unique file name.    
 
#### Method 2: Move the original worksheets to a new workbook

1. Add a filler worksheet to your workbook. To do this, press Shift + F11.

    > [!NOTE]
    > This sheet is required because there has to be at least one remaining sheet in a workbook after you move all relevant data sheets.         
2. Group all the worksheets (except the filler). To do this, select the first sheet, hold the **Shift** key, and then select the last sheet.     
3. Right-select the grouped sheets, and then select **Move or copy**.    
4. In the **To Book** list, select **(New Book)**.    
5. Select **OK**.    
   
    > [!NOTE]
    > These steps should move the active (grouped) worksheets to a new workbook.     

If your workbook contains VBA macros, copy the modules from the old workbook to the new workbook. 

#### Method 3: Save the file as a different Excel file type

1. On the **File** menu, select **Save As**.    
2. In the **Save as Type** list, select a file format other than the current file format. If you are using Microsoft Excel 2007 or a later version, save the file as .xlsx or .xlsm instead of as .xls.     
  
### Troubleshooting
 
To troubleshoot this problem, follow these steps in the given order.

#### Step 1: Try to save the workbook to another location
 
Try saving your notebook to another location, such as a local hard drive, a network drive, or removable drive. If you are successful, the following are possible causes of the problem:   
 
- [Antivirus software conflict](#antivirus-software-conflict)    
- [Restricted permissions](#restricted-permissions)    
- [File name length](#file-name-length)    
- [File sharing conflict](#file-sharing-conflict)    
 
#### Step 2: Try to save a new workbook to the original location
 
To save a new Excel file to the original location, follow these steps:

1. Create an Excel workbook.    
2. On the **File** menu, select **Save As**.    
3. In the **Save As** dialog box, follow these steps:

   1. In the **Save in** box, select the location in which the original workbook is saved.    
   2. In the **File name** box, type a name for the new file.    
   3. Select **Save**.    
     
 If you can save a new workbook to the original location, the following are possible causes of the problem:

 
- [File name length](#file-name-length)    
- [File sharing conflict](#file-sharing-conflict)    
 
If you cannot save a new workbook to the original location, the following is a possible cause of the problem:

- [Insufficient drive space](#insufficient-drive-space)    
 
If you have sufficient drive space, try Step 3.
 
#### Step 3: Try to save the workbook in safe mode

Restart Windows in safe mode, and then try to save the workbook to your local hard disk.   

**Notes**
 
- If you use a network location to save your workbook, try to restart Windows in safe mode with network support, and then try to save.    
- Windows safe mode cannot be used to troubleshoot issues in Microsoft Excel 2010 or later versions.    
     
For more information about how to start Windows in safe mode, see [Advanced startup options (including safe mode)](https://windows.microsoft.com/windows/start-computer-safe-mode#start-computer-safe-mode=windows-7). 

If the workbook saves after you restart Windows in safe mode, try to save the file again. To do this, select **Save** on the **File** menu.

If the workbook does not save (or save again) after you restart Windows in safe mode, the following are possible causes:

- [Third-party add-in](#third-party-add-in)    
- [Antivirus software conflict](#antivirus-software-conflict)    
- [Restricted permissions](#restricted-permissions)    
- [File name length](#file-name-length)    
 
### Causes

#### Third-party add-in
 
If the Excel file is not saved when you run Excel in Windows safe mode, the issue may be caused by a third-party add-in or by a file that is in one of the Excel startup locations. By default, these files are loaded when you start Excel.

Sometimes, third-party software vendors install custom add-ins to work with Excel. Some of these add-ins work with existing Excel features by design, and some are intended to enable a seamless transition when you are using a third-party product. Typically, these third-party add-ins do not interfere with normal Excel functionality. However, there are some exceptions. For example, Excel save conflicts have occurred because of an add-in.

To test for and eliminate the possibility that a third-party Excel add-in or file is causing an Excel save issue, start Excel in safe mode. To do this, follow these steps: 

1. Exit Excel.    
2. Select **Start**, and then point to **Programs**.    
3. Press Ctrl when you start Excel, and hold it until you receive a message that resembles the following:   

    **Excel has detected that you are holding down the Ctrl key. Do you want to start Excel in safe mode?**           
4. Select **Yes**.    
5. Try to save a new Excel file, and then resave the same Excel file again.    
 
If the file saves correctly, a custom add-in or a file that is located in an Excel startup location is most likely the cause. You must locate and remove the add-in or the file to eliminate the problem. After you determine the add-in or the file that caused the problem, contact the vendor that designed it. The vendor may have additional information about this issue and an update that does not cause the issue to occur.

For more information about Microsoft Excel safe mode, press F1 in Excel to open the Help menu, type safe modein the Search box, and then select Search to view the topic.

For more information about how to determine the folders that Excel uses during startup and additional options to disable this functionality, select the following article numbers to view the articles in the Microsoft Knowledge Base:

[822107](https://support.microsoft.com/help/822107) How to use startup folders in Excel
 
[826922](https://support.microsoft.com/help/826922) How to prevent files from opening automatically in Excel

#### Restricted permissions
 
When you save an Excel file, you must have the following permissions to the folder in which you are saving the file:

- Read permission    
- Write permission    
- Modify permission    
- Delete permission    

> [!NOTE]
> If you do not have these permissions, the Excel save process cannot be completed.

#### Insufficient drive space
 
When you save to any medium, such as a floppy disk drive, a local hard disk, or a network drive, you must make sure that the drive has sufficient free space to enable the file to save. If the destination drive does not have sufficient space, Excel cannot complete the save operation, and you receive the following error message:
   
**Disk is Full.**

For more information about this error message, select the following article numbers to view the articles in the Microsoft Knowledge Base:

[214245](https://support.microsoft.com/help/214245) You receive the "Disk is Full" error message when you save a workbook in Excel 

[214073](https://support.microsoft.com/help/214073) You receive an error message when you try to save a file in Excel
  
#### Antivirus software conflict
 
When antivirus software is installed or is running, you may receive an error message when you try to save an existing workbook. You do not receive an error message if you try to save a new file. You may receive an error message because some antivirus programs quickly scan any new files that appear on a computer. This scan can sometimes disrupt the Excel save process. This interruption may stop Excel from saving the file correctly.

#### File sharing conflict
 
If you and a second user work concurrently on a shared workbook, you may receive an error message if you and the second user try to save the file at the same time. You receive an error message because Excel cannot save the file if another instance of Excel is saving the same file.

For more information about this error message, see the following Microsoft Knowledge Base article:

[130494](https://support.office.com/article/Unlock-a-file-that-has-been-locked-for-editing-bdda0d41-1b8e-44ed-a6ae-6d095d37c22d) Unlock a file that has been locked for editing 
#### File name length
 
If you try to save or open an Excel file, and the path of that file (including the file name) is more than 218 characters, you may receive the following error message:
   
**Filename is not valid.**
 
For more information, select the following article number to view the article in the Microsoft Knowledge Base:
   
[213983](https://support.microsoft.com/help/213983) Error message when you open or save a file in Microsoft Excel: "Filename is not valid"  

### Process to save a file

Excel follows these steps when it saves a file:

1. Excel creates a randomly named temporary file (for example, Cedd4100 without a file name extension) in the destination folder that you specified in the **Save As** dialog box. The whole workbook is written to the temporary file.   
2. If changes are being saved to an existing file, Excel deletes the original file.   
3. Excel renames the temporary file. Excel gives the temporary file the file name that you specified (such as Book1.xls) in the **Save As** dialog box.   
 
For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[814068](https://support.microsoft.com/help/814068) Description of the way that Excel saves files

> [!NOTE]
> Other processes that occur on your computer may disrupt the Excel save process. These issues may occur if the Excel temporary file is accessed before the Excel save process is completed. For example, the local antivirus software locks the temporary file for scanning before the file can be renamed. Therefore, you must keep track of any new software installations or updates that are performed before you have problems when you try to save workbooks. This information will be helpful if this article does not fix your issue and you have to contact Microsoft Support. For more information, go to the following Microsoft website: [http:/support.microsoft.com]()