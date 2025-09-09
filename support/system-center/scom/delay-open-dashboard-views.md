---
title: A delay when you open dashboard views
description: Fixes an issue in which a delay occurs when you use a non-English locale and open dashboard views in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: kaushika, adgoda
---
# A delay occurs when you open dashboard views in System Center Operations Manager

This article helps you work around an issue in which a delay occurs when you use a non-English locale and open dashboard views in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 4018986

## Symptoms

Assume that you use a non-English Windows operating system version or locale in System Center Operations Manager. When you open a dashboard performance widget, you may experience a delay of 5 to 10 minutes. If you set your locale to English-US (ENU), the delay doesn't occur.

## Cause

This issue occurs when there are multiple management packs that contain both dashboard visualization elements and non-ENU language packs.

When you use a non-English locale, and you open one of the dashboard views, the console enumerates elements in any management pack that contains visualization elements and that has a language pack that matches the systems language or locale. This can cause high CPU usage on the management server. Thus, in turn, causes a delay in the UI.

## Workaround

To work around the issue, reduce the number of custom management packs that contain visualization elements. For example, designate a single management pack to contain all the dashboard views instead of creating dashboard views in multiple management packs.
