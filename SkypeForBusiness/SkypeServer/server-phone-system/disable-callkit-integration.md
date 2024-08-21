---
title: Disable CallKit integration for Skype for Business iOS
description: Describes how to disable CallKit integration for Skype for Business iOS.
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
  - Skype for Business iOS
ms.date: 03/31/2022
---

# How to disable CallKit integration for Skype for Business iOS

## Summary

Skype for Business iOS is integrated with CallKit version 6.10 and later versions.

CallKit API with iOS 10 enables Skype for Business (SfB) calls to work the same way as the native calling experience on iOS, allowing you to seamlessly extend your personal device as a business phone.

CallKit integration lets you do the following:

- Answer Skype for Business calls with a single swipe from the lock screen, just like on a cellular phone call.   
- Have uninterrupted business conversations with the ability to choose between Skype for Business and a cellular call.   
- Initiate Skype for Business calls directly from the native call log, where CallKit integration registers SfB calls.   

## Resolution

### Disable CallKit integration for a tenant

A tenant administrator may set the AllowDeviceContactsSync policy to false.

Required: [November 2016 Update for Skype for Business Server 2015](https://support.microsoft.com/help/3061064)

Run the following PowerShell command, which will disable CallKit integration for the Redmond site:

```powershell
Set-CsMobilityPolicy -Identity site:Redmond -AllowDeviceContactsSync $False
```

### Disable CallKit integration for a single user

A user can disable CallKit integration on their device by tapping their avatar, selecting **Settings**, and then toggling **Mobile Integration** to off (default is on). This cannot be done if CallKit is disabled for the user's tenant.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
