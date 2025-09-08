---
title: Certified Android devices get signed out of Teams
description: Provides workarounds for an issue in which certified Android devices are signed out of Teams automatically.
ms.date: 08/08/2024
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Compatible Devices and Peripherals
  - CI163313
  - CI188846
ms.reviewer: kponnus
---

# Certified Android devices get signed out of Teams

Some certified Android devices in your environment are signed out of Microsoft Teams automatically. This issue affects the following devices:

- Teams Rooms on Android
- Teams panels
- Teams phones
- Teams displays

If you're a tenant administrator, you can get information about the sign-in state of your devices from the [sign-in logs in the Microsoft Entra admin center](/azure/active-directory/reports-monitoring/concept-sign-ins). To access these logs, navigate to the Microsoft Entra ID menu, and then select **Monitoring & health** > **Sign-in logs**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-log.png" alt-text="Screenshot of a sign-in log with the User sign-ins (non-interactive) tab, the Applications, Status, and Resource columns, and their entries highlighted.":::

You can also use the information in the sign-in logs to determine whether this issue is affecting a device in your environment. On the **User sign-ins (non-interactive)** tab, check for the following entries:

- In the **Application** column: **Microsoft Authentication Broker**
- In the **Status** column: **Failure**
- In the **Resource** column: **Device Registration Service**

These entries indicate that the issue is affecting your device.

To resolve the Teams sign-in issue on an affected device, select the appropriate option based on the device type.

## Teams Rooms on Android devices and Teams panels

If Teams Rooms on Android devices and Teams panels are affected, run the [Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test performs checks to verify a specific user's permissions to use a Teams Rooms device to sign in to Teams.

> [!NOTE]
>
> - A Global Administrator account is required to run the Microsoft Teams Rooms sign-in connectivity test.
> - The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input) connectivity test.
1. Sign in by using the credentials of a Global Administrator account.
1. Specify the username for the account that can't access the Teams Rooms app.
1. In the **Device Selection** field, select a type for the affected user's device.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test finishes, the screen displays details about all the checks that were performed and whether the test succeeded, failed, or was successful but includes warnings. In the list of failures or warnings, select the provided links for more information about each item and how to resolve it.

## Teams phones

If Teams phones are affected, run the [Teams Android Desk Phone Sign in](https://testconnectivity.microsoft.com/tests/TeamsPhoneDeviceSignIn/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test verifies that the user account meets the requirements for a Teams user to sign in to a Teams Android desk phone. For more information about all the checks that this test performs, see [Teams Android Desk Phone Diagnostic](https://techcommunity.microsoft.com/t5/microsoft-teams-support/new-diagnostic-updated-teams-android-desk-phone-diagnostic-now/ba-p/3957808).

> [!NOTE]
>
> - Both administrators and non-administrators can run the Teams Android Desk Phone Sign in connectivity test.
> - The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Teams Android Desk Phone Sign in](https://testconnectivity.microsoft.com/tests/TeamsPhoneDeviceSignIn/input) connectivity test.
1. Sign in by using the credentials of the affected user account. To perform advanced tests, sign in by using the credentials of a Global Administrator account, and then specify the affected user account in the **Specify the target user name (optional)** field.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test finishes, the screen displays details about all the checks that were performed and whether the test succeeded, failed, or was successful but includes warnings. In the list of failures or warnings, select the provided links for more information about each item and how to resolve it.

## Teams displays

If Teams displays are affected, or if you're using the GCC or GCC High Microsoft 365 Government environment, use one of the following options to sign in to Teams.

### Option 1: Sign in from the Microsoft Teams admin center

> [!NOTE]
>
> - You must have Teams administrator permissions to use this option.
> - Also,  make sure that your device is running the [minimum firmware and Teams app versions](/microsoftteams/devices/teams-ip-phones) that are required for Teams-certified Android devices.

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. In the navigation menu on the left, select **Teams devices**, and then select your Android device.
3. On the page for the Android device, select **Actions** > **Sign out** to sign out of the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-out.png" alt-text="Screenshot of selecting the sign out option on the device page.":::
4. After you're signed out, select **Sign in**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-sign-in.png" alt-text="Screenshot of selecting the sign in option on the device page.":::
5. A pop-up window appears. After two to five minutes, the window is populated by a URL, a code, and instructions to sign in. Use the information that's provided to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-instructions.png" alt-text="Screenshot of the pop-up window that provides sign-in instructions.":::

### Option 2: Restart the device and then sign in from the Microsoft Teams admin center

> [!NOTE]
>
> - You must have Teams administrator permissions to use this option.
> - Also,  make sure that your device is running the [minimum firmware and Teams app versions](/microsoftteams/devices/teams-ip-phones) that are required for Teams-certified Android devices.

Restart the Android device remotely from the Microsoft Teams admin center, and then try to sign in.

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. In the navigation menu on the left, select **Teams devices**, and then select your Android device.
3. On the page for the Android device, select **Restart** to restart the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/select-restart.png" alt-text="Screenshot of the restart option highlighted on the device page.":::
4. After the device restarts, check the **Username** field.

   - If the **Username** field displays a username, select **Actions** > **Sign out** to sign out of the device.

     :::image type="content" source="media/signed-out-of-teams-android-devices/username-and-select-sign-out.png" alt-text="Screenshot of the device page with the username field populated and the sign out option selected.":::

     After you're signed out, select **Sign in**.

   - If the **Username** field is blank, select **Sign in**.

     :::image type="content" source="media/signed-out-of-teams-android-devices/username-and-select-sign-in.png" alt-text="Screenshot of the device page with the username field blank and the sign in option selected.":::

5. A pop-up window appears. After two to five minutes, the window is populated by a URL, a code, and instructions to sign in. Use the provided information to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-instructions.png" alt-text="Screenshot of the pop-up window that provides sign-in instructions.":::

### Option 3: Generate a new code on the device to sign in

1. Select **Refresh code** on the device to generate a new code to sign in.

   :::image type="content" source="media/signed-out-of-teams-android-devices/refresh-code.png" alt-text="Screenshot of the refresh code option highlighted.":::
2. If a new code is generated, use it to sign in to the device.
3. If a new code isn't generated, select **Sign in on this device**.

   :::image type="content" source="media/signed-out-of-teams-android-devices/sign-in-on-this-device.png" alt-text="Screenshot of the sign in on this device option highlighted.":::
4. The username is already populated in the appropriate field. Enter the password to sign in to the device.
5. If the sign-in is still unsuccessful, select **Start over**. This will sign you out of the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/start-over.png" alt-text="Screenshot of the start over option highlighted.":::
6. Select **Refresh code** to generate a new code to sign in to the device.

   :::image type="content" source="media/signed-out-of-teams-android-devices/refresh-code.png" alt-text="Screenshot of the refresh code option highlighted.":::

### Option 4: Reset the device

If you still can't sign in to the device, reset the device to its factory settings.

1. Perform a factory reset from the OEM device settings or by using the key combination that's specific to the OEM model.
2. Delete the device object in Microsoft Entra ID, Microsoft Intune, and the Microsoft Teams admin center. This will enable fresh objects to be created when you sign in.
3. Use Option 1, 2, or 3 to sign in to the device.
