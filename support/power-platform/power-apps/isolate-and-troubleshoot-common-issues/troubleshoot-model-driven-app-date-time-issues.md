---
title: Troubleshoot date and time issues in model-driven apps
description: Helps troubleshoot date and time issues in Power Apps model-driven apps.
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
# Troubleshoot date and time issues in model-driven apps

When date and time values are off by a day or a few hours, it might be caused by time zone or daylight saving adjustments. This article provides tips to troubleshoot issues such as:

- The **Date and Time** field shows the wrong value.
- The **Date only** value shows the wrong date for some users and time zones.
- The **Date and Time** field shows the correct value in some parts of the app, but not others.
- After changing a date and time value and saving it, it changes automatically to a different value.
- Entering a daylight saving switchover date results in the date being off by one day or the time being off by an hour.

## Determine if it's a server or client issue

Model-driven apps are web apps. They get data from the Dataverse cloud service (server). The same data can power multiple apps (clients). Errors can occur on the server or client.

If the date and time value stored on the server is unexpected, it will likely appear incorrectly in all apps regardless of user or system time zone. Therefore, verifying the server value is an important first step.

#### Check the configuration of the date and time column

Dataverse supports different time zone adjustment behaviors for [date and time columns](/power-apps/maker/data-platform/behavior-format-date-time-field#date-and-time-column-behavior-and-format) (fields). Before troubleshooting, it's important to [understand how different parts of the system process date and time values](/power-apps/maker/data-platform/behavior-format-date-time-field).

[Check the date and time column options](/power-apps/maker/data-platform/create-edit-fields) in the [Power Apps portal](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) or solution explorer:

- Whether it accounts for a user's time zone
- Whether it displays the time part of the value

#### Check if the correct value is stored on the server

Date and time values are always stored as UTC on the server. You can view the raw value on the server with a [Web API query](/power-apps/developer/data-platform/webapi/query-data-web-api).

Here's a query to get a column for a row (record).

```http
[Organization URI]/api/data/v9.2/<entity set name>(<row id>)?$select=<column name>
```

The table and column names used are [logical names](/power-apps/developer/data-platform/entity-metadata#table-names), not display names.

> [!TIP]
> An easy way to find the ID of a row is to open it in a model-driven app. The ID can be found in the page URL.

The following example gets the `scheduledstart` column of the `appointment` table for the row with ID `d2862246-4763-ee11-8def-000d3a34118b`.

```http
https://myorg.crm.dynamics.com/api/data/v9.2/appointments(d2862246-4763-ee11-8def-000d3a34118b)?$select=scheduledstart
```

Entering this in the browser address bar will show something like the following:

```json
{
    "@odata.context": "https://myorg.crm.dynamics.com/api/data/v9.2/$metadata#appointments(scheduledstart)/$entity",
    "@odata.etag": "W/\"11472725\"",
    "scheduledstart": "2023-10-15T07:30:00Z",
    "activityid": "d2862246-4763-ee11-8def-000d3a34118b"
}
```

Therefore, the `scheduledstart` of the `appointment` is October 15th, 2023, 7:30 am. The `Z` at the end indicates that the value is in UTC.

Let's say a user in the time zone UTC-8 views this column in a model-driven app. These are the expected values for the different column options.

| Time zone adjustment behavior | Format | Value shown in the app |
| -------- | ------ | ---------------------- |
| User Local | Date and time | October 14th, 2023, 11:30 pm |
| User Local | Date only | October 14th, 2023 |
| Time-Zone Independent | Date and time | October 15th, 2023, 7:30 am |
| Time-Zone Independent | Date only | October 15th, 2023 |
| Date only | - | October 15th, 2023 |

If the value shown in the app isn't adjusted correctly, it's likely a client issue. If the server value is incorrect to begin with, it's likely a server issue.

#### Check the formatted value from the server

Time zone and daylight saving adjustments can be done on the server or in the app. If the same column shows a different value in different parts of the app, it's likely that some parts of the app are using the formatted value from the server, while others are making the adjustments in the app.

This is likely an issue. Before reporting it, you can isolate whether it's a server or client issue by [checking the formatted value from the server](/power-apps/developer/data-platform/webapi/query-data-web-api#formatted-values).

For example,

```http
GET https://myorg.crm.dynamics.com/api/data/v9.2/appointments(d2862246-4763-ee11-8def-000d3a34118b)?$select=scheduledstart
Accept: application/json
OData-MaxVersion: 4.0
OData-Version: 4.0
Prefer: odata.include-annotations="OData.Community.Display.V1.FormattedValue"
```

The response will include the value adjusted by the server. In this example, the user is in the UTC-8 time zone, and `scheduledstart` has **User Local** behavior. Therefore, the formatted value is eight hours behind the raw value.

```json
{
    "@odata.context": "https://myorg.crm.dynamics.com/api/data/v9.2/$metadata#appointments(scheduledstart)/$entity",
    "@odata.etag": "W/\"11472725\"",
    "scheduledstart@OData.Community.Display.V1.FormattedValue": "10/14/2023 11:30 PM",
    "scheduledstart": "2023-10-15T07:30:00Z",
    "activityid": "2ad8786a-9164-ee11-9ae7-0022480a0700"
}
```

If this formatted value is incorrect, it's a server issue. If it's correct, then it's a client issue.

#### Investigate unexpected server values

Possible reasons for unexpected server values are:

- You might not have configured the time zone adjustment behavior and format correctly.
- [Business rules](/power-apps/maker/data-platform/data-platform-create-business-rule) and [workflows](/power-apps/maker/data-platform/overview-realtime-workflows) running on the server can change the value before or after it's saved. Inside an app, [client scripts](/power-apps/developer/model-driven-apps/client-scripting) can change the value before sending it to the server for saving.

## Determine if it's a customization issue or product issue

[Customizations](isolate-model-app-issues.md#remove-customizations) can lead to unexpected behavior. The following methods can help rule out problems caused by customizations.

#### Disable custom scripts

Custom scripts frequently cause issues. Try [disabling them temporarily](isolate-model-app-issues.md#client-scripts).

#### Create a new date and time column

Creating a new date and time column is the easiest way to find out if the issue is caused by configuration errors or customizations like business rules. Ideally, use a different table and app.

If the new column works as expected, it's likely a customization issue. Compare with the original column to find the difference.

If the new column has the same problem, it might be a product issue. You can [create a vanilla repro model-driven app](vanilla-model-driven-app-repro.md) and report it through a [support request](/power-platform/admin/get-help-support).

## Try a different time zone

To find out if time zone and daylight saving adjustments are causing unexpected values, try changing the user's time zone.

There are two settings that affect time zones in model-driven apps:

1. Time zone in [personal options](/power-apps/user/set-personal-options#general-tab-options).
2. System time zone. For information on how to change it, see the respective documentation in Windows, Android, iOS, or macOS.

Useful combinations to try:

- Match the time zone in personal options with the system time zone.
- Use UTC time zone.
- Use a time zone with the same offset, but doesn't observe daylight saving.

> [!TIP]
> The following methods provide more details to make it easier to investigate date and time issues.
>
> - [Change the "Date Only" format to "Date and Time"](#change-the-date-only-format-to-date-and-time)
> - [Don't use 2-digit years](#dont-use-2-digit-years)

## Change the "Date Only" format to "Date and Time"

If a date-only value is off by a day, it's helpful to show the time part to see if time zone adjustments could be the cause. You can temporarily [change the column format](/power-apps/maker/data-platform/create-edit-fields) in the [Power Apps portal](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) or solution explorer.

## Don't use 2-digit years

The 2-digit year is ambiguous. For example, 40 might mean 1940, 2040, or 2140. How the system interprets 2-digit years can and will likely change over time.

It's also difficult to investigate when the complete date and time values aren't shown. For these reasons, it's strongly recommended to use 4-digit years, especially when entering dates.

If you can't switch to 4-digit years permanently, try it temporarily to help troubleshoot.

## See also

[Behavior and format of the Date and Time column](/power-apps/maker/data-platform/behavior-format-date-time-field)
