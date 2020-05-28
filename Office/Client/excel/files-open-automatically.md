---
title: How to prevent files from opening automatically in Excel
description: Provides step-by-step instructions to prevent files from opening automatically when you start Excel.
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
- Excel 2019
- Excel 2016
- Excel 2013
---

# How to prevent files from opening automatically in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

This article describes how to prevent files from automatically opening when you start Microsoft Excel. 

## More information

When you start Excel, all the files that are located in the XLStart folder are automatically opened. This behavior occurs regardless of the kind of file. Additionally, if you specified an alternative startup folder for Excel, every file in that folder is also automatically opened. 
To remove an alternative startup folder: 
 
1. Select the **File** menu and then select **Options**.    
2. Select the **Advanced** tab and then locate the **General** section.    
3. Clear the box next to "At startup, open all files in:".

Excel might stop responding or take longer to start if either of the following conditions is true:   

- The files in either startup folder aren't valid Excel workbooks or worksheets.    
- The files are stored on a network drive that has a slow network connection.    
 
### How to prevent files from automatically opening in Excel

Use one of the following methods to prevent files from automatically opening when you start Excel.
 
#### Remove files from the XLStart folder and the alternative startup folders

To remove files from the XLStart folder and the alternative startup folders, follow these steps: 
 
1. Select **Start**, and then select **Run**.    
2. In the Open box, type one of the following and press Enter:  
   - For Office365 or 2019 32 bit:
    
      C:\Program Files (x86)\Microsoft Office\root\xx\XLSTART    
   - For Office365 or 2019 64 bit:
 
      C:\Program Files\Microsoft Office\root\xx\XLSTART
  
     Where "xx" represents the version that you are using (for example, Office15, Office14, etc.).    

   Also try the following:  
      - %appdata%\Microsoft\excel\XLSTART
      - C:\Users\UserName\AppData\Roaming\Microsoft\excel\XLSTART    
     
3. Delete any files in the XLStart folder or move them to another folder.    
4. Restart Excel.    
 
#### Start Excel in safe mode

> [!NOTE]
> This is only a temporary solution that will not fix the issue. To use this method, it must be done every time that you start Excel.
     
Another method for preventing files from automatically opening is to start Excel in safe mode. Starting Excel in safe mode prevents all Excel add-ins, toolbar customizations, and startup folders from loading when the program is started.

There are two ways to start Excel in safe mode: the CTRL key and command-line switches.

##### Using the CTRL key

To start Excel in safe mode, hold down the CTRL key while you start Excel. You will receive the following message: Excel has detected that you are holding down the CTRL key. Do you want to start Excel in Safe mode? Select **Yes** to start in safe mode.

You can then delete files from the alternative startup location as described earlier.
  
##### Use Command-line switches

In all versions of Excel, you can use a command-line switch to start Excel in safe mode.Both the /safe switch and the /automation switch can be used for this purpose.   

> [!NOTE]
> The /safe switch starts Excel in safe mode. The /automation switch disables all automatically opened files and auto-run macros.

To use a command-line switch to start Excel, follow these steps: 
 
1. Select **Start**, and then select **Run**.    
2. In the **Open** box, type either of the following lines (but not both): 

    excel.exe /safe
    
    excel.exe /automation     
3. Select **OK**.    
   
> [!NOTE]
> If Microsoft Windows Installer starts when you use one of these command-lines switches, click**Cancel** to finish starting Excel.

#### Press the ESCAPE key

> [!NOTE]
> This is only a temporary solution that will not fix the issue. To use this method, it must be done every time that you start Excel.    

Another method for preventing files from automatically opening is to press the ESCAPE key (but do not press and hold). When you press ESCAPE after the files start to open, Excel is prevented from opening additional files.   

Using this method, you may receive one or both of the following messages: 

- Would you like to cancel opening all files from your Alternate Startup File Location?
- Would you like to cancel opening all files from your XLStart Location? 

If you click **Yes** in either message, Excel starts without opening any additional files from the startup locations.   

> [!NOTE]
> Do not hold the ESCAPE key. If you do this, the messages will be closed before you can click **Yes**.      

## References

For more information about Excel startup folders, see the following Microsoft Knowledge Base articles: 

- [Use startup folders in Excel](https://docs.microsoft.com/office/troubleshoot/excel/use-startup-folders)  
- [Description of the startup switches for Excel](https://support.microsoft.com/help/291288/description-of-the-startup-switches-for-excel)
