---
title: Troubleshoot policies and configuration profiles in Microsoft Intune
description: Learn how to use the built-in Intune troubleshooting feature, and get guidance for common problems or issues with compliance policies and configuration profiles in Microsoft Intune
ms.date: 12/05/2023
ms.reviewer: kaushika, jlynn
search.appverid: MET150
ms.custom: sap:Configure Devices - Android\Assign profiles
---
# Troubleshooting policies and profiles in Microsoft Intune

This article provides troubleshooting guidance for common issues related to policies and configuration profiles in Microsoft Intune. including instructions on how to use the built-in Intune troubleshooting feature.

## Use the built-in Troubleshoot pane

You can use the built-in troubleshooting feature to review different compliance and configuration statuses.

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Troubleshooting + support** > **Troubleshoot**.

    :::image type="content" source="media/troubleshoot-policies-in-microsoft-intune/troubleshoot-plus-support.png" alt-text="In Endpoint Management admin center and Intune, go to Troubleshooting and support.":::

2. Choose **Select user** > select the user having an issue > **Select**.
3. Confirm that **Intune license** shows the green check:

    :::image type="content" source="media/troubleshoot-policies-in-microsoft-intune/account-status-intune-license-show-green.png" alt-text="In Intune, select the user and confirm Intune license shows the green check mark for the status.":::

    **Helpful links**:

    - [Assign licenses so users can enroll devices](/mem/intune/fundamentals/licenses-assign)
    - [Add users to Intune](/mem/intune/fundamentals/users-add)

4. Under **Devices**, find the device having an issue. Review the different columns:

    - **Managed**: For a device to receive compliance or configuration policies, this property must show **MDM** or **EAS/MDM**.

        - If **Managed** isn't set to **MDM** or **EAS/MDM**, then the device isn't enrolled. It doesn't receive compliance or configuration policies until it's enrolled.

        - App protection policies (mobile application management) don't require devices to be enrolled. For more information, see [create and assign app protection policies](/mem/intune/apps/app-protection-policies).

    - **Microsoft Entra join Type**: Should be set to **Workplace** or **AzureAD**.

        - If this column is **Not Registered**, there may be an issue with enrollment. Typically, unenrolling and re-enrolling the device resolves this state.

    - **Intune compliant**: Should be **Yes**. If **No** is shown, there may be an issue with compliance policies, or the device isn't connecting to the Intune service. For example, the device may be turned off, or may not have a network connection. Eventually, the device becomes non-compliant, possibly after 30 days.

        For more information, see [get started with device compliance policies](/mem/intune/protect/device-compliance-get-started).

    - **Microsoft Entra compliant**: Should be **Yes**. If **No** is shown, there may be an issue with compliance policies, or the device isn't connecting to the Intune service. For example, the device may be turned off, or may not have a network connection. Eventually, the device becomes non-compliant, possibly after 30 days.

        For more information, see [get started with device compliance policies](/mem/intune/protect/device-compliance-get-started).

    - **Last check in**: Should be a recent time and date. By default, Intune devices check in every 8 hours and the **Last check-in** value also updates every 8 hours in the Intune portal.

        - If **Last check in** is more than 24 hours, there may be an issue with the device. A device that can't check in can't receive your policies from Intune.

        - To force check-in:
            - On the Android device, open the Company Portal app > **Devices** > Choose the device from list > **Check Device Settings**.
            - On the iOS/iPadOS device, open the Company portal app > **Devices** > Choose the device from list > **Check Settings**.
            - On a Windows device, open **Settings** > **Accounts** > **Access Work or School** > Select the account or MDM enrollment > **Info** > **Sync**.

    - Select the device to see policy-specific information.

        **Device Compliance** shows the states of compliance policies assigned to the device.

        **Device Configuration** shows the states of configuration policies assigned to the device.

        If the expected policies aren't shown under **Device Compliance** or **Device Configuration**, then the policies aren't targeted correctly. Open the policy, and assign the policy to this user or device.

        **Policy states**:

        - **Not Applicable**: This policy isn't supported on this platform. For example, iOS/iPadOS policies don't work on Android. Samsung KNOX policies don't work on Windows devices.
        - **Conflict**: There's an existing setting on the device that Intune can't override. Or, you deployed two policies with the same setting using different values.
        - **Pending**: The device hasn't checked into Intune to get the policy. Or, the device received the policy but hasn't reported the status to Intune.
        - **Errors**: Look up errors and possible resolutions at [Troubleshoot company resource access problems](../general/troubleshoot-company-resource-access-problems.md).

## Check tenant status

Check the [Tenant Status](/mem/intune/fundamentals/tenant-status) and confirm the subscription is Active. You can also view details for active incidents and advisories that may impact your policy or profile deployment.

## Confirm a configuration profile is correctly applied

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Devices** > **All devices** > select the device > **Device configuration**.

    Every device lists its profiles. Each profile has a **Status**. The status applies when all of the assigned profiles, including hardware and OS restrictions and requirements, are considered together. Possible statuses include:

    - **Conforms**: The device received the profile and reports to Intune that it conforms to the setting.

    - **Not applicable**: The profile setting isn't applicable. For example, email settings for iOS/iPadOS devices don't apply to an Android device.

    - **Pending**: The profile is sent to the device, but hasn't reported the status to Intune. For example, encryption on Android requires the user to enable encryption, and might show as pending.

For more information, see [Monitor device profiles in Microsoft Intune](/mem/intune/configuration/device-profile-monitor)

## Saving of Access Rules to Exchange has Failed

**Issue**: You receive the alert **Saving of Access Rules to Exchange has Failed**  in the admin console.

If you create policies in the Exchange On-Premises Policy workspace (Admin console), but are using Microsoft 365, then the configured policy settings aren't enforced by Intune. In the alert, note the policy source. Under the Exchange On-premises Policy workspace, delete the legacy rules. The legacy rules are Global Exchange rules within Intune for on-premises Exchange, and aren't relevant to Microsoft 365. Then, create new policy for Microsoft 365.

[Troubleshoot the Intune on-premises Exchange connector](../device-protection/troubleshoot-exchange-connector.md) may be a good resource.

## Can't change security policies for enrolled devices

Windows 10 devices may not remove security policies when you unassign the policy (stop deployment). You may need to leave the policy assigned, and then change the security settings back to the default values.

Depending on the device platform, if you want to change the policy to a less secure value, you may need to reset the security policies.

For example, in Windows 8.1, on the desktop, swipe in from right to open the **Charms** bar. Choose **Settings** > **Control Panel** > **User Accounts**. On the left, select **Reset Security Policies** link, and choose **Reset Policies**.

Other platforms, such as Android, and iOS/iPadOS may need to be retired and re-enrolled to apply a less restrictive policy.
