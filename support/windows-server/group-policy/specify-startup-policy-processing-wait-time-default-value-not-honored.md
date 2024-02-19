---
title: Specify startup policy processing wait time default value isn't honored
description: Helps resolve an issue in which Group Policy fails to apply because the Specify startup policy processing wait time value isn't honored.
author: Deland-Han
ms.author: delhan
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, teterenc, dennhu, v-lianna
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot, ikb2lmc
---
# Group Policy fails to apply if default value of "Specify startup policy processing wait time" isn't honored

This article helps fix an issue in which Group Policy fails to apply because the [Specify startup policy processing wait time](https://gpsearch.azurewebsites.net/Default.aspx?PolicyID=319) group policy value isn't honored.

Group Policy fails to apply during system startup because the default value of the **Specify startup policy processing wait time** group policy isn't honored. 

This issue occurs because the **Specify startup policy processing wait time** group policy isn't configured. If the group policy isn't configured, the Group Policy Service will retrieve the wait time-out from the following registry values:

- `HKLM\Software\Microsoft\Windows\CurrentVersion\Group Policy\History\AvgWaitTimeoutAtStartup`
- `HKLM\Software\Microsoft\Windows\CurrentVersion\Group Policy\History\CurrentWaitAtStartup`

In this case, the time-out is miscalculated, and the Group Policy Service doesn't wait for the default 30 seconds for the network to be available.

To work around this issue, configure the **Specify startup policy processing wait time** group policy in *Computer Configuration\\Administrative Templates\\System\\Group policy\\* with the desired value.

## Install Windows updates

To fix this issue, install Windows updates released on or after the following:

|Products  |Updates  |
|---------|---------|
|Windows 11, version 22H2     |[August 22, 2023—KB5029351 (OS Build 22621.2215)](https://support.microsoft.com/topic/august-22-2023-kb5029351-os-build-22621-2215-preview-9af25662-083a-43f5-b3a7-975fe25cc692)         |
|Windows 11, version 21H2     |[August 22, 2023—KB5029332 (OS Build 22000.2360)](https://support.microsoft.com/topic/august-22-2023-kb5029332-os-build-22000-2360-preview-8f8aec64-77b4-4225-9a0f-f0153204ae28)         |
|Windows Server 2022     |[September 12, 2023—KB5030216 (OS Build 20348.1970)](https://support.microsoft.com/topic/september-12-2023-kb5030216-os-build-20348-1970-34d4aff3-fd05-4270-b288-4ab6379c7f81)         |
|Windows 10, version 22H2     |[August 22, 2023—KB5029331 (OS Build 19045.3393)](https://support.microsoft.com/topic/august-22-2023-kb5029331-os-build-19045-3393-preview-9f6c1dbd-0ee6-469b-af24-f9d0bf35ca18)         |
|Windows 10 Enterprise LTSC 2019<br>Windows 10 IoT Enterprise LTSC 2019<br>Windows 10 IoT Core 2019<br>Windows Server 2019|[September 12, 2023—KB5030214 (OS Build 17763.4851)](https://support.microsoft.com/topic/september-12-2023-kb5030214-os-build-17763-4851-e6ae7551-49f4-428e-b2d4-caa73078fb06)         |
