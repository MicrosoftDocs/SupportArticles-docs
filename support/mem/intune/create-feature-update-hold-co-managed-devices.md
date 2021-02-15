---
title: How to create a feature update hold for co-managed Windows 10 devices
description: Describes how to use the TargetReleaseVersion Policy CSP to specify Windows 10 feature update versions for co-managed devices.
author: helenclu
ms.author: luche
ms.reviewer: markstan
ms.date: 11/16/2020
ms.prod-support-area-path:
---
# Use the TargetReleaseVersion policy CSP to manage Windows 10 feature updates for co-managed devices

Intune provides the [Windows 10 feature updates (public preview)](/mem/intune/protect/windows-update-for-business-configure#windows-10-feature-updates) policy to manage software updates for your Windows 10 devices. However, when you co-manage devices by using Configuration Manager and Intune, there is a limitation where feature update policies may not immediately take effect. This limitation causes devices to update to a later feature update than the one that's configured in Intune. This limitation will be removed in a future update to Configuration Manager.

This article describes an alternative method to restrict the Windows 10 feature update versions that are offered to devices enrolled in Intune.

## The `TargetReleaseVersion` Policy CSP

The [`./Vendor/MSFT/Policy/Config/Update/TargetReleaseVersion` Policy CSP](/windows/client-management/mdm/policy-csp-update#update-targetreleaseversion) setting enables IT administrators to specify a Windows 10 feature update version to meet and remain at.

Setting the `TargetReleaseVersion` Open Mobile Alliance Uniform Resource Identifier (OMA-URI) configures devices to apply the Windows 10 feature update version that's specified in its value. There are several things to consider when you set the `TargetReleaseVersion` policy:

- Existing devices that have an older feature update version installed will be updated to the specified feature update version the next time that the Windows Update client checks for updates.
- Existing devices that have a later feature update version installed will remain at their current version.
- Newly added devices will receive the feature update the first time they check for updates.
- Devices will remain at the feature update version that's specified in the policy when new Windows 10 feature update versions are released.
- This policy doesn't override [safeguard holds](/windows/deployment/update/safeguard-holds). If the `TargetReleaseVersion` policy is successfully applied to a device but the device doesn't update to the specified version, check whether any safeguard holds exist.

## Set the `TargetReleaseVersion` policy

To set the target release version policy setting, follow these steps:

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Devices** > **Configuration profiles** > **Create profile**.
3. Select **Windows 10 and later** in **Platform**, select **Custom** in **Profile**, and then select **Create**.
4. In **Basics**, enter a meaningful name and a description for the policy, and then select **Next**.
5. In **Configuration settings**, select **Add**, and then enter the following settings:

   - Name: **TargetReleaseVersion**
   - Description: Enter a description.
   - OMA-URI: `./Vendor/MSFT/Policy/Config/Update/TargetReleaseVersion`
   - Data type: **String**
   - Value: Enter the version that you want to specify. For example, enter **1909** (for Windows 10 1909) or **2004** (for Windows 10 20H1) or **2009** (for Windows 10 20H2)
6. Select **Next**.
7. (Optional) In **Scope tags**, assign a tag, if it's necessary, and then select **Next**.
8. In **Assignments**, select the groups that will receive the profile, and then select **Next**.
9. In **Review + create**, review your settings, and then select **Create**.

Intune-managed devices will receive the policy setting the next time they sync with the Intune service. The policy will be effective for the Windows Update client after the sync finishes.

To verify that the setting is successfully applied to a Windows 10 device, check the value of the following registry entry:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update\TargetReleaseVersion`
