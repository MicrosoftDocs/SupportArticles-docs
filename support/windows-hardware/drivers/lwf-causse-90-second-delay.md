---
title: LWF could cause 90-second delay
description: This article describes the Optional NDIS LWF could cause 90-second delay in network availability.
ms.date: 09/04/2020
ms.custom: sap:Network Driver
ms.subservice: network-driver
---
# Optional NDIS LWF could cause 90-second delay in network availability

This article introduces Optional NDIS Lightweight Filters (LWF) could cause 90-second delay in network availability.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2019184

## Summary

If an optional NDIS Lightweight Filter (LWF) driver is installed and the driver is not started, the network will not be available for up to 90 seconds.

## More information

An NDIS Lightweight Filter driver is one of several driver models to monitor and filter network packets in Windows. LWFs are new with the NDIS 6 Specification (Vista and following).

NDIS LWFs can be either mandatory filter drivers or optional filter drivers. The filter run type is specified in the driver's INF via `FilterRunType`. A `FilterRunType` of 1 is a Mandatory Filter, whereas a FilterRunType of 2 is an Optional Filter:

```console
HKR, Ndi,FilterRunType, 0x00010001, 0x00000001 ; MANDATORY filter  
```

or

```console
HKR, Ndi,FilterRunType, 0x00010001, 0x00000002 ; OPTIONAL filter
```

If an LWF driver is installed but not started, the network stack will be unavailable for up to 90 seconds if the unloaded filter driver is an Optional filter. The stack will never become available if the missing filter driver is Mandatory. This timeout period is to give the filter an opportunity to load. Starting the stack, pausing it, and then restarting it when an Optional filter eventually loads may cause other side effects to upper-layer components that are watching for network availability.

Typically, filter drivers are started immediately as SERVICE_SYSTEM_START by specifying its `StartType` as 1 (`SERVICE_SYSTEM_START`) in the LWF's INF:

```console
StartType = 1 ;SERVICE_SYSTEM_START
```

Some filters, however, are started later as `SERVICE_DEMAND_START` by specifying its StartType as 3 (`SERVICE_DEMAND_START`):

```console
StartType = 3 ;SERVICE_DEMAND_START
```

LWFs that use the DEMAND START should be started as soon as possible by some other mechanism, usually from a service or application that starts the driver using the Session Control Manager (SCM) APIs. The Native WiFi (NWIFI.SYS) LWF does this, for example. It is started by the service wlansvc. So, while it is `SERVICE_DEMAND_START`, users don't experience a delay in network availability.

If the driver never starts or is slow in starting, NDIS will wait for it to be registered (`NdisFRegisterFilterDriver`) and to attach to the stack before making the network adapter available, up to the 90-second timeout period, at which time the stack will start without it if it is Optional.
