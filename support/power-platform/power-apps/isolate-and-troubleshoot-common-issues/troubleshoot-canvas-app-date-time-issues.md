---
title: Troubleshoot date and time issues in canvas apps
description: Learn about techniques to troubleshoot date and time issues in canvas apps.
author: tahoon
ms.date: 10/10/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---

# Troubleshoot date and time issues in canvas apps

When date and time values are off by a day or a few hours, it might be caused by time zone or daylight savings adjustments. This article provides tips to troubleshoot issues such as:

- Date and time field displays as UTC or local instead of the opposite.
- Date only value shows the wrong date for some users and time zones.
- Entering a daylights savings switchover date results in the date being off by one day or the time being off by an hour.

## Find out if it's a server or client issue

Canvas apps are web apps. They get data from cloud services (servers). This same data can power multiple apps (clients). Errors can happen on the server or client.

If the date and time value in the data source is unexpected, it'll likely display incorrectly everywhere and not just canvas apps. Therefore, verifying the stored value is an important first step.

### Check if the correct value is stored on the server

Date and time values are usually stored as UTC. For Dataverse tables, you can [view the raw date and time value with a Web API query](troubleshoot-model-driven-app-date-time-issues#check-if-the-correct-value-is-stored-on-the-server). For other data sources like Microsoft List or Excel, refer to their respective documentation.

### Check time zone adjustment settings of the data source and the Date picker control

Some data sources already adjust for time zones. In addition, the [Date picker control](/power-apps/maker/canvas-apps/controls/control-date-picker) can also adjust for time zones with its **DateTimeZone** property.

A common error is to have mismatched settings for both the data source and control. For example, when a Dataverse table column is **[Time-Zone Independent](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format)**, but the Date picker's **DateTimeZone** is set to **Local**, the UTC value from the server will be displayed according to the user's time zone. The reverse is also true. A **User Local** value from Dataverse will be displayed as UTC when the **DateTimeZone** is set to **UTC**. 

Note that this potential conflict doesn't occur with model-driven apps because it's not possible to customize time zone handling for individual controls.


## Try a different time zone

To find out if time zone and daylight savings adjustments are causing unexpected values, try changing the time zone of the user.

Canvas apps use the system time zone. Refer to respective documentation in Windows, Android, iOS, or macOS on how to change it.


## Make it easy to investigate

It's easier to investigate date and time issues when more details are shown.

### Show the user's time zone

You can verify the user's time zone with the [TimeZoneOffset function](/power-platform/power-fx/reference/function-dateadd-datediff). It gives the number of minutes between UTC and the user's time zone. For example, if the user is in Pacific Standard Time, it'll return 480. This is the same offset that the Date picker control and Power Fx uses to adjust for time zones and daylight savings.

With this offset, you can calculate whether date and time values have been adjusted correctly.

### Change Date only format to Date and time

If a date-only value is off by a day, it's helpful to show the time part as well to see if time zone adjustments could be the cause.

### Don't use 2-digit years

2-digit years are ambiguous. For example, 40 could mean 1940, 2040, or 2140. How the system interprets 2-digit years can, and will likely change over time.

It's also difficult to investigate when the full date and time value is not shown. For these reasons, it's strongly recommended to use 4-digit years, especially when entering dates.


## Common issues with Dataverse date and time columns

### Date only column shows the wrong date for some users

This can happen for [Time-Zone Independent and User Local adjustment behaviors](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format), which always have a time component. Time zone adjustments either by Dataverse or the canvas app can push the date forward or backward by a day.

To troubleshoot, show the time component of the value and check for time zone adjustment settings, as explained earlier.

### Form shows time picker for a column even though its format is Date only

This can happen for [Time-Zone Independent and User Local adjustment behaviors](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format), which always have a time component. If you add such a column to a form, the form will assume that you'll need a time as well.

If you don't want users to see or edit the time component of the value,

* Remove the time picker.
* For User Local columns that have don't actually need time zone adjustments, change their adjustment behavior to **Date only**. Note that this is different from **Date only** _format_. This is a permanent change and cannot be undone. Other apps, plugins, or workflows that previously adjusted the column for time zones may not work correctly.


### See also

- [Behavior and format of the Dataverse Date and Time column](/power-apps/maker/data-platform/behavior-format-date-time-field)
