---
title: Office applications crash when you open an IRM document if HTTPS proxy is enabled
description: Fixes an issue that causes Office 2016 and Office 2013 applications to crash when you try to open an information rights management (IRM)–protected document.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Errors & Crashing
  - Reliability
  - CSSTroubleshoot
ms.reviewer: jarrettr, aartigoyle
search.appverid: 
  - MET150
appliesto: 
  - Word 2013
  - PowerPoint 2013
  - Excel 2013
  - Outlook 2013
  - Outlook 2016
  - Visio 2016
  - Word 2016
  - PowerPoint 2016
  - Excel 2016
ms.date: 06/06/2024
---

# Office applications crash when you open an IRM document if HTTPS proxy is enabled

## Symptoms

You do one of the following: 

- Start an Office 2016 or Office 2013 application    
- Open an information rights management (IRM)–protected document or email message    
- Try to protect a document or email message by using IRM    
- Sign in to an Office 2016 or Office 2013 application    
 
In this situation, the relevant Office application crashes. 

## Cause

Windows verifies that the data sent by the Azure RMS service is valid and is coming from RMS. If Windows is configured to use a proxy server for HTTPS connections, this validation process may fail and cause Office applications to crash. 

## Resolution

This issue is fixed in the following updates: 
 
- Office 2013 MSI: [April 4, 2017, update for Office 2013 (KB 3172523)](https://support.microsoft.com/help/3172523)    
- Office 2016 MSI: [April 4, 2017, update for Office 2016 (KB 3178666)](https://support.microsoft.com/help/3178666)    
- Office 2013 Click-to-Run: Build 15.0. 4919.1002 or a later build    
- Office 2016 Click-to-Run: Build 16.0.8067.2115 or a later build

## Workaround

To work around this issue, temporarily disable Azure RMS server certification validation by configuring a registry key as follows.

**Important** Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.   

**Notes**

- Setting this registry key disables the additional security validation that makes sure that the Azure RMS server's certificate is chained to the [Microsoft Trusted Root Certificate](https://technet.microsoft.com/library/cc751157.aspx?f=255&MSPPError=-2147217396).    
- Setting this registry key does not affect the primary security validation (whether the Azure RMS server's certificate is valid, expired, and chained to a trusted root).    
 
1. Exit all Office applications.    
2. Start Registry Editor:

   - In Windows 10, go to **Start**, enter **regedit **in the **Search **box, and then select **regedit.exe** in the search results.    
   - In Windows 7, click **Start**, enter **regedit** in the **Search programs and files** box, and then click **regedit.exe** in the search results.    
   - In Windows 8 or Windows 8.1, move the mouse pointer to the upper-right corner, select **Search**, type **regedit **in the search box, and then select **regedit.exe** in the search results.

3. Locate and then select one of the following subkeys, depending on your version of Office and Windows:
   - 32-bit Office
     - 32-bit Windows

       `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSIPC\RMSOServerVerification`
     - 64-bit Windows

       `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSIPC\RMSOServerVerification`

   - 64-bit Office

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSIPC\RMSOServerVerification`
4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.    
5. Enter **NoValidation**, and then press Enter.    
6. In the **Details** pane, press and hold (or right-click) **NoValidation**, and then select **Modify**.    
7. In the **Value data** box, enter **1**, and then select **OK**.    
8. Exit Registry Editor.    
 
## More Information

This issue occurs in installations of Office 2013 (Word 2013, Excel 2013, PowerPoint 2013, and Outlook 2013) and Office 2016 (Word 2016, Excel 2016, PowerPoint 2016, Visio 2016, and Outlook 2016) that have the msipc.dll file (version **1.0.2284.0** or **1.0.2236.0**). You may have the affected msipc.dll file in the following situations:  
 
- If you have the [February 7, 2017, update for Office 2013 (KB3115489)](https://support.microsoft.com/help/3115489) installed. 
- If you have the [February 7, 2017, update for Office 2016 (KB3114389)](https://support.microsoft.com/help/3114389) installed.  
- If you have Office subscription build **16.0.7571.2072** or a later version.
