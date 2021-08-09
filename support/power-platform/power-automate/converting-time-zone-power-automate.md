---
title: Converting time zone in Power Automate
description: Provides a solution to an issue where you find a datetime in the wrong time zone.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Converting time zone in Microsoft Power Automate

This article provides a solution to an issue where you find a datetime in the wrong time zone.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4557244

## Symptoms

When you're passing datetimes through triggers and actions in Microsoft Power Automate, users may find a datetime in the wrong time zone. Users may wish to convert the time zone (frequently in UTC) to their local time.

## Cause

It's because of services passing dates through in varying formats or time zones. Each connector may use a different datetime format or time zone.

Some services use strictly UTC time to avoid confusion.

## Resolution

There are two ways to solve it - via an action or an expression.

### Using the action

Power Automate has a built-in operation called **Convert time zone**.

Search for **convert time zone** and choose the **Convert time zone** operation.

:::image type="content" source="media/converting-time-zone-power-automate/search-convert-time-zone.png" alt-text="Search convert time zone action in Power Automate.":::

The **Convert time zone** operation has a few required inputs:

:::image type="content" source="media/converting-time-zone-power-automate/required-inputs.png" alt-text="Required inputs in Convert time zone operation.":::

**Base time**: The datetime you wish to convert.
**Source time zone**: The time zone that the datetime is currently in.
**Destination time zone**: The time zone you want to convert your date to.

See the [Notes](#notes) below for ways to find the current time zone.

### Using the expression

Power Automate has an expression function for converting time zone.

:::image type="content" source="media/converting-time-zone-power-automate/expression-function.png" alt-text="Convert time zone expression in Power Automate.":::

```console
convertTimeZone(timestamp: string, sourceTimeZone: string, destinationTimeZone: string, format?: string)
Required. A string that contains the time.
Converts a string timestamp passed in from a source time zone to a target time zone
```

You'll need to pass in the following ones:

**timestamp**: The datetime you wish to convert.
**sourceTimeZone**: The time zone the datetime is currently in.
**destinationTimeZone**: The time zone you want to convert your date to.
**format** (optional): The format of the time zone you wish to convert your date to.

For example:

```console
convertTimeZone(triggerBody()?['Date'],'UTC','Eastern Standard Time','HH:mm')
```

Here, timestamp is `"triggerBody()?['Date']"`, the source time zone is `UTC`, the destination time zone is `Eastern Standard Time`, and the format is `HH:mm`.

For more information about this expression function, see the [convertTimeZone](/azure/logic-apps/workflow-definition-language-functions-reference#convertTimeZone).

## Notes

**Deciphering a datetime**  
Datetimes may come in different formats.

If your datetime has a **Z** at the end, it means it's in UTC time.

For example: 2020-04-10T01:28:14.0406387Z

For more information about datetime formats, see [Standard date and time format strings](/dotnet/standard/base-types/standard-date-and-time-format-strings).

You may get errors where your date time string isn't in the correct format. For example:

> "The date time string must match ISO8601 format".

For more information about how to correctly format your datetime string, see the [formatDateTime](/azure/logic-apps/workflow-definition-language-functions-reference#formatDateTime)

**Checking the time zone of an output**  
If you're unsure what the datetime time zone is currently in, you can run your flow to take a look out the datetime output format.

In this example, the **Get forecast for today** operation outputs the timestamp for when we got the forecast.

:::image type="content" source="media/converting-time-zone-power-automate/get-forest-today.png" alt-text="Convert time zone example in Power Automate.":::

This datetime is using the ISO-8601 datetime format. We can see that this operation outputs the datetime in the UTC timezone.

## Limitations

There may be limitations in some connectors on how the time zone is displayed. For more information on each connector, see [Connector reference overview](/connectors/connector-reference/).
