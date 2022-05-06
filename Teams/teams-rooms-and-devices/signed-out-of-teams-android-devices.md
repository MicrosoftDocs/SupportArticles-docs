---
title: Can't sign in to Teams after signing out
description: Provides workarounds for an issue that Android devices are signed out of Teams and can't sign in.
ms.date: 05/04/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI163313
ms.reviewer: kponnus
---

# Signed out of Teams on Android devices and can't sign in

You've been signed out of Microsoft Teams on your Android devices and can't sign in to Teams again. The devices that are affected by this issue are:

- Teams Rooms on Android
- Teams phone devices
- Teams panels
- Teams displays

Use one of the following options to work around the issue and sign in to Teams on your Teams devices.

## Workaround 1: Sign in from the Microsoft Teams admin center

**Note** You must have Teams administrator permissions to use this workaround. To use this work around, ensure that your device is running the following versions of the Teams app or a newer version:

- Teams Rooms on Android: 1.0.96.2021051904
- Teams phone devices: 1449/1.0.94.2021101205
- Teams panels: 1449/1.0.95.2021111203

For more information, see [What's new in Microsoft Teams devices](https://support.microsoft.com/office/what-s-new-in-microsoft-teams-devices-eabf4d81-acdd-4b23-afa1-9ee47bb7c5e2#ID0EBD=Desk_phones).

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. Select **Devices** in the navigation menu on the left side, and then select your Android device.
3. On the page for the Android device, select **Actions** > **Sign out** to sign out of the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-out.png" alt-text="Screenshot of selecting sign out on the device page.":::
4. After you're signed out, select **Sign in**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-in.png" alt-text="Screenshot of selecting sign in on the device page.":::
5. A pop-up window will display. After you wait for two to five minutes, the window will be populated with a URL, a code and instructions to sign in. Use the information provided to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-instructions.png" alt-text="Screenshot of the pop-up window that provides sign in instructions.":::

## Workaround 2: Restart the device and then sign in from the Microsoft Teams admin center

**Note** You must have Teams administrator permissions to use this workaround. To use this work around, ensure that your device is running the following versions of the Teams app or a newer version:

- Teams Rooms on Android: 1.0.96.2021051904
- Teams phone devices: 1449/1.0.94.2021101205
- Teams panels: 1449/1.0.95.2021111203

For more information, see [What's new in Microsoft Teams devices](https://support.microsoft.com/office/what-s-new-in-microsoft-teams-devices-eabf4d81-acdd-4b23-afa1-9ee47bb7c5e2#ID0EBD=Desk_phones).

If workaround 1 doesn't work, restart the Android device remotely from the Microsoft Teams admin center and then try to sign in.

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. Select **Devices** in the navigation menu on the left side, and then select your Android device.
3. On the page for the Android device, select **Restart** to restart the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-restart.png" alt-text="Screenshot of selecting restart on the device page.":::
4. After the device restarts, select **Sign in**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-in.png" alt-text="Screenshot of selecting sign in on the device page.":::
5. A pop-up window will display. After you wait for two to five minutes, the window will be populated with a URL, a code and instructions to sign in. Use the provided information to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-instructions.png" alt-text="Screenshot of the pop-up window that provides sign in instructions.":::

## Workaround 3: Generate a new code on the device to sign in

1. Select **Refresh code** on the device to generate a new code to sign in.

   :::image type="content" source="media/signed-out-of-teams-android-devices/refresh-code.png" alt-text="Screenshot of selecting refresh code on the device.":::
2. If a new code is generated, use it to sign in to the device.
3. If a new code isn't generated, select **Sign in on this device**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-on-this-device.png" alt-text="Screenshot of selecting sign in on this device.":::
4. The username will already be populated in the appropriate field. Enter the password to sign in to the device.
5. If the sign-in is still unsuccessful, select **Start over**. This will sign you out of the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/start-over.png" alt-text="Screenshot of selecting start over on this device.":::
6. Select **Refresh code** to generate a new code to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/refresh-code.png" alt-text="Screenshot of selecting refresh code on the device.":::

## Workaround 4: If you still can't sign in to the device, reset the device to its factory settings

1. Perform a factory reset from the OEM device settings or by using the key combination that's specific to the OEM model.
2. Use workaround 1, 2 or 3 to sign in to the device.
