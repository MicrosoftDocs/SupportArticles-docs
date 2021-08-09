---
title: IIS events not detected by Management Pack
description: This article provides resolutions for the problem where certain IIS events are not detected by System Center Operations Manager.
ms.date: 04/15/2020
ms.prod-support-area-path: IIS extensions, tools, and Add-ons
ms.technology: iis
ms.reviewer: dougste 
---
# Some IIS events are not detected by the IIS Management Pack

This article helps you resolve the problem where certain Microsoft Internet Information Services (IIS) events are not detected by the IIS Management Pack.

_Original product version:_ &nbsp; Internet Information Services 7.5, 7.0  
_Original KB number:_ &nbsp; 2635429

## Symptoms

When monitoring an IIS 7.0 or 7.5 web site with System Center Operations Manager by using the IIS Management Pack, certain IIS events are not detected by System Center Operations Manager. This problem occurs even though the same IIS events do appear in the Windows event logs. Specifically, events with ID 2269, 2276, 2280, 2281, and 2282 from source Microsoft-Windows-IIS-W3SVC-WP are not detected.

For example, the following event may be logged to the Application event log, but not be reported by System Center Operations Manager:

```console
 Log Name:      Application  
 Source:        Microsoft-Windows-IIS-W3SVC-WP  
 Date:          DateTime  
 Event ID:      2281  
 Task Category: None  
 Level:         Error  
 Keywords:      Classic  
 User:          N/A  
 Computer:      MACHINENAME  
 Description:  
 The worker process failed to initialize communication with the W3SVC and therefore could not be started.  
 The data is the error.
```

## Cause

System Center Operations Manager is monitoring for events ranged 2201-2307 to be logged with a source of Microsoft-Windows-IIS-WMSVC, which is incorrect. The correct source for these events is Microsoft-Windows-IIS-W3SVC-WP.

## Resolution

To work around this problem, create a custom rule in System Center Operations Manager to look for the correct event source of Microsoft-Windows-IIS-W3SVC-WP.

## More information

Microsoft has confirmed that this problem is due to an issue in the IIS Management Pack and the associated IIS documentation. The following table lists the correct event source and event ID pairs:

|Event ID range|Event Source|
|---|---|
|1001-1175|Microsoft-Windows-IIS-W3SVC|
|2000-2003|Microsoft-Windows-IIS-W3SVC-PerfCounters|
|2201-2307|Microsoft-Windows-IIS-W3SVC-WP|
|5001-5210|Microsoft-Windows-WAS|
|7001-7006|Microsoft-Windows-WAS-ListenerAdapter|
|8001-8001|Microsoft-Windows-IIS-WMSVC|
|9001-9013|Microsoft-Windows-IIS-APPHOSTSVC|
|||
