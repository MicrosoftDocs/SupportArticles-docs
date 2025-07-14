---
title: KB2998527 causes wrong code lookups on past dates
description: This article explains the problem where update 2998527 causes incorrect code lookups on past dates when the application use TimeZoneInfo.
ms.date: 07/08/2025
ms.reviewer: leecow
ms.custom: sap:Class Library Namespaces
ms.topic: troubleshooting-known-issue

#customer intent: As a developer, I want to learn about known issues with the TimeZoneInfo class so I can account for them in my application design.
---
# Known issues: .NET Framework

This article explains the problem where [KB 2998527](https://support.microsoft.com/help/2998527) causes incorrect code lookups on past dates when you use the `TimeZoneInfo` class in an application.

_Applies to:_ .NET Framework 4.6, 4.5

_Original KB number:_ 3012229

## Update 2998527 causes incorrect code lookups on past dates

After October 26, 2014, applications that are hosted on systems that have the September 2014 Russian time zone update ([KB 2998527](https://support.microsoft.com/help/2998527)) installed and that use the Microsoft .NET Framework might calculate time incorrectly when they use the `TimeZoneInfo` class.

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

For example, before you apply KB 2998527, this code correctly returns the date and time as June 1, 2013 at 04:00. After you apply the update, the code incorrectly returns the date and time as June 1, 2013 at 03:00.

### Troubleshooting steps

Microsoft is researching this problem and will post more information in this article when the information becomes available. A new update is planned that will update the .NET Framework to correctly use UTC offsets and adjustment rules for all-time zones.

We recommend that you install both update 2998527 and the new update when it's available. This will make sure that UTC offset rules are used correctly for all past years and all years going forward.

### Possible causes

This problem occurs because a change in the base offset of a time zone breaks any code in the affected time zones if that code looks up past dates by using `TimeZoneInfo` in the .NET Framework. This is because the .NET Framework can't track year-to-year changes in the base offset.

This problem was exposed by the recent changes to Russian time zones that are described in Microsoft Knowledge Base article 2998527.

The .NET Framework previously ignored the UTC offset that is set in an internal adjustment rule. Instead, it used the base UTC offset in certain calculations. The .NET Framework also ignored adjustment rules that don't have daylight transitions.
