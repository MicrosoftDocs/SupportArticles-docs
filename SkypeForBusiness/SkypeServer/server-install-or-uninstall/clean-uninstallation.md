---
title: How to do a clean uninstallation of Skype for Business on Mac
description: Describes how to cleanly remove Skype for Business on Mac from your computer.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skypeforbusiness-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business on Mac
---

# How to do a clean uninstallation of Skype for Business on Mac

## Introduction 

This article describes how to do a clean uninstallation of Microsoft Skype for Business on Mac.

## Procedure 

To cleanly uninstall Skype of Business on Mac, follow these steps:

1. Log on to your computer by using administrative credentials.   
1. Exit Skype For Business on Mac if it’s running.   
1. Drag the Skype For Business on Mac application to the Trash.   
1. Remove existing Skype preferences if those hidden files exist. To do so, follow these steps:
   1. In the **Finder** menu, click **Go**, and click **Go to Folder**.
   2. Run the following commands:

      - sudo rm -rf /Applications/Skype\ for\ Business.app
      - sudo rm -rf /Library/Internet\ Plug-Ins/MeetingJoinPlugin.plugin
      - defaults delete com.microsoft.SkypeForBusiness || true
      - rm -rf ~/Library/Containers/com.microsoft.SkypeForBusiness
      - rm -rf ~/Library/Logs/DiagnosticReports/Skype\ for\ Business_*
      - rm -rf ~/Library/Saved\ Application\ State/com.microsoft.SkypeForBusiness.savedState
      - rm -rf ~/Library/Preferences/com.microsoft.SkypeForBusiness.plist
      - rm -rf ~/Library/Application\ Support/CrashReporter/Skype\ for\ Business_*
      - rm -rf ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.microsoft.skypeforbusiness*
      - rm -rf ~/Library/Cookies/com.microsoft.SkypeForBusiness*
      - sudo rm -rf /private/var/db/receipts/com.microsoft.SkypeForBusiness*
      - rmdir ~/Library/Application\ Scripts/com.microsoft.SkypeForBusiness
      - find -f /private/var/db/BootCaches/* -name "app.com.microsoft.SkypeForBusiness*" -exec sudo rm -rf {} +

6. In the Applications/Utilities folder, open **Keychain Access**.   
7. In your logon keychains, delete **Skype for Business**.   

## More Information

If you plan to reinstall Skype for Business on Mac later, you can [download the program](https://www.microsoft.com/download/details.aspx?id=54108).

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
