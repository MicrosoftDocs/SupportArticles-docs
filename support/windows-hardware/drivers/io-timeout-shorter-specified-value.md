---
title: I/O timeout is 10 times shorter
description: This article provides resolutions for the problem in which the actual I/O timeout is 10 times shorter than the specified value in User-Mode Driver Framework 2.0.
ms.date: 01/29/2021
ms.custom: sap:Developer Tools\Windows Driver Kit (WDK, HLK)\Windows Driver Kit 10\Windows Device Driver Interface (DDI)\User-Mode Driver Framework (UMDF)Developer Tools\Windows Driver Kit (WDK, HLK)\Windows Driver Kit 8.1\Windows Device Driver Interface (DDI)\User-Mode Driver Framework (UMDF)
ms.reviewer: heikom
ms.subservice: other-driver
---
# Actual I/O time-out is 10 times shorter than the specified value in User-Mode Driver Framework 2.0

This article helps you resolve the problem in which the actual I/O timeout is 10 times shorter than the specified value in User-Mode Driver Framework 2.0.

_Original product version:_ &nbsp; Windows 8.1, Windows Server 2012 R2, Windows 10, Windows 10 IoT Enterprise v1507, Windows Driver Kit 8.1, Windows Driver Kit 10  
_Original KB number:_ &nbsp; 4512989

## Symptoms

Assume that your driver uses User-Mode Driver Framework (UMDF) version 2.0 in Windows operating systems. You notice that the time-out value of I/O operation is 10 times shorter than the specified value.

For example, if you call the `WdfIoTargetSendWriteSynchronously` function as follows, the write request is expected to cause a time-out to occur after 10 milliseconds. However, the time-out occurs after 1 millisecond.

```cpp
WDF_REQUEST_SEND_OPTIONS reqOptions; 
WDF_REQUEST_SEND_OPTIONS_INIT(&reqOptions, WDF_REQUEST_SEND_OPTION_TIMEOUT); // We specify 10 milliseconds as a timeout. WDF_REQUEST_SEND_OPTIONS_SET_TIMEOUT(&reqOptions, WDF_REL_TIMEOUT_IN_MS(10));
WdfIoTargetSendWriteSynchronously(ioTarget, request, &memDescr, NULL, & reqOptions, &bytesWritten);
```

## Cause

The issue occurs because the time-out calculation in UMDF 2.0 is incorrect.

## Resolution

The issue is fixed in Windows 10, Version 1511. If your driver uses a system that is earlier than Windows 10, Version 1511, you can increase the time-out value by a factor of 10.
