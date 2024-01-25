---
title: New Japanese era update for .NET Framework
description: This article introduces the new Japanese era update for .NET Framework. This update contains quality and reliability improvements.
ms.date: 05/06/2020
ms.reviewer: kaorif
---
# Summary of new Japanese era updates for .NET Framework

This article introduces the new Japanese era updates for .NET Framework.

_Original product version:_ &nbsp; .NET Framework 3.5 and later versions  
_Original KB number:_ &nbsp; 4477957

## Summary

On May 1, 2019, the new era in the Japanese calendar will begin. Microsoft is preparing for these changes and plans to ship updates in each monthly rollup release. This is the first transition from one era to another since January 1989, and also the first in the history of .NET Framework. This article is intended to help developers test and verify how eras work in .NET applications, how applications are affected by the era change, and what you, as a developer, have to do to make sure that your applications handle the upcoming Japanese era changes successfully.

For more information about Windows updates for the Japanese era change, see [KB 4469068](https://support.microsoft.com/help/4469068).

## .NET Framework updates

The following releases contain the Japanese era updates for .NET Framework. They also contain quality and reliability improvements.

- [.NET Framework September 2018 Preview of Quality Rollup](https://devblogs.microsoft.com/dotnet/net-framework-september-2018-preview-of-quality-rollup/)
- [.NET Framework November 2018 Security and Quality Rollup](https://devblogs.microsoft.com/dotnet/net-framework-november-2018-security-and-quality-rollup/)
- [.NET Framework December 2018 Security and Quality Rollup](https://devblogs.microsoft.com/dotnet/net-framework-december-2018-security-and-quality-rollup/)
- [.NET Framework March 2019 Update](https://devblogs.microsoft.com/dotnet/net-framework-march-2019-update/)
- [.NET Framework May 2019 Security and Quality Rollup](https://devblogs.microsoft.com/dotnet/net-framework-may-2019-security-and-quality-rollup/)

> [!NOTE]
> For some versions of Windows, .NET Framework updates are delivered through a separate .NET Framework-specific cumulative update. For more information, see [Announcing Cumulative Updates for .NET Framework for Windows 10 October 2018 Update](https://devblogs.microsoft.com/dotnet/announcing-cumulative-updates-for-net-framework-for-windows-10-october-2018-update/).

### Knowledge base articles by .NET Framework version for Japanese era updates

The servicing updates that are listed in the following table contain all the Japanese era updates for .NET Framework that were already included in the previously released updates. The servicing updates also contain a new quality update that removes the dependency on single quotation marks to output the Gannen character in Japanese era formatting, so that either :::no-loc text="\"y年\""::: or :::no-loc text="\"y'年'\""::: of the custom date and time format string enable .NET Framework to format year number 1 to :::no-loc text="元":::. These updates are available on Windows Update, Windows Server Update Service (WSUS), and Windows Update Catalog.

|Windows 10, version 1507|Windows 10, version 1607 (Anniversary Update) / Windows Server 2016|Windows 10, version 1703 (Creators Update)|Windows 10, version 1709 (Fall Creators Update)|Windows 10, version 1803 (April 2018 Update)|Windows 10, version 1809 (October 2018 Update) / Windows Server 2019|
|---|---|---|---|---|---|
|[4489872](https://support.microsoft.com/help/4489872)|[4489889](https://support.microsoft.com/help/4489889)|[4489888](https://support.microsoft.com/help/4489888)|[4489890](https://support.microsoft.com/help/4489890)|[4489894](https://support.microsoft.com/help/4489894)|[4489192](https://support.microsoft.com/help/4489192)|

Microsoft released a .NET framework security and quality rollup for Windows 8.1 and earlier supported versions of Windows in May 2019 as below. All security and quality rollups released later to these updates will also contain Japanese era updates.

|.NET Framework|Windows Server 2008|Windows 7 / Windows Server 2008 R2|Windows Server 2012|Windows 8.1 / Windows Server 2012 R2|
|---|---|---|---|---|
|.NET Framework 3.5|[4495604](https://support.microsoft.com/help/4495604)|[4495606](https://support.microsoft.com/help/4495606)|[4480061](https://support.microsoft.com/help/4480061)|[4495608](https://support.microsoft.com/help/4495608)|
|.NET Framework 4.5.2|[4495596](https://support.microsoft.com/help/4495596)|[4495596](https://support.microsoft.com/help/4495596)|[4495594](https://support.microsoft.com/help/4495594)|[4495592](https://support.microsoft.com/help/4495592)|
|.NET Framework 4.6 or later|[4495588](https://support.microsoft.com/help/4495588)|[4495588](https://support.microsoft.com/help/4495588)|[4495582](https://support.microsoft.com/help/4495582)|[4495585](https://support.microsoft.com/help/4495585)|

> [!NOTE]
> Microsoft did not release a .NET Framework security and quality rollup for Windows 8.1 and earlier supported versions of Windows in March 2019. If you want to deploy the latest updates for .NET Framework that contain all the Japanese era updates for Windows 8.1 and earlier supported versions of Windows, see the [Changes for Security Only update customers](#changes-for-security-only-update-customers) section.

## Changes for Security Only update customers

This section is for customers who rely on the Security Only (SO) updates for Windows 8.1 and earlier versions of supported Windows.

Similar to the .NET Framework updates for Windows 10 that are listed in the previous section, the updates that are listed in the following table contain all the Japanese era updates for .NET Framework that were already included in previously released updates and a new quality update to remove the dependency on using single quotation marks to output the Gannen character in Japanese era formatting.

These updates don't include any new security updates or new additional quality and reliability improvements that were not already included in previously released updates, except the update for the single quotation mark issue. Therefore, users who rely on the Security Only (SO) updates and the Monthly Rollup (MO) updates for Windows 8.1 and earlier supported versions of Windows can also select these updates for the new Japanese era. These updates are available through Windows Server Update Service (WSUS) and Windows Update Catalog only.

|.NET Framework|Windows Server 2008|Windows 7 / Windows Server 2008 R2|Windows Server 2012|Windows 8.1 / Windows Server 2012 R2|
|---|---|---|---|---|
|.NET Framework 3.5|[4488661](https://support.microsoft.com/help/4488661)|[4488662](https://support.microsoft.com/help/4488662)|[4488660](https://support.microsoft.com/help/4488660)|[4488663](https://support.microsoft.com/help/4488663)|
|.NET Framework 4.5.2|[4488669](https://support.microsoft.com/help/4488669)|[4488669](https://support.microsoft.com/help/4488669)|[4488668](https://support.microsoft.com/help/4488668)|[4488667](https://support.microsoft.com/help/4488667)|
|.NET Framework 4.6 or later|[4488666](https://support.microsoft.com/help/4488666)|[4488666](https://support.microsoft.com/help/4488666)|[4488664](https://support.microsoft.com/help/4488664)|[4488665](https://support.microsoft.com/help/4488665)|

> [!IMPORTANT]
> After you install update 4488669 on Windows 7 Service Pack 1 (SP1), Windows Server 2008 R2 Service Pack 1 (SP1), or Windows Server 2008 Service Pack 2 (SP2), .NET applications may not start after you upgrade .NET Framework from version 4.5.2 to version 4.6 or a later version. Microsoft is working on a resolution to this issue and will provide an update in an upcoming release. For more information, see [KB 4488669](https://support.microsoft.com/help/4488669).

## Test the new Japanese era on .NET Framework

For all the versions of .NET Framework in the Knowledge Base articles table, and also for .NET Core running on Windows, calendar era information is provided by the Windows operating system and retrieved from the system registry when you apply the updates for .NET Framework. To make it easier for you to prepare for the Japanese era change, you can control when you add the placeholder registry entry to your systems, and choose the timing that meets your needs. Currently, the placeholder registry for the Windows operating system is supported for the following systems:

- Windows Client: Windows 7 SP1 and later
- Windows Server: Windows Server 2008 R2 SP1 and later

> [!NOTE]
> We will offer additional new Japanese era updates for Windows Server 2008 SP2 and Windows Embedded & IoT, Windows Embedded Compact 7 and later versions, Windows Embedded Standard/POSReady 7 and later versions, and Windows 10 IoT.

An update to Windows will add the new era value to the registry after the era name and abbreviated era name are known. .NET on Windows will automatically reflect this update.

## Recommended test scenarios to cover

- Relaxed era range checks

    This test scenario is to verify LOB applications work when the new era transition is set to a future date.

    A date in a particular era can "overflow" into the following era, and no `ArgumentOutOfRangeException` or `FormatException` is thrown by default. When you set the value of `Switch.System.Globalization.EnforceJapaneseEraYearRanges` to **true**, you can restore strict era checks.

- The first year of an era

    This test scenario is to verify the Gannen (:::no-loc text="元年":::) convention in formatting operations as the first year of a new Japanese calendar era.

    By default, .NET adopts the Gannen (:::no-loc text="元年":::) convention in formatting operations. You can restore the previous behavior. That behavior always represents the year as "1" instead of as Gannen (:::no-loc text="元年":::). To do this, set the following value to **true**:

    `Switch.System.Globalization.FormatJapaneseFirstYearAsANumber`

## Japanese era supported features

- **Updating data source**

    Japanese era information was originally maintained as hard-coded data in .NET Framework 3.5 and lower versions of .NET Framework, however similarly to .NET Framework 4.0 and later, its source for Japanese era was changed from private hard-coded data to the registry key under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Calendars\Japanese\Eras` registry path. The update for Windows will add the registry key for the new era after its name is announced.

- **Range-Relaxation**

    When Heisei (:::no-loc text="平成":::) Era ends on April 30th, 2019 which is Heisei (:::no-loc text="平成":::) 31, and the new era begins on May 1, 2019, :::no-loc text=""平成 31 年 5 月 1 日""::: becomes invalid. We have relaxed our parsers to allow the future or past dates (both Gregorian and Japanese dates) in .NET applications, to be converted into a relevant Japanese era date without throwing an exception such as `ArgumentOutOfRangeException` and `System.FormatException`. You will also be able to convert the future dates in Heisei to the new Japanese era once the new Japanese era name is announced. It can be disabled in .NET Framework. By setting the value of `Switch.System.Globalization.EnforceJapaneseEraYearRanges` to **true**.

- **Gannen (:::no-loc text="元年":::) for the first year of Japanese era**

    In historical practice, for the first year of the era, a special character "Gan (:::no-loc text="元":::)", whose Kanji character means "origin" or "beginning", is used in place of the number "Ichi (1)". The first year "Gannen (:::no-loc text="元年":::)" continues until the end date of the Gregorian calendar year, December 31st. .NET Framework supports both "Gannen (:::no-loc text="元年":::)" and "Ichinen (1 :::no-loc text="年":::)" for the first year of the era. For all the versions of .NET Framework, Gannen is ON by default. It can be disabled by setting the value of `Switch.System.Globalization.FormatJapaneseFirstYearAsANumber` to **true**.

## Previously released updates

Customers need only install the latest update listed above in the [Knowledge Base articles by .NET Framework version for Japanese era updates](#knowledge-base-articles-by-net-framework-version-for-japanese-era-updates) section or those from Windows Update, Windows Server Update Service (WSUS), or Windows Update Catalog.

|.NET Framework|Windows Server 2008|Windows 7 / Windows Server 2008 R2|Windows Server 2012|Windows 8.1 / Windows Server 2012 R2|Windows 10 1507|Windows 10 1607 (Anniversary Update) / Windows Server 2016|Windows 10 1703 (Creators Update)|Windows 10 1709 (Fall Creators Update)|Windows 10 1803 (April 2018 Update)|Windows 10 1809 (October 2018 Update)|Windows Server 2019|
|---|---|---|---|---|---|---|---|---|---|---|---|
|**Updating data sources**|
|.NET Framework 3.5|[4457007](https://support.microsoft.com/help/4457007)|[4457008](https://support.microsoft.com/help/4457008)|[4457006](https://support.microsoft.com/help/4457006)|[4457009](https://support.microsoft.com/help/4457009)|[4471323](https://support.microsoft.com/help/4471323)|[4457127](https://support.microsoft.com/help/4457127)|[4457141](https://support.microsoft.com/help/4457141)|[4457136](https://support.microsoft.com/help/4457136)|[4458469](https://support.microsoft.com/help/4458469)|Unnecessary|Unnecessary|
|.NET Framework 4.5.2|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|
|.NET Framework 4.6 or later|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|Unnecessary|
|**Relaxed era range checks**|
|.NET Framework 3.5|[4457007](https://support.microsoft.com/help/4457007)|[4457008](https://support.microsoft.com/help/4457008)|[4457006](https://support.microsoft.com/help/4457006)|[4457009](https://support.microsoft.com/help/4457009)|[4471323](https://support.microsoft.com/help/4471323)|[4457127](https://support.microsoft.com/help/4457127)|[4457141](https://support.microsoft.com/help/4457141)|[4457136](https://support.microsoft.com/help/4457136)|[4458469](https://support.microsoft.com/help/4458469)|Unnecessary|Unnecessary|
|.NET Framework 4.5.2|[4457019](https://support.microsoft.com/help/4457019)|[4457019](https://support.microsoft.com/help/4457019)|[4457018](https://support.microsoft.com/help/4457018)|[4457017](https://support.microsoft.com/help/4457017)|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|
|.NET Framework 4.6 or later|[4457016](https://support.microsoft.com/help/4457016)|[4457016](https://support.microsoft.com/help/4457016)|[4457014](https://support.microsoft.com/help/4457014)|[4457015](https://support.microsoft.com/help/4457015)|[4467680](https://support.microsoft.com/help/4467680)|[4457127](https://support.microsoft.com/help/4457127)|[4457141](https://support.microsoft.com/help/4457141)|[4457136](https://support.microsoft.com/help/4457136)|[4458469](https://support.microsoft.com/help/4458469)|Not applicable|Not applicable |
|**The first year of an era**|
|.NET Framework 3.5|[4459933](https://support.microsoft.com/help/4459933)|[4459934](https://support.microsoft.com/help/4459934)|[4459932](https://support.microsoft.com/help/4459932)|[4459935](https://support.microsoft.com/help/4459935)|[4471323](https://support.microsoft.com/help/4471323)|[4467691](https://support.microsoft.com/help/4467691)|[4467696](https://support.microsoft.com/help/4467696)|[4467686](https://support.microsoft.com/help/4467686)|[4467702](https://support.microsoft.com/help/4467702)|[4470502](https://support.microsoft.com/help/4470502)|[4470502](https://support.microsoft.com/help/4470502)|
|.NET Framework 4.5.2|[4459945](https://support.microsoft.com/help/4459945)|[4459945](https://support.microsoft.com/help/4459945)|[4459944](https://support.microsoft.com/help/4459944)|[4459943](https://support.microsoft.com/help/4459943)|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|Not applicable|
|.NET Framework 4.6 or later|[4459942](https://support.microsoft.com/help/4459942)|[4459942](https://support.microsoft.com/help/4459942)|[4459940](https://support.microsoft.com/help/4459940)|[4459941](https://support.microsoft.com/help/4459941)|[4467680](https://support.microsoft.com/help/4467680)|[4467691](https://support.microsoft.com/help/4467691)|[4467696](https://support.microsoft.com/help/4467696)|[4467686](https://support.microsoft.com/help/4467686)|[4467702](https://support.microsoft.com/help/4467702)|[4470502](https://support.microsoft.com/help/4470502)|[4470502](https://support.microsoft.com/help/4470502)|

## Additional resources

- Handling a new era in the Japanese calendar in .NET - [.NET Blog](https://devblogs.microsoft.com/dotnet/handling-a-new-era-in-the-japanese-calendar-in-net/)
- Using the Registry to Test the New Japanese era on Windows - [August 2018 blog](https://blogs.msdn.microsoft.com/shawnste/2018/08/07/using-the-registry-to-test-the-new-japanese-era-on-windows/)
- Gannen vs Ichinen - [November 2018 blog](/archive/blogs/shawnste/gannen-vs-ichinen)
