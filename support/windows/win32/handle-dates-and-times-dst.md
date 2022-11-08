---
title: Guidelines for handling dates and times
description: This article describes developer guidelines for date and time handling and includes guidelines to handle daylight saving time (DST).
ms.date: 03/12/2020
ms.custom: sap:System services development
ms.reviewer: jhornick, djanson
ms.topic: how-to
ms.technology: windows-dev-apps-system-services-dev
---
# Handle dates and times that include DST

This article describes how to handle dates and times that include the daylight saving time (DST) and the effect of DST 2007 changes on certain products and technologies.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 932955

## Summary

Developers who write applications that handle dates and times may use one or more technologies that perform date manipulation and time manipulation. In particular, certain base operating system APIs, the C runtime (CRT), and the Microsoft .NET Framework may convert or otherwise manipulate dates and times. This article describes some of the general concepts that are involved in handling dates and times.

## Time storage and manipulation

Timestamps are values that specify a date and time combination. Applications that must handle timestamps typically store those timestamps in Universal Coordinated Time (UTC). The advantage of UTC is that UTC is universal. UTC isn't subject to local time zones or to DST. However, UTC is not user-friendly or relevant to most users. Although UTC is the obvious choice for storage, it isn't a good choice for display. Therefore, most applications convert UTC time to local time before they display the timestamp to the user. For example, Windows Explorer applies the time zone and the DST setting to the UTC timestamp before it displays dates and times for files in a New Technology File System (NTFS) directory.

Conversion from UTC time to local time can be thought of as applying two offsets. The first is the time zone offset, and the second is the DST offset. Therefore, local time is effectively UTC time plus a time zone offset, plus any applicable DST offset. The time zone offset is fairly straightforward. The computer is configured for a particular time zone, and that time zone has an offset from UTC. Determining whether a DST offset should be applied is much more complex. This activity relies on many rules that are complex and dynamic.

Those complex DST rules have recently changed with DST 2007. Starting in 2007, the United States has adopted new start dates and new end dates for DST. In addition, it's common for other countries/regions and governments to routinely change the start dates and the end dates for DST in time zones that are under their control. The following section describes the effects of the DST 2007 change on developer-related products.

For more information about DST 2007, see [Daylight saving time help and support](https://support.microsoft.com/help/22803).

## DST 2007 effects on Windows

On Windows Update and on Microsoft Update, updates are available that enable Windows to correctly apply the changes for DST 2007 and for the following years. After these updates are applied, Windows correctly calculates the current offsets from UTC time to local time as the computer passes through DST. The offsets include the offsets for the base APIs and for the networking time-related APIs.

For more information, see [December 2007 cumulative time zone update for Windows operating systems](https://support.microsoft.com/help/942763).

## DST 2007 effects on C runtime (CRT)

The CRT also performs date translations and time translations. Therefore, the CRT must also be updated to include the new rules for DST 2007. The CRT performs its own time handling only when the TZ environment variable is set or when an underlying operating system API time call fails. Updates are available for the CRTs that are included with each version of Visual Studio and also for the CRTs that are included with Windows. These updates enable the CRT to continue to correctly handle DST conversions in United States time zones.

## DST 2007 effects on the .NET Framework

The .NET Framework relies on the underlying operating system calls. Therefore, the behavior of the .NET Framework reflects the state of the underlying operating system. No separate update is required.

## DST 2007 effects on Visual Studio .NET IDEs

The Visual Studio .NET Integrated Development Environments (IDEs) include versions 2002, 2003, and 2005 of Visual C++, Visual C#, and Visual Basic. These products are affected only because they include the CRT. No IDE-specific update is required.

## DST 2007 effects on Visual Studio 2005 Team Foundation Server

Visual Studio 2005 Team Foundation Server relies on the underlying operating system for date and time conversions. Therefore, Visual Studio 2005 Team Foundation Server exhibits the same behavior as the operating system. Visual Studio 2005 Team Foundation Server also relies on SQL Server, SQL Server Reporting Services, and Windows SharePoint Services. Computers should be updated with the relevant updates for the operating system, for SQL Server, and for Windows SharePoint Services. All relevant updates should be applied on all affected computers at the same time. No separate Visual Studio 2005 Team Foundation Server update is required.

## DST 2007 effects on Visual Studio 2005 Team System

Visual Studio 2005 Team System is affected through the operating system, through Visual Studio 2005 Team Foundation Server, and through the CRT. No separate Visual Studio 2005 Team System update is required.

## DST 2007 effects on Visual Basic 6.0 runtime

The Visual Basic 6.0 runtime isn't affected.

## DST 2007 effects on Visual C++ 6.0

Visual C++ 6.0 is no longer supported. For more information, see [Microsoft Lifecycle Policy](https://support.microsoft.com/hub/4095338/microsoft-lifecycle-policy).

## DST 2007 effects on Windows SDK for Windows Vista

This Software Development Kit (SDK) includes a version of the CRT that is affected by the DST 2007 changes. As part of the installation of this SDK, you can install the Visual Studio 2005 CRT on computers that don't already have that version of the CRT installed. If a newer version of the CRT is already installed, the SDK installation does not overwrite that newer version. When the SDK is uninstalled, the latest version of CRT is left on the computer. You may either install the Visual Studio 2005 CRT update before or after you install the SDK.

The Windows SDK for Windows Vista also installs a set of merge modules (.msm files) for the Visual Studio 2005 CRT for redistribution of the CRT as part of custom C++ applications. An application that deploys the redistributable CRT to the installation folder of the application must deploy the updated CRT from the Visual Studio 2005 CRT update instead of the CRT .msm files from the Windows SDK for Windows Vista. An application that deploys the redistributable Visual Studio 2005 CRT update to the Windows installation folder must apply the Visual Studio 2005 CRT redistributable update to those computers.

## DST 2007 effects on platform SDK for Windows Server 2003 R2

This SDK includes a version of the CRT that is affected by the DST 2007 changes. Customers must follow the release notes for this SDK and use the Visual Studio 2005 CRT updates if they're necessary.

## DST 2007 effects on the .NET Framework 2.0 SDK

This SDK includes a version of the CRT that is affected by the DST 2007 changes. As part of the installation of this SDK, you can install the Visual Studio 2005 CRT on computers that don't already have that version of the CRT installed. If a newer version of the CRT is already installed, the SDK installation doesn't overwrite that newer version. When the SDK is uninstalled, the latest version of CRT is left on the computer. You may either install the Visual Studio 2005 CRT update before or after you install the SDK.

## Local time conversion in Windows

Applications typically convert UTC times to local times before they display time information and date information to the user. Windows provides several APIs for applications to use for timestamp manipulation.

- The `GetSystemTime()` function and the `GetSystemTimeAsFileTime()` function obtain the current UTC time in a `SYSTEMTIME` structure or in a `FILETIME` structure.

- The `GetLocalTime()` function obtains the current local time in a `SYSTEMTIME` structure.

- The `GetTimeZoneInformation()` function obtains a `TIME_ZONE_INFORMATION` structure that describes the current time zone and the DST setting for the computer.

- The `SystemTimeToFileTime()` function and the `FileTimeToSystemTime()` function marshal between `SYSTEMTIME` structures and `FILETIME` structures.

- The `FileTimeToLocalFileTime()` function and the `LocalFileTimeToFileTime()` function convert and translate a `FILETIME` structure between UTC and local time by using the current time zone and the DST setting on the computer.

- The `SystemTimeToTzSpecificLocalTime()` function and the `TzSpecificTimeToSystemTime()` function convert a UTC timestamp in a `SYSTEMTIME` structure to a local `SYSTEMTIME` structure. These functions use a `TIME_ZONE_INFORMATION` structure that specifies the start date and the end date for DST. By default, the current DST rules are used when no such structure is provided.

- The `NetRemoteTOD()` function obtains the time from a remote server by using the server's information and settings.

> [!NOTE]
> The `FileTimeToLocalFileTime()` function and the `LocalFileTimeToFileTime()` function perform the conversion between UTC time and local time by using only the current time zone information and the DST information. This conversion occurs regardless of the timestamp that is being converted.

To see an example of this behavior in Windows Explorer, follow these steps on a computer that resides in a time zone that uses DST.

These steps require that you change the system clock. Therefore, you must exit any applications, such as calendar applications, that might react to these time changes before you follow these steps.

1. Change the date on the computer to a DST day. For example, set the date to July 1, 2006.
2. In an NTFS directory on the same computer, create a new text file that is named Test.txt.
3. Notice that the timestamp on the file is displayed as follows in Windows Explorer:  
   7/1/2006 3:37pm
4. Change the date on the computer to a non-DST day. For example, set the date to February 1, 2007.
5. Refresh the Windows Explorer window.
6. Notice that the timestamp on the file is displayed as follows in Windows Explorer:  
   7/1/2006 2:37pm

In this previous example, the UTC timestamp on the file doesn't change. However, the rules that are used to convert the timestamp to a local time change depending on the current date on the computer. In step 3, a DST offset was applied because July 1 falls within the DST range. In step 6, no DST offset was applied, because February 1 doesn't fall within the DST range. This behavior occurs so that the file timestamp can be converted deterministically to local time and from local time.

The `SystemTimeToTzSpecificLocalTime()` method and the `TzSpecificTimeToSystemTime()` method convert between UTC time and the local time by using the provided `TIME_ZONE_INFORMATION` structure. If no time zone information is provided, these functions use the current time zone rules and the DST rules to determine whether a DST offset must be applied to the timestamp. This is functionally equivalent to calling the `GetTimeZoneInformation()` method to obtain the `TIME_ZONE_INFORMATION` structure that is currently in effect.

The `TIME_ZONE_INFORMATION` structure includes the start date and the stop date for DST. Therefore, when the `TIME_ZONE_INFORMATION` structure uses the current time zone information, the `TIME_ZONE_INFORMATION` structure may introduce a historical inaccuracy. This behavior may occur if the current time zone information and the DST information don't reflect the timestamp that is being converted. This behavior is affected by DST 2007 only because the rules that govern the dates when DST starts and stops have been changed.

To obtain historically accurate conversions from these functions, an application must provide a historically accurate `TIME_ZONE_INFORMATION` structure when the application calls these functions.

## Dynamic time zones in Windows

Windows Vista introduces dynamic DST time zones. Dynamic DST provides support for time zones whose boundaries for DST change from year to year. These rules are stored in the registry. Applications can query the rules by using the `GetDynamicTimeZoneInformation()` function.

Dynamic time zones enable easier updating of computers, especially for locales where the yearly DST boundaries are known in advance. For more information about the `DYNAMIC_TIME_ZONE_INFORMATION` structure in the Windows SDK for Vista, see [DYNAMIC_TIME_ZONE_INFORMATION structure](/windows/win32/api/timezoneapi/ns-timezoneapi-dynamic_time_zone_information).

## Local time conversion in the C runtime (CRT)

The CRT basically has three modes in which it can translate timestamps:

- If the TZ environment variable isn't set, the CRT calls the Windows APIs and exhibits Windows behavior as described in this article.

- If the TZ environment variable is set, the CRT performs its own conversions that are based on that setting. The CRT is being updated so that it respects the new DST 2007 rules when it performs conversions in this scenario.

- If the TZ environment variable isn't set, but the underlying Windows APIs fail, the CRT falls back to its own conversions by using a value of PST8PDT for the TZ environment variable.

The CRT contains its own logic for converting UTC to local time. Applications can obtain UTC timestamps from functions such as the `time()` function. These UTC timestamps are stored in `time_t` values. Conversion to local time can be performed with a function such as the `localtime_s()` function. The `localtime_s()` function populates a `tm` structure that is defined in the `Time.h` header file. The `tm` structure is based on the time zone that is defined in the TZ environment variable and on the DST rules that are in effect at the time of the timestamp.

> [!NOTE]
> This conversion follows rules specific to the United States.

Before you apply the DST 2007 update, the CRT correctly handles current timestamps in United States time zones. After you apply the DST 2007 update, the CRT also handles both past and future United States dates. Updates for the CRT are listed in the [References](#references) section.

## Local time conversion in the .NET Framework

The .NET Framework contains classes that store and convert timestamps. These classes include the `DateTime` class, the `TimeZone` class, the `TimeSpan` class, and the `DateTimeKind` class. As previously noted, these classes depend primarily on the underlying platform implementation. These classes exhibit the same behavior as the underlying operating system APIs.

One interesting behavior exhibited by the .NET Framework date classes and time classes relates to the functions that offset the timestamp by a requested amount. For example, consider the `AddHours()` function, the `AddMinutes()` function, and the `AddSeconds()` function in the `DateTime` class. These functions, and similarly named functions, merely increment the timestamp by the requested amount without regard for DST settings. This behavior might be considered simple arithmetic on the underlying UTC timestamp. However, this behavior could lead to unexpected outcomes when the addition causes the timestamp to pass into or out of DST. This behavior is unrelated to DST 2007 changes.

### Recommendations

The following recommendations can help developers minimize the effect of DST 2007 and improve general date and time handling.

- You should plan for a near-atomic installation of the DST 2007 updates. All planned DST 2007 updates should be applied as close in time to one another as possible. If a computer that has been updated tries to use methods such as SQL queries or Web services to communicate with a computer that has not been updated, translation errors may occur. Similarly, if a single computer requires two or more updates, such as the Windows update and the CRT update, the updates should be applied at the same time.

- UTC timestamps are historically accurate. It is typically the conversion to local time that concerns most applications. Applications should always store UTC timestamps. Conversions to local time for display purposes require time zone information and DST information. This information can come from several sources:
  
  - The application may use the current time zone and the DST setting for the conversion. This may introduce an inaccuracy in the conversion if the current time zone and the DST setting were not in effect at the time of the timestamp.
  
  - The application may store the previously accurate time zone information and DST information in addition to the UTC timestamp.
  
  - When dynamic time zones are available, the application may use dynamic time zones to determine which time zone information should be applied to a particular UTC timestamp. This option is available only when the dynamic time zone information is available for a specific timestamp and for a specific time zone.
  
  - The application may store a local timestamp and the UTC timestamp. This method prevents the need for future conversion.

- Any communication between computers that deal with timestamps should use UTC timestamps. This implicitly gives both computers the same context information for UTC.

- If an application handles dates, you should be careful with the way that the dates are handled in testing. Dates that are displayed without time information are typically stored as a timestamp of 12:00 AM on the relevant date. Therefore, an off-by-one error in the hour part of the timestamp could result in an off-by-one result in the effective date if the time is shifted to 11:00 PM the previous day.

## References

- [Daylight saving time help and support](https://support.microsoft.com/help/22803/daylight-saving-time)

- [December 2007 cumulative time zone update for Microsoft Windows operating systems](https://support.microsoft.com/help/942763)

- [FileTimeToLocalFileTime function](/windows/win32/api/fileapi/nf-fileapi-filetimetolocalfiletime)

- [LocalFileTimeToFileTime function](/windows/win32/api/fileapi/nf-fileapi-localfiletimetofiletime)

- [Time Functions](/windows/win32/sysinfo/time-functions)
