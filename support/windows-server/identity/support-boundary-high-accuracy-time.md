---
title: Support boundary for high-accuracy time
description: Describes the support boundary for the Windows Time (W32Time) service in environments that require highly accurate and stable system time.
ms.date: 11/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dahavey, v-lianna
ms.custom: sap:windows-time-service, csstroubleshoot
---
# Support boundary for high-accuracy time

This article describes the support boundaries for the Windows Time service (W32Time) in environments that require highly accurate and stable system time.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10 version 1607 or later, Azure Stack HCI, versions 21H2 and 20H2

## High accuracy support for Windows 8.1 and 2012 R2 (or prior)

Earlier versions of Windows (Prior to Windows 10 1607 or Windows Server 2016 1607) can't guarantee highly accurate time. The Windows Time service on these systems:

- Provided the necessary time accuracy to satisfy Kerberos version 5 authentication requirements
- Provided loosely accurate time for Windows clients and servers joined to a common Active Directory forest

Tighter accuracy requirements were outside of the design specification of the Windows Time Service on these operating systems and isn't supported.

## Windows 10 and Windows Server 2016

Time accuracy in Windows 10 and Windows Server 2016 has been substantially improved, while maintaining full backwards NTP compatibility with older Windows versions. Under the right operating conditions, systems running Windows 10 or Windows Server 2016 and newer releases can deliver 1 second, 50 ms (milliseconds), or 1-ms accuracy.

> [!WARNING]
> It is highly recommended to disable the Secure Time Seeding (STS) feature for the Windows Time service on devices that already sync with a reliable time source such as an NTP server. This includes both Active Directory domain controllers as well as member servers. This is because STS was designed specifically to correct only gross clock inaccuracies on portable devices such as tablets and laptops whose batteries might die or whose hardware clocks might not be as reliable. Furthermore, it is possible for STS to incorrectly set the system clock if enough SSL-based handshakes containing random data are received.
>
> For more information, see [Time accuracy improvements for Windows Server 2016](/windows-server/networking/windows-time-service/windows-server-2016-improvements).

> [!IMPORTANT]
>
> - Highly accurate time sources
>
>     The resulting time accuracy in your topology is highly dependent on using an accurate, stable root (stratum 1) time source. There are Windows based and non-Windows based highly accurate, Windows compatible, NTP Time source hardware sold by 3rd-party vendors. Please check with your vendor on the accuracy of their products.
>
> - Time accuracy
>
>     Time accuracy entails the end-to-end distribution of accurate time from a highly accurate authoritative time source to the end device. Anything that introduces network asymmetry will negatively influence accuracy, for example physical network devices or high CPU load on the target system.

## High accuracy requirements

The rest of this document outlines the environmental requirements that must be satisfied to support the respective high accuracy targets.

### Target accuracy: 1 second (1 s)

To achieve 1-s accuracy for a specific target machine when compared to a highly accurate time source:

- The target system must run Windows 10, Windows Server 2016.
- The target system must synchronize time from an NTP hierarchy of time servers, culminating in a highly accurate, Windows compatible NTP time source.
- All Windows operating systems in the NTP hierarchy mentioned above must be configured as documented in the [Configuring Systems for High Accuracy](/windows-server/networking/windows-time-service/configuring-systems-for-high-accuracy) documentation.
- The cumulative one-way network latency between the target and source must not exceed 100 ms. The cumulative network delay is measured by adding the individual one-way delays between pairs of NTP client-server nodes in the hierarchy starting with the target and ending at the source. For more information, please review the high accuracy time sync document.

### Target accuracy: 50 milliseconds

All requirements outlined in the section [Target accuracy: 1 second](#target-accuracy-1-second-1-s) apply, except where stricter controls are outlined in this section.

The other requirements to achieve 50-ms accuracy for a specific target system are:

- The target computer must have better than 5 ms of network latency between its time source.
- The target system must be no further than stratum 5 from a highly accurate time source.

    > [!NOTE]
    > Run `w32tm /query /status` from the command line to see the stratum.

- The target system must be within 6 or less network hops from the highly accurate time source.
- The one-day average CPU utilization on all stratums must not exceed 90%.
- For virtualized systems, the one-day average CPU utilization of the host must not exceed 90%.

### Target accuracy: 1 millisecond

All requirements outlined in the sections [Target accuracy: 1 second](#target-accuracy-1-second-1-s) and [Target accuracy: 50 milliseconds](#target-accuracy-50-milliseconds) apply, except where stricter controls are outlined in this section.

The other requirements to achieve 1-ms accuracy for a specific target system are:

- The target computer must have better than 0.1 ms of network latency between its time source
- The target system must be no further than stratum 5 from a highly accurate time source

    > [!NOTE]
    > Run `w32tm /query /status` from the command line to see the stratum.

- The target system must be within 4 or less network hops from the highly accurate time source.
- The one-day average CPU utilization across each stratum must not exceed 80%.
- For virtualized systems, the one-day average CPU utilization of the host must not exceed 80%.
