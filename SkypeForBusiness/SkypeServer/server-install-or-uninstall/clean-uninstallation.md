---
title: How to do a clean uninstallation of Skype for Business on Mac
description: Describes how to cleanly remove Skype for Business on Mac from your computer.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: skypeforbusiness-powershell
ms.topic: article
ms.author: v-six
---

# How to do a clean uninstallation of Skype for Business on Mac

## Introduction 

This article describes how to do a clean uninstallation of Microsoft Skype for Business on Mac.

## Procedure 

To cleanly uninstall Skype of Business on Mac, follow these steps:

1. Log on to your computer by using administrative credentials.   
1. Exit Skype For Business on Mac if it’s running.   
1. Drag the Skype For Business on Mac application to the Trash.   
1. Remove the existing Skype preferences if these hidden files exist. To do this, follow these steps:
   1. In the **Finder** menu, click **Go**, and click Go to Folder.   
   2. Delete the following files:

      - /Users/<User>/Library/Containers/com.microsoft.SkypeForBusiness   
      - /Users/<User>/Library/Logs/LwaTracing   
      - /Users/<User>/Saved Application State/com.microsoft.SkypeForBusiness.savedState   
      - /Users/<User>/Preferences/com.microsoft.SkypeForBusiness.plist      

1. Delete the following file:

   - /Library/Internet Plug-Ins/MeetingJoinPlugin.plugin   
   
6. In the Applications/Utilities folder, open **Keychain Access**.   
7. In your logon keychains, delete **Skype for Business**.   

## More Information

If you plan to reinstall Skype for Business on Mac later, you can [download the program](https://www.microsoft.com/download/details.aspx?id=54108).

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
