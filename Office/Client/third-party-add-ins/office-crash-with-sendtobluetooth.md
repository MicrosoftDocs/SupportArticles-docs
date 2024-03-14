---
title: Office programs may crash with the SendToBluetooth add-in installed
description: Describes problems that may occur with Office applications with the SendToBluetooth add-in installed.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Word 2016
  - PowerPoint 2016
  - Excel 2016
  - Outlook 2016
  - Visio Professional 2016
  - Visio Standard 2016
  - Word 2013
  - PowerPoint 2013
  - Excel 2013
  - Visio Professional 2013
  - Outlook 2013
  - Microsoft Word 2010
  - PowerPoint 2010
  - Excel 2010
  - Visio Professional 2010
  - Microsoft Outlook 2010
  - Microsoft Office PowerPoint 2007
  - Microsoft Office Excel 2007
  - Microsoft Office Visio Standard 2007
  - Microsoft Office Visio Professional 2007
  - Microsoft Office Outlook 2007
  - Microsoft Office Word 2003
  - Microsoft Office PowerPoint 2003
  - Microsoft Office Excel 2003
  - Microsoft Office Visio Professional 200
  - 3Microsoft Office Outlook 2003
  - Microsoft Office OneNote 2003
  - Microsoft OneNote 2010
  - OneNote 2013
  - Microsoft Office Publisher 2003
  - Microsoft Office Publisher 2007
  - Publisher 2010Publisher 2013
ms.date: 03/31/2022
---

# Office programs may crash with the SendToBluetooth add-in installed

## Resolution

If you have the WIDCOMM SendToBluetoothadd-in installed, your Office programs might be crashing due to an incompatibility issue between the add-in and other Microsoft Office programs.

Note: This add-in is installed by default on many OEM images of Windows.

Here's how you can check to see if the add-in is the cause of your Office programs crashing:

### First, open the Event Viewer 

**For a Windows 10, Windows 8.1 and Windows 8**


1. From the Start screen, type View event log-in the search box.    
2. Select View event logs.   

**Windows 7 and Vista**


1. Click Start.   
2. In the Search box, type Event Viewer, and then, in the list of results, double-click Event Viewer.    

**Windows XP**


1. Click Start>Control Panel>Performance and Maintenance, and then click Administrative Tools, and then double-click Computer Management.    
2. In the console tree, expand Event Viewer.   

### Now, check for the following events

Event ID: 1000

Faulting module name: msctf.dll

Event ID: 1000

Faulting module name: ntdll.dll

Note: Even if you do not see an Event 1000 with either of these two dlls listed, you may still be encountering crashes due to this add-in.

### Method 1: Try to update the SendToBluetooth add-inYou might be able to find an update to the Bluetooth add-in here:

[https://www.broadcom.com/support/bluetooth/update.php[Enter](https://www.broadcom.com/support/bluetooth/update.php)

If you weren't able to update the add-in, you can continue to Method 2 to disable the SendToBluetooth add-in. 

### Method 2: Manually disable the SendToBluetooth add-in
Important: This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

Warning: Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Before you start the steps below, make sure you close all of your Office programs.


1. Open the Registry, here's how:
   - Windows 10, Windows 8.1 and Windows 8: Press Windows Key + R to open a Run dialog box. Type regedit.exeand then select OK.   
   - Windows 7 or Vista: Click Start, type regedit.exein the search box, and then select Enter.    


2. Select the Office program that is crashing and locate and then select the key listed for it:
### Click for a list of Office programs
Word

HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Word\Addins

Note: If you are using a 32-bit version of Office on a 64-bit version of Windows, you will need to select the following key:

HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\Word\AddinsOutlook
HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Outlook\Addins

Note: If you are using a 32-bit version of Office on a 64-bit version of Windows, you will need to select the following key:

HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\Outlook\AddinsExcel
HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Excel\Addins

Note: If you are using a 32-bit version of Office on a 64-bit version of Windows, you will need to select the following key:

HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\Excel\AddinsPowerPoint
HKEY_LOCAL_MACHINE\Software\Microsoft\Office\PowerPoint\Addins

Note: If you are using a 32-bit version of Office on a 64-bit version of Windows, you will need to select the following key:

HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\PowerPoint\AddinsOneNote
HKEY_LOCAL_MACHINE\Software\Microsoft\Office\OneNote\Addins

Note: If you are using a 32-bit version of Office on a 64-bit version of Windows, you will need to select the following key:

HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\OneNote\AddinsVisio
HKEY_LOCAL_MACHINE\Software\Microsoft\Visio\Addins

Note: If you are using a 32-bit version of Office on a 64-bit version of Windows, you will need to select the following key:

HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Visio\Addins   
3.  Expand the \Addins subkey to display all of the add-ins registered at the Machine level.   
4. If listed, select the subkey for the SendToBluetooth add-in called BtOfficeAddin.BtOfficeIntegration.1.   
5. Right-click the LoadBehavior value and then click Modify.   
6. Change the Value data to 0, and then click OK and then close the Registry Editor.   
7. Start your Office program that was crashing to determine if the registry change has improved the stability of the program.   

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
