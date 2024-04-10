---
title: Incorrect date value from standard time to DST
description: Describes an Internet Explorer issue that occurs during construction of a JavaScript Date object for dates when Daylight Saving Time (DST) begins or ends.
ms.date: 04/20/2020
---
# Error in Date value at beginning of DST in certain time zones

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes the error report when converting from standard time to Daylight Saving Time (DST) and provides a solution.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 2410734

## Symptoms

When you use the `JavaScript Date` object to compute dates under certain circumstances, users may see results that are apparently incorrect. This behavior occurs when the following conditions are true:

- The time zone configured in **Date and Time Settings** transitions from standard time to DST at midnight.
- Date arithmetic uses `Date` objects without hours and minutes (or hours and minutes using 0), and only uses dates that transition from standard time to DST.

For example, trying to construct a Date of 10/17/2010 yields a date of 10/16:

```js
var dt = new Date(2010, 9,17);
// ...
console.log(dt.toString()); // evaluates to 'Sat Oct 16 23:00:00 UTC-0300 2010'
dt.getDate(); // evaluates to 16
```

## Cause

This is a specific instance of a problem that occurs when a `Date()` object is initialized to exactly the time when DST begins.

The values that are used to construct the `Date` object represent a time after the point where standard time ends, but earlier than a local clock would show after DST has begun. The European Computer Manufacturers Association Script (ECMAScript) Language specification specifies that a DST adjustment of 1 hour is subtracted when calculating the time value, the internal representation of the `Date` object. However, this ends up representing a time before DST would begin. In the case of Brazil, this occurs at midnight, and therefore the `Date` object ends up representing a time from the previous day.

## Resolution

This behavior conforms to the ECMAScript standard, and it is therefore by design.

When you are concerned only with the day, month, and year, you can work around this behavior by constructing date objects by using an hours value that is not zero-that is, an hours value that is safely larger than the daylight saving time adjustment.

## More information

The ECMAScript standard can be found at [ECMAScript&reg; 2016 Language Specification](https://www.ecma-international.org/ecma-262/7.0/index.html).

[Section 20.3.2](https://www.ecma-international.org/ecma-262/7.0/index.html#sec-date-constructor) defines how the Date constructor is interpreted, including the fact of a conversion of a time value to Coordinated Universal Time (UTC).

[Section 20.3.1.10](https://www.ecma-international.org/ecma-262/7.0/index.html#sec-utc-t) defines the conversions between local time and UTC time, and states that these conversions are not necessarily inverses of each other.

The formula for this conversion is as follows:

```console
UTC( t ) = t - LocalTZA - DaylightSavingTA(t - LocalTZA)
```

If you follow this through for the start of DST, you can see how the hour gets subtracted. This example is for pacific time, so the actual date isn't changed. Start with:

```console
t = <Sun Mar 13 02:00:00 Pacific 2011>
LocalTZA = -8
The expression t - LocalTZA occurs twice in this equation; it evaluates to <Sun Mar 13 10:00:00 UTC 2011>. This is the exact moment when DST starts in the Pacific time zone. This is the key fact during conversion of this time to UTC:
UTC( <Sun Mar 13 02:00:00 Pacific 2011> )
= <Sun Mar 13 02:00:00 Pacific 2011> - LocalTZA - DaylightSavingTA( <Sun Mar 13 02:00:00 Pacific 2011> - LocalTZA )
= <Sun Mar 13 10:00:00 UTC 2011> -DaylightSavingTA( <Sun Mar 13 10:00:00 UTC 2011> )
= <Sun Mar 13 10:00:00 UTC 2011>- 1
= <Sun Mar 13 9:00:00 UTC 2011>
```
