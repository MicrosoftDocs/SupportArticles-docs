---
title: Incorrect time displayed after in-place upgrade
description: Fixes an issue where the displayed time on affected computers doesn't match the current local time after you do an in-place upgrade to a 64-bit version of Windows 7 or Windows Server 2008 R2.
ms.date: 12/21/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dst-and-timezones, csstroubleshoot
---
# Incorrect time displayed on 64-bit versions of Windows 7 or Windows Server 2008 R2 after in-place upgrade

This article helps fixes an issue where the displayed time on affected computers doesn't match the current local time after you do an in-place upgrade to a 64-bit version of Windows 7 or Windows Server 2008 R2.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2001086

## Symptoms

Consider the following scenario:  

- You install a 64-bit version of Windows Vista, Windows 7, or Windows Server 2008 R2.

- You set the time zone to Israel Standard Time. In Windows Vista, this is displayed as **(GMT+02:00) Jerusalem**. On Windows 7 and Windows Server 2008 R2, this is displayed as **(UTC+02:00) Jerusalem.**  

- You do an in-place upgrade to a 64-bit version of Windows 7 or Windows Server 2008 R2.

    **Expected Behavior:**  

    After the upgrade, the time zone setting is correctly configured and such features as Dynamic DST continue to work.

    **Observed Behavior:**  

    After the upgrade, the current time zone can't be recognized by the **GetDynamicTimeZoneInformation()** API. Without user intervention to correct this, Dynamic DST is broken and the computer doesn't adjust for DST on the correct dates in upcoming years. Therefore, the displayed time on affected computers doesn't match the current local time.

    When this problem occurs, users don't receive a notification about the error.

### Additional Windows Server 2008 R2 problem  

On Windows server 2008 R2 servers, you can't change the time zone setting, and you receive the following error message:
> Your current time zone is not recognized. Please select a valid time zone.

## Cause

The **TimeZoneKeyName** registry setting is defined as a 128 WCHAR REG_SZ data type. If the 128th WCHAR in **TimeZoneKeyName** isn't a null terminator, the system upgrade process (Offline.xml) appends a null to the string. This increases its length to 129 WCHARs. Because Windows has a 128 WHCAR buffer in which to store this data, the system doesn't load the modified string from the registry.

This problem applies to upgrades to 64-bit Windows 7 and Windows Server 2008 R2.

### Additional Windows Server 2008 R2 cause

Permissions are missing on non-working servers for the following registry subkey:

`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones` and `HKLM\System\CurrentControlSet\Control\TimeZoneInformation`

## Resolution

On **Windows Server 2008 R2** computers, start the **Date and Time**  item in Control Panel or on the Windows task bar. If the message in the clock window indicates that the time zone is unrecognized, click **Change time zone**, verify the time zone setting, and then press **OK**. This restores correct values to **TimeZoneKeyName**.
On Windows 7 clients, verify your time zone selection during the OOBE phase of Setup. This restores the **TimeZoneKeyName** setting in the registry.
> [!Note]  
>
> - The Windows operating system uses UTC time internally for time-dependent operations. The displayed time that appears in the Windows task bar or Control Panel item is based on UTC time plus or minus a regional time offset corrected for daylight saving times rules based on the local computers time zone locale.
> - This bug doesn't affect the internal system time used by Windows. It can cause the displayed time to appear incorrect.
> - When you correct the time setting in the **Date and Time** item, first verify that the correct time zone has been configured. Do this before you make any date or hour changes so that you don't unintentionally configure an incorrect system time.

## More information

### Dynamic DST

In some countries/regions, the DST dates differ from year to year and cannot be defined by a single rule. Therefore, Windows includes the Dynamic DST feature that stores per-year rules in the registry. When the year changes, the current time zone information is refreshed by using the correct DST information for that year.

Dynamic DST depends on the following registry value being set to the name of the time zone key where the Dynamic DST data resides (for example, "Israel Standard Time"):

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\TimeZoneKeyName`

Only time zones that have different rules for different years (Dynamic DST) are affected. This is because the registry value that indicates where these per-year rules are stored is corrupted.
If this value is missing, the time zone information data is not refreshed at the next year changeover period. This causes the previous year's DST rules to be used to calculate local time.
Immediately after the system version upgrade, display time isn't affected by this issue. You'll get a notification of an unrecognized time zone if you click the taskbar clock or open the **Date and Time**  item in the Control Panel.

If the time zone isn't corrected, future transitions to or from DST could occur at the wrong time. This would cause an incorrect time on the system, or incorrect conversions between system and local time being incorrect.

All time zones are potentially affected, but the main effect is on operating system installations that are configured to use zones that contain Dynamic DST data. The time zones that support Dynamic DST are as follows:

Alaskan Standard Time  
Arabic Standard Time  
Argentina Standard Time  
Atlantic Standard Time  
AUS Eastern Standard Time  
Cen. Australia Standard Time  
Central Brazilian Standard Time  
Central Standard Time  
E. South America Standard Time  
Eastern Standard Time  
Egypt Standard Time  
Greenland Standard Time  
Iran Standard Time  
Israel Standard Time  
Mauritius Standard Time  
Montevideo Standard Time  
Morocco Standard Time  
Mountain Standard Time  
New Zealand Standard Time  
Newfoundland Standard Time  
Pacific SA Standard Time  
Pacific Standard Time  
Pakistan Standard Time  
Paraguay Standard Time  
Tasmania Standard Time  
Venezuela Standard Time  
W. Australia Standard Time  

The reason that the impact in this case is greater is that the DST data for the time zone may not be updated to reflect the rules that should be in force for the given year. This may cause a transition to or from DST to occur at the incorrect time in the given time zone. This isn't an issue if Dynamic DST isn't present in the time zone. However, the corrupted registry data causes any call to **GetDynamicTimeZoneInformation()** to fail, regardless of whether the time zone supports dynamic DST.
