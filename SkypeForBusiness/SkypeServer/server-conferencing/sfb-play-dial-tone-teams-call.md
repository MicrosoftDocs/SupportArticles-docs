---
title: Skype for Business plays a dial tone during a Teams call
description: Skype for Business plays a dial tone to all participants of a call for 30 seconds in a call. This article provides a workaround.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 115787, CI 125216
  - CSSTroubleshoot
ms.reviewer: splette, brweathe
appliesto: 
  - Skype for Business 2016
  - Teams
search.appverid: 
  - MET150
ms.date: 03/31/2022
---
# Skype for Business plays a dial tone during a Teams call

## Symptoms

In a Microsoft Teams call, the Microsoft Skype for Business client has the Human Interface Device (HID) controls enabled in Islands mode. During the call, if either Skype for Business starts or the Hook button is pressed on an HID that supports the Flash feature, the client broadcasts a dial tone for 30 seconds to all participants in the call.

## Cause

There is a new HID feature for Islands mode users in Teams to enable **Mute/Unmute** controls (see the "[More information](#more-information)" section for details). This feature requires that the version of the Skype for Business client be **16.0.11020.10000** or later.

If the Skype for Business client is earlier than **16.0.11020.10000**, this issue occurs when the hook button is pressed.

This issue also occurs if Skype for Business starts during a Teams call. This is true for all versions of Skype for Business.

## Workaround

**Note:** Use any of the following methods to work around the issue if it occurs when the Hook button is pressed. Use Method 1 or 2 to work around the issue if it occurs when Skype for Business starts during a Teams call.

### Method 1

Set the dial tone to **None** for Skype for Business.

**Administrators:**

Use the Windows Registry to change the dial tone setting for all users. Clear the data in the following registry subkey:

`HKEY_CURRENT_USER\AppEvents\Schemes\Apps\Communicator\LYNC_dialtone\.Current\Default`

**Individual users:**

Access Windows settings to change the dial tone setting, as follows:

1. Open the **Settings** app, and select **System** > **Sound** > **Sound Control Panel**.
1. Select the **Sounds** tab.
1. In the **Program Events** section, scroll down to locate **Skype for Business**.
1. Under the **Skype for Business** node, select **Dial Tone**.
1. In the **Sounds** section, scroll to the top of the list, select **None**, and then select **OK**.

:::image type="content" source="./media/sfb-play-dial-tone-teams-call/sound-setting.png" alt-text="Screenshot that shows setting the Dial Tone sound to None.":::

### Method 2

Set `PlayAbbreviatedDialTone` to **True** in the client policy. If `PlayAbbreviatedDialTone` is set to **True**, a three-second dial tone is played when a Skype for Business-compatible handset is taken off the hook. To learn more, see [Set-CsClientPolicy](/powershell/module/skype/set-csclientpolicy). To set the value, run the following command:

```powershell
Set-CsClientPolicy -Identity RedmondClientPolicy  -PlayAbbreviatedDialTone $True
```

### Method 3

Enable HID interop features in the Skype for Business client. To learn how, see [EnableTeamsHIDInterop for coordination of HID device usage in Microsoft Teams and Skype for Business 2016 in Islands mode](https://support.microsoft.com/help/4559449).

## More information

To improve the user experience, Microsoft rolled out a new HID feature to enable a **Mute/Unmute** control for Islands mode users in Teams.

This feature applies to Windows (32-bit) only.

Because of the availability of the new **Mute/Unmute HID** controls, previously available controls such as **Hook/OffHook** are no longer supported. However, the volume and ring tone controls will continue to work as before.
