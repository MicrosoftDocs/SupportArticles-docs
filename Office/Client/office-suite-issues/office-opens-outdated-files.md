---
title: Microsoft 365 apps open files from SharePoint On-Premises that aren’t the current version
ms.author: v-matham
author: v-matham
manager: dcscontentpm
ms.date: 3/8/2021
audience: ITPro
ms.topic: article
ms.prod: sharepoint
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Server
- Microsoft 365
ms.custom: 
- CI 144436
- CSSTroubleshoot 
ms.reviewer: sharepoint_triage
description: When you open a Word or PowerPoint file from SharePoint On-Premises in a Microsoft 365 desktop app, you see the local cached file instead of the current server document contents.
---

# Microsoft 365 apps open files from SharePoint On-Premises that aren’t the current version

## Symptoms
When you open a Word or PowerPoint file from SharePoint On-Premises in a Microsoft 365 desktop app, you see the local cached file instead of the current server document contents.  An **Updates Available** button shows in the bottom middle of the app window, in the status bar.


## Cause
This behavior is by design. The AutoSave feature isn't available in SharePoint On-Premises, so the merge doesn’t show until the Updates Available button is pressed.

## Workaround

If you want Office to open the current file on the server every time, you can turn off AutoSave.

> [!IMPORTANT]
> If you turn AutoSave off and then open files from SharePoint Online, real-time co-authoring will not work.  You would need to manually turn AutoSave on to get real-time co-authoring to work.

To turn off AutoSave on an individual computer, do the following:

1.	Select Start and type regedit. Select Registry Editor from the search results.
2.	Navigate to the key: **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\word**
3.	Right-click the key, select **New**, and then select **DWORD (32-bit value)**.
4.	Name the value **autosavebydefaultadminchoice**.
5.	Right-click the new value, select **Modify**, and then set the **Value data** to **2**.
6.	Navigate to the key: **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\powerpoint**
7.	Create the new DWORD value for this key the same way you did for the Word key in steps 3 through 5.
  
For IT administrators looking to turn off AutoSave for all users using Group Policies, create the DWORD key **autosavebydefaultadminchoice** in the following registry hives and set its **Hexadecimal value** to **2**:

- **HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\word**
- **HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\powerpoint**
