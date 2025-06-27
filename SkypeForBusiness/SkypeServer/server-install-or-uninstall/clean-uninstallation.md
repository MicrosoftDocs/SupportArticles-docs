---
title: How to do a clean uninstallation of Skype for Business on Mac
description: Describes how to cleanly remove Skype for Business on Mac from your computer.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business on Mac
ms.date: 03/31/2022
---

# How to do a clean uninstallation of Skype for Business on Mac

## Introduction 

This article describes how to do a clean uninstallation of Microsoft Skype for Business on Mac.

## Procedure 

To cleanly uninstall Skype of Business on Mac, follow these steps:

1. Log on to your computer by using administrative credentials.
2. Exit Skype for Business on Mac if it's running.
3. Drag the Skype for Business on Mac application to the Trash.
4. Remove existing Skype preferences if those hidden files exist. To do so, run the following commands in a Terminal:

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

5. In the Applications/Utilities folder, open **Keychain Access**.
6. In your logon keychains, delete **Skype for Business**.

## More Information

If you plan to reinstall Skype for Business on Mac later, you can [download the program](https://www.microsoft.com/download/details.aspx?id=54108).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
