---
title: Signed out of Teams on Android devices 
description: Provides workarounds for when Android devices are signed out of Teams automatically.
ms.date: 10/30/2023
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

# Signed out of Teams on Android devices

Some Microsoft Teams devices in your environment are signed out of Teams automatically. The devices that are affected by this issue are:

- Teams Rooms on Android
- Teams phone devices
- Teams panels
- Teams displays

If you're a tenant administrator, you can get information about the sign-in state of your devices from the [sign-in logs in the Microsoft Entra admin center](/azure/active-directory/reports-monitoring/concept-sign-ins). To access these logs, navigate to the Microsoft Entra ID menu > **Monitoring** > **Sign-in logs**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-log.png" alt-text="Screenshot of a sign-in log with the User sign-ins (non-interactive) tab, the Applications, Status and Resource columns and their entries highlighted.":::

You can also use the information in the sign-in logs to determine whether a device in your environment is affected by this issue. In the **User sign-ins (non-interactive)** tab, check for the following entries:

- In the **Application** column: Microsoft Authentication Broker
- In the **Status** column: Failure
- In the **Resource** column: Device Registration Service

These entries indicate that your device is affected by the issue.

To sign in to Teams on an affected device, use one of the following options.

## Option 1: Sign in from the Microsoft Teams admin center

**Note** You must have Teams administrator permissions to use this option. Also ensure that your device is running the following versions of the Teams app or a newer version before you begin:

- Teams Rooms on Android: 1.0.96.2021051904
- Teams phone devices: 1449/1.0.94.2021101205
- Teams panels: 1449/1.0.97.2021070601
- Teams displays: 1449/1.0.95.2021111203

For more information, see [What's new in Microsoft Teams devices](https://support.microsoft.com/office/what-s-new-in-microsoft-teams-devices-eabf4d81-acdd-4b23-afa1-9ee47bb7c5e2#ID0EBD=Desk_phones).

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. Select **Devices** in the navigation menu on the left, and then select your Android device.
3. On the page for the Android device, select **Actions** > **Sign out** to sign out of the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-out.png" alt-text="Screenshot of selecting sign out on the device page.":::
4. After you're signed out, select **Sign in**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-in.png" alt-text="Screenshot of selecting sign in on the device page.":::
5. A pop-up window will display. After a wait time of two to five minutes, the window will be populated with a URL, a code and instructions to sign in. Use the information provided to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-instructions.png" alt-text="Screenshot of the pop-up window that provides sign in instructions.":::

## Option 2: Restart the device and then sign in from the Microsoft Teams admin center

**Note** You must have Teams administrator permissions to use this option. Also ensure that your device is running the following versions of the Teams app or a newer version before you begin:

- Teams Rooms on Android: 1.0.96.2021051904
- Teams phone devices: 1449/1.0.94.2021101205
- Teams panels: 1449/1.0.97.2021070601
- Teams displays: 1449/1.0.95.2021111203

For more information, see [What's new in Microsoft Teams devices](https://support.microsoft.com/office/what-s-new-in-microsoft-teams-devices-eabf4d81-acdd-4b23-afa1-9ee47bb7c5e2#ID0EBD=Desk_phones).

Restart the Android device remotely from the Microsoft Teams admin center and then try to sign in.

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. Select **Devices** in the navigation menu on the left, and then select your Android device.
3. On the page for the Android device, select **Restart** to restart the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-restart.png" alt-text="Screenshot of selecting restart on the device page.":::
4. After the device restarts, check the **Username** field.

- If the **Username** field displays a username, select **Actions** > **Sign out** to sign out of the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/username-and-select-sign-out.png" alt-text="Screenshot of the device page with the username field populated and the sign out option selected.":::

  After you're signed out, select **Sign in**.

- If the **Username** field is blank, select **Sign in**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/username-and-select-sign-in.png" alt-text="Screenshot of the device page with the username field blank and the sign in option selected.":::

5. A pop-up window will display. After a wait time of two to five minutes, the window will be populated with a URL, a code and instructions to sign in. Use the provided information to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-instructions.png" alt-text="Screenshot of the pop-up window that provides sign in instructions.":::

## Option 3: Generate a new code on the device to sign in

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

## Option 4: Reset the device

If you still can't sign in to the device, reset the device to its factory settings.

1. Perform a factory reset from the OEM device settings or by using the key combination that's specific to the OEM model.
2. Delete the device object in Microsoft Entra ID, Microsoft Intune and the Microsoft Teams admin center. This will enable fresh objects to be created when you sign in.
3. Use option 1, 2 or 3 to sign in to the device.
