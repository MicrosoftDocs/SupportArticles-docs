---
title: How to do a clean uninstallation of Lync for Mac 2011
description: Describes how to cleanly remove Microsoft Lync for Mac 2011 from your computer.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto:
- Lync for Mac 2011
---

# How to do a clean uninstallation of Lync for Mac 2011

## Introduction

This article describes how to do a clean uninstallation of Microsoft Lync for Mac 2011.

## Procedure

To cleanly uninstall Lync for Mac 2011, follow these steps:

> [!NOTE]
> You may be able to avoid uninstalling Lync for Mac 2011 if you create a new profile on the Mac. If you contact Microsoft technical support, you may be asked to create the new profile as a troubleshooting step. If the issue is resolved by creating the new profile, it will be determined that the issue was caused by a corrupted profile.

1. Log on to your computer by using administrative credentials.   
2. Exit Lync if it's running.   
3. Drag the Lync application to the Trash.   
4. To remove your existing Lync preferences, delete the following files:

   - Users/username/Library/Preferences/com.microsoft.Lync.plist    
   - Users/username/Library/Preferences/ByHost/MicrosoftLyncRegistrationDB.xxxx.plist   
   - Users/username/Library/Logs/Microsoft-Lync-x.log 

     **Note** This file is present only if you turned on Lync Logging.   
   - Users/username/Library/Logs/Microsoft-Lync.log   
   
5. To remove all Lync files from your computer, delete the following folders in the Users/username/Documents/Microsoft User Data folder:

   - Microsoft Lync Data   
   - Microsoft Lync History

    > [!NOTE]
    > If you delete the Microsoft Lync History folder, you delete all conversations that are saved in the Conversation History.   
   
6. In the Applications/Utilities folder, open Keychain Access.

   - Delete any keychains on the left that resemble OC__KeyContainer__<email address>.   
   - In your Login keychain, delete the <your email address> certificate.   
   
7. In the Users/username/Library/Keychains folder, delete all the files that resemble OC__KeyContainer__<email address>.   

See the following table for more information about the path locations that are used in Lync for Mac 2011.

|Folder path|Description|
|----|----|
|Users/Home Folder/Documents/Microsoft User Data/Microsoft Lync Data|Contains information about the users who have logged into Lync for Mac 2011 on this user account.|
|Users/Home Folder/Documents/Microsoft User Data/Microsoft Lync History|Contains conversation history for the user currently logged in.|
|Users/Home Folder/Library/Preferences/com.microsoft.Lync.plist|Contains application preferences for Lync.|
|Users/Home Folder/Library/Caches/com.microsoft.Lync|Contains server names and endpoints from previous connections to Lync servers.|

## More Information 

To view the Lync for Mac 2011 deployment guide, go to the following Microsoft website: [Lync for Mac 2011 Deployment Guide](/previous-versions/office/office-for-mac-2011/jj984275(v=office.14)).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).