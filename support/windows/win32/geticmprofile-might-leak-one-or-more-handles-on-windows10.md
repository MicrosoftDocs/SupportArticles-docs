---
title: GetICMProfile might leak one or more handles on Windows 10
description: This article describes an issue where the GetICMProfile function doesn't close one or more registry handles on Windows 10
ms.date: 08/05/2022
author: 
ms.author: v-shwetasohu
ms.prod: 
ms.reviewer: mihayash, davean 
ms.custom: sap:System services development
ms.technology: windows-dev-apps-system-services-dev
---
# GetICMProfile function might leak one or more handles on Windows 10

This article describes a problem where the `GetICMProfile` function leaks one or more handles on Windows 10.

_Applies to:_ &nbsp; Windows 10 version 2004, Windows 10 version 20H2, Windows 10 version 21H1, Windows 10 version 21H2

## Symptoms

Applications that call the [GetICMProfile](https://docs.microsoft.com/previous-versions/ms536585(v=vs.85)) Image Color Management (ICM) function might see increased handle usage counts in tools such as Task Manager or might experience unexpected error or behavior.

## Cause

The `GetICMProfile` function uses the Windows Registry functions to obtain color profile information from the registry but doesn't close the opened registry handles. This problem can also occur while calling other ICM or Windows Color System (WCS) functions, including:
- [EnumICMProfiles](https://docs.microsoft.com/previous-versions/ms536595(v=vs.85))
- [WcsGetDefaultColorProfile](https://docs.microsoft.com/previous-versions/ms536874(v=vs.85))
- [WcsGetDefaultColorProfileSize](https://docs.microsoft.com/previous-versions/ms536875(v=vs.85))
- [WcsGetUsePerUserProfiles](https://docs.microsoft.com/previous-versions/ms536877(v=vs.85))

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More information

This problem is fixed in Windows 11.