---
title: Fix Conditional Access-related issues for Teams Android devices
description: Discusses how to exclude devices from Conditional Access policies or Intune device compliance policies that can prevent users from signing in to or using the Teams app on Android devices.
ms.reviewer: taherr
ms.topic: troubleshooting
ms.date: 05/26/2024
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Compatible Devices and Peripherals
  - CI168070
  - CI188847
---
# Fix Conditional Access issues for Teams Android devices

## Symptoms

Conditional Access is a Microsoft Entra feature that helps make sure that devices that access corporate resources are correctly managed and secured. If Conditional Access policies are applied to the Microsoft Teams service, Android devices that access Teams must comply with the policies. Such devices include Teams phones, Teams displays, Teams panels, and Teams Rooms on Android. Otherwise, Conditional Access will prevent users from signing in to or using the Teams app on the devices.

If these policies are applied, you might experience one or more of the following issues on non-compliant devices:

- The devices can't sign in to Teams, or they get stuck in sign-in loops.
- The devices automatically sign out of Teams randomly.
- Microsoft Teams stops responding (freezes).

## Cause

These issues can occur for the following reasons:

- Unsupported Conditional Access policy or Intune device compliance policy settings

  If a device is marked as non-compliant, the Microsoft Entra token-issuing service stops renewing the tokens for the device object or even revokes the token. In this case, the device can't get an updated authentication token, and it's forced to sign out.

  To check the compliance status of your devices, use the [Intune Device compliance dashboard](/mem/intune/protect/compliance-policy-monitor).
  
- The [Sign-in frequency](/azure/active-directory/conditional-access/howto-conditional-access-session-lifetime#user-sign-in-frequency) setting

  This setting forces periodic reauthentication. This action might cause the devices to sign out randomly, depending on how many of your Conditional Access policies have different sign-in frequencies set. Whenever reauthentication occurs, the token is revoked and a new device object is created under the user account. If the number of device objects exceeds the Microsoft Entra device limit or Intune device limit, the user can't sign in to the device.
  
- The Terms of Use (ToU) and MFA Conditional Access policies, if both are used

  For more information, see [Known issues with Teams phones](/microsoftteams/troubleshoot/teams-rooms-and-devices/rooms-known-issues#issues-with-teams-phones).

## Resolution

Identify the specific cause of the issue by checking multiple details about the affected user's access to the Teams app. To perform the checks that are required, you can either use an automated option or run the checks manually by using the steps provided.

### Automated checks

The automated option is to run the [Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test performs checks to verify a specific user's permissions to sign in to Teams by using a Teams Rooms device.

> [!NOTE]
>
> - A Global Administrator account is required to run the Microsoft Teams Rooms sign-in connectivity test.
> - The Microsoft Remote Connectivity Analyzer tool isn’t available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:

1. Open a web browser and navigate to the [Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input) connectivity test.
1. Sign in by using the credentials of a Global Administrator account.
1. Specify the username for the account that can't access the Teams Rooms app.
1. In the **Device Selection** field, select a type for the affected user's device.
1. Enter the verification code that's displayed, and then **select Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test finishes, the screen displays details about all the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided link for more information about the warnings and failures, and about how to resolve them.

### Manual checks

To manually check user access to the Teams app, follow these steps:

1. Go to the [sign-in logs in the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins).
1. Select the **User sign-ins (non-interactive)** tab.
1. Select **Add filters** to add the following filters:

   - **Status**: Select **Failure**, and then select **Apply**.
   - **Application**: Enter **Teams**, and then select **Apply**.

   :::image type="content" source="media/teams-android-devices-conditional-access-issues/add-filters.png" alt-text="Screenshot of the Status and Application filters.":::
1. For the affected usernames, look for items that have the following **Application** values:

   - Microsoft Teams
   - Microsoft Teams Service
   - Microsoft Teams – Device Admin Agent
1. Select each item to view details about the failed sign-in. Usually, you can get more information from the following fields on the **Basic info** tab:

   - Sign-in error code
   - Failure reason
   - Additional Details

   :::image type="content" source="media/teams-android-devices-conditional-access-issues/sign-in-details-basic-info.png" alt-text="Screenshot of the Basic info page of the sign-in activity details.":::
1. If the sign-in error code seems to be related to compliance, select the **Conditional Access** tab, and then look for policies that show a **Failure** result.

   :::image type="content" source="media/teams-android-devices-conditional-access-issues/sign-in-details-conditional-access.png" alt-text="Screenshot of the Conditional Access page of the sign-in activity details.":::
1. Review the policy details.

   :::image type="content" source="media/teams-android-devices-conditional-access-issues/conditional-access-policy-details.png" alt-text="Screenshot of the Conditional Access policy details.":::

After you identify the specific Conditional Access policy that's causing the issue, you can use [device filters](/azure/active-directory/conditional-access/concept-condition-filters-for-devices) to exclude the affected device from the policy. Commonly used device properties in device filters are *manufacturer* and *model*. These are used together with the *Contains*, *StartsWith*, and *In* operators.

> [!NOTE]
>
> - Device filters apply to only device objects, not user accounts.
> - Some attributes, such as *model* and *manufacturer*, can be set only if devices are enrolled in Intune. If your devices aren't enrolled in Intune, use extension attributes.
> - Check each policy setting for unsupported settings for Teams devices.

The following screenshot shows a sample device filter.

:::image type="content" source="media/teams-android-devices-conditional-access-issues/device-filter.png" alt-text="Screenshot of an example device filter.":::

## References

- [Supported Conditional Access and Intune device compliance policies for Microsoft Teams Rooms and Teams Android Devices](/microsoftteams/rooms/supported-ca-and-compliance-policies?tabs=phones)
- [App protection policies overview](/mem/intune/apps/app-protection-policy#microsoft-teams-android-devices)
- [Conditional Access and compliance best practices for Microsoft Teams Rooms](/microsoftteams/rooms/conditional-access-and-compliance-for-devices)
- [Authentication best practices for Microsoft Teams shared device management of Android devices](/MicrosoftTeams/devices/authentication-best-practices-for-android-devices#using-filters-for-devices)
- [Known issues in Teams Rooms and devices](/microsoftteams/troubleshoot/teams-rooms-and-devices/rooms-known-issues#issues-with-teams-phones)
- [Video: Intune Compliance & Conditional Access with Teams Android devices](https://www.youtube.com/watch?v=uTQR_YuWZag)
