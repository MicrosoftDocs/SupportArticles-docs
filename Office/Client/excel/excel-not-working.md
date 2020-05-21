---
title: Excel 2010 not responding, hangs, freezes, or stops working
description: Provides steps to stop Excel from hanging or freezing when you open it or when you save a workbook.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Excel 2010
---

# Excel 2010 not responding, hangs, freezes, or stops working

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

This article discusses troubleshooting steps that can help resolve issues when you receive an "Excel not responding" error, or Excel hangs or freezes when you launch Excel, open a file or save a file.

## Cause

Problems with Excel hanging, freezing or not responding may occur for one or more of the following reasons:

- This issue can occur if you have not installed the latest updates.    
- Excel may be in use by another process.    
- A previously installed add-in may be interfering with Excel.    
- You may need to repair your Office 2010 programs.    
- Antivirus software may be outdated, or conflicting with Excel.    
- Advanced Troubleshooting Another program may be conflicting with Excel.     

## Resolution

Follow the provided methods in this article in order. If you have previously tried one of these methods and it did not help, go to another method from this list: 

### Method 1: Install the latest updates

Click here to show information on how to install latest updates.

You might need to set Windows Update to automatically download and install recommended updates. Installing any important, recommended, and optional updates can often correct problems by replacing out-of-date files and fixing vulnerabilities. To install the latest Office updates, see [Install Windows updates](https://windows.microsoft.com/windows7/install-windows-updates).

If installing the latest Office updates did not resolve your issue, continue to method 2.

### Method 2: Check to make sure Excel is not in use by another process

Click here to show information on how to make sure Excel is not in use by another process.

If Excel is in use by another process, this information will be displayed in the horizontal status bar at the bottom of the screen. If you try to perform other actions while Excel is in use, Excel may not respond. Let the task in process finish its job before attempting other actions.

If Excel is not in use by another process, continue to method 3.  

### Method 3: Investigate possible issues with add-ins

Click here to show information on how to look for add-in issues.

While add-ins can enhance your experience, they can occasionally interfere or conflict with Excel. Try starting Excel without add-ins to see if the problem goes away. Here's how:

1. Do one of the following:
 
    If you are running Windows XP, click Start, and then click Run.
    
    If you are running Windows Vista or Windows 7, click Start.   
2. Type Excel /safe, and then click OK.    
3. If the issue is resolved, on the File menu, click Options, and then click Add-Ins.    
4. Select COM Add-ins, and then click Go.    
5. Click to clear all the check boxes (Disable the Add-ins) in the list, and then click OK.    
6. Restart Excel.    

If the issue does not occur, start enabling the add-ins one at a time until the issue occurs. This will allow you to figure out which add-in is causing the problem. Be sure and restart Excel each time you enable an Add-in.

If disabling add-ins did not resolve your issue, continue to method 4.

### Method 4: Repair your Office 2010 programs

Click here to show information on how you can repair Office 2010 programs.

Repairing your Office 2010 programs can resolve issues with Excel not responding, hanging, or freezing by automatically repairing errors in the file.
 
1. Quit any Microsoft Office programs that are running.    
2. Open the Control Panel, and then open Add or Remove Programs (if you are running Windows XP) or Programs and Features (if you are running Windows Vista or Windows 7).   
3. In the list of installed programs, right-click Microsoft Office 2010, and then click Repair.    

> [!NOTE]
> If you are using Office Click-to-Run, please see the following Microsoft Office article and follow the steps to Repair Office Click-to-Run:

If you're not sure if the version of Office that you have is Click to Run, check your version by: 

1. Open any Office product (Excel, Word, PowerPoint etc.).  
2. Click on the FileTab and select Help.    
3. Under "About Microsoft Office", it should say (32-bit) or (64-bit) next to the version number.    
4. If you have a Click to Runversion, it will be stated there. 

If repairing your Office programs did not resolve your issue, continue to method 5.  

### Method 5: Check to see if your antivirus software is up-to-date or conflicting with Excel

Click here to show information on how you can check for conflicts or if the antivirus is up to date.

If your antivirus software is not up-to-date, Excel may not function properly.

**To check whether your antivirus software is up to date**

To keep up with new viruses that are created, antivirus software vendors periodically provide updates that you can download from the Internet. Download the latest updates by visiting your antivirus software vendor's website.

For a list of antivirus software vendors, see [Consumer security software providers](https://www.microsoft.com/windows/antivirus-partners/windows-7.aspx).

**To check whether antivirus software is conflicting with Excel**

If your antivirus software includes integration with Excel, you may experience performance issues. In this case, you can disable all Excel integration within the antivirus software. Or, you can disable any antivirus software add-ins that are installed in Excel.

> [!IMPORTANT]
> Changing your antivirus settings may make your PC vulnerable to viral, fraudulent, or malicious attacks. Microsoft does not recommend that you attempt to change your antivirus settings. Use this workaround at your own risk.

You may have to contact your antivirus software vendor to determine how to configure the software to exclude any integration with Excel or to exclude scanning in Excel.

If updating you antivirus software, and excluding it from integrating with Excel did not resolve your issue, continue to Advanced Troubleshooting.

### Advanced Troubleshooting

This section is intended for more advanced computer users. If you are not comfortable with advanced troubleshooting, go to the More Information section.

### Perform a Selective Startup to determine if another program is conflicting with Excel

Click here to show information on how to perform a selective startup.

When you start Windows normally, several applications and services start automatically and then run in the background. These applications and services can interfere with other software on your PC. Performing a Selective Startup or "clean boot" can help you identify problems with conflicting applications. To perform a Selective Startup, see [How to perform a clean boot in Windows](https://support.microsoft.com/help/310353).

If performing a Selective Startup does not resolve your issue, continue to method 2.

## More Information

If the information in this knowledge base article did not help resolve your issue in Excel 2010, select one of the following options: 

- More Microsoft online articles:
[Perform a search to find more online articles about this specific error](https://support.microsoft.com/search) 
- Help from the Microsoft Community online:
[Visit the Microsoft Community online and post your question about this error.](https://answers.microsoft.com/)  
- Contact Microsoft support:
[Find the phone number to contact Microsoft Support.](https://support.microsoft.com/contactus/) 