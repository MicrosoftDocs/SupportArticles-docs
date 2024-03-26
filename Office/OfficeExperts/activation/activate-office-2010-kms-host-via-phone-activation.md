---
title: Activate Office 2010 KMS host through phone activation
description: Describes how to activate the Office 2010 KMS host through telephone when you are in a disconnected environment.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
ms.reviewer: ericspli
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Activate Office 2010 KMS host through phone activation

This article was written by [Eric Ashton](https://social.technet.microsoft.com/profile/EricAshton), Senior Support Escalation Engineer.

## Summary

This article describes how to activate the Office 2010 KMS host through telephone when you are in a disconnected environment.

## More Information

1. Download and install [Microsoft Office 2010 KMS Host License Pack](https://www.microsoft.com/download/details.aspx?id=25095).
1. At a command prompt, change the directory to **c:\windows\system32**.
1. Type **cscript slmgr.vbs /dlv bfe7a195-4f8f-4f0b-a622-cf13c7d16864**, and then press Enter. You see all the license files that are installed on your KMS server.

   :::image type="content" source="media/activate-office-2010-kms-host-via-phone-activation/command-result.png" alt-text="Screenshot of the script command result with license files installed." border="false":::

1. Copy the activation ID and installation ID into Notepad. You may have to put dashes after every six characters in the installation ID. For example:

   020362-296235-955944-683420-831782-XXXXXX-XXXXXX-XXXXXX-XXXXXX

1. If you are in United States, you can dial phone # 888-725-1047 to input your installation ID.
1. If you are NOT in United States, at a command prompt, type **c:\windows\system32\slui.exe 4**, and then select your country/region to get the phone #. After you get your phone # from this screen, close the activation window, as we only wanted the phone #.
1. After you give the automated voice your installation ID, it will return with a confirmation ID.

   For example, a confirmation ID resembles the following:

   XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX

1. Remove the dashes from your confirmation ID. For example:

   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

1. Use the following command under c:\Windows\system32 to activate Office 2010 KMS host:

   ```powershell
   cscript slmgr.vbs /atp XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX bfe7a195-4f8f-4f0b-a622-cf13c7d16864
   ```

   *XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX* is your confirmation ID without dashes.

> [!NOTE]
> You can activate new Office KMS hosts likes 2016 and 2019 in the same manner. The Activation ID is different in each version. If you do not know the Activation ID, you can run the following command:
> ```slmgr.vbs /dlv All >C:\path\kmsinfo.txt```
> In this command, *path* is where you want to pipe the output of the command. Open the created file and search for Office. Find your Office KMS host installation, copy out the Activation ID, and then complete the previous steps with the Activation ID that you just copied.