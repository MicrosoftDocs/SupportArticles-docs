---
title: Booking card shows NaN or incorrect date and time on the schedule board
description: Resolves issues where booking cards display NaN or incorrect date/time values on the Dynamics 365 Field Service schedule board.
author: mkelleher-msft
ms.author: mkelleher
ms.reviewer: puneetsingh
ms.date: 03/12/2026
ms.custom: sap:Schedule Board
---

# Booking card shows 'NaN' or incorrect date and time on the schedule board

This article helps resolve issues where booking cards on the Dynamics 365 Field Service schedule board display `NaN undefined NaN` or incorrect date and time values.

## Symptoms

When you view bookings on the schedule board, you experience one or more of the following issues:

- Booking cards display `NaN undefined NaN` instead of the correct date and time.
- Booking start and end times don't match the values you entered when creating the booking.
- Bookings appear shifted by several hours on the schedule board timeline, particularly during daylight saving time (DST) transitions.
- The booking tooltip shows different times than the booking card.

## Cause

### Cause 1: Regional date/time format mismatch

The user's personal date/time format settings in Dynamics 365 don't match the format expected by the schedule board control. This mismatch commonly occurs when the browser locale differs from the Dynamics 365 user settings.

### Cause 2: Daylight saving time (DST) transition

Bookings you create during a DST transition period (for example, scheduling April bookings in March) can display shifted times because the schedule board applies the current UTC offset instead of the target date's offset.

### Cause 3: Time zone configuration mismatch

The user's time zone in Dynamics 365 personalization settings doesn't match the schedule board's time zone setting.

## Resolution

### Resolution for Cause 1: Align date and time format settings

1. Sign in to your Dynamics 365 Field Service app (for example, `https://<your-org>.crm.dynamics.com`).
2. Select the **Settings** (gear icon) in the upper-right corner, and then select **Personalization Settings**.
3. On the **Formats** tab, verify the **Date Format** and **Time Format** match your region.
4. Ensure the browser's language and locale setting matches the Dynamics 365 format settings.
5. Select **OK** to save the settings, and then refresh the schedule board page.

### Resolution for Cause 2: DST-related time shifts

This behavior occurs during daylight saving time transitions. To verify:

1. Open the booking record directly (not via the schedule board) and check the **Start Time** and **End Time** fields.
2. If the booking record shows correct times but the board shows shifted times, the issue is in the board's rendering.
3. Go to a date after the DST transition date on the schedule board — bookings after the transition should render correctly.

> [!NOTE]
> If this problem affects many bookings, consider rescheduling them by using the schedule assistant after the DST transition occurs.

### Resolution for Cause 3: Align time zone settings

1. Sign in to your Dynamics 365 Field Service app (for example, `https://<your-org>.crm.dynamics.com`).
2. Select the **Settings** (gear icon) in the upper-right corner, and then select **Personalization Settings**.
3. On the **General** tab, verify the **Time Zone** is set correctly for your location.
4. Select **OK** to save.
5. In the Field Service app, go to **Scheduling** > **Schedule Board**.
6. On the schedule board, select the **...** (horizontal ellipsis on top-right) > **Scheduler settings** on the active board tab to open board view settings, and then check the board's time zone setting.
7. Ensure both the user personalization time zone and the board tab time zone match.

## More information

- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
- [Use the schedule board in Field Service](/dynamics365/field-service/work-with-schedule-board)
