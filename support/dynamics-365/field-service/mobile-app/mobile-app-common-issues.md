---
title: Common issues with the Field Service mobile app
description: Resolve common issues with the Dynamics 365 Field Service mobile app, including blank screens, offline sync errors, access errors, and WebView resets.
ms.date: 03/11/2026
ms.topic: troubleshooting
ms.subservice: field-service-mobile
author: JonBaker007
ms.author: jobaker
ms.reviewer: puneetsingh
ms.custom: bap-template
---

# Common issues with the Field Service mobile app

## Summary

This article helps you resolve common issues that occur in the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview).

## Booking screen or agenda is blank

### Symptoms

After signing in to the Field Service mobile app, you see one or more of the following symptoms:

- The booking screen shows a blank white page with no bookings listed.
- The daily agenda view doesn't load and shows no content.
- No error message is displayed, but the screen remains empty after waiting.

Users most frequently report this symptom on Android devices.

### Cause

This issue occurs when the mobile offline profile hasn't completed its initial synchronization, or when a previous sync was interrupted. Without a successful sync, the app has no local data to display and shows a blank screen.

A secondary cause is an offline filter that references a related entity that isn't included in the mobile offline profile. When you publish the profile with an invalid filter, the sync fails silently and data doesn't appear.

### Resolution

1. Force a manual sync. In the Field Service Mobile app, select the menu icon and go to **Offline Status** > **Sync now**.

1. Wait for the sync to complete, then go back to the booking screen.

1. If the screen stays blank after syncing, sign out of the app and sign back in.

1. If the issue persists, ask your administrator to verify the offline profile configuration:

   1. In [Power Apps](https://make.powerapps.com), go to **Apps** and select the **Field Service Mobile** app.
   1. Select **Settings**.
   1. Go to **Select offline mode and profile**, select **...** after the selected offline profile.
   1. Select **Edit selected profile** to open the assigned profile.
   1. Confirm that the **Bookable Resource Booking** (`bookableresourcebooking`) table is included in the profile.
   1. Check each table filter for lookup fields that reference tables not included in the profile. Remove or update any filters that cause validation errors.
   1. Save and publish the profile, then ask the user to sync again.

1. On Android, if the issue continues, clear the app cache: go to the device **Settings** > **Apps** > **Field Service** > **Storage** > **Clear cache**, then reopen the app.

> [!NOTE]
> This symptom is common after a Field Service solution update. If it starts after a recent update, check the [Field Service version history](/dynamics365/field-service/version-history) for known issues in your release.

## "Contact your administrator" error when opening the app

### Symptoms

When a user opens the Field Service mobile app, the user sees the following error message instead of the home screen:

> Contact your administrator for access to your organization's mobile apps.

The user can't proceed past this screen.

### Cause

This error occurs when the user doesn't have a security role that grants access to the Field Service mobile app. The app requires at least one of the following security roles to be assigned directly to the user (not only through a team):

- Field Service - Resource
- Field Service - Administrator
- Field Service - Dispatcher

### Resolution

1. Sign in to Dynamics 365 Field Service as an administrator.

1. Go to **Settings** (gear icon at top) > **System** > **Security (Preview)** > **Users**.

1. Open the affected user's record.

1. Select **Manage Roles**, assign the **Field Service - Resource** security role, and select **Save**.

1. Ask the user to sign out of the mobile app and sign back in.

> [!IMPORTANT]
> Assign security roles directly to the user, not only through a team membership. Team-inherited roles aren't sufficient for mobile app access in some configurations. For more information, see [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions).

> [!TIP]
> Use the [Field Service solution health checker](/dynamics365/field-service/troubleshoot-field-service-solution-health) and select **Verify mobile user security roles** to automatically detect users who are missing required roles.

## WebView reset error when opening a file or PDF

### Symptoms

When a user opens a PDF or file attachment in the Field Service mobile app, one or more of the following symptoms occur:

- The file opens briefly and then immediately closes.
- The app returns to the home screen without warning.
- The following error message appears:

  > WebView reset.

### Cause

A WebView reset occurs when the mobile operating system terminates the WebView process because it exceeded its memory limit. Field Service, like all model-driven Power Apps, runs as a web application inside a WebView on the mobile client. When a memory-intensive operation - such as opening a large file - causes the WebView process to exceed the operating system's memory threshold, the process is terminated and the app resets.

The behavior differs by platform:

- **iOS**: The WebView runs in a separate process. When memory limits are exceeded, the operating system terminates only the WebView process and shows a reset message.
- **Android**: The WebView runs within the main app process. If memory limits are exceeded, the entire app crashes rather than showing a reset message.

### Resolution

**For end users:**

1. Reduce the file size. Attachments larger than 10 MB are more likely to trigger a WebView reset.
1. If the issue occurs with a specific file, ask the sender to compress or reduce the file size before reattaching it to the work order.
1. Restart the app and try again. If the issue occurs consistently with the same file, the file might be corrupted.

**For administrators:**

1. Review any [custom controls or web resources](/dynamics365/field-service/mobile/improve-mobile-performance) added to the mobile app. Custom controls that store Base64-encoded images or import large JavaScript libraries can cause memory pressure that makes WebView resets more frequent.

1. Use browser developer tools (such as Microsoft Edge DevTools) to investigate memory usage. Load the form that causes the reset in a desktop browser and use the **Memory** panel to detect leaks or spikes. For more information, see [Fix memory problems in Microsoft Edge DevTools](/microsoft-edge/devtools-guide-chromium/memory-problems/).

1. To debug on iOS, use Safari memory analysis tools. For more information, see [the Timelines Tab in Web Inspector](https://webkit.org/web-inspector/timelines-tab/).

> [!NOTE]
> For more information about WebView resets, see [Home page unexpectedly shown and WebView reset in the Field Service mobile app](/troubleshoot/dynamics-365/field-service/mobile-app/webview-reset).

## Offline sync error: related entities not available offline

### Symptoms

When a user tries to sync the Field Service mobile app for offline use, the sync fails and the following error message appears:

> The view has related entities that are not available offline.

The offline sync doesn't complete and the user can't access the data.

### Cause

This error occurs when a table filter in the mobile offline profile uses a lookup field that references a related table that the profile doesn't include. When you publish the profile, the sync process validates all filters against the offline-enabled tables. The sync process fails if it finds a reference to a table that isn't available offline.

### Resolution

1. In [Power Apps](https://make.powerapps.com), go to **Apps** and select the **Field Service Mobile** app.

1. Select **Settings** (gear icon).

1. In the **General** tab, go to  **Select offline mode and profile**, and select **...** located after the offline profile.

1. Select **Edit selected profile** to open the offline profile assigned to the app.

1. Review each table listed in the profile and examine its **Filter** settings. Look for any filter that uses a related table column, for example, a filter on `ownerid` that joins to the `systemuser` table.

1. For each filter that references a related table, do one of the following actions:
   - Add the related table to the offline profile.
   - Change the filter to use only columns from the primary table.
   - Remove the filter entirely if it isn't required.

1. Save and publish the updated offline profile.

1. Ask the affected users to sync again by going to **Offline Status** > **Sync now** in the app.

> [!TIP]
> For guidance on building offline profiles that avoid this issue, see [Best practices and limitations for the mobile offline profile](/dynamics365/field-service/mobile/best-practices-limitations-offline-profile).

## Guests can't sign in to the Field Service mobile app

### Symptoms

A user with an external or guest Microsoft Entra ID account can't sign in to the Field Service mobile app. One or more of the following symptoms occur:

- The sign-in process completes but the app shows no data or an access error.
- The user receives an error indicating they don't have the correct permissions.
- The user can access Dynamics 365 on a desktop browser but not through the mobile app.

### Cause

The Field Service mobile app doesn't support external guest Microsoft Entra ID accounts. Guest accounts are user accounts from an external Microsoft Entra ID tenant that you invite to access your organization's tenant. These accounts have limitations that prevent full access to the mobile app experience, including offline sync and security role enforcement.

### Resolution

**If the user requires full Field Service mobile access:**

The guest account must be converted to an internal member account in your organization's Microsoft Entra ID tenant. Contact your Azure AD administrator to create an internal user account and assign a Dynamics 365 Field Service license to it.

**If the user only needs to view or update their own service appointments:**

Use the [Field Service customer portal](/dynamics365/field-service/customer-portal-overview) instead of the mobile app. The customer portal supports guests and doesn't require a Field Service license.

> [!NOTE]
> For a full list of supported user types and platform requirements, see the [Field Service mobile app FAQ](/dynamics365/field-service/mobile/mobile-power-app-faq).

## App shows the wrong environment or a missing environment

### Symptoms

When a user opens the Field Service mobile app, one or more of the following symptoms occur:

- The user doesn't see the correct Dynamics 365 environment in the environment picker.
- The app loads but shows data from the wrong environment.
- Some users can see a specific environment but others can't.

### Cause

The environment picker in the Field Service mobile app only shows environments where the user has at least one Dynamics 365 security role assigned and the Field Service solution is installed. If an environment doesn't appear, it typically means the user doesn't have a security role in that environment, or Field Service isn't installed in it.

If users see data from the wrong environment, the app might have cached credentials or a previous environment selection.

### Resolution

**If the environment is missing from the picker:**

1. Confirm that Field Service is installed in the environment. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com), open the environment and go to **Dynamics 365 apps** to verify that **Field Service** is listed with a status of **Installed**.

1. Confirm that the user has a security role assigned in that environment. Go to the environment's **Settings** > **Security** > **Users**, find the user, and verify their roles.

1. Ask the user to sign out of the mobile app completely and sign back in. The environment picker refreshes on each sign-in.

**If the app loads data from the wrong environment:**

1. In the app, select the environment name at the top of the screen (if available) to open the environment picker.

1. Select the correct environment.

1. If you can't access the environment picker, sign out of the app, sign back in, and select the correct environment during the sign-in flow.

> [!NOTE]
> If your organization has multiple environments and users frequently select the wrong one, consider setting a default environment. For more information, see [Set up the Field Service mobile app](/dynamics365/field-service/mobile/set-up-field-service-mobile).

## Related content

- [Field Service mobile app overview](/dynamics365/field-service/mobile/overview)
- [Set up the mobile app](/dynamics365/field-service/mobile/set-up-field-service-mobile)
- [Set up the mobile offline profile](/dynamics365/field-service/mobile/set-up-offline-profile)
- [Best practices and limitations for the offline profile](/dynamics365/field-service/mobile/best-practices-limitations-offline-profile)
- [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
- [Field Service mobile app FAQ](/dynamics365/field-service/mobile/mobile-power-app-faq)
