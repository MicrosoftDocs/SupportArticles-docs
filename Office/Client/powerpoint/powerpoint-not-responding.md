---
title: PowerPoint 2010 not responding, hangs or freezes
description: Provides several methods to fix problems when you start, open a file or save a file in PowerPoint 2010 and it hangs or freezes.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
search.appverid: 
- MET150
appliesto:
- PowerPoint 2013
- PowerPoint 2010
---

# PowerPoint 2010 not responding, hangs or freezes

## Summary

This article discusses troubleshooting steps that can help resolve issues when you receive an “Microsoft PowerPoint has stopped working” error, or PowerPoint hangs or freezes when you launch PowerPoint, open a file or save a file.

## Cause

Problems with PowerPoint hanging, freezing or not responding may occur for one or more of the following reasons:

- This issue can occur if you have not installed the latest updates.    
- PowerPoint may be in use by another process.    
- A previously installed add-in may be interfering with PowerPoint.   
- You may need to repair your Office 2010 programs.    
- Antivirus software may be outdated, or conflicting with PowerPoint.    
- Advanced Troubleshooting    

## Resolution

Follow the provided methods in this article in order. If you have previously tried one of these methods and it did not help, go to another method from this list:

### Install the latest updates

You might need to set Windows Update to automatically download and install recommended updates. Installing any important, recommended, and optional updates can often correct problems by replacing out-of-date files and fixing vulnerabilities. To install the latest Office updates, see [Windows Update: FAQ](https://support.microsoft.com/help/12373/windows-update-faq).

If installing the latest Office updates did not resolve your issue, continue to the next step.

### Check to make sure PowerPoint is not in use by another process

If PowerPoint is in use by another process, this information will be displayed in the horizontal status bar at the bottom of the screen. If you try to perform other actions while PowerPoint is in use, PowerPoint may not respond. Let the task in process finish its job before attempting other actions. 

If PowerPoint is not in use by another process, continue to the next step.
 
### Investigate possible issues with add-ins

While add-ins can enhance your experience, they can occasionally interfere or conflict with PowerPoint. Try starting PowerPoint without add-ins to see if the problem goes away. Here’s how:

1. Do one of the following:
    
   If you are running Windows XP, click Start, and then click Run.
    
   If you are running Windows Vista or Windows 7, click Start.   
2. Type PowerPoint /safe, and then click OK.

   If PowerPoint doesn't launch, click Start, point to All Programs, and then point to Microsoft Office. Press and hold the CTRL key, and then click the name of the Microsoft PowerPoint 2010.   
3. If the issue is resolved, on the File menu, click Options, and then click Add-Ins.   
4. Select COM Add-ins, and then click Go.    
5. Click to clear all the check boxes (Disable the Add-ins) in the list, and then click OK.   
6. Restart PowerPoint.   

If the issue does not occur, start enabling the add-ins one at a time until the issue occurs. This will allow you to figure out which add-in is causing the problem. Be sure and restart PowerPoint each time you enable an Add-in.

If disabling add-ins did not resolve your issue, continue to the next step. Or, PowerPoint 2013 users may also refer to the troubleshooting steps in [I get a "stopped working" error when I start Office applications on my PC](https://office.microsoft.com/support/why-cant-i-start-my-office-2013-application-ha104011864.aspx)

### Repair your Office 2010 programs

Repairing your Office 2010 programs can resolve issues with PowerPoint not responding, hanging, or freezing by automatically repairing errors in the file. 

1. Quit any Microsoft Office programs that are running.    
2. Open the Control Panel, and then open Add or Remove Programs (if you are running Windows XP) or Programs and Features (if you are running Windows Vista or Windows 7).   
3. In the list of installed programs, right-click Microsoft Office 2010, and then click Repair.   

If you are using Office Click-to-Run, update, repair, or uninstall Office Click-to-Run products.

If you're not sure if the version of Office that you have is Click to Run, check your version by:

1. Open any Office product (Excel, Word, PowerPoint etc.).   
2. Click on the FileTab and select Help.   
3. Under "About Microsoft Office" it should say (32-bit) or (64-bit) next to the version number.   
4. If you have a Click to Runversion it will be stated there.   

If repairing your Office programs did not resolve your issue, continue to the next step.

### Check to see if your antivirus software is up-to-date or conflicting with PowerPoint

If your antivirus software is not up-to-date, PowerPoint may not function properly. 

To check whether your antivirus software is up-to-date

To keep up with new viruses that are created, antivirus software vendors periodically provide updates that you can download from the Internet. Download the latest updates by visiting your antivirus software vendor’s website. 

For a list of antivirus software vendors, see [Consumer antivirus software providers for Windows](https://www.microsoft.com/windows/antivirus-partners/windows-7.aspx)

To check whether antivirus software is conflicting with PowerPoint

If your antivirus software includes integration with PowerPoint , you may experience performance issues. In this case, you can disable all PowerPoint integration within the antivirus software. Or, you can disable any antivirus software add-ins that are installed in PowerPoint. 

> [!IMPORTANT]
> Changing your antivirus settings may make your PC vulnerable to viral, fraudulent, or malicious attacks. Microsoft does not recommend that you attempt to change your antivirus settings. Use this workaround at your own risk. 

You may have to contact your antivirus software vendor to determine how to configure software to exclude any integration with PowerPoint or to exclude scanning in PowerPoint. 

If updating you antivirus software, and excluding it from integrating with PowerPoint did not resolve your issue, continue to Advanced Troubleshooting. 

### Advanced Troubleshooting

This section is intended for more advanced computer users. If you are not comfortable with advanced troubleshooting, go to the More Information section.

#### Perform a Selective Startup to determine if another program is conflicting with PowerPoint

When you start Windows normally, several applications and services start automatically and then run in the background. These applications and services can interfere with other software on your PC. Performing a Selective Startup or "clean boot" can help you identify problems with conflicting applications. To perform a Selective Startup, see [How to perform a clean boot in Windows](https://support.microsoft.com/en-us/help/929135).

If performing a Selective Startup does not resolve your issue, please contact Microsoft Support. 

#### Change the default printer

PowerPoint loads a default printer, and changing this setting may resolve the issue:

1. Open the Control Panel, open Hardware and Sound, and then open Devices and Printers.   
2. In the list of printers, right click either the Microsoft XPS Document Writer or Send to OneNote.   
3. Select Set as default printerfrom the menu.   

## More Information

If the information in this knowledge base article did not help resolve your issue in PowerPoint 2010, select one of the following options: 

- More Microsoft online articles:
[Perform a search to find more online articles about this specific error.](https://support.microsoft.com)   
- Help from the Microsoft Community online community:
[Visit the Microsoft community and post your question about this error.](https://answers.microsoft.com/)   
- Contact Microsoft support:
[Find the phone number to contact Microsoft Support.](https://support.microsoft.com/contactus/)   
