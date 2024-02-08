---
title: Daylight saving time help and support
description: Describes the Microsoft policy in response to DST and time zone changes.
ms.date: 01/19/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dst, csstroubleshoot
ms.subservice: system-mgmgt-components
adobe-target: true
---
# Daylight saving time help and support

This article describes the Microsoft policy in response to daylight saving time (DST) and time zone (TZ) changes.

_Original KB number:_ &nbsp; 22803

## Microsoft support policy in DST and TZ changes

Many applications and cloud services reference the underlying Windows operating system for DST and TZ information. To make sure that Windows has the latest and most accurate time data, Microsoft continuously monitors DST and TZ changes that are announced by governments around the world. Microsoft makes an effort to incorporate these changes to Windows and publishes updates through Windows Update (WU). Each DST and TZ update that's released through WU will have the latest time data and will also supersede any previously issued DST and TZ updates.

Refer to the following table for Microsoft support policy in DST and TZ changes:

|Change type|Change details|Microsoft support policy|Solution|
|---|---|---|---|
|Changes to a region's time zone rules|A subset of the region that shares a time zone makes a change to its DST requirements or changes the time bias of its time zone. A new time zone is required for the affected users within that region because the existing time zone has to remain unchanged for the rest of the users.<br/><br/>-or-<br/> <br/>New DST or TZ change that doesn't match the exact parameters of another TZ, including historical time data accuracy (from 2010).|Microsoft will introduce a new time zone for such scenarios.<br/><br/> A new Windows time zone entry will be created only when a country or region (including dependencies), or a first-order administrative division of a country or region (state, province, department, and so on), has a separate and distinct history of UTC offsets and DST rules from existing TZ entries. Additionally, a smaller geographic area (county, city, and so on) qualifies for a new Windows time zone entry when its current UTC offset and DST rule combination isn't provided by another Windows time zone entry. <br/><br/> If there's insufficient lead time to engineer, test, and publish a Windows Update before these changes take effect, Microsoft will publish interim guidance on [the DST Blog](https://techcommunity.microsoft.com/t5/Daylight-Saving-Time-Time-Zone/bg-p/DSTBlog) that can be used up until a Windows Update is made available.|Interim guidance and Windows Update|
|Changes to DST start and end dates|Modify an existing time zone by changing the DST rule or adding and removing DST to a time zone.<br/><br/>-or-<br/><br/>Modifying the time bias to an existing time zone.|Microsoft will publish a Windows Update that incorporates these DST changes to existing Windows time zones. To make sure that these updates are made available before these laws take effect, we recommend that governments provide ample notice (one year or more) prior to the change taking effect.<br/><br/>If there's insufficient lead time to engineer, test, and publish a Windows Update before these changes take effect, Microsoft will publish interim guidance on [the DST Blog](https://techcommunity.microsoft.com/t5/Daylight-Saving-Time-Time-Zone/bg-p/DSTBlog) that can be used up until a Windows Update is made available.|Interim guidance and Windows Update |
| Changes to display names| A region that has an existing Windows time zone announces changes to the name referenced in the Windows time zone display name.| Microsoft will update the display name for the existing time zones for all supported languages and publish an update. <br/><br/> If there's insufficient lead time to engineer, test, and publish a Windows Update before these changes take effect, Microsoft recommends using the existing time zone until a Windows Update is made available.|Windows Update|

## Microsoft recommendations

In order for Microsoft to provide an update at the earliest and ensure a seamless transition to the new DST and TZ policies, Microsoft recommends that governments provide the following:

- Ample advance notice (one year or more) of the planned change
- Official published confirmation of planned changes to DST or time zones
- Concentrated efforts to promote the change to affected citizens

### Standalone DST updates

Standalone DST updates are no longer available. Please use the current monthly rollup for your version of Windows.

### Monthly rollups

DST updates are also included in monthly rollup releases. You can find more information about our monthly rollup releases here:

[Windows 11 update history](https://support.microsoft.com/help/5018680)  
[Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825)  
[Windows 8.1 and Windows Server 2012 R2 update history](https://support.microsoft.com/help/4009470)  
[Windows 7 SP1 and Windows Server 2008 R2 SP1 update history](https://support.microsoft.com/help/4009469)  
[Windows Server 2022 update history](https://support.microsoft.com/help/5005454)  
[Windows Server 2012 update history](https://support.microsoft.com/help/4009471)  
[Windows Server 2008 SP2 update history](https://support.microsoft.com/help/4343218)  

> [!NOTE]
> Subscribe to the [Microsoft Daylight Saving Time & Time Zone Blog](https://techcommunity.microsoft.com/t5/Daylight-Saving-Time-Time-Zone/bg-p/DSTBlog) to receive the latest updates on changes around the world.
