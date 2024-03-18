---
title: Office files with RMS protection crash
description: Resolves the issue when Office files that have RMS protection seem to crash.
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
  - Word 2010
  - PowerPoint 2010
ms.date: 03/31/2022
---

# Office files that have RMS protection seem to crash

## Symptoms

When you try to open a Microsoft Office document that has Information Rights Management (IRM) protection, the document seems to crash and does not respond. This behavior occurs after you install either of the following: 

[2687297 ](https://support.microsoft.com/help/2687297) Description of the Office 2010 hotfix package (Mso-x-none.msp): June 26, 2012 

[2553260 ](https://support.microsoft.com/help/2553260) MS12-057: Description of the security update for Office 2010 (MSO): August 14, 2012

## Resolution

ImportantThis section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 

[322756 ](https://support.microsoft.com/help/322756) How to back up and restore the registry in WindowsTo resolve this issue, follow these steps:


1. Delete all files in the following folder:

   %localAppData%\Microsoft\DRM\   
2.  Close all Office programs.   
3.  Click **Start**, click **Run**, in the **Open** box, type regedit, and then click **OK**.    
4. Locate the following subkey and remove the CachedCorpLicenseServer value from the subkey: 
   **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\DRM**   
5. Delete all entries under the following subkey:
   **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\DRM\ServiceLocations**   

## More Information

For an automated solution, execute a batch file to update your system automatically.

**Note** We recommend that you back up the registry before you follow these steps:

1. Start Notepad, and paste the following in a new text file: 

   del %localAppData%\Microsoft\DRM\*.* /q /f /s

   reg delete hkcu\Software\Microsoft\Office\14.0\Common\DRM /v 

   CachedCorpLicenseServer /f

   reg delete 
   
   hkcu\Software\Microsoft\Office\14.0\Common\DRM\ServiceLocations /f   
2. Save the file, and change the file name extension from .txt to .bat.   
3. Run the .bat file that you created in step 2. To do this, double-click the file to run it.   

## Status

Microsoft has confirmed that this is an issue in the Microsoft products that are listed in the "Applies to" section.
