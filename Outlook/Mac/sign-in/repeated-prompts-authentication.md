---
title: Outlook 2016 for Mac repeatedly prompts for authentication
description: Describes an issue that causes Outlook 2016 for Mac to repeatedly prompt the user for authentication.  Provides a workaround.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshootCSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Exchange Online
  - Outlook 2016 for Mac
ms.date: 01/30/2024
---

# Outlook 2016 for Mac repeatedly prompts for authentication

## Symptoms

In Microsoft Outlook 2016 for Mac, you are repeatedly prompted for authentication while you're connected to your Microsoft 365 account.

## Cause

This issue occurs because of the presence of duplicate tokens in the keychain.

## Resolution

To resolve this issue in Outlook 2016 for Mac, install the February 2017 Outlook update (version 15.31.0) from the following Office website:

[Release notes for Office 2016 for Mac](https://support.office.com/article/Release-notes-for-Office-2016-for-Mac-ed2da564-6d53-4542-9954-7e3209681a41?ui=en-US&rs=en-US&ad=US)

## Workaround

To work around this issue, delete any cached passwords for your account, and also delete any modern authentication tokens from the keychain. To do this, follow these steps.

> [!NOTE]
> These steps affect all Office applications that use modern authentication.

1. Quit Outlook and all other Office applications. 
2. Start Keychain Access by using one of the following methods:   
   - Select the **Finder** application, click **Utilities** on the **Go** menu, and then double-click **Keychain Access**.   
   - In **Spotlight Search**, type **Keychain Access**, and then double-click **Keychain Access** in the search results.   

3. In the search field in Keychain Access, enter **Exchange**.   
4. In the search results, select each item to view the **Account** that's listed at the top, and then press Delete. Repeat this step to delete all items for your Exchange account.   
5. In the search field, enter **adal**.   
6. Select all items whose type is **MicrosoftOffice15_2_Data:ADAL:\<GUID>**, and then press Delete.
7. In the search field, enter **office**.   
8. Select the items that are named **Microsoft Office Identities Cache 2** and **Microsoft Office Identities Settings 2**, and then press Delete.   
9. Quit Keychain Access.   

   > [!NOTE]
   > When you start Outlook, you are prompted to authenticate.