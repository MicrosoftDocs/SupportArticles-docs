---
title: Restore Missing Work Order Details or Booking Statuses
description: Resolve missing work order details or booking statuses in the Field Service mobile app by checking view columns, status mappings, and offline profiles.
ms.reviewer: jobaker, puneetsingh, v-shaywood
ms.date: 09/11/2026
ms.custom: sap:Mobile Application
ai-usage: ai-assisted
---
# Work order details or booking statuses are missing in the Field Service mobile app

## Summary

This article helps you resolve missing work order details and limited booking status options in the Microsoft Dynamics 365 Field Service mobile app. Review booking view columns, field service status mappings, and mobile offline profile tables.

## Symptoms

When you view a booking in the Field Service mobile app, you experience one or more of the following symptoms:

- The booking on the schedule doesn't show the service account, primary incident type, address, or a configured custom field.
- An alert reports that one or more custom fields aren't available.
- The booking status list shows fewer options than expected, or shows only the status that you already selected.

## Cause

The booking calendar reads work order information through the related columns that the configured view links to the booking. It displays the service account, the primary incident type, and the address from the linked work order, along with any configured custom fields. If the view doesn't include a linked column, the corresponding value doesn't appear.

Custom fields must reference a column that's present in the view. When a configured custom field isn't in the view's columns, the control skips the value and reports the unavailable fields. The default primary custom field is the work order's primary incident type (`msdyn_workorder.msdyn_primaryincidenttype`).

The booking status list is limited in the following ways:

- When a booking is linked to a work order, the list shows only statuses that map to a field service status. Statuses without a field service status mapping appear only when no work order is attached.
- In offline mode, the app reads booking statuses from the offline database. If the Booking Status table isn't available offline, the app can display only the status that you already set on the booking.

## Solution

### Restore missing work order details

1. In [Power Apps](https://make.powerapps.com), open the view that the Field Service mobile app uses for bookings.

1. Add the related work order columns that you want to display, such as service account, primary incident type, and the address columns.

1. For each custom field configured on the booking control, confirm that the field references a column that's included in the view. Use the `<RelatedEntity>.<Column>` format for a linked column, for example `msdyn_workorder.msdyn_primaryincidenttype`. Replace `<RelatedEntity>` with the related entity name and `<Column>` with the column name. Learn more in [Customize the booking view](/dynamics365/guidance/resources/field-service-mobile-customize-booking-view).

1. Save and publish the view.

1. If details are missing only in offline mode, ask your administrator to confirm that the mobile offline profile includes the work order table and its relationship to the booking. For more information, see [Troubleshoot mobile offline profile publishing and related-table issues](publish-mobile-offline-profile.md).

### Restore missing booking statuses

1. Verify that each expected booking status is active and mapped to a field service status. Statuses without a field service status mapping don't appear for a booking that's linked to a work order.

1. If statuses are missing only in offline mode, ask your administrator to confirm that the Booking Status table is included in the mobile offline profile so the full list is available offline.

1. If only the currently selected status appears offline, this behavior indicates that the Booking Status table isn't available in the offline database. Add the table to the offline profile, publish it, and ask the user to synchronize again.

## Related content

- [Troubleshoot common issues in the Dynamics 365 Field Service mobile app](mobile-app-common-issues.md)
- [Troubleshoot mobile offline profile publishing and related-table issues](publish-mobile-offline-profile.md)
