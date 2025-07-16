---
title: KB2998527 Causes Wrong Code Lookups on Past Dates
description: This article explains how update 2998527 causes incorrect code lookups on past dates when an application uses TimeZoneInfo.
ms.date: 07/08/2025
ms.reviewer: leecow
ms.custom: sap:Class Library Namespaces
ms.topic: troubleshooting-problem-resolution
#customer intent: As a developer, I want to fix incorrect code lookups on past dates when I use the TimeZoneInfo class so that my application handles time zones correctly.
---
# Update 2998527 causes incorrect code lookups on past dates

This article explains a problem in [Microsoft Knowledge Base article 2998527](https://support.microsoft.com/help/2998527) that causes incorrect code lookups on past dates when you use the `TimeZoneInfo` class in an application.

_Applies to:_ .NET Framework 4.6, 4.5

_Original KB number:_ 3012229

## Symptoms

After October 26, 2014, applications that are hosted on systems that have the September 2014 Russian time zone update ([KB 2998527](https://support.microsoft.com/help/2998527)) installed and that use Microsoft .NET Framework might calculate time incorrectly when they use the `TimeZoneInfo` class.

This problem occurs in the following time zones:

- (UTC-04:30) Caracas
- (UTC+01:00) Windhoek
- (UTC+02:00) Kaliningrad (RTZ 1)
- (UTC+02:00) Tripoli
- (UTC+03:00) Minsk
- (UTC+03:00) Moscow, St. Petersburg, Volgograd (RTZ 2)
- (UTC+05:00) Ekaterinburg (RTZ 4)
- (UTC+06:00) Novosibirsk (RTZ 5)
- (UTC+07:00) Krasnoyarsk (RTZ 6)
- (UTC+08:00) Irkutsk (RTZ 7)
- (UTC+09:00) Yakutsk (RTZ 8)
- (UTC+10:00) Magadan
- (UTC+10:00) Vladivostok, Magadan (RTZ 9)
- (UTC+13:00) Samoa

Consider the following C# example code:

```csharp
TimeZoneInfo tz = TimeZoneInfo.FindSystemTimeZoneById("Russian Standard Time");
DateTime dt = TimeZoneInfo.ConvertTimeFromUtc(new DateTime(2013, 6, 1), tz);
Console.WriteLine(dt);
```

Before you apply KB 2998527, this code correctly returns the date and time as June 1, 2013 at 04:00. After you apply the update, the code returns the date and time incorrectly as June 1, 2013 at 03:00.

## Cause

This problem occurs because a change in the base offset of a time zone breaks any code in the affected time zones if that code looks up past dates by using `TimeZoneInfo` in .NET Framework. This problem occurs because .NET Framework can't track year-to-year changes in the base offset.

This problem was exposed by the changes to Russian time zones that are described in KB 2998527.

Previously, .NET Framework ignored the UTC offset that's set in an internal adjustment rule. Instead, it used the base UTC offset in certain calculations. .NET Framework also ignored adjustment rules that don't have daylight transitions.

## Solution

If your .NET application uses `TimeZoneInfo`, update it to use the latest Windows time zone information. If applicable, you should also make sure that your application correctly handles the latest time zone rules for Russia.

## Related content

- [Time zone changes for Russia in Windows](https://support.microsoft.com/topic/time-zone-changes-for-russia-in-windows-43f3d691-0bab-eb64-3ec1-6451d148194c)
