---
title: Troubleshoot Field Service mobile app common issues
description: Troubleshoot common Field Service mobile app errors, including offline sync failures, blank agenda screens, and "Contact your administrator" messages.
ms.date: 03/20/2026
ms.subservice: field-service-mobile
ms.reviewer: jobaker, puneetsingh, v-shaywood
ms.custom: sap:Mobile Application\Application is throwing errors
---

# Troubleshoot common issues in the Dynamics 365 Field Service mobile app

## Summary

This article helps you resolve common problems that affect the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview). It covers problems that field technicians and administrators might encounter when they use the app, including:

- Blank booking screens
-  Sign-in and access errors
-  Offline sync failures
-  Guest account limitations
-  Environment selection problems

Each section describes the symptoms, identifies the cause, and provides step-by-step solution guidance.

## Booking screen or agenda is blank

### Symptoms

After you sign in to the Field Service mobile app, you experience one or more of the following symptoms:

- The booking screen shows a blank white page without any listed bookings.
- The daily agenda view doesn't load and shows no content.
- No error message appears, but the screen stays empty.

Users most frequently report these symptoms on Android devices.

### Cause

This problem occurs when the mobile offline profile doesn't completed its initial synchronization, or when a previous sync is interrupted. Without a successful sync, the app has no local data to display, and it shows a blank screen.

This problem also occurs if an offline filter references a related entity that isn't included in the mobile offline profile. When you publish the profile by having an invalid filter, the sync fails silently and data doesn't appear.

### Solution

1. Force a manual sync. In the Field Service mobile app, select the menu icon, and go to **Offline Status** > **Sync now**.

1. Wait for the sync to finish. Then, go back to the booking screen.

1. If the screen stays blank after syncing, sign out of the app, and then sign back in.

1. If the issue persists, ask your administrator to check the offline profile configuration:

   1. In [Power Apps](https://make.powerapps.com), go to **Apps**, and select the **Field Service Mobile** app.
   1. Select **Settings**.
   1. Go to **Select offline mode and profile**, select the ellipsis (**...**) after the selected offline profile.
   1. To open the assigned profile, select **Edit selected profile**.
   1. Verify that the **Bookable Resource Booking** (`bookableresourcebooking`) table is included in the profile.
   1. Check each table filter for lookup fields that reference tables that are not included in the profile. Remove or update any filters that cause validation errors.
   1. Save and publish the profile. Then, ask the user to sync again.

1. On Android, if the issue continues, clear the app cache:

   1. Go to **Settings** > **Apps** > **Field Service** > **Storage**.
   1. Select **Clear cache**.
   1. Reopen the app.

> [!NOTE]
> This issue is common after a Field Service solution update. If the symptoms appear after a recent update, check the [Field Service version history](/dynamics365/field-service/version-history) for known issues in your release.

## "Contact your administrator" error when opening the app

### Symptoms

When a user opens the Field Service mobile app, they see the following error message instead of the home screen:

> Contact your administrator for access to your organization's mobile apps.

The user can't proceed past this screen.

### Cause

This error occurs if the user doesn't have a security role that grants access to the Field Service mobile app. The user must have the role assigned directly to their account. Roles that are inherited through team membership alone aren't sufficient. The app requires at least one of the following security roles:

- Field Service - Resource
- Field Service - Administrator
- Field Service - Dispatcher

### Solution

1. Sign in to Dynamics 365 Field Service as an administrator.

1. Go to **Settings** (gear symbol) > **System** > **Security (Preview)** > **Users**.

1. Open the affected user's record.

1. Select **Manage Roles**, assign the **Field Service - Resource** security role, and select **Save**.

1. Ask the user to sign out of the mobile app and sign back in.

You can also use the [Field Service solution health checker](/dynamics365/field-service/troubleshoot-field-service-solution-health) and select **Verify mobile user security roles** to automatically detect users who are missing required roles.

> [!IMPORTANT]
> Assign security roles directly to the user, not only through a team membership. Team-inherited roles aren't sufficient for mobile app access in some configurations. For more information, see [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions).

## Offline sync error: related entities not available offline

### Symptoms

When a user tries to sync the Field Service mobile app for offline use, the sync fails and the following error message appears:

> The view has related entities that are not available offline.

The offline sync doesn't complete, and the user can't use the data offline.

### Cause

This error occurs when a table filter in the mobile offline profile uses a lookup field that references a related table that the profile doesn't include. When you publish the profile, the sync process validates all filters against the offline-enabled tables. The sync process fails if it finds a reference to a table that isn't available offline.

### Solution

1. In [Power Apps](https://make.powerapps.com), go to **Apps**, and select the **Field Service Mobile** app.

1. Select **Settings** (gear symbol).

1. In the **General** tab, go to **Select offline mode and profile**, and select the ellipsis (**...**) after the offline profile.

1. Select **Edit selected profile** to open the offline profile that's assigned to the app.

1. Review each table that's listed in the profile, and check its **Filter** settings. Find any filter that uses a related table column. For example, a filter on `ownerid` field that joins to the `systemuser` table.

1. For each filter that references a related table, take one of the following actions:

   - Add the related table to the offline profile.
   - Change the filter to use columns from the primary table only.
   - Remove the filter entirely if it isn't required.

1. Save and publish the updated offline profile.

1. Ask the affected users to sync again by going to **Offline Status** > **Sync now** in the app.

For guidance baout how to build offline profiles that avoid this issue, see [Best practices and limitations for the mobile offline profile](/dynamics365/field-service/mobile/best-practices-limitations-offline-profile).

## Guests can't sign in to the Field Service mobile app

### Symptoms

A user who has an external or guest Microsoft Entra ID account can't sign in to the Field Service mobile app. One or more of the following symptoms occur:

- The sign-in process finishes, but the app shows an access error or no data.
- The user receives an error message that indicates that they don't have the correct permissions.
- The user can use Dynamics 365 in a desktop browser but not through the mobile app.

### Cause

The Field Service mobile app doesn't support external guest Microsoft Entra ID accounts. Guest accounts are user accounts from an external Microsoft Entra ID tenant that you invite to your organization's tenant. These accounts have limitations that prevent full use of the mobile app, including offline sync and security role enforcement.

### Solution

If the user requires full Field Service mobile access, contact your Microsoft Entra ID administrator to create an internal member account for the user in your organization's tenant. Then, assign a Dynamics 365 Field Service license to it.

If the user needs only to view or update their own service appointments, use the [Field Service customer portal](/dynamics365/field-service/customer-portal-overview) instead of the mobile app. The customer portal supports guests and doesn't require a Field Service license.

For a full list of supported user types and platform requirements, see the [Field Service mobile app FAQ](/dynamics365/field-service/mobile/mobile-power-app-faq).

## App shows the wrong environment or a missing environment

### Symptoms

When a user opens the Field Service mobile app, one or more of the following symptoms occur:

- The user doesn't see the correct Dynamics 365 environment in the environment picker.
- The app loads but shows data from the wrong environment.
- Some users can see a specific environment but others can't.

### Cause

The environment picker in the Field Service mobile app shows only environments in which you have at least one Dynamics 365 security role assigned, and the Field Service solution is installed.

If an environment doesn't appear, this typically means that you don't have a security role assigned in that environment, or that Field Service isn't installed in it.

If you see data from the wrong environment, the app might have cached credentials or a previous environment selection.

### Solution

#### Environment is missing from the picker

1. Verify that Field Service is installed in the environment:

   1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com), open the environment.
   1. Go to **Dynamics 365 apps**.
   1. Check that **Field Service** is listed and has a status of **Installed**.

1. Verify that the user has a security role assigned in that environment:

   1. Go to the environment's **Settings** > **Security** > **Users**.
   1. Find the user and check their roles.

1. Ask the user to sign out of the mobile app completely and sign back in. The environment picker refreshes upon each sign-in.

#### App loads data from the wrong environment

1. In the app, select the environment name at the top of the screen (if available) to open the environment picker.

1. Select the correct environment.

1. If you can't open the environment picker, sign out of the app, sign back in, and then select the correct environment during the sign-in flow.

> [!TIP]
> If your organization has multiple environments and users frequently select the wrong one, consider setting a default environment. For more information, see [Set up the Field Service mobile app](/dynamics365/field-service/mobile/set-up-field-service-mobile).

## Related content

- [Set up the mobile offline profile](/dynamics365/field-service/mobile/set-up-offline-profile)
- [Troubleshoot WebView reset in the Field Service mobile app](webview-reset.md)
