---
title: GetTickCount resets to zero after approximately 776 days
description: Describes a problem where the value returned by GetTickCount resets to zero after approximately 776 days.
author: cts-davean
ms.author: davean
ms.reviewer: v-sidong
ms.custom: sap:System Services Development
ms.technology: windows-dev-apps-system-services-dev
ms.date: 08/29/2023
---

# GetTickCount resets to zero after approximately 780 days

Describes a problem where the value returned by GetTickCount resets to zero after approximately 776 days.

## Symptoms

The time returned by the [GetTickCount](https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount) function will reset from 0x9FFFFFF0 to zero if the system is run continuously for approximately 776 days.

This problem occurs in 32-bit applications running on Windows 10 and later.

## Cause

Microsoft has confirmed this is a problem in Windows 10 and later.

## Workaround

Use the [GetTickCount64](https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount64) function instead.

## More information

The problem described in this article is not related to the behavior described in the [GetTickCount](https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount) function documentation, where the time will wrap around from 0xFFFFFFFF to zero if the system is run continuously for 49.7 days.

Based on the hardware Windows is installed on, and the time between clock interrupts, it is also possible that the issue may occur with a duration other than 776 days.
