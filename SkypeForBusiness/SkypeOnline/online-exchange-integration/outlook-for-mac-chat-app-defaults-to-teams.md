---
title: Chat app in Outlook for Mac defaults to Teams instead of Skype for Business
ms.author: v-six
author: simonxjx
manager: dcscontentpm
ms.date: 12/12/2019
audience: Admin
ms.topic: article
ms.prod: skype-for-business
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Skype for Business
- Outlook for Mac
ms.custom: 
- CI 104345
- CSSTroubleshoot 
ms.reviewer: premgan  
description: Outlines what to do when the chat app in Outlook for Mac will not default to Skype for Business.
---

# Chat app in Outlook for Mac defaults to Teams instead of Skype for Business

## Symptom

You cannot set the default chat app to **Skype for Business** in Microsoft Outlook for Mac because the default value is set to another app (for example, Microsoft Teams).

## Workaround

To work around this issue, follow these steps:

1. Navigate to the following location:<br/>
~Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist.
2. Locate the **LSHandlerURLScheme** sip under the Root/LSHandlers/Item array and verify that **LSHandlerRoleAll** refers to an app other than com.microsoft.skypeforbusiness.
3. Change **LSHandlerRoleAll** to **com.microsoft.skypeforbusiness**.
4. Restart the computer.
5. In Outlook, hover the cursor over the contact, and then select the IM button to verify that the Skype for Business app starts.

Alternatively, you may be able to use Workgroup Manager by getting support from Apple to avoid configuring LSHandlerRoleAll on a per-user basis. For more information, see the [Client Management](https://go.microsoft.com/fwlink/?LinkId=106770) documentation in the Mac OS X Server area of the Apple website (www.apple.com/server).

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.

## More information

For detailed information about how to manage preferences by using Workgroup Manager, see the [Mac OS X Server User Management](https://go.microsoft.com/fwlink/?LinkId=106762) documentation.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
