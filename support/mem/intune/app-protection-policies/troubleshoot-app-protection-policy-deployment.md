---
title: Troubleshoot Microsoft Intune app protection policy deployment
description: This article gives troubleshooting guidance for IT Admins with issues when deploying Intune app protection policies. 
ms.date: 05/12/2022
search.appverid: MET150
ms.reviewer: kaushika
---

# Troubleshooting app protection policy deployment in Intune

This article helps IT Admins understand and troubleshoot problems when you apply app protection policies (APP) in Microsoft Intune. Follow the instructions in the sections that apply to your situation. Browse the guide for additional APP-related troubleshooting guidance, such as [Troubleshooting app protection policy user issues](troubleshoot-mam.md) and [Troubleshoot data transfer between apps](troubleshoot-data-transfer.md).

## Before you begin

Before you start troubleshooting, collect some basic information to help you better understand the problem and reduce the time to find a resolution.

Collect the following background information:

- Which policy setting is or isn't applied? Is any policy applied?
- What is the user experience? Have users installed and started the targeted app?
- When did the problem start? Has app protection ever worked?
- Which platform (Android or iOS) has the problem?
- How many users are affected? Are all users or only some users affected?
- How many devices are affected? Are all devices or only some devices affected?
- Although Intune app protection policies don't require a mobile device management (MDM) service, are affected users using Intune or a third-party MDM solution?
- Are all managed apps or only specific apps affected? For example, are line-of-business (LOB) apps built with the [Intune App SDK](/mem/intune/developer/app-sdk-get-started) affected but store apps are not?
- Is any management service other than Intune being used on the device?

With the above information in place, you can start troubleshooting.

## Recommended investigation flow

Successful app protection policy deployment relies on proper configuration of settings and other dependencies. The recommended flow for investigating common issues with Intune APP is as follows, which we review in more detail in this article:

1. [Verify you have met the prerequisites for deploying app protection policies](#step-1-verify-app-protection-policy-prerequisites).
1. [Check app protection policy status and check targeting](#step-2-check-app-protection-policy-status).
1. [Verify that the user is targeted](#step-3-verify-that-the-user-is-targeted).
1. [Verify that the managed app is targeted](#step-4-verify-that-the-managed-app-is-targeted).
1. [Verify that the user signed in to the affected application using their targeted corporate account](#step-5-verify-that-the-user-signed-in-to-the-affected-application-using-their-targeted-corporate-account).
1. [Collect device data](#step-6-collect-device-data-with-microsoft-edge).

### Step 1: Verify app protection policy prerequisites

The first step in troubleshooting is to check whether all prerequisites are met. Although you can use Intune APP independent of any MDM solution, the following prerequisites must be met:

- The user must have an Intune license assigned.
- The user must belong to a security group that is targeted by an app protection policy. The same app protection policy must target the specific app that's used.
- For Android devices, the Company Portal app is required to receive app protection policies.
- If you use [Word, Excel, or PowerPoint](https://products.office.com/business/office) apps, the following additional requirements must be met:
  - The user must have a license for [Microsoft 365 Apps for business or enterprise](https://products.office.com/business/compare-more-office-365-for-business-plans) linked to the user's Microsoft Entra account. The subscription must include the Office apps on mobile devices and can include a cloud storage account with [OneDrive for Business](https://onedrive.live.com/about/business/). Microsoft 365 licenses can be assigned in the [Microsoft 365 admin center](https://admin.microsoft.com) by following [these instructions](/microsoft-365/admin/add-users/add-users).
  - The user must have a managed location that's configured by using the granular **Save as** functionality. This command is located under the **Save Copies of Org Data** application protection policy setting. For example, if the managed location is [OneDrive](https://onedrive.live.com/about/), the OneDrive app should be configured in the user's Word, Excel, or PowerPoint app.
  - If the managed location is OneDrive, the app must be targeted by the app protection policy that's deployed to the user.

  > [!NOTE]
  > The Office mobile apps currently support only SharePoint Online and not SharePoint on-premises.

- If you use Intune app protection policies together with on-premises resources (Microsoft Skype for Business and Microsoft Exchange Server), you must enable [Hybrid Modern Authentication for Skype for Business and Exchange](/microsoft-365/enterprise/hybrid-modern-auth-overview).

### Step 2: Check app protection policy status

Review the following details to understand the status of your app protection policies:

- Has there been a user check-in from the affected device?
- Are the applications for the problem scenario managed via the targeted policy?
- Verify that the timing of policy delivery is within expected behavior. For more information, see [Understand app protection policy delivery timing](/mem/intune/apps/app-protection-policy-delivery).

Use these steps to get detailed information:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Apps** > **Monitor** > **App protection status**, and then select the **Assigned users** tile.
1. On the **App reporting** page, select **Select user** to bring up a list of users and groups.
1. Search for and select one of the affected users from the list, then select **Select user**. At the top of the App reporting page, you can see whether the user is licensed for app protection and has a license for Microsoft 365. You can also see the app status for all the user's devices.
1. Make a note of such important information as the targeted apps, device types, policies, device check-in status, and last sync time.

> [!NOTE]
> App protection policies are applied only when apps are used in the work context. For example, when the user is accessing apps by using a work account.

For more information, see [How to validate your app protection policy setup in Microsoft Intune](/mem/intune/apps/app-protection-policies-validate).

### Step 3: Verify that the user is targeted

Intune app protection policies must be targeted to users. If you don't assign an app protection policy to a user or user group, the policy isn't applied.

To verify that the policy is applied to the targeted user, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Apps** > **Monitor** > **App protection status**, and then select the **User status** tile (based on device OS platform).
On the **App reporting** pane that opens, select **Select user** to search for a user.
1. Select the user from the list. You can see the details for that user. Note it can take up to 24 hours for a newly targeted user to show up in reports.

When you assign the policy to a user group, make sure that the user is in the user group. To do this, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Groups > All groups**, and then search for and select the group that's used for your app protection policy assignment.
1. Under the **Manage** section, select **Members**.
1. If the affected user isn't listed, review [Manage app and resource access using Microsoft Entra groups](/azure/active-directory/fundamentals/active-directory-manage-groups) and your group membership rules. Make sure that the affected user is included in the group.
1. Make sure that the affected user isn't in any of the excluded groups for the policy.

> [!IMPORTANT]
>
> - The Intune app protection policy must be assigned to user groups and not device groups.
> - If the affected device uses Android Enterprise, only personally-owned work profiles will support app protection policies.
> - If the affected device uses Apple's Automated Device Enrollment (ADE), make sure that **User Affinity** is enabled. User Affinity is required for any app that requires user authentication under ADE. For more information on iOS/iPadOS ADE enrollment, see [Automatically enroll iOS/iPadOS devices](/mem/intune/enrollment/device-enrollment-program-enroll-ios).

### Step 4: Verify that the managed app is targeted

When you configure Intune app protection policies, the targeted apps must use [Intune App SDK](/mem/intune/developer/app-sdk-get-started). Otherwise, app protection policies may not work correctly.

Make sure that the targeted app is listed in [Microsoft Intune protected apps](/mem/intune/apps/apps-supported-intune-apps). For LOB or custom apps, verify that the apps use the latest version of [Intune App SDK](/mem/intune/developer/app-sdk-get-started).

For iOS, this practice is important because each version contains fixes that affect how these policies are applied and how they function. For more information, see [Intune App SDK iOS releases](https://github.com/msintuneappsdk/ms-intune-app-sdk-ios/releases). Android users should have the latest version of the Company Portal app installed because the app works as the policy broker agent.

### Step 5: Verify that the user signed in to the affected application using their targeted corporate account

Some apps can be used without user sign-in, but to successfully manage an app using Intune APP, your users must sign in to the app using their corporate credentials. Intune app protection policies require that the identity of the user is consistent between the app and [Intune App SDK](/mem/intune/developer/app-sdk-get-started). Make sure that the affected user has successfully signed in to the app with their corporate account.

In most scenarios, users sign in to their accounts with their user principal name (UPN). However, in some environments (such as on-premises scenarios), users might use some other form of sign-in credentials. In these cases, you might find that the UPN that's used in the app doesn't match the UPN object in Microsoft Entra ID. When this issue occurs, app protection policies aren't applied as expected.

Microsoft's recommended best practices are to match the UPN to the primary SMTP address. This practice enables users to log in to managed apps, Intune app protection, and other Microsoft Entra resources by having a consistent identity. For more information, see [Microsoft Entra UserPrincipalName population](/azure/active-directory/hybrid/plan-connect-userprincipalname).

The only way to guarantee this consistency is through modern authentication. There are scenarios in which apps may work in an on-premises configuration without modern authentication. However, the outcomes are not consistent or guaranteed.

If your environment requires alternative sign-in methods, see [Configuring Alternate Login ID](/windows-server/identity/ad-fs/operations/configuring-alternate-login-id), specifically [Hybrid Modern Authentication with Alternate-ID](/windows-server/identity/ad-fs/operations/configuring-alternate-login-id#hybrid-modern-authentication-with-alternate-id).

### Step 6: Collect device data with Microsoft Edge

Work with the user to collect details about they are trying to do and the steps they are taking. Ask the user to collect screenshots or video recording of the behavior. This helps clarify the explicit device actions being performed. Then, collect managed app logs through Microsoft Edge on the device.

Users with Microsoft Edge installed on their iOS or Android device can view the management status of all Microsoft published apps. They can use the following steps to send logs to help with troubleshooting.

1. Open Microsoft Edge for iOS and Android on your device.
1. In the address bar, type *about:intunehelp*.
1. Microsoft Edge for iOS and Android launches in troubleshooting mode.

From this screen, you will be presented with two options and data about the device.

:::image type="content" source="media/troubleshoot-app-protection-policy-deployment/intune-diagnostics-start.png" alt-text="Screenshot that shows the shared device information.":::

Select **View Intune App Status** to see a list of apps. If you select a specific app, it will show the APP settings associated with that app that are currently active on the device.

:::image type="content" source="media/troubleshoot-app-protection-policy-deployment/intune-diagnostics-app-status.png" alt-text="Screenshot that shows the information about the app.":::

If the information displayed for a specific app is limited to the app version and bundle with the policy check-in timestamp, it means no policy is currently applied to that app on the device.

The **Get Started** option allows you to collect logs about the APP enabled applications. If you open a support ticket with Microsoft for app protection policies, you should always provide these logs from an affected device if possible. For Android-specific instructions, see [Upload and email logs](/mem/intune/user-help/send-logs-to-your-it-admin-by-email-android).

:::image type="content" source="media/troubleshoot-app-protection-policy-deployment/intune-logs.png" alt-text="Screenshot that shows the options to share logs.":::

For a list of the settings stored in the Intune Diagnostics (APP) logs, see [Review client app protection logs](/mem/intune/apps/app-protection-policy-settings-log).

## Additional troubleshooting scenarios

Review the following common scenarios when troubleshooting APP issue. You can also review the scenarios in [Common data transfer issues](data-transfer-scenarios.md).

### Scenario: Policy changes are not applying

The [Intune App SDK](/mem/intune/developer/app-sdk-get-started) checks regularly for policy changes. However, this process may be delayed for any of the following reasons:

- The app hasn't checked in with the service.
- The Company Portal app has been removed from the device.

Intune app protection policy relies on user identity. Therefore, a valid login that uses a work or school account to the app and a consistent connection to the service are required. If the user hasn't signed in to the app, or the Company Portal app has been removed from the device, policies updates won't apply.

> [!IMPORTANT]
> The [Intune App SDK](/mem/intune/developer/app-sdk-get-started) checks every 30 minutes for selective wipe. However, changes to existing policy for users who are already signed in may not appear for up to 8 hours. To speed up this process, have the user log out of the app and then log back in or restart their device.

To check app protection status, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Apps** > **Monitor** > **App protection status**, and then select the **Assigned users** tile.
1. On the App reporting page, select **Select user** to open a list of users and groups.
1. Search for and select one of the affected users from the list, then select **Select user**.
1. Review the policies that are currently applied, including the status and last sync time.
1. If the status is **Not checked in**, or if the display indicates that there has not been a recent sync, check whether the user has a consistent network connection. For Android users, make sure that they have the latest version of the Company Portal app installed.

Intune app protection policies include multi-identity support. Intune can apply app protection policies to only the work or school account that's signed in to the app. However, only one work or school account per device is supported.

### Scenario: Intune-enrolled iOS devices require additional configuration

When you create an app protection policy, you can target it to all app types or to the following app types:

- Apps on unmanaged devices
- Apps on Intune-managed devices
- Apps in the Android personally-owned work profile

> [!NOTE]
> To specify the app types, set **Target to all app types** to **No**, and then select from the **App types** list.

If you are targeting only iOS Intune-managed devices, the following additional [app configuration settings](/mem/intune/apps/app-configuration-policies-use-ios) are required to be targeted alongside your app protection policy:

- **IntuneMAMUPN** must be configured for all MDM (Intune or a third-party EMM)-managed applications. For more information, see Configure user UPN setting for Microsoft Intune or third-party EMM.
- **IntuneMAMDeviceID** must be configured for all third-party and LOB MDM-managed applications.
- **IntuneMAMDeviceID** must be configured as the device ID token. For example, key=IntuneMAMDeviceID, value={{deviceID}}. For more information, see [Add app configuration policies for managed iOS devices](/mem/intune/apps/app-configuration-policies-use-ios).
- If only the **IntuneMAMDeviceID** value is configured, Intune APP will consider the device as unmanaged.

## Next steps

- [Troubleshooting app protection policy user issues](troubleshoot-mam.md)
- [Frequently asked questions about MAM and app protection](/mem/intune/apps/mam-faq)
- [Validate your app protection policy setup in Microsoft Intune](/mem/intune/apps/app-protection-policies-validate)
