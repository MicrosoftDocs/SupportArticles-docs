---
title: Converting time zone in Power Automate
description: Provides a solution to an issue where you find a datetime in the wrong time zone.
ms.reviewer: anaggar
ms.date: 09/28/2023
ms.subservice: power-automate-connections
---
# Converting time zone in Microsoft Power Automate

This article provides steps to convert the time zone to the intended time zone in a Power Automate trigger or action.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4557244

## Symptoms

When passing datetimes through triggers and actions in Power Automate flows, you might find that the time zone isn't what you expected, or you might wish to convert the time zone (frequently in Coordinated Universal Time (UTC)) to your local time. You can do this using the **Convert time zone** action or the `convertTimeZone` expression.

Dates are passed through services in varying formats or time zones, so each connector might use a different datetime format or time zone. Some services strictly use UTC time to avoid confusion.

## Convert time zone using an action

Power Automate has a built-in operation called **Convert time zone**.

1. Type _convert time zone_ in the Search box and choose the built-in **Convert time zone** operation.

   :::image type="content" source="media/converting-time-zone-power-automate/search-convert-time-zone.png" alt-text="Screenshot to search for the convert time zone action in Power Automate.":::

2. Add the required inputs for the **Convert time zone** operation.

   - **Base time**: The datetime you wish to convert.
   - **Source time zone**: The time zone that the datetime is currently in.
   - **Destination time zone**: The time zone you want to convert your date to.

   See the [More information](#more-information) section for ways to find the current time zone.

   :::image type="content" source="media/converting-time-zone-power-automate/required-inputs.png" alt-text="Screenshot of the required inputs in the Convert time zone operation.":::

## Convert time zone using an expression

Power Automate has an expression function `convertTimeZone` that converts a timestamp from the source time zone to the target time zone.

:::image type="content" source="media/converting-time-zone-power-automate/expression-function.png" alt-text="Screenshot shows that Power Automate has an expression function for converting the time zone.":::

```console
convertTimeZone(timestamp: string, sourceTimeZone: string, destinationTimeZone: string, format?: string)
```

The function takes the following parameters:

- `timestamp`: The datetime you wish to convert.
- `sourceTimeZone`: The time zone the datetime is currently in.
- `destinationTimeZone`: The time zone you want to convert your date to.
- `format` (optional): The format of the time zone you wish to convert your date to.

For example:

```console
convertTimeZone(triggerBody()?['Date'],'UTC','Eastern Standard Time','HH:mm')
```

Here, `timestamp` is `"triggerBody()?['Date']"`, the source time zone is `UTC`, the destination time zone is `Eastern Standard Time`, and the format is `HH:mm`.

For more information about this expression function, see the [convertTimeZone](/azure/logic-apps/workflow-definition-language-functions-reference#convertTimeZone).

## More information

**Decipher a datetime**

Datetimes might come in different formats. If your datetime has a **Z** at the end, it means it's in UTC time.

For example: 2020-04-10T01:28:14.0406387Z

For more information about datetime formats, see [Standard date and time format strings](/dotnet/standard/base-types/standard-date-and-time-format-strings).

You may get errors where your date time string isn't in the correct format. For example:

> The date time string must match ISO8601 format.

For more information about how to correctly format your datetime string, see [formatDateTime](/azure/logic-apps/workflow-definition-language-functions-reference#formatDateTime).

**Check the time zone of an output**

If you're unsure what format the datetime time zone is currently in, you can run your flow and see the datetime output format.

In this example, the **Get forecast for today** operation outputs the timestamp for when we got the forecast.

:::image type="content" source="media/converting-time-zone-power-automate/get-forest-today.png" alt-text="Screenshot shows an example of checking the datetime output format.":::

This datetime uses the ISO-8601 datetime format. This operation outputs the datetime in the UTC time zone.

**Convert a timestamp to or from UTC**

To convert a timestamp from the source time zone to UTC or from UTC to the target time zone, use the [convertFromUtc](/azure/logic-apps/workflow-definition-language-functions-reference#convertfromutc) and [convertToUtc](/azure/logic-apps/workflow-definition-language-functions-reference#converttoutc) expression functions.

## Limitations

There might be limitations in some connectors on how the time zone is displayed. For more information on each connector, see [Connector reference overview](/connectors/connector-reference/).

## References

- [How to customize or format Date and Time values in a flow](/troubleshoot/power-platform/power-automate/how-to-customize-or-format-date-and-time-values-in-flow)
- [Reference guide to workflow expression functions in Azure Logic Apps and Power Automate](/azure/logic-apps/workflow-definition-language-functions-reference)
