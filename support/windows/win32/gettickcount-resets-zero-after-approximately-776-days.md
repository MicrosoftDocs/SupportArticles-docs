---
title: GetTickCount resets to zero after approximately 776 days
description: Describes a problem where the value returned by GetTickCount resets to zero after approximately 776 days.
author: cts-davean
ms.author: davean
ms.reviewer: v-sidong
ms.custom: sap:System Services Development
ms.technology: windows-dev-apps-system-services-dev
ms.date: 09/04/2023
---
# GetTickCount resets to zero after approximately 776 days

This article describes a problem where the value returned by `GetTickCount` resets to `zero` after approximately 776 days.

## Symptoms

The time returned by the [GetTickCount](/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount) function resets from `0x9FFFFFF0` to `zero` if the system runs continuously for approximately 776 days.

This problem occurs in 32-bit applications running on Windows 10 and later.

## Status

Microsoft has confirmed this is a problem in Windows 10 and later.

## Workaround

Use the [GetTickCount64](/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount64) function instead.

## More information

This problem isn't related to the behavior described in the [GetTickCount](/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount) function documentation, where the time wraps around from `0xFFFFFFFF` to `zero` if the system runs continuously for 49.7 days.

The number of days before this problem occurs may vary depending on the resolution of the system timer. The problem occurs after approximately 776 days on systems whose system timer resolution is 15.6 milliseconds.
