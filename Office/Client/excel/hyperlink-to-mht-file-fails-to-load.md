---
title: Hyperlink to MHT File in Office documents fails to load in Internet Explorer
description: Fixes the issue that MHT file can't be loaded when you click the hyperlink of the MHT file.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Word 2013
  - Microsoft Word 2010
  - Microsoft Office Word 2003
  - PowerPoint 2013
  - PowerPoint 2010
  - Microsoft Office PowerPoint 2007
  - Microsoft Office PowerPoint 2003
  - Internet Explorer 9
ms.date: 03/31/2022
---

# Hyperlink to MHT File in Office Documents Fails to Load in Internet Explorer

## Symptoms

Consider this scenario:

You are using an Office application (Microsoft Excel, Microsoft Word, Microsoft PowerPoint) and you insert a hyperlink to a MHT file on a file share. When you click the link to follow it, Internet Explorer starts, but the MHT file is not loaded. Instead you see an error:

The address is not valid.

Most likely causes:

- There might be a typing error in the address.   
- If you clicked on a link, it may be out of date.   

## Cause

There are spaces in the path or file name in the URL.

## Resolution

Important: This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To work around this issue, follow these steps: 

1. Quit any open Office Application that is affected by the issue.   
2. Click **Start**, click **Run**, type regedit, and then click **OK**.   
3. Locate and then click to select the following registry key: HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl\   
4. After you select the key that is specified in step 3, point to **New** on the **Edit** menu, and then click Key.   
5. Type FEATURE_CREATE_URL_MONIKER_DISABLE_LEGACY_COMPAT, and then press ENTER.   
6. Select Newon the Editmenu again, and select DWord (32-bit) Value   
7. Type iexplore.exe and press Enter   
8. On the **File** menu, click **Exit** to quit Registry Editor.   

#### Did this fix the problem?

- Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).   
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, please send us an [email](mailto:fixit4me@microsoft.com?subject=kb).   

## More Information

Web files (.HTM, .HTML, .ASP, .MHT, .MHTML, etc.) are most frequently stored on web servers, which are designed to use URL encoding to deal with spaces. If you access your .MHT files from a web server, they will load properly with or without spaces in the path.