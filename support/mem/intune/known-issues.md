---
title: Known issues with Microsoft Intune
description: Learn about known issues with Microsoft Intune, including workarounds and updated fixes.
ms.date: 01/31/2022
---
# Known issues

This page lists recent known issues with Microsoft Intune. For a list of weekly feature announcements, see the [What's new in Microsoft Intune](/mem/intune/fundamentals/whats-new) in the Intune product documentation. Visit the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/bg-p/IntuneCustomerSuccess) for posts about best practices, support tips, and other tutorials, as well as a backlog of past known issues.

## Android Enterprise device filtering not supported in some reports

- **Status:** Active

We are aware of an issue where granular OS filtering is not working as expected for corporate-owned .... 

waiting on final edits...

### Available workaround

Until we release a fix, you can search/filter by OS on the exported report file for more granular results.


## Missing certificates after updating Samsung work profile devices to Android 12

- **Status:** Active

We are aware of an issue that affects Samsung devices enrolled with a work profile. After updating to Android 12, these devices are missing certificates when a user tries to access Gmail or AnyConnect VPN. We are working closely with Samsung to resolve this issue, but have provided temporary workarounds below to help users access their VPN apps. For more information, see the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-missing-certificates-after-updating-samsung-work/ba-p/3039834).

### AnyConnect VPN

Users will see a prompt from the AnyConnect VPN app stating that the client certificate needed to make the connection could not be found and a valid certificate should be chosen. To address this issue, clear out the app data cache.  

1. Go to **Settings** > **Work Profile** > **Apps** > **AnyConnect VPN** > **Storage** > **Clear Data**.
1. Upon opening AnyConnect VPN again, the app will request the certificates again in a pop-up prompt.
1. Select the certificate to fix the problem.

### Gmail

Users attempting to access Gmail are prompted to select a certificate and then will see a “Can’t reach server” message. In this scenario, there are two different approaches you can use to work around the issue; one is user-driven on the device and the other option is administrator-driven in the Microsoft Endpoint Manager admin center.

#### Option 1: On a device - Remove and reinstall the work profile and Company Portal

1. Open the Company Portal app > Menu > tap **Remove Company Portal**.
1. Open Google Play app > select the Intune Company Portal app > **Uninstall** the app.
1. In Google Play, install the Intune Company Portal app.
1. Open and sign in to the Company Portal.
1. Gmail in the work profile now works as expected.

#### Option 2 (IT administrators only): Remove and re-add the Gmail device configuration

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), create an [exclusion group](/mem/intune/apps/apps-inc-exl-assignments) for the Gmail app.
1. Add the user(s) to the exclusion group.
1. Sync the policy on the Android device.
1. Confirm Gmail is removed from the device.
1. Remove the user from the exclusion group.
1. Confirm Gmail is added to the device.
1. Gmail in the work profile now works as expected.

## Smart card removal behavior for Lock workstation has the wrong behavior applied on Windows 10 devices

- **Status:** In progress (2201 service release)

We've identified a bug in the [Smart card removal behavior setting](/mem/intune/protect/endpoint-protection-windows-10#interactive-logon) for Windows 10 devices where the underlying setting values in Microsoft Intune for **Lock workstation** has the **No Action** behavior applied.

### Who is impacted

If you have the value **Lock workstation** selected for the Smart card removal behavior setting configured in either your device configuration, security baselines, or Endpoint protection profiles for Windows 10 devices then you might be impacted by this issue.

### Recommended actions

Check the value selected for the Smart card removal behavior setting for existing policies. If you have the selected the value **Lock workstation**, re-save existing policies to apply the correct behavior or update the values based on your organization's needs.

> [!NOTE]
> For security baselines, you do not need to update or re-save the policies after the fix is rolled out.

## Several Office settings in the settings catalog need parent settings enabled

- **Status:** Active

We identified several Office settings in the settings catalog that, when enabled, do not automatically enable the required parent setting. This can lead to the policy not applying as expected if you did not configure the parent setting.

To help identify which configuration settings have this behavior, we recently made a user interface (UI) change to mark them as **(deprecated)** in the Settings catalog (preview) page. We have also included a full list below. For a full list of updated settings, see the [NEED TO UPDATE Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/bg-p/IntuneCustomerSuccess). 

We will release new device configuration settings (with the same name) that will automatically enforce the dependencies.

### Recommended actions

Check your device configuration profiles to see if you are using a deprecated setting and if the parent setting is enabled. If the parent setting is not enabled, update your profiles to configure the parent setting and ensure the child setting works as expected. After we release the replacement settings, you can update your configuration profile to use the new setting instead.

## Long sync times in Intune for Managed Google Play private apps and web apps

- **Status:** Active

This issue affects Managed Google Play web apps and private line-of-business (LOB) apps. If you recently created or have been added to a web app and sync your tenant, it may take three to six hours or longer for you to see the apps in Intune. Google is aware of this issue and their engineering team is currently working on a fix. For more information, see the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-long-sync-times-in-intune-for-managed-google-play/ba-p/3039795).

### Who is impacted

Admins who recently published a new Managed Google Play web or LOB app via one of the available publishing methods (iFrame in the Microsoft Endpoint Manager admin center, the custom app publishing API, or the Google Play Console external to Intune), will notice delays for those apps to sync to Intune. After selecting **Sync** from either the Microsoft Endpoint Manager admin center or the Google Play console, it can take hours for the new apps to appear in the app list in Intune.

> [!NOTE]
> Existing web and private apps are not affected, including updates or edits to those apps.

### Available workaround

There is one available workaround for web apps for dedicated devices using Microsoft Managed Home Screen by creating and deploying web links instead of Managed Google Play web apps. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), go to **Apps** > All **apps**, select **Add**, and then choose **web link** as the app type.

:::image type="content" source="media/known-issues/long-sync-time.png" alt-text="Microsoft Endpoint Manager admin center - All apps blade with the Add and web link options highlighted.":::

There is no workaround for any other app type or enrollment scenario at this time.

## Fully managed Samsung devices are noncompliant after managed update

- **Status:** Active

Samsung devices provisioned as Android Enterprise fully managed devices running Android 11 and later show as noncompliant after a managed update is applied. This could potentially affect access to corporate resources, depending on the Conditional Access policies set by the IT administrator. We are working to resolve this issue with Samsung, but we have workaround instructions to help you bring devices back into compliance. For more information, see the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/known-issue-samsung-devices-are-noncompliant-after-restart-or/ba-p/2952544).

> [!NOTE]
> As of January 7, 2022, this issue only applies to Android Enterprise fully managed Samsung devices. In December, Samsung released a fix in December 2020 (CP Version 5.0.5358.0) for Android device administrator (DA) management and Android Enterprise personally-owned work profiles.

### Available workaround

Users need to unlock the phone, open the Device Policy Controller app, and trigger a sync. Once the sync is completed, the device should show as compliant in Intune and access to corporate resources should be restored.
