---
title: How to customize or format Date and Time values in a flow
description: Introduces how to customize or format date and time (for example, DateTime) values in a flow.
ms.reviewer: 
ms.topic: how-to
ms.date: 3/31/2021
---
# How to customize or format Date and Time values in a flow

This article provides steps to customize or format Date and Time values in a flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4534778

## Scenario

When working with date and time values (for example, DateTime values) in flow, they may look like:

- 2019-12-06T22:47:23.0798367Z
- 2009-06-15T13:45:30Z

You may format these values to look like:

- 6/15/2009 1:45 PM
- Monday, June 15, 2009

This is done by using **Date and Time Format Strings** passed to the `formatDateTime()` function.

## Format strings

A standard format string is a single character (for example, `'d'`, `'g'`, `'G'`, this is case-sensitive) that corresponds to a specific pattern.

For example, the format string `'g'` corresponds to the General date/time pattern (short time):

- `formatDateTime('2009-06-15T13:45:30', 'g') -> 6/15/2009 1:45 PM`

A custom format string is any string with more than one character (for example, `'M/dd/yyyy h:mm tt'`) that can control the visibility, positioning, precision of the month, day, hour, second etc. of the DateTime value.

For example, the format string `'M/dd/yyyy h:mm tt'` represents the same pattern as the standard format string `'g'` as described above:

- `formatDateTime('2009-06-15T13:45:30', 'M/dd/yyyy h:mm tt') -> 6/15/2009 1:45 PM`

See the [Resources](#resources) section in this article for more information about available standard format patterns and how to construct a custom format string.

## Example steps

1. Select the input field where you want the formatted DateTime value.
2. Go to the expression editor (go to Add dynamic content > select the **Expression** tab).
3. Type *formatDateTime()* (or look under **Date and time** functions).
4. Provide the value (can be dynamic content) to be formatted (surrounded by single quotes).
5. Provide the format string (surrounded by single quotes).
6. The full expression should look like:

   `formatDateTime('<your-value>', 'dd/MM/yyyy hh:mm tt')`

7. Select **Ok**.

## Resources

- [Standard date and time format strings](/dotnet/standard/base-types/standard-date-and-time-format-strings#Resources#Resource)
- [Custom date and time format strings](/dotnet/standard/base-types/custom-date-and-time-format-strings)
