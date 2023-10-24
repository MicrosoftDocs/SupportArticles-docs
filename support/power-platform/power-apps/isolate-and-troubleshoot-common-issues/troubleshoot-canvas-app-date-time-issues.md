---
title: Troubleshoot date and time issues in canvas apps
description: Helps troubleshoot date and time issues in Power Apps canvas apps.
author: tahoon
ms.date: 10/23/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# Troubleshoot date and time issues in Power Apps canvas apps

When date and time values are off by a day or a few hours, it might be caused by time zone or daylight saving adjustments. This article provides tips to troubleshoot issues such as:

- The **Date and Time** field shows UTC instead of local time or vice versa.
- The **Date Only** value shows the wrong date for some users and time zones.
- Entering a daylight saving switchover date results in the date being off by one day or the time being off by an hour.

## Determine if it's a server or client issue

Canvas apps are web apps. They get data from cloud services (servers). The same data can power multiple apps (clients). Errors can occur on the server or client.

If the date and time value in the data source is unexpected, it will likely appear incorrectly everywhere and not just in canvas apps. Therefore, verifying the stored value is an important first step.

#### Check if the correct value is stored on the server

Date and time values are usually stored as UTC. For Dataverse tables, you can [view the raw date and time value with a Web API query](troubleshoot-model-driven-app-date-time-issues.md#check-if-the-correct-value-is-stored-on-the-server). For other data sources like Microsoft List or Excel, see their respective documentation.

#### Check the time zone adjustment settings of the data source and Date Picker control

Some data sources have already been adjusted for time zones. In addition, the [Date Picker control](/power-apps/maker/canvas-apps/controls/control-date-picker) can also adjust time zones with its **DateTimeZone** property.

A common mistake is mismatching the data source and control settings. For example, when a Dataverse table column is **[Time-Zone Independent](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format)**, but the Date Picker's **DateTimeZone** is set to **Local**, the UTC value from the server will be displayed according to the user's time zone. The reverse is also true. A **User Local** value from Dataverse will be displayed as UTC when the **DateTimeZone** is set to **UTC**.

Note that this potential conflict doesn't occur with model-driven apps because it's impossible to customize time zone handling for individual controls.

## Try a different time zone

To find out if time zone and daylight saving adjustments are causing unexpected values, try changing the user's time zone.

Canvas apps use the system time zone. For information on how to change it, see the respective documentation in Windows, Android, iOS, or macOS.

> [!TIP]
> The following methods provide more details to make it easier to investigate date and time issues.
>
> - [Show the user's time zone](#show-the-users-time-zone)
> - [Change the "Date Only" format to "Date and Time"](#change-the-date-only-format-to-date-and-time)
> - [Don't use 2-digit years](#dont-use-2-digit-years)

## Show the user's time zone

You can verify the user's time zone with the [TimeZoneOffset function](/power-platform/power-fx/reference/function-dateadd-datediff). It gives the number of minutes between UTC and the user's time zone. For example, if the user is in Pacific Standard Time, it will return **480**. This is the same offset that the Date Picker control and Power Fx use to adjust time zones and daylight savings.

With this offset, you can calculate whether the date and time values have been adjusted correctly.

## Change the "Date Only" format to "Date and Time"

If a date-only value is off by a day, it's helpful to show the time part to see if time zone adjustments could be the cause.

## Don't use 2-digit years

The 2-digit year is ambiguous. For example, 40 might mean 1940, 2040, or 2140. How the system interprets 2-digit years can and will likely change over time.

It's also difficult to investigate when the complete date and time values aren't shown. For these reasons, it's strongly recommended to use 4-digit years, especially when entering dates.

## Common issues with Dataverse Date and Time columns

#### "Date Only" column shows the wrong date for some users

This issue can occur for [Time-Zone Independent and User Local adjustment behaviors](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format), which always have a time component. Time zone adjustments, either by Dataverse or the canvas app, can move the date forward or backward by a day.

To solve this issue, show the time component of the value and [check for time zone adjustment settings](#check-the-time-zone-adjustment-settings-of-the-data-source-and-date-picker-control).

#### Form shows a time picker for a column even though its format is "Date Only"

This issue can occur for [Time-Zone Independent and User Local adjustment behaviors](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format), which always have a time component. If you add such a column to a form, the form will assume that you also need a time.

If you don't want users to see or edit the time component of the value,

- Remove the time picker.
- For **User Local** columns that don't need time zone adjustments, change their adjustment behavior to **Date Only**.

  > [!NOTE]
  > This is different from the **Date Only** format. This is a permanent change and can't be undone. Other apps, plugins, or workflows that previously adjusted the column for time zones might not work correctly.

#### See also

[Behavior and format of the Dataverse Date and Time column](/power-apps/maker/data-platform/behavior-format-date-time-field)
