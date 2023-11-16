---
title: Known issues with Microsoft Intune
description: Learn about known issues with Microsoft Intune, including workarounds and updated fixes.
ms.date: 09/16/2022
search.appverid: MET150
ms.reviewer: kaushika
---
# Known issues

This page lists recent known issues with Microsoft Intune. For a list of weekly feature announcements, see [What's new in Microsoft Intune](/mem/intune/fundamentals/whats-new) in the Intune product documentation. Visit the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/bg-p/IntuneCustomerSuccess) for posts about best practices, support tips, and other tutorials, and a backlog of past known issues.

## Remediation message doesn't list all valid builds in Company Portal for Windows 10/11

- **Status:** Active
- **Blog Post:** [Remediation message doesn't list all valid builds in Company Portal for Windows 10/11](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-remediation-message-doesn-t-list-all-valid-builds-in/ba-p/3622082)

We are aware of an issue with the noncompliance messaging details that appear in Company Portal for Windows 10/11 devices. When a device is identified as noncompliant due to having a Windows build outside the ranges an admin specifies in the Intune compliance policy, a remediation message is displayed in the Company Portal indicating the operating system (OS) needs updating along with a valid range of OS versions. However, when multiple OS ranges are specified in the policy by configuring the [Valid operating system builds](/mem/intune/protect/compliance-policy-create-windows#device-properties) compliance setting, the message in the Company Portal will only display the first OS build range rather than all acceptable ranges.

The compliance policy is being enforced correctly despite the missing ranges in the remediation messaging. To make the device compliant, update the device OS build to a version within the specified acceptable range in the compliance policy.

For more information about this known issue, see our blog [Remediation message doesn't list all valid builds in Company Portal for Windows 10/11](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-remediation-message-doesn-t-list-all-valid-builds-in/ba-p/3622082).

## A limited number of macOS devices may be unexpectedly unenrolled from the Microsoft Intune service

- **Status:** Active

There is a known issue (originally posted on the Service Health Dashboard as IT393575) where occasionally a macOS device becomes unenrolled after performing an enrollment due to an issue with the headers being sent to the client MDM agent. This issue is specific to a very limited number of macOS devices with the Microsoft Intune management extension; the majority of macOS devices enroll as expected. To fix this issue, re-enroll the device. In a future service release, we plan to make an architectural change to fully resolve the issue.

## Android 12 clipboard data toast notification

- **Status:** Active

Android 12 introduced a toast notification when an application accesses the clipboard, regardless of whether the device is MDM enrolled or if apps are protected by app protection policies. Users running Android Company Portal version 5.0.5450.0 or later may notice an unexpected toast notification when using apps, such as Outlook. An example notification reads "Outlook pasted from your clipboard."

> [!NOTE]
> The clipboard data is never stored locally or transmitted to Microsoft.

## Android devices lose access to Intune-managed resources after upgrading to Android 12

- **Status:** Resolved
- **Blog post:** [Known Issue: Android devices lose access to Intune-managed resources after upgrading to Android 12](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-android-devices-lose-access-to-intune-managed/ba-p/3249657)

The issue where customers lose access to Microsoft Intune-managed resources or are prevented from completing enrollment after upgrading certain devices from Android 11 to Android 12 has been resolved. The impacted brands included OPPO, OnePlus, and Realme devices enrolled as Android Enterprise personally-owned work profiles.

At this time, the fix should have been rolled out to all S-product devices across OPPO, OnePlus, and Realme brands, with no issues with devices accessing Intune-managed resources after upgrading to Android 12. We encourage customers to install any new OTA updates as soon as they become available and check with Google and Device OEM support resources as software release dates are subject to change.

## Several Office settings in settings catalog do not automatically enable the parent setting

- **Status:** Active
- **Blog post:** [Support tip: Several Office settings in settings catalog may need parent settings enabled](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-several-office-settings-in-settings-catalog-may-need/ba-p/3075669)

We recently identified several Office settings in the settings catalog that, when enabled, do not automatically enable the required parent setting. This can lead to the policy not applying as expected if you did not configure the parent setting.

To help identify which configuration settings have this behavior, we recently made a user interface (UI) change to mark them as **(deprecated)** in the Settings catalog (preview) page. For updates, recommended actions, and a full list of settings, see [Support tip: Several Office settings in settings catalog may need parent settings enabled](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-several-office-settings-in-settings-catalog-may-need/ba-p/3075669)on the Intune Customer Success blog.

## Android Enterprise device filtering not supported in some reports

- **Status:** Active

We're aware of an issue where granular OS filtering isn't working as expected for corporate-owned Android Enterprise devices when exporting the [All devices report](/mem/intune/fundamentals/reports#all-devices-report-operational) from the Microsoft Intune admin center, when exporting the [DevicesWithInventory](/mem/intune/fundamentals/reports-export-graph-available-reports) and [Devices](/mem/intune/fundamentals/reports-export-graph-available-reports) reports using the Export API, or when making native calls to the [/deviceManagement/managedDevices](/graph/api/intune-devices-manageddevice-list) API.

> [!NOTE]
> This issue doesn't affect device filtering in the Intune admin center UI.

The Export API doesn't distinguish between Android Enterprise management modes and will instead group them together. This issue affects exported report data and managedDevices API calls for the following device types:

- [Android Enterprise dedicated devices](/mem/intune/fundamentals/deployment-guide-enrollment-android#android-enterprise-dedicated-devices)
- [Android Enterprise fully managed devices](/mem/intune/fundamentals/deployment-guide-enrollment-android#android-enterprise-fully-managed)
- [Android Enterprise corporate-owned devices with a work profile](/mem/intune/fundamentals/deployment-guide-enrollment-android#android-enterprise-corporate-owned-work-profile)

If you want to include any Android Enterprise dedicated devices, fully managed devices, or corporate-owned devices with a work profile, all three types will be included regardless of the OS you filter to. For example, if a customer exports a report with the **OS** filter set to **Android Enterprise (corporate-owned work profile)**, the report will also include all dedicated devices and fully managed devices. The other filter parameters will apply accurately to the exported file.

Until we release a fix, you can search/filter by OS on the exported report file for more granular results.

## Missing certificates after updating Samsung work profile devices to Android 12

- **Status:** Resolved
- **Blog post:** [Known Issue: Missing certificates after updating Samsung work profile devices to Android 12](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-missing-certificates-after-updating-samsung-work/ba-p/3039834)

We're aware of an issue that affects Samsung devices enrolled with a work profile. After updating to Android 12, these devices are missing certificates when a user tries to access Gmail or AnyConnect VPN. For more information and temporary workarounds, see [Known Issue: Missing certificates after updating Samsung work profile devices to Android 12](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-missing-certificates-after-updating-samsung-work/ba-p/3039834) on the Intune Customer Success blog.

## Long sync times in Intune for Managed Google Play private apps and web apps

- **Status:** Resolved
- **Blog post:** [Known Issue: Long sync times in Intune for Managed Google Play private apps and web apps](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-long-sync-times-in-intune-for-managed-google-play/ba-p/3039795)

Admins who recently published a new Managed Google Play web or line-of-business (LOB) app will notice delays for those apps to sync to Intune. After selecting Sync from either the Microsoft Intune admin center or the Google Play console, it can take six hours or longer for the new apps to appear in the app list in Intune. For more information and workarounds, see [Known Issue: Long sync times in Intune for Managed Google Play private apps and web apps](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-long-sync-times-in-intune-for-managed-google-play/ba-p/3039795).

> [!NOTE]
> Existing web and private apps aren't affected, including updates or edits to those apps.

## Fully managed Samsung devices are noncompliant after managed update

- **Status:** Active
- **Blog post:** [Known Issue: Samsung devices are noncompliant after restart or update](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-samsung-devices-are-noncompliant-after-restart-or/ba-p/2952544)

Samsung devices provisioned as Android Enterprise fully managed devices running Android 11 and later show as noncompliant after a managed update is applied. This could potentially affect access to corporate resources, depending on the Conditional Access policies set by the IT administrator. For more information and workarounds, see [Known Issue: Samsung devices are noncompliant after restart or update](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-samsung-devices-are-noncompliant-after-restart-or/ba-p/2952544) on the Intune Customer Success blog.

> [!NOTE]
> As of January 7, 2022, this issue only applies to Android Enterprise fully managed Samsung devices. In December, we released a fix in December 2021 (CP Version 5.0.5358.0) for Android device administrator (DA) management and Android Enterprise personally-owned work profiles.

## Common issues with Intune policy reports

- **Status:** Active
- **Blog post:** [Support Tip: Known Issues with Intune policy reports](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-known-issues-with-intune-policy-reports/ba-p/2676483)

We are aware of some common issue with Intune policy reports, including multiple records for a single device, inaccurate "pending" status, and inconsistencies between data in report lists and in summary charts. We are working on reporting improvements for better performance and new capabilities for search, sort, filtering, and other functionality. For detailed information and updates, see [Support Tip: Known Issues with Intune policy reports](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-known-issues-with-intune-policy-reports/ba-p/2676483).

## Users are signed out of managed iOS Office apps

- **Status:** Active
- **Blog post:** [Support Tip: Known Issue occasionally occurring with iOS MAM and Office apps](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-known-issue-occasionally-occurring-with-ios-mam-and/ba-p/2617909)

We are aware of an issue that can affect organization using app protection policies (APP, also known as MAM) to manage their mobile Office apps. In this scenario, users are signed out of *all* Office mobile apps once they sign out of a single Office app (or if they are automatically signed out of an app). Once a user is signed out, they are forced to reauthenticate so that policies can be applied before they access the managed apps. This can sometimes lead to an authentication loop.

For more information and a workaround, see [Support Tip: Known Issue occasionally occurring with iOS MAM and Office apps](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-known-issue-occasionally-occurring-with-ios-mam-and/ba-p/2617909).

## Known issues with filters in Microsoft Intune

- **Status:** Active
- **Blog post:** [Filters Public Preview - Overview and Known Issues](https://techcommunity.microsoft.com/t5/intune-customer-success/filters-public-preview-overview-and-known-issues/ba-p/2346835)

There are some known issues with filters in Microsoft Intune. This feature became generally available in February 2021. We are tracking remaining known issues with this feature in [Filters Public Preview - Overview and Known Issues](https://techcommunity.microsoft.com/t5/intune-customer-success/filters-public-preview-overview-and-known-issues/ba-p/2346835), which also includes common questions and documentation links.

## App install lifecycle or app install history status might be inaccurate

- **Status:** Engineering actively working on fix
- **Blog post:** [Known Issue: Status reporting for App install lifecycle and App install history](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-status-reporting-for-app-install-lifecycle-and-app/ba-p/2147870)

We are aware of an issue within the Troubleshooting + support blade where the Devices table > column **App install lifecycle** might show a status of "Failure" even if there are no issues with the apps on the device. Additionally, if you load the Managed Apps view for the impacted device and select a targeted app, the app install history might show "Failed to install"&mdash;even though the app has installed correctly on the device.

This issue appears to occur at random. For more information, see [Known Issue: Status reporting for App install lifecycle and App install history](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-status-reporting-for-app-install-lifecycle-and-app/ba-p/2147870) on the Intune Customer Success blog.

## Launching protected apps on Samsung A10 with biometric authorization cause the device to crash

- **Status:** Active
- **Blog post:** [Known Issue: Android 10 Samsung A10 Biometric Authentication](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-android-10-samsung-a10-biometric-authentication/ba-p/2002610)

There is a known issue with the Android 10 Samsung A10 biometric authorization (face recognition/thumbprint). Launching any apps with app protection policies (APP, also known as MAM) on an Android 10 Samsung A10 with biometric authorization enabled will cause the device to crash. We have disabled biometric authentication for affected devices. For more information, see [Known Issue: Android 10 Samsung A10 Biometric Authentication](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-android-10-samsung-a10-biometric-authentication/ba-p/2002610).

## Password reset issues for Intune-enrolled devices with iOS 13+

- **status:** Active
- **Blog post:** [Support Tip: PowerShell Script now available for iOS Passcode Reset Token Known Issue](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-powershell-script-now-available-for-ios-passcode/ba-p/1250875)

Intune shared a known issue in MC203629, whereby approximately 1% of devices Intune enrolled with iOS 13+ do not return the token needed to allow a password reset. Apple addressed the bug in 13.3.1 and higher, however, simply updating to 13.3.1 cannot fix already-enrolled devices. Devices without a password reset token will need to update to 13.3.1, then remove and then re-enroll in Intune. For more information and instructions to help you identify and fix affected devices, see [Support Tip: PowerShell Script now available for iOS Passcode Reset Token Known Issue](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-powershell-script-now-available-for-ios-passcode/ba-p/1250875) on the Intune Customer Success blog.

## Profile error enrolling iOS devices with Apple Configurator

- **Status:** Active
- **Blog post:** [Known Issue: Profile error enrolling iOS devices with Apple Configurator](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-profile-error-enrolling-ios-devices-with-apple/ba-p/294412)

We are aware of an issue when [enrolling and iOS devices with Apple Configurator](/mem/intune/enrollment/apple-configurator-enroll-ios) for Setup Assistant enrollment. After accepting **Apply configuration** on the device, you might see the error: "Invalid Profile: The configuration for your iPad/iPhone could not be downloaded from [Your Organization Name]." This is due to an invalid enrollment URL. For more information and a workaround, see [Known Issue: Profile error enrolling iOS devices with Apple Configurator](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-profile-error-enrolling-ios-devices-with-apple/ba-p/294412) on the Intune Customer Success blog.

## iOS certificate-based authentication issue with Pulse Secure 7.0.0 and Check Point Capsule Connect versions 1.600

- **Status:** Active
- **Blog post:** [Known issue: Certificate-based authentication issue with Pulse Secure 7.0.0 for iOS and Check Point Capsule Connect versions 1.600 for iOS](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-certificate-based-authentication-issue-with-pulse/ba-p/280162)

There are issues with certificate-based authentication when using the Pulse Secure VPN client for iOS, version 7.0 and Check Point Capsule Connect version 1.600 for iOS. Specifically, both VPN clients may report that the certificate is missing from the device, even when the certificate has been properly delivered. These issues impact Intune in addition to other Enterprise Mobility Management providers. For more information and workarounds, see [Known issue: Certificate-based authentication issue with Pulse Secure 7.0.0 for iOS and Check Point Capsule Connect versions 1.600 for iOS](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-certificate-based-authentication-issue-with-pulse/ba-p/280162) on the Intune Customer Success blog.

<a name='rename-device-setting-disabled-for-hybrid-azure-ad-joined-windows-devices'></a>

## "Rename device" setting disabled for Microsoft Entra hybrid joined Windows devices

- **Status:** Feature disabled
- **Blog post:** [Known issue with "Rename device" setting for Windows 10 devices in the Intune console](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-with-rename-device-setting-for-windows-10-devices-in/ba-p/390868)

In the Intune admin center, we've disabled the "Rename device setting" for Windows devices that are Microsoft Entra hybrid joined. This is to prevent device single sign-on errors that might occur after a user changes their password. Device renaming is available for co-managed devices that are Microsoft Entra joined. For details, see [Known issue with "Rename device" setting for Windows 10 devices in the Intune console](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-with-rename-device-setting-for-windows-10-devices-in/ba-p/390868) on the Intune Customer Success blog.

## iOS/iPadOS or macOS device unenrollment through management profile deletion may not be reflected in Microsoft Intune

- **Status:** Active

There is a known issue where the enrollment status of an iOS/iPadOS or macOS device may not update correctly in Microsoft Intune if a user manually deletes the management profile. The device will be unenrolled from Intune, but it may not be reflected in Microsoft Intune admin center for 30 days.
