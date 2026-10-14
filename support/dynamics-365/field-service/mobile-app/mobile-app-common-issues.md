---
title: Troubleshoot Field Service Mobile App Issues and Errors
description: Troubleshoot Dynamics 365 Field Service mobile app issues, including missing bookings, sign-in errors, offline sync failures, guest access, and missing environments.
ms.date: 09/11/2026
ms.subservice: field-service-mobile
ms.reviewer: jobaker, puneetsingh, v-shaywood, v-wesmith
ai-usage: ai-assisted
ms.custom: sap:Mobile Application\Application is throwing errors
---

# Troubleshoot Dynamics 365 Field Service mobile app issues

## Summary

This article helps you resolve common problems that affect the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview). It covers problems that field technicians and administrators might encounter when they use the app, including:

- Missing bookings and agenda errors
- Sign-in and access errors
- Offline sync failures
- Guest account limitations
- Environment selection problems

Each section describes the symptoms, identifies the cause, and provides step-by-step solution guidance.

## Schedule shows no bookings or an error

### Symptoms

After you sign in to the Field Service mobile app, you experience one or more of the following symptoms:

- The schedule displays **No bookings**, but you expect to see one or more bookings.
- The schedule displays an error while loading bookings.
- The app remains blank while loading and doesn't display an empty-state or error message.

### Cause

The mobile agenda applies the configured agenda view and includes bookings that overlap the displayed date range. It also limits bookings to the bookable resource associated with your user account. A booking doesn't appear if it doesn't meet these conditions.

If a request to load bookings fails, the app displays an error instead of intentionally converting the failure to an empty result. A completed request that returns no records displays **No bookings**.

The native mobile client doesn't establish that an incomplete synchronization or an offline-profile filter causes a blank screen. The Power Apps mobile offline platform controls offline data and synchronization.

### Solution

1. Confirm that the booking is assigned to the bookable resource associated with your user account.

1. Confirm that the booking's start and end times overlap the date displayed in the schedule.

1. Check whether the configured agenda view excludes the booking because of its filters.

1. If the schedule displays an error, select **Retry**.

1. If bookings are missing only when you work offline, ask your administrator to verify that the mobile offline profile includes the **Bookable Resource Booking** (`bookableresourcebooking`) table and the data required by its filters. For more information, see [Troubleshoot mobile offline profile publishing and related-table issues](publish-mobile-offline-profile.md).

1. If the app remains blank without displaying **No bookings** or an error, collect the session details and use **Send feedback**. A blank host screen requires runtime investigation and isn't the same as an agenda with no matching bookings.

Signing out resets native cached state before the app delegates sign-out to the host. It doesn't force an offline synchronization or repair an offline-profile configuration.

## "Contact your administrator" error at app startup

### Symptoms

When a user opens the Field Service mobile app, they see the following error message instead of the home screen:

> Contact your administrator for access to your organization's mobile apps.

The user can't proceed past this screen.

### Cause

This error occurs if you don't have the effective Dataverse privileges and app access required to use Field Service. Organizations commonly provide these privileges through one of the following security roles:

- Field Service - Resource
- Field Service - Administrator
- Field Service - Dispatcher

### Solution

1. Sign in to Dynamics 365 Field Service as an administrator.

1. Go to **Settings** (gear symbol) > **System** > **Security (Preview)** > **Users**.

1. Open the affected user record.

1. Select **Manage Roles**, assign a role that provides the required Field Service privileges and app access, and select **Save**.

1. Ask the user to sign out of the mobile app and sign back in.

You can also use the [Field Service solution health checker](/dynamics365/field-service/troubleshoot-field-service-solution-health) and select **Verify mobile user security roles** to automatically detect users who are missing required roles.

> [!IMPORTANT]
> Verify the user's effective privileges and Field Service mobile app access. The native client checks effective privileges; it doesn't determine whether the privileges came from a direct role assignment or team membership. For more information, see [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions).

## Offline sync error: related entities not available offline

### Symptoms

When a user tries to sync the Field Service mobile app for offline use, the sync fails and the following error message appears:

> The view has related entities that aren't available offline.

The offline sync doesn't complete, and the user can't use the data offline.

### Cause

This error comes from the Power Apps mobile offline platform when the profile can't make data referenced by a view or filter available offline. The Field Service native client doesn't publish or validate mobile offline profiles.

### Solution

1. In [Power Apps](https://make.powerapps.com), go to **Apps**, and select the **Field Service Mobile** app.

1. Select **Settings** (gear symbol).

1. In the **General** tab, go to **Select offline mode and profile**, and select the ellipsis (**...**) that's located next to the selected offline profile.

1. Select **Edit selected profile** to open the offline profile that's assigned to the app.

1. Review each table that's listed in the profile, and check its **Filter** settings. Find any filter that uses a related table column. For example, a filter on `ownerid` field that joins to the `systemuser` table.

1. For each filter that references a related table, take one of the following actions:

   - Add the related table to the offline profile.
   - Change the filter to use columns from the primary table only.
   - Remove the filter entirely if it isn't required.

1. Save and publish the updated offline profile.

1. Ask the affected users to synchronize offline data again.

For more profile publishing and related-table troubleshooting, see [Troubleshoot mobile offline profile publishing and related-table issues](publish-mobile-offline-profile.md). For guidance on how to build offline profiles that avoid this issue, see [Best practices and limitations for the mobile offline profile](/dynamics365/field-service/mobile/best-practices-limitations-offline-profile).

## Guests can't sign in to the Field Service mobile app

### Symptoms

A user with an external or guest Microsoft Entra ID account can't sign in to the Field Service mobile app. One or more of the following symptoms occur:

- The sign-in process finishes, but the app shows an access error or no data.
- The user receives an error message that indicates that they don't have the correct permissions.
- The user can use Dynamics 365 in a desktop browser but not through the mobile app.

### Cause

Guest accounts are user accounts from an external Microsoft Entra ID tenant that you invite to your organization's tenant. These accounts have limitations that prevent full use of the mobile app, including offline sync and security role enforcement.

### Solution

Frontline workers [enabled as Microsoft Entra B2B collaborator](/entra/external-id/what-is-b2b) (guest) can access the mobile app by [switching to the guest tenant](/power-apps/mobile/tenant-switcher).

If a guest user needs to access the application with a personal account, use a formatted deep link to access the guest tenant.

```text
https://apps.powerapps.com/mobile/redirect?appid=<AppId>&tenantid=<TenantId>&playerchannel=FieldServiceMobile&sourceurl=https%3A%2F%2F<OrgUrlWithoutHttps>%2Fmain.aspx%3Fappid%<AppId>
```

For a full list of supported user types and platform requirements, see the [Field Service mobile app FAQ](/dynamics365/field-service/mobile/mobile-power-app-faq).

## App shows the wrong environment or a missing environment

### Symptoms

When a user opens the Field Service mobile app, one or more of the following symptoms occur:

- The user doesn't see the correct Dynamics 365 environment in the environment picker.
- The app loads but shows data from the wrong environment.
- Some users can see a specific environment but others can't.

### Cause

The environment picker in the Field Service mobile app shows only environments in which you have at least one Dynamics 365 security role assigned, and the Field Service solution is installed.

If an environment doesn't appear, you might not have the required access in that environment, or Field Service might not be installed in it.

The Power Apps host controls environment discovery and selection. The native client provides a route to the host app list but doesn't determine which environments appear or when the host refreshes the list.

### Solution

#### Environment is missing from the picker

1. Verify that Field Service is installed in the environment:

   1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com), open the environment.
   1. Go to **Dynamics 365 apps**.
   1. Check that **Field Service** is listed and has a status of **Installed**.

1. Verify that the user has a security role assigned in that environment:

   1. Go to the environment's **Settings** > **Security** > **Users**.
   1. Find the user and check their roles.

1. In the mobile app, go to **Settings** > **Apps** to open the host app list, and check for the expected Field Service app.

#### App loads data from the wrong environment

1. In the app, go to **Settings** > **Apps**.

1. Select the Field Service app in the correct environment.

1. If authentication or account state prevents you from opening the app list, sign out, sign back in with the correct account, and try again.

> [!TIP]
> If your organization has multiple environments and users frequently select the wrong one, consider setting a default environment. For more information, see [Set up the Field Service mobile app](/dynamics365/field-service/mobile/set-up-field-service-mobile).

## Related content

- [Set up the mobile offline profile](/dynamics365/field-service/mobile/set-up-offline-profile)
- [Troubleshoot WebView reset in the Field Service mobile app](webview-reset.md)
- [Work order details or booking statuses are missing on a booking](booking-missing-work-order-details.md)
