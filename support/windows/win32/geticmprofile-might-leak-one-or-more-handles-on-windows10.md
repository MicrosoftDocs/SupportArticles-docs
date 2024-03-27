---
title: GetICMProfile leaks one or more handles in Windows 10
description: This article describes an issue in which the GetICMProfile function doesn't close one or more registry handles in Windows 10.
ms.date: 12/19/2023
ms.reviewer: mihayash, davean, v-jayaramanp
ms.custom: sap:Graphics and Multimedia development\Other
---

# GetICMProfile function leaks one or more handles in Windows 10

This article describes a problem in which the `GetICMProfile` function leaks one or more handles in Windows 10.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1, Windows 10, version 21H2

## Symptoms

Applications that call the [`GetICMProfile`](/previous-versions/ms536585(v=vs.85)) function experience increased handle usage counts in tools such as Task Manager, or experience unexpected errors or behavior.

## Cause

The `GetICMProfile` function uses the Windows registry functions to obtain color profile information from the registry. However, it doesn't close the opened registry handles. This problem can also occur when applications call other Image Color Management (ICM) or Windows Color System (WCS) functions. These include the following functions:
- [`EnumICMProfiles`](/previous-versions/ms536595(v=vs.85))
- [`WcsGetDefaultColorProfile`](/previous-versions/ms536874(v=vs.85))
- [`WcsGetDefaultColorProfileSize`](/previous-versions/ms536875(v=vs.85))
- [`WcsGetUsePerUserProfiles`](/previous-versions/ms536877(v=vs.85))

## Status

Microsoft has confirmed that this is a problem in the products that are listed in the "Applies to" section.

This problem is fixed in Windows 11.
