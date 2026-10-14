---
title: Booking Card Shows NaN or Incorrect Date on Schedule Board
description: Booking cards on the Dynamics 365 Field Service schedule board show NaN or incorrect times. Learn how to fix format, time zone, DST, and version issues.
ms.date: 09/08/2026
ms.reviewer: mkelleher, puneetsingh, v-shaywood, anclear
ms.custom: sap:Schedule Board\Issues with usability
ai-usage: ai-assisted
---

# Booking card shows NaN or incorrect date and time on the schedule board

## Summary

This article provides resolutions for booking cards on the [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) schedule board that display `NaN undefined NaN` or incorrect date and time values. These problems are typically caused by mismatched date and time format settings, daylight saving time (DST) transitions, time zone configuration differences, or an outdated schedule board or Universal Resource Scheduling (URS) rendering component.

## Symptoms

When you view bookings on the [schedule board](/dynamics365/field-service/work-with-schedule-board), you see one or more of the following problems:

- Booking cards display `NaN undefined NaN` instead of the correct date and time.
- Booking start and end times don't match the values that you entered when you created the booking.
- Bookings appear shifted by several hours on the schedule board timeline, particularly during daylight saving time (DST) transitions.
- The booking tooltip shows different times than the booking card shows.

> [!NOTE]
> The schedule board's own date and time formatters are designed to guard against invalid values: when a date can't be parsed, they render an empty value or a placeholder (such as `---`) rather than the text `NaN`. If a booking card persistently displays a literal `NaN` value, the cause is usually the rendering component itself (an outdated schedule board or Universal Resource Scheduling version), not the underlying booking data or your personalization settings. See [Cause: Outdated schedule board rendering component](#cause-outdated-schedule-board-rendering-component).

## Cause: Regional date or time format mismatch

The user's personal date and time format settings in Dynamics 365 don't match the format expected by the schedule board control. This mismatch commonly occurs if the browser locale differs from the Dynamics 365 user settings.

### Solution

1. Sign in to your Dynamics 365 Field Service app (for example, `https://<YourOrg>.crm.dynamics.com`).
1. Select **Settings** in the upper-right corner, and then select **Personalization Settings**.
1. On the **Formats** tab, check that the **Date Format** and **Time Format** match your region.
1. Make sure that your browser's language and locale setting matches the Dynamics 365 format settings.
1. Select **OK** to save any settings changes, and then refresh the schedule board page.

## Cause: Daylight saving time (DST) transition

Bookings that you create during a DST transition period (for example, scheduling April bookings in March) can display shifted times. Depending on the schedule board version and view, some rendering paths apply the current UTC offset instead of the offset that's in effect on the target date, which shifts times across a DST boundary.

### Solution

To check whether this problem is the cause:

1. Open the booking record directly (not from the schedule board), and check the **Start Time** and **End Time** fields.
1. If the record shows correct times but the schedule board shows shifted times, the board is applying the wrong UTC offset.
1. On the schedule board, go to a date that occurs after the DST transition. Bookings that are listed after the transition should appear correctly.

> [!NOTE]
> If this problem affects many bookings, consider rescheduling the bookings by using the [schedule assistant](/dynamics365/field-service/schedule-assistant) after the DST transition occurs.

## Cause: Time zone configuration mismatch

The user's time zone in Dynamics 365 personalization settings doesn't match the schedule board's time zone setting.

### Solution

1. Sign in to your Dynamics 365 Field Service app (for example, `https://<YourOrg>.crm.dynamics.com`).
2. Select **Settings** in the upper-right corner, and then select **Personalization Settings**.
1. On the **General** tab, check that the **Time Zone** is set correctly for your location.
1. Select **OK** to save any settings changes.
1. In the Field Service app, go to **Scheduling** > **Schedule Board**.
1. On the schedule board, select the ellipsis (**...**) > **Scheduler settings** on the active board tab, and then check the board's time zone setting.
1. Make sure that the user personalization time zone and the board tab time zone match.

## Cause: Outdated schedule board rendering component

The schedule board renders booking cards by using a scheduler control that's part of the schedule board and Universal Resource Scheduling (URS) solutions. The board's formatters usually convert invalid dates to an empty value or a placeholder. So, a literal `NaN` value on a booking card typically indicates a defect in the rendering component in an outdated board or URS build, rather than a problem with the booking data or user settings.

### Solution

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. Select **Manage** > **Environments**, and then select your Field Service environment.
1. Go to **Resources** > **Dynamics 365 apps**.
1. Update **Universal Resource Scheduling** (also listed as **msdyn_Scheduling**) and **Dynamics 365 Field Service** to the latest available versions.
1. Clear the browser cache and cookies for your Dynamics 365 domain, close all Dynamics 365 tabs, and then reopen the schedule board.
1. If the `NaN` value persists after you update and clear the cache, [contact Microsoft Support](/power-platform/admin/get-help-support) and include the affected booking, the board time zone, and the browser time zone.

## Related content

- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
