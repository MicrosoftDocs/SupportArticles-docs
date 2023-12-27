---
title: How to customize or format Date and Time values in a flow
description: Introduces how to customize or format date and time (for example, DateTime) values in a Power Automate flow.
ms.reviewer: wifun
ms.topic: how-to
ms.date: 09/25/2023
ms.subservice: power-automate-admin
---
# How to customize or format Date and Time values in a flow

This article provides steps to customize or format Date and Time values in a Power Automate flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4534778

## Symptoms

When working with date and time values in a Power Automate flow, you might find that the date and time format isn't what you expected, or you might want to customize the format of the output. You can do this by passing format strings to the [formatDateTime()](/azure/logic-apps/workflow-definition-language-functions-reference#formatDateTime) function.

## Format strings

The format string parameter of the `formatDateTime()` function is either a standard format string or a custom format string.

A [standard format string](/dotnet/standard/base-types/standard-date-and-time-format-strings) uses a single character (for example, `d`, `g`, `G`,) as the format specifier.

For example, the format string `g` corresponds to the General date/time pattern (short time):

- `formatDateTime('2009-06-15T13:45:30', 'g')  // Returns the format6/15/2009 1:45 PM`

A [custom format string](/dotnet/standard/base-types/custom-date-and-time-format-strings) is any string with more than one character (for example, `M/dd/yyyy h:mm tt`) that can control the visibility, positioning, precision of the month, day, hour, second and so on of the `DateTime` value.

For example:

- The format string `M/dd/yyyy h:mm tt` represents the same pattern as the standard format string `g` as described above:

  `formatDateTime('2009-06-15T13:45:30', 'M/dd/yyyy h:mm tt') // Returns the format 6/15/2009 1:45 PM`

- The format string `HH:mm:ss tt` returns the 24 hour format:

  `formatDateTime('2009-06-15T13:45:30', 'M/dd/yyyy HH:mm:ss tt') // Returns the format 6/15/2009 13:45:30 PM`

- The format string `hh:mm:ss tt` returns the 12 hour format:

  `formatDateTime('2009-06-15T13:45:30', 'yyyy/MM/dd hh:mm:ss tt') // Returns the format 2009/06/15 1:45:30 PM`

For more information and examples of using standard format strings, see [Standard date and time format strings](/dotnet/standard/base-types/standard-date-and-time-format-strings).

For more information and examples of using custom format strings, see [Custom date and time format strings](/dotnet/standard/base-types/custom-date-and-time-format-strings).

## Example steps

1. In the flow, select the input field where you want to enter the formatted `DateTime` value.
2. Go to **Add dynamic content** and select the **Expression** tab to open the expression editor.
3. Type _formatDateTime()_ (or look for it under **Date and time** functions).
4. Provide the value to be formatted (surrounded by single quotes). Dynamic content can be used but shouldn't be surrounded by single quotes.
5. Provide the format string (surrounded by single quotes).
6. The full expression should look like the following examples:

   - `formatDateTime('<your-value>', 'dd/MM/yyyy hh:mm tt')`
   - `formatDateTime(<dynamic-content>, 'dd/MM/yyyy hh:mm tt')`

7. Select **OK**.

:::image type="content" source="media/how-to-customize-or-format-date-and-time-values-in-flow/formatdatetime-expression.png" alt-text="Screenshot that shows an example of the formatDateTime expression.":::

## References

- [Converting time zone in Power Automate](converting-time-zone-power-automate.md)
- [Format dates by examples](/power-automate/format-data-by-examples#format-dates-by-examples)
