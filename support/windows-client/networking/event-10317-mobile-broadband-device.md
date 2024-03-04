---
title: Event 10317 when turning on mobile broadband device
description: Describes error events that may be logged when you turn on a device that has a mobile broadband connection or resume the device from sleep.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# Event ID 10317 is logged when you turn on a mobile broadband device or resume it from sleep

This article describes Event ID 10317 that's logged when you turn on a mobile broadband device or resume it from sleep.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2981681

## Symptoms

You have a device that has a mobile broadband connection. When you turn on the device or resume it from sleep, one of the following errors is logged in the System log:

> Log Name: System  
Source: Microsoft-Windows-NDIS  
Date: <*Date and Time*>  
Event ID: 10317  
Task Category: PnP  
Level: Error  
Keywords: (16384),(16),(4),(2)  
User: <*User Name*>  
Computer: <*Computer Name*>  
Description:  
Miniport <*Mobile broadband device name*>, {*GUID*}, had event Fatal error: The miniport has detected an internal error  

>Log Name: System  
Source: Microsoft-Windows-NDIS  
Date: <*Date and Time*>  
Event ID: 10317  
Task Category: PnP  
Level: Error  
Keywords: (16384),(16),(4),(2)  
User: <*User Name*>  
Computer: <*Computer Name*>  
Description:  
Miniport <*Mobile broadband device name*>, {*GUID*}, had event Fatal error: The miniport has failed a power transition to operational power  

## Cause

This error is logged when a request is sent to the mobile broadband device and a response is not received in 400 milliseconds. This frequently occurs when the mobile broadband device was turned off and is restarting. For example, this may occur during an initial start or when the device resumes from sleep or hibernation. In most cases, the device cannot start fast enough to be able to respond in the 400-millisecond window. After the device is fully turned on, these errors are typically no longer logged because the device is awake and able to respond quickly.

## Resolution

These errors can safely be ignored when they are logged during or shortly after the device is turned on or resumed from sleep.
