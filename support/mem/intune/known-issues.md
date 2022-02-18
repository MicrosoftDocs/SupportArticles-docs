---
title: Known issues with Microsoft Intune
description: Learn about known issues with Microsoft Intune, including workarounds and updated fixes.
ms.date: 02/18/2022
---
# Known issues

This page lists recent known issues with Microsoft Intune. For a list of weekly feature announcements, see [What's new in Microsoft Intune](/mem/intune/fundamentals/whats-new) in the Intune product documentation. Visit the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/bg-p/IntuneCustomerSuccess) for posts about best practices, support tips, and other tutorials, and a backlog of past known issues.

## Several Office settings in settings catalog do not automatically enable the parent setting

- **Status:** Active
- **Blog post:** [Support tip: Several Office settings in settings catalog may need parent settings enabled](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-several-office-settings-in-settings-catalog-may-need/ba-p/3075669)

We recently identified several Office settings in the settings catalog that, when enabled, do not automatically enable the required parent setting. This can lead to the policy not applying as expected if you did not configure the parent setting.

To help identify which configuration settings have this behavior, we recently made a user interface (UI) change to mark them as **(deprecated)** in the Settings catalog (preview) page. We will release new device configuration settings (with the same name) that will automatically enforce the dependencies. For updates, recommended actions, and a full list of settings, see [Support tip: Several Office settings in settings catalog may need parent settings enabled](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-several-office-settings-in-settings-catalog-may-need/ba-p/3075669)on the Intune Customer Success blog.

## Android Enterprise device filtering not supported in some reports

- **Status:** Active

We're aware of an issue where granular OS filtering isn't working as expected for corporate-owned Android Enterprise devices when exporting the [All devices report](/mem/intune/fundamentals/reports#all-devices-report-operational) from the Microsoft Endpoint Manager admin center, when exporting the [DevicesWithInventory](/mem/intune/fundamentals/reports-export-graph-available-reports) and [Devices](/mem/intune/fundamentals/reports-export-graph-available-reports) reports using the Export API, or when making native calls to the [/deviceManagement/managedDevices](/graph/api/intune-devices-manageddevice-list) API.

> [!NOTE]
> This issue doesn't affect device filtering in the Endpoint Manager admin center UI.

The Export API doesn't distinguish between Android Enterprise management modes and will instead group them together. This issue affects exported report data and managedDevices API calls for the following device types:

- [Android Enterprise dedicated devices](/mem/intune/fundamentals/deployment-guide-enrollment-android#android-enterprise-dedicated-devices)
- [Android Enterprise fully managed devices](/mem/intune/fundamentals/deployment-guide-enrollment-android#android-enterprise-fully-managed)
- [Android Enterprise corporate-owned devices with a work profile](/mem/intune/fundamentals/deployment-guide-enrollment-android#android-enterprise-corporate-owned-work-profile)

If you want to include any Android Enterprise dedicated devices, fully managed devices, or corporate-owned devices with a work profile, all three types will be included regardless of the OS you filter to. For example, if a customer exports a report with the **OS** filter set to **Android Enterprise (corporate-owned work profile)**, the report will also include all dedicated devices and fully managed devices. The other filter parameters will apply accurately to the exported file.

Until we release a fix, you can search/filter by OS on the exported report file for more granular results.

## Missing certificates after updating Samsung work profile devices to Android 12

- **Status:** Active
- **Blog post:** [Known Issue: Missing certificates after updating Samsung work profile devices to Android 12](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-missing-certificates-after-updating-samsung-work/ba-p/3039834)

We're aware of an issue that affects Samsung devices enrolled with a work profile. After updating to Android 12, these devices are missing certificates when a user tries to access Gmail or AnyConnect VPN. For more information and temporary workarounds, see [Known Issue: Missing certificates after updating Samsung work profile devices to Android 12](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-missing-certificates-after-updating-samsung-work/ba-p/3039834) on the Intune Customer Success blog.

## Long sync times in Intune for Managed Google Play private apps and web apps

- **Status:** Active
- **Blog post:** [Known Issue: Long sync times in Intune for Managed Google Play private apps and web apps](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-long-sync-times-in-intune-for-managed-google-play/ba-p/3039795)

Admins who recently published a new Managed Google Play web or line-of-business (LOB) app will notice delays for those apps to sync to Intune. After selecting Sync from either the Microsoft Endpoint Manager admin center or the Google Play console, it can take six hours or longer for the new apps to appear in the app list in Intune. For more information and workarounds, see [Known Issue: Long sync times in Intune for Managed Google Play private apps and web apps](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-long-sync-times-in-intune-for-managed-google-play/ba-p/3039795).

> [!NOTE]
> Existing web and private apps aren't affected, including updates or edits to those apps.

## Fully managed Samsung devices are noncompliant after managed update

- **Status:** Active
- **Blog post:** [Known Issue: Samsung devices are noncompliant after restart or update](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-samsung-devices-are-noncompliant-after-restart-or/ba-p/2952544)

Samsung devices provisioned as Android Enterprise fully managed devices running Android 11 and later show as noncompliant after a managed update is applied. This could potentially affect access to corporate resources, depending on the Conditional Access policies set by the IT administrator. For more information and workarounds, see [Known Issue: Samsung devices are noncompliant after restart or update](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-samsung-devices-are-noncompliant-after-restart-or/ba-p/2952544) on the Intune Customer Success blog.

> [!NOTE]
> As of January 7, 2022, this issue only applies to Android Enterprise fully managed Samsung devices. In December, we released a fix in December 2021 (CP Version 5.0.5358.0) for Android device administrator (DA) management and Android Enterprise personally-owned work profiles.
