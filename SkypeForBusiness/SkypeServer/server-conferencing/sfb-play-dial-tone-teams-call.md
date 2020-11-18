---
title: Skype for Business plays a dial tone while a user is active on a Teams call
description: Skype for Business plays a dial tone to all participants of a call for 30 seconds in a call, this article provides a workaround. 
author: TobyTu
ms.author: splette
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: skype-for-business-itpro
localization_priority: Normal
ms.custom: 
- CI 115787
- CSSTroubleshoot
ms.reviewer: splette
appliesto:
- Skype for Business 2016
- Teams
search.appverid: 
- MET150
---

# Skype for Business plays a dial tone while a user is active on a Teams call

## Symptoms

Microsoft Skype for Business client broadcasts a dial tone to all participants of a call for 30 seconds if the Hook button on a Human Interface Device (HID) supporting flash is pressed when using Microsoft Teams with Skype for Business client with HID controls enabled in Islands mode.

## Cause

This issue occurs because new changes have been made in the HID feature for Island mode users.

## Workaround

### Method 1

Set **PlayAbbreviatedDialTone** to "true" in the client policy. If PlayAbbreviatedDialTone is set to True, a 3-seconds dial tone will be played when a Skype for Business-compatible handset is taken off the hook. To learn more, read [Set-CsClientPolicy](https://docs.microsoft.com/powershell/module/skype/set-csclientpolicy?view=skype-ps). To set the value, run the following command:

```powershell
Set-CsClientPolicy -Identity RedmondClientPolicy  -PlayAbbreviatedDialTone $True
```

### Method 2

Another option is to enable HID interop features in the Skype for Business client. To learn how to do that, see [EnableTeamsHIDInterop for coordination of HID device usage in Microsoft Teams and Skype for Business 2016 in Islands mode](https://support.microsoft.com/help/4559449).

## More information

To improve the user's experience, Microsoft has rolled out a new HID feature to enable **Mute/Unmute** for Island mode users in Teams. Here are a few notes and requirements regarding this new feature:

1. This feature applies to Windows (32 bit) only. macOS experience is unchanged.
2. You must update Skype for Business client to version 16.0.11020.10000 or higher. If you don't, HID will remain disabled in Teams.
3. The new feature allows the use of the **Mute/Unmute** HID controls. The **Hook/OffHook** and other HID controls won't work. Volume control and ring tone aren't affected.
