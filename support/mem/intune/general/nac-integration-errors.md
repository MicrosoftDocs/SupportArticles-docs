---
title: Troubleshooting 503 errors for Microsoft Intune NAC integration
description: Troubleshoot 503 errors that network access control (NAC) partners receive from Intune, and learn about the four-hour throttle window for unfiltered queries.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
ms.custom: sap:Set Up Intune\Set up administrators and manage roles
---
# Troubleshooting 503 errors for Intune NAC integration

The article explains 503 errors that network access control (NAC) partners receive from Microsoft Intune. Additionally, it describes the recommended best practice of limiting broad, unfiltered queries to the Intune service to the first hour of every four-hour throttle window, as noted in [Network access control (NAC) integration with Intune](/mem/intune/protect/network-access-control-integrate).

NAC partner solutions typically send two different types of queries to Intune to determine the device compliance state:

- **Device specific calls:** Device-specific calls are filtered based on a known property value of a single device, such as its IMEI or Wi-Fi MAC address. NAC solutions are allowed to make as many device-specific calls as necessary. These calls will *never* result in 503 errors.

- **Broad, unfiltered queries for all non-compliant devices:** A broad unfiltered query may return bulk data. So to avoid overloading the Intune services, we recommend unfiltered queries are made only once every four hours. Queries made more frequently will return HTTP 503 errors.

The four-hour throttle window starts after the first unfiltered call to Intune (and after the previous throttle has expired, if this isn't the first call). Unfiltered compliance calls can be repeated for the first 60 minutes without throttling. After the 60-minute interval has passed, it is followed by three hours of 503 responses. So, the four-hour window includes one hour of unlimited compliance calls and three hours of 503 throttle. Therefore, we recommend that the interval for unfiltered NAC queries be greater than four hours.

It's important to understand that a new four-hour throttle timer doesn't start until the first unfiltered compliance call *after* the previous throttle has expired.
