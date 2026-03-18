---
title: Booking card date errors in Dynamics 365 Field Service
description: Troubleshoot and fix NaN or incorrect date/time values on booking cards in Dynamics 365 Field Service. Follow step-by-step solutions for common causes.
ms.date: 03/16/2026
ms.reviewer: mkelleher, puneetsingh, v-shaywood
ms.custom: sap:Schedule Board\Issues with usability
---

# Booking card shows NaN or incorrect date and time on the schedule board

## Summary

This article provides resolutions for booking cards on the [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) schedule board that display `NaN undefined NaN` or incorrect date and time values. These problems are typically caused by mismatched date and time format settings, daylight saving time (DST) transitions, or time zone configuration differences.

## Symptoms

When you view bookings on the [schedule board](/dynamics365/field-service/work-with-schedule-board), you see one or more of the following problems:

- Booking cards display `NaN undefined NaN` instead of the correct date and time.
- Booking start and end times don't match the values that you entered when you created the booking.
- Bookings appear shifted by several hours on the schedule board timeline, particularly during daylight saving time (DST) transitions.
- The booking tooltip shows different times than the booking card shows.

## Cause: Regional date or time format mismatch

The user's personal date and time format settings in Dynamics 365 don't match the format expected by the schedule board control. This mismatch commonly occurs if the browser locale differs from the Dynamics 365 user settings.

### Solution

1. Sign in to your Dynamics 365 Field Service app (for example, `https://<YourOrg>.crm.dynamics.com`).
2. Select **Settings** in the upper-right corner, and then select **Personalization Settings**.
3. On the **Formats** tab, check that the **Date Format** and **Time Format** match your region.
4. Make sure that your browser's language and locale setting matches the Dynamics 365 format settings.
5. Select **OK** to save any settings changes, and then refresh the schedule board page.

## Cause: Daylight saving time (DST) transition

Bookings that you create during a DST transition period (for example, scheduling April bookings in March) can display shifted times because the schedule board applies the current UTC offset instead of the target date's offset.

### Solution

To check whether this problem is the cause:

1. Open the booking record directly (not from the schedule board), and check the **Start Time** and **End Time** fields.
2. If the record shows correct times but the schedule board shows shifted times, the board is applying the wrong UTC offset.
3. On the schedule board, go to a date that occurs after the DST transition. Bookings that are listed after the transition should appear correctly.

> [!NOTE]
> If this problem affects many bookings, consider rescheduling the bookings by using the [schedule assistant](/dynamics365/field-service/schedule-assistant) after the DST transition occurs.

## Cause: Time zone configuration mismatch

The user's time zone in Dynamics 365 personalization settings doesn't match the schedule board's time zone setting.

### Solution

1. Sign in to your Dynamics 365 Field Service app (for example, `https://<YourOrg>.crm.dynamics.com`).
2. Select **Settings** in the upper-right corner, and then select **Personalization Settings**.
3. On the **General** tab, check that the **Time Zone** is set correctly for your location.
4. Select **OK** to save any settings changes.
5. In the Field Service app, go to **Scheduling** > **Schedule Board**.
6. On the schedule board, select the ellipsis (**...**) > **Scheduler settings** on the active board tab, and then check the board's time zone setting.
7. Make sure that the user personalization time zone and the board tab time zone match.

## Related content

- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
