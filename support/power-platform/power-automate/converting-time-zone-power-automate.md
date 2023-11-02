---
title: Converting time zone in Power Automate
description: Provides a solution to an issue where you find a datetime in the wrong time zone in Microsoft Power Automate.
ms.reviewer: anaggar
ms.date: 11/02/2023
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

1. Add the required and optional inputs for the **Convert time zone** operation.

   - **Base time**: The datetime you wish to convert.
   - **Source time zone**: The time zone that the datetime is currently in.
   - **Destination time zone**: The time zone you want to convert your date to.
   - **Format string** (optional): The string that specifies the desired format of the converted time.

   See the [More information](#more-information) section for ways to find the current time zone.

   :::image type="content" source="media/converting-time-zone-power-automate/required-inputs.png" alt-text="Screenshot of the required inputs in the Convert time zone operation." border="false":::

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

**Example 1**: This example converts a time zone to the specified time zone and format.

```console
convertTimeZone('2018-01-01T80:00:00.0000000Z', 'UTC', 'Pacific Standard Time', 'D')
```

It returns the result: `Monday, January 1, 2018`.

**Example 2**: This is an example of using dynamic content in the expression. Here, the `triggerBody()?['Date']` timestamp is the dynamic content you want to format. The source time zone is `UTC`. The destination time zone is `Eastern Standard Time`. The format is the custom format string `HH:mm`.

```console
convertTimeZone(triggerBody()?['Date'],'UTC','Eastern Standard Time','HH:mm')
```

For more information about this expression function, see [convertTimeZone](/azure/logic-apps/workflow-definition-language-functions-reference#convertTimeZone).

For more information about the format string parameter, see [standard date and time format strings](/dotnet/standard/base-types/standard-date-and-time-format-strings) and [custom date and time format strings](/dotnet/standard/base-types/custom-date-and-time-format-strings).

## More information

#### Decipher a datetime

- Datetimes might have different formats. If your datetime has a `Z` at the end, it means it's in UTC time.

  For example: `2020-04-10T01:28:14.0406387Z`

- You might receive an error that states your date time string isn't in the correct format. For example:

  > The date time string must match ISO8601 format.

  For more information about how to correctly format your datetime string, see [convertTimeZone](/azure/logic-apps/workflow-definition-language-functions-reference).

#### Check the time zone of an output

If you're unsure what format the datetime time zone is currently in, you can run your flow and see the datetime output format.

In this example, the **Get forecast for today** operation outputs the timestamp for when you got the forecast.

:::image type="content" source="media/converting-time-zone-power-automate/get-forest-today.png" alt-text="Screenshot shows an example of checking the datetime output format.":::

This datetime uses the ISO-8601 datetime format. This operation outputs the datetime in the UTC time zone.

#### Convert a timestamp to or from UTC

To convert a timestamp from the source time zone to UTC or from UTC to the target time zone, use the [convertFromUtc](/azure/logic-apps/workflow-definition-language-functions-reference#convertfromutc) and [convertToUtc](/azure/logic-apps/workflow-definition-language-functions-reference#converttoutc) expression functions.

## Limitations

There might be limitations in some connectors on how the time zone is displayed. For more information on each connector, see [Connector reference overview](/connectors/connector-reference/).

## References

- [How to customize or format Date and Time values in a flow](how-to-customize-or-format-date-and-time-values-in-flow.md)
- [Reference guide to workflow expression functions in Azure Logic Apps and Power Automate](/azure/logic-apps/workflow-definition-language-functions-reference)
