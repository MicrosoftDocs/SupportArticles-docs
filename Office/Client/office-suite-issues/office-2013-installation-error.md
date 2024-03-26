---
title: Error 25004, The product key you entered cannot be used on this machine
description: Resolves an issue in which you cannot install Microsoft Office 2013. Specifically, you receive an Error 25004. The product key you entered cannot be used on this machine error message.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: gregak, mmaxey, tomol
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office 2013
ms.date: 03/31/2022
---

# "Error 25004. The product key you entered cannot be used on this machine" when you install Office 2013

## Symptoms

When you try to Install Microsoft Office 2013, you receive the following error message:

```adoc
Microsoft Office encountered an error during setup.

Error 25004. The product key you entered cannot be used on this machine. This is most likely due to previous Office 2013 trials being installed. (System error: -1073422308)
```

## Cause

This issue occurs when you try to install a Windows Installer (MSI)-based version of Office 2013 on a computer on which the computer manufacturer has already installed a version of Microsoft Office 2013.

## Resolution

To resolve this issue, uninstall the existing version of Microsoft Office. To do this, follow the steps for the version of Windows that you are running.

**Windows 8**

1. Swipe in from the right edge of the screen, and then tap **Search**. Or, if you are using a mouse, point to the lower-right corner of the screen, and then click **Search**.   
2. In the search box, type Control Panel.    
3. Tap or click **Control Panel**, tap or click **Programs**, and then tap or click **Programs and Features**.    
4. Select the Microsoft Office 2013, and then tap or click **Uninstall**.   

**Windows 7**

1. Click **Start**, click **Control Panel**, click **Programs**, and then click **Programs and Features**.    
2. Select the Microsoft Office 2013, and then click **Uninstall**.   
